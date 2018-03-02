from django.shortcuts import render, redirect
from django.views.generic import View
from goods.models import GoodsCategory, Goods, GoodsSKU, IndexGoodsBanner
from goods.models import IndexCategoryGoodsBanner, IndexPromotionBanner
from django.core.cache import cache
from django_redis import get_redis_connection
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator, EmptyPage
import json

# Create your views here.


class BaseCartView(View):
    """提供统计购物车的功能"""
    def get_cart_num(self, request):
        """计算购物车数量"""
        # 购物车数量
        cart_num = 0
        # 如果是登录的用户
        if request.user.is_authenticated():
            user_id = request.user.id
            # 从redis中获取购物车信息
            redis_conn = get_redis_connection("default")
            # 如果redis中不存在，会返回0
            cart = redis_conn.hgetall("cart_%s" % user_id)
            for val in cart.values():
                cart_num += int(val)
        else:
            # 用户未登录，从cookie中获取
            cart = request.COOKIES.get("cart")
            if cart is not None:
                cart = json.loads(cart)
                for val in cart.values():
                    cart_num += int(val)
        return cart_num


class IndexView(BaseCartView):
    """主页"""
    def get(self, request):
        """提供主页面"""
        # 尝试获取缓存
        context = cache.get("index_page")
        # 如果没有缓存
        if context is None:
            print("not hit redis")
            # 获取类别
            categorys = GoodsCategory.objects.all()
            # 获取商品轮播图
            goods_banners = IndexGoodsBanner.objects.all().order_by("index")[:5]
            # 获取活动信息
            promotion_banners = IndexPromotionBanner.objects.all().order_by("index")[:2]

            # 获取分类商品信息
            for category in categorys:
                # 标题商品
                title_banners = IndexCategoryGoodsBanner.objects.filter(category=category,
                                                                        display_type=0).order_by("index")[:5]
                category.title_banners = title_banners

                # 图片商品
                image_banners = IndexCategoryGoodsBanner.objects.filter(category=category,
                                                                        display_type=1).order_by("index")[:4]
                category.image_banners = image_banners

            context = {
                "categorys": categorys,
                "goods_banners": goods_banners,
                "promotion_banners": promotion_banners,
            }
            # 设置缓存
            cache.set("index_page", context, 3600)

        # 获取购物车数量
        cart_num = self.get_cart_num(request)
        context.update({"cart_num": cart_num})

        return render(request, "index.html", context)


class DetailView(BaseCartView):
    """商品详情"""
    def get(self, request, sku_id):
        # 尝试获取缓存数据
        context = cache.get("detail_%s" % sku_id)
        # 如果缓存不存在
        if context is None:
            try:
                # 获取商品信息
                sku = GoodsSKU.objects.get(id=sku_id)
            except GoodsSKU.DoesNotExist:
                # raise Http404("商品不存在!")
                return redirect(reverse("goods:index"))

            # 获取类别
            categorys = GoodsCategory.objects.all()

            # 从订单中获取评论信息
            sku_orders = sku.ordergoods_set.exclude(comment="").order_by('-create_time')[:30]
            if sku_orders:
                for sku_order in sku_orders:
                    sku_order.ctime = sku_order.create_time.strftime('%Y-%m-%d %H:%M:%S')
                    sku_order.username = sku_order.order.user.username
            else:
                sku_orders = []

            # 获取最新推荐
            new_skus = GoodsSKU.objects.filter(category=sku.category).order_by("-create_time")[:2]

            # 获取其他规格的商品
            goods_skus = sku.goods.goodssku_set.exclude(id=sku_id)

            context = {
                "categorys": categorys,
                "sku": sku,
                "orders": sku_orders,
                "new_skus": new_skus,
                "goods_skus": goods_skus
            }

            # 设置缓存
            cache.set("detail_%s" % sku_id, context, 3600)

        # 购物车数量
        cart_num = self.get_cart_num(request)

        # 浏览记录
        if request.user.is_authenticated():
            user_id = request.user.id
            redis_conn = get_redis_connection("default")
            # 移除已经存在的本商品浏览记录
            redis_conn.lrem("history_%s" % user_id, 0, sku_id)
            # 添加新的浏览记录
            redis_conn.lpush("history_%s" % user_id, sku_id)
            # 只保存最多5条记录
            redis_conn.ltrim("history_%s" % user_id, 0, 4)

        context.update({"cart_num": cart_num})

        return render(request, 'detail.html', context)


# /list/种类id/页码/?sort=排序方式
class ListView(BaseCartView):
    """商品列表页"""
    def get(self, request, category_id, page):
        # 获取排序参数
        sort = request.GET.get('sort', 'default')

        # 判断page参数是否正确
        try:
            page = int(page)
        except Exception:
            return redirect(reverse("goods:index"))

        # 获取类别并判断类别是否存在
        categorys = GoodsCategory.objects.all()
        try:
            current_category = categorys.get(id=category_id)
        except GoodsCategory.DoesNotExist:
            return redirect(reverse("goods:index"))

        # 新品推荐
        new_skus = GoodsSKU.objects.filter(category_id=category_id).order_by("-create_time")[:2]

        # 购物车数量
        cart_num = self.get_cart_num(request)

        # 获取分页数据
        if sort == "hot":
            skus = GoodsSKU.objects.filter(category_id=category_id).order_by("-sales")
        elif sort == "price":
            skus = GoodsSKU.objects.filter(category_id=category_id).order_by("price")
        else:
            skus = GoodsSKU.objects.filter(category_id=category_id).order_by("-create_time")

        paginator = Paginator(skus, 2)
        try:
            page_skus = paginator.page(page)
        except EmptyPage:
            page_skus = paginator.page(1)
            page = 1

        # 获取总页数
        num_pages = paginator.num_pages
        # 当前页转化为数字
        page = int(page)

        # 分页页数显示计算
        # 1.如果总页数<=5
        # 2.如果当前页是前3页
        # 3.如果当前页是后3页,
        # 4.既不是前3页，也不是后3页
        if num_pages <= 5:
            page_list = paginator.page_range
        elif page <= 3:
            page_list = range(1, 6)
        elif (num_pages - page) <= 2:
            page_list = range(num_pages - 4, num_pages + 1)
        else:
            page_list = range(page - 2, page + 3)

        context = {
            "sort": sort,
            "categorys": categorys,
            "current_category": current_category,
            "new_skus": new_skus,
            "cart_num": cart_num,
            "skus": page_skus,
            "page_list": page_list,

        }
        return render(request, 'list.html', context)
