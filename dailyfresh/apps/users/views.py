import re

from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from django import db
from django.shortcuts import render, redirect
from django.views.generic import View
from users.models import User, Address
from django.conf import settings
from django.core.urlresolvers import reverse
from django.contrib.auth import authenticate, login, logout
from utils.views import LoginRequiredMixin
from django_redis import get_redis_connection
from goods.models import GoodsSKU
from itsdangerous import SignatureExpired
import json

from celery_tasks.tasks import send_active_email, send_register_success_email


# Create your views here.


class RegisterView(View):
    """注册"""
    def get(self, request):
        """提供注册页面"""
        return render(request, "register.html", {"errmsg": ""})

    def post(self, request):
        """处理用户注册"""
        uname = request.POST.get("user_name")
        passwd = request.POST.get("pwd")
        email = request.POST.get("email")
        allow = request.POST.get("allow")
        if not all([uname, passwd, email, allow]) or allow != "on" \
                or not re.match(r"^[a-z0-9][\w\.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$", email):
            return render(request, "register.html")
        try:
            user = User.objects.create_user(uname, email, passwd)
        except db.IntegrityError:
            return render(request, "register.html", {"errmsg": "用户名已注册"})
        user.is_active = False
        user.save()
        # 生成激活令牌
        token = user.generate_active_token()
        send_active_email.delay(uname, email, token)
        return redirect(reverse("goods:index"))


class ActiveView(View):
    """用户激活"""
    def get(self, request, token):
        s = Serializer(settings.SECRET_KEY)
        data = s.loads(token)
        try:
            user_id = data.get("confirm")
        except SignatureExpired:
            return render(request, "active_failed.html")
        try:
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return render(request, "active_failed.html")
        user.is_active = True
        user.save()
        send_register_success_email.delay(user.username, user.email)
        return redirect(reverse("users:login"))


class LoginView(View):
    """用户登录"""
    def get(self, request):
        return render(request, "login.html", {"errmsg": ""})

    def post(self, request):
        uname = request.POST.get("username")
        passwd = request.POST.get("pwd")
        if not all([uname, passwd]):
            return render(request, "login.html", {"errmsg": "参数不完整"})
        user = authenticate(username=uname, password=passwd)
        if user is not None:
            if user.is_active:
                login(request, user)
                remembered = request.POST.get("remembered")
                if remembered == "on":
                    request.session.set_expiry(None)
                else:
                    request.session.set_expiry(0)

                next = request.GET.get("next")
                if next is None:
                    next = reverse("goods:index")
                elif next == reverse("orders:place"):
                    next = reverse("cart:info")
                response = redirect(next)

                # 将cookie中的购物车数据合并保存到redis中
                cart_cookie = request.COOKIES.get("cart")
                if cart_cookie is not None:
                    cart_cookie = json.loads(cart_cookie)
                    redis_conn = get_redis_connection("default")
                    cart_redis = redis_conn.hgetall("cart_%s" % user.id)
                    cart_redis.update(cart_cookie)
                    # 更新redis中的购物车
                    redis_conn.hmset("cart_%s" % user.id, cart_redis)
                    # 删除cookie中的购物车
                    response.delete_cookie("cart")
                return response
            else:
                return render(request, "login.html", {"errmsg": "用户尚未激活"})
        else:
            return render(request, "login.html", {"errmsg": "用户名或密码错误"})


class LogoutView(View):
    """退出"""
    def get(self, request):
        logout(request)
        return redirect(reverse("goods:index"))


class AddressView(LoginRequiredMixin, View):
    """用户地址"""
    def get(self, request):
        """提供地址页面"""
        # 获取请求的用户
        user = request.user
        # 查询用户的地址信息
        try:
            address = user.address_set.latest("update_time")
        except Address.DoesNotExist:
            address = None
        return render(request, "user_center_site.html", {"address": address})

    def post(self, request):
        """修改地址信息"""
        user = request.user
        recv_name = request.POST.get("recv_name")
        addr = request.POST.get("addr")
        zip_code = request.POST.get("zip_code")
        recv_mobile = request.POST.get("recv_mobile")
        if all([recv_name, addr, zip_code, recv_mobile]):
            # address = Address(
            #     user=user,
            #     receiver_name=recv_name,
            #     detail_addr=addr,
            #     zip_code=zip_code,
            #     receiver_mobile=recv_mobile
            # )
            # address.save()
            Address.objects.create(
                    user=user,
                    receiver_name=recv_name,
                    detail_addr=addr,
                    zip_code=zip_code,
                    receiver_mobile=recv_mobile
            )
        return redirect(reverse("users:address"))


class UserInfoView(LoginRequiredMixin, View):
    """个人信息"""
    def get(self, request):
        user = request.user
        try:
            address = user.address_set.latest("update_time")
        except Address.DoesNotExist:
            address = None

        # 浏览历史
        redis_conn = get_redis_connection("default")
        history = redis_conn.lrange("history_%s" % user.id, 0, 4)
        skus = []
        for sku_id in history:
            sku = GoodsSKU.objects.get(id=sku_id)
            skus.append(sku)

        # 模板变量
        context = {
            "user_name": user.username,
            "address": address,
            "skus": skus
        }
        return render(request, "user_center_info.html", context)







