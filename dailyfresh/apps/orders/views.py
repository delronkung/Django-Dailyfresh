import json

from django.shortcuts import render, redirect
from utils.views import LoginRequiredMixin, TransactionAtomicMixin, LoginRequiredJsonMixin
from users.models import Address
from goods.models import GoodsSKU
from django.views.generic import View
from decimal import Decimal
from django.core.urlresolvers import reverse
from django_redis import get_redis_connection
from django.http import JsonResponse, HttpResponse
from orders.models import OrderInfo, OrderGoods
from django.db import transaction
from django.utils import timezone
from django.core.paginator import Paginator
from django.core.cache import cache
from alipay import AliPay
from django.conf import settings
import os
import time

# Create your views here.


class PlaceOrderView(LoginRequiredMixin, View):
    """下单页面"""
    def post(self, request):
        user = request.user
        try:
            address = user.address_set.latest("create_time")
        except Address.DoesNotExist:
            address = None
        sku_ids = request.POST.getlist("sku_ids")
        if not sku_ids:
            return redirect(reverse("cart:info"))
        count = request.POST.get("count")
        skus = []
        total_count = 0
        skus_amount = Decimal("0")
        redis_conn = get_redis_connection("default")
        if count:
            # 直接购买
            for sku_id in sku_ids:
                sku = GoodsSKU.objects.get(id=sku_id)
                sku.count = int(count)
                amount = sku.price * sku.count
                sku.amount = amount
                skus_amount += amount
                total_count += sku.count
                skus.append(sku)
                # 将商品存入购物车，下单
                redis_conn.hset("cart_%s" % user.id, sku_id, count)
        else:
            # 从购物车页面过来
            cart = redis_conn.hgetall("cart_%s" % user.id)
            for sku_id in sku_ids:
                sku_count = cart[sku_id.encode()]
                sku = GoodsSKU.objects.get(id=sku_id)
                sku.count = int(sku_count)
                amount = sku.price * Decimal(sku_count.decode())
                sku.amount = amount
                skus_amount += amount
                total_count += int(sku_count)
                skus.append(sku)

        trans_cost = Decimal('10.00')
        total_amount = skus_amount + trans_cost

        context = {
            "address": address,
            "skus": skus,
            "skus_amount": skus_amount,
            "trans_cost": trans_cost,
            "total_amount": total_amount,
            "total_count": total_count,
            "sku_ids": ",".join(sku_ids)
        }
        return render(request, 'place_order.html', context)


class CommitOrderView(LoginRequiredJsonMixin, TransactionAtomicMixin, View):
    """提交订单"""
    def post(self, request):
        # 判断用户是否登录
        user = request.user
        # if not user.is_authenticated():
        #     return JsonResponse({"code": 1, "message": "请先登录"})

        address_id = request.POST.get("address_id")  # 地址
        pay_method = request.POST.get("pay_method")  # 支付方式
        sku_ids = request.POST.get("sku_ids")  # 订单的商品

        if not all([address_id, pay_method, sku_ids]):
            return JsonResponse({"code": 2, "message": "参数不完整"})
        sku_ids = sku_ids.split(",")

        # 判断地址是否存在
        if not Address.objects.filter(id=address_id).exists():
            return JsonResponse({"code": 3, "message": "地址不存在"})

        # 判断支付方式
        pay_method = int(pay_method)
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({"code": 4, "message": "不支持的支付方式"})

        redis_conn = get_redis_connection("default")

        # 组织订单信息 20170903153611+user.id
        order_id = timezone.now().strftime('%Y%m%d%H%M%S') + str(user.id)

        # 生成订单
        # 创建一个保存点
        save_id = transaction.savepoint()

        try:
            # 创建订单信息
            order = OrderInfo.objects.create(
                order_id=order_id,
                user=user,
                address_id=address_id,
                total_count=0,
                total_amount=Decimal('0'),
                trans_cost=Decimal('10'),
                pay_method=pay_method
            )
            # 获取购物车信息
            cart = redis_conn.hgetall("cart_%s" % user.id)
            total_amount = Decimal("0")
            total_count = 0
            # 处理订单商品
            for sku_id in sku_ids:
                for i in range(3):
                    sku_count = cart.get(sku_id.encode())
                    if not sku_count:
                        # 如果商品不存在
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({"code": 5, "message": "商品信息错误"})

                    # 使用悲观锁
                    # sku = GoodsSKU.objects.select_for_update().get(id=sku_id)

                    # 使用乐观锁
                    sku = GoodsSKU.objects.get(id=sku_id)
                    # 判断库存
                    origin_stock = sku.stock  # 原始库存
                    origin_sales = sku.sales  # 原始销量
                    sku_count = int(sku_count)
                    if sku_count > origin_stock:
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({"code": 6, "message": "商品库存不足"})
                    # 减少库存
                    new_stock = origin_stock - sku_count
                    new_sales = origin_sales + sku_count

                    # 根据原始库存条件更新，返回更新的条目数，乐观锁
                    ret = GoodsSKU.objects.filter(id=sku_id, stock=origin_stock).update(stock=new_stock, sales=new_sales)
                    if ret == 0 and i < 2:
                        continue
                    elif ret == 0 and i == 2:
                        # 未能更新库存
                        transaction.savepoint_rollback(save_id)
                        return JsonResponse({"code": 7, "message": "下单失败"})

                    sku_amount = sku.price * Decimal(sku_count)  # 商品金额
                    total_amount += sku_amount  # 累计总金额
                    total_count += sku_count  # 累计总额
                    # 保存订单商品
                    OrderGoods.objects.create(
                        order=order,
                        sku=sku,
                        count=sku_count,
                        price=sku.price,
                    )

                    # 更新成功
                    break

            # 更新订单的金额数量信息
            order.total_amount = total_amount
            order.total_amount += order.trans_cost
            order.total_count = total_count
            order.save()

        except Exception as e:
            print(e)
            transaction.savepoint_rollback(save_id)
            return JsonResponse({"code": 8, "message": "服务器错误"})

        # 提交事务
        transaction.savepoint_commit(save_id)

        # 更新redis中保存的购物车数据
        redis_conn.hdel("cart_%s" % user.id, *sku_ids)
        return JsonResponse({"code": 0, "message": "下单成功"})


class UserOrdersView(LoginRequiredMixin, View):
    """用户订单"""
    def get(self, request, page):
        user = request.user
        # 查询订单
        orders = user.orderinfo_set.all().order_by("-create_time")

        for order in orders:
            order.status_name = OrderInfo.ORDER_STATUS[order.status]
            order.pay_method_name = OrderInfo.PAY_METHODS[order.pay_method]
            order.skus = []
            order_skus = order.ordergoods_set.all()
            for order_sku in order_skus:
                sku = order_sku.sku
                sku.count = order_sku.count
                sku.amount = sku.price * Decimal(sku.count)
                order.skus.append(sku)

        # 分页
        paginator = Paginator(orders, 3)
        # 获取页码的列表
        pages = paginator.page_range
        # 获取总页数
        num_pages = paginator.num_pages
        # 当前页转化为数字
        page = int(page)

        # 1.如果总页数<=5
        # 2.如果当前页是前3页
        # 3.如果当前页是后3页,
        # 4.既不是前3页，也不是后3页
        if num_pages <= 5:
            pages = range(1, num_pages + 1)
        elif page <= 3:
            pages = range(1, 6)
        elif (num_pages - page) <= 2:
            pages = range(num_pages - 4, num_pages + 1)
        else:
            pages = range(page - 2, page + 3)

        # 取第page页的内容 has_previous has_next number
        page_orders = paginator.page(page)

        context = {
            "orders": page_orders,
            "page": page,
            "pages": pages
        }

        return render(request, "user_center_order.html", context)


class CommentView(LoginRequiredMixin, View):
    """订单评论"""
    def get(self, request, order_id):
        """提供评论页面"""
        user = request.user
        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("orders:info"))

        order.status_name = OrderInfo.ORDER_STATUS[order.status]
        order.skus = []
        order_skus = order.ordergoods_set.all()
        for order_sku in order_skus:
            sku = order_sku.sku
            sku.count = order_sku.count
            sku.amount = sku.price * Decimal(sku.count)
            order.skus.append(sku)

        return render(request, "order_comment.html", {"order": order})

    def post(self, request, order_id):
        """处理评论内容"""
        user = request.user
        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("orders:info"))

        # 获取评论条数
        total_count = request.POST.get("total_count")
        total_count = int(total_count)

        for i in range(1, total_count + 1):
            sku_id = request.POST.get("sku_%d" % i)
            content = request.POST.get('content_%d' % i, '')
            try:
                order_goods = OrderGoods.objects.get(order=order, sku_id=sku_id)
            except OrderGoods.DoesNotExist:
                continue

            order_goods.comment = content
            order_goods.save()

            # 清除商品详情缓存
            cache.delete("detail_%s" % sku_id)

        order.status = OrderInfo.ORDER_STATUS_ENUM["FINISHED"]
        order.save()

        return redirect(reverse("orders:info", kwargs={"page": 1}))


class PayView(LoginRequiredJsonMixin, View):
    """订单支付"""
    def get(self, request):

        # 获取订单号
        order_id = request.GET.get("order_id")
        if not order_id:
            return JsonResponse({"code": 2, "message": "缺少订单号"})

        # 判断订单信息是否正确
        try:
            order = OrderInfo.objects.get(order_id=order_id, user=request.user,
                                          pay_method=OrderInfo.PAY_METHODS_ENUM["ALIPAY"],
                                          status=OrderInfo.ORDER_STATUS_ENUM["UNPAID"])
        except OrderInfo.DoesNotExist:
            return JsonResponse({"code": 3, "message": "订单信息有误"})

        # 构造支付宝支付链接地址
        alipay = AliPay(
            appid=settings.ALIPAY_APPID,
            app_notify_url=None,  # 默认回调url
            app_private_key_path=os.path.join(settings.BASE_DIR, "apps/orders/app_private_key.pem"),
            alipay_public_key_path=os.path.join(settings.BASE_DIR, "apps/orders/alipay_public_key.pem"),  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            sign_type="RSA2",  # RSA 或者 RSA2
            debug=True  # 默认False
        )

        order_string = alipay.api_alipay_trade_page_pay(
            out_trade_no=order_id,
            total_amount=str(order.total_amount),
            subject="天天生鲜%s" % order_id,
        )
        alipay_url = settings.ALIPAY_URL + "?" + order_string
        return JsonResponse({"code": 0, "message": "OK", "pay_url": alipay_url})


class ChechPayStatusView(LoginRequiredJsonMixin, View):
    """检查支付完成状态"""
    def get(self, request):
        # 获取订单id
        order_id = request.GET.get("order_id")
        if not order_id:
            return JsonResponse({"code": 2, "message": "缺少订单号"})

        # 判断订单信息是否正确
        try:
            order = OrderInfo.objects.get(order_id=order_id, user=request.user,
                                          pay_method=OrderInfo.PAY_METHODS_ENUM["ALIPAY"],
                                          status=OrderInfo.ORDER_STATUS_ENUM["UNPAID"])
        except OrderInfo.DoesNotExist:
            return JsonResponse({"code": 3, "message": "订单信息有误"})

        # 构造支付宝支付链接地址
        alipay = AliPay(
            appid=settings.ALIPAY_APPID,
            app_notify_url=None,  # 默认回调url
            app_private_key_path=os.path.join(settings.BASE_DIR, "apps/orders/app_private_key.pem"),
            alipay_public_key_path=os.path.join(settings.BASE_DIR, "apps/orders/alipay_public_key.pem"),
            # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            sign_type="RSA2",  # RSA 或者 RSA2
            debug=True  # 默认False
        )

        # 查询支付结果
        while True:
            result = alipay.api_alipay_trade_query(order_id)
            print(result)
            trage_status = result.get("trade_status")
            if result.get("code") != "10000" or trage_status == "WAIT_BUYER_PAY":
                time.sleep(10)
                continue
            elif trage_status == "TRADE_SUCCESS":
                order.status = OrderInfo.ORDER_STATUS_ENUM["UNCOMMENT"]
                order.trade_id = result.get("trade_no")
                order.save()
                return JsonResponse({"code": 0, "message": "支付成功"})
            else:
                return JsonResponse({"code": 4, "message": "支付失败"})












