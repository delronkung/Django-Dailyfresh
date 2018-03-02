from django.shortcuts import render
from django.views.generic import View
from django.http import JsonResponse
from goods.models import GoodsSKU
from django_redis import get_redis_connection
from utils.views import LoginRequiredMixin
from decimal import Decimal
import json
# Create your views here.


class CartAddView(View):
    """添加购物车"""
    def post(self, request):
        # # 判断用户是否登录
        # if not request.user.is_authenticated():
        #     return JsonResponse({"code": 1, "message": "请先登录"})

        # 获取参数
        sku_id = self.request.POST.get("sku_id")
        sku_count = self.request.POST.get("sku_count")

        # 参数校验
        if not all([sku_id, sku_count]):
            return JsonResponse({"code": 2, "message": "参数错误"})
        try:
            sku_count = int(sku_count)
        except Exception:
            return JsonResponse({"code": 2, "message": "参数错误"})

        # 获取商品信息
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except GoodsSKU.DoesNotExist:
            return JsonResponse({"code": 3, "message": "商品不存在"})

        # 判断库存
        if sku.stock < sku_count:
            return JsonResponse({"code": 4, "message": "库存不足"})

        # 添加购物车信息
        if request.user.is_authenticated():
            # 登录用户， 添加到redis中
            user_id = request.user.id
            redis_conn = get_redis_connection("default")
            num = redis_conn.hget("cart_%s" % user_id, sku_id)
            if num is not None:
                sku_count += int(num)
            redis_conn.hset("cart_%s" % user_id, sku_id, sku_count)

            # 购物车总数
            cart_num = 0
            cart = redis_conn.hgetall("cart_%s" % user_id)
            for val in cart.values():
                cart_num += int(val)
            return JsonResponse({"code": 0, "message": "添加成功", "cart_num": cart_num})
        else:
            # 未登录用户，添加到cookie中
            cart = request.COOKIES.get("cart")
            if cart is not None:
                cart = json.loads(cart)
            else:
                cart = {}
            num = cart.get(sku_id)
            if num is not None:
                sku_count += int(num)
            cart[sku_id] = sku_count
            # 购物车总数
            cart_num = 0
            for val in cart.values():
                cart_num += val
            response = JsonResponse({"code": 0, "message": "添加成功", "cart_num": cart_num})
            response.set_cookie("cart", json.dumps(cart))
            return response


class CartInfoView(View):
    """购物车页面"""
    def get(self, request):
        if request.user.is_authenticated():
            # 如果用户已登录，从redis中读取购物车数据
            user_id = request.user.id
            redis_conn = get_redis_connection("default")
            cart = redis_conn.hgetall("cart_%s" % user_id)
        else:
            # 用户未登录，从cookie中读取购物车数据
            cart = request.COOKIES.get("cart")
            if cart is not None:
                cart = json.loads(cart)
            else:
                cart = {}

        # 处理购物车数据
        skus = []
        total_count = 0
        total_amount = Decimal(0)
        for sku_id, sku_count in cart.items():
            sku = GoodsSKU.objects.get(id=int(sku_id))
            amount = sku.price * int(sku_count)
            sku.amount = amount
            sku.count = sku_count
            total_count += int(sku_count)
            total_amount += amount
            skus.append(sku)
        context = {
            "skus": skus,
            "total_count": total_count,
            "total_amount": total_amount
        }
        return render(request, "cart.html", context)


class CartDeleteView(View):
    """购物车删除"""
    def post(self, request):
        # # 判断用户是否登录
        # if not request.user.is_authenticated():
        #     return JsonResponse({"code": 1, "message": "请先登录"})

        sku_id = request.POST.get("sku_id")
        if not sku_id:
            return JsonResponse({"code": 2, "message": "参数错误"})

        response = JsonResponse({"code": 0, "message": "删除成功"})
        if request.user.is_authenticated():
            # 如果用户登录，操作redis
            user_id = request.user.id
            redis_conn = get_redis_connection("default")
            redis_conn.hdel("cart_%s" % user_id, sku_id)
            return response
        else:
            # 用户未登录
            cart = request.COOKIES.get("cart")
            if cart is not None:
                cart = json.loads(cart)
                if sku_id in cart:
                    del cart[sku_id]
                    response.set_cookie("cart", json.dumps(cart))
            return response


class CartUpdateView(View):
    """购物车更新"""
    def post(self, request):
        # # 判断用户是否登录
        # if not request.user.is_authenticated():
        #     return JsonResponse({"code": 1, "message": "请先登录"})

        sku_id = request.POST.get("sku_id")
        sku_count = self.request.POST.get("count")

        if not all([sku_id, sku_count]):
            return JsonResponse({"code": 2, "message": "参数错误"})

        try:
            sku_count = int(sku_count)
        except Exception:
            return JsonResponse({"code": 2, "message": "参数错误"})

        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except GoodsSKU.DoesNotExist:
            return JsonResponse({"code": 3, "message": "商品不存在"})

        # 判断库存
        if sku.stock < sku_count:
            return JsonResponse({"code": 4, "message": "库存不足"})

        response = JsonResponse({"code": 0, "message": "更新成功"})
        if request.user.is_authenticated():
            # 如果用户存在
            user_id = request.user.id
            redis_conn = get_redis_connection("default")
            redis_conn.hset("cart_%s" % user_id, sku_id, sku_count)
        else:
            # 用户不存在
            cart = request.COOKIES.get("cart")
            if cart is not None:
                cart = json.loads(cart)
            else:
                cart = {}
            cart[sku_id] = sku_count
            response.set_cookie("cart", json.dumps(cart))
        return response




