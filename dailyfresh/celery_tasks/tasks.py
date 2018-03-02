from celery import Celery

import os
os.environ["DJANGO_SETTINGS_MODULE"] = "dailyfresh.settings"

# 放到celery服务器上时将注释打开
# import django
# django.setup()

from django.core.mail import send_mail
from django.conf import settings
from django.template import loader, Context
from goods.models import GoodsCategory, Goods, GoodsSKU, IndexGoodsBanner
from goods.models import IndexCategoryGoodsBanner, IndexPromotionBanner


app = Celery("celery_tasks.tasks", broker="redis://10.211.55.5:6379/1")


@app.task
def send_active_email(uname, email, token):
    """发送激活邮件"""
    subject = "天天生鲜用户激活"
    html_message = '<h1>尊敬的用户 %s, 感谢您注册天天生鲜！</h1>' \
                   '<br/><p>请点击此链接激活您的帐号<a href="http://127.0.0.1:8000/users/active/%s">' \
                   'http://127.0.0.1:8000/users/active/%s<a></p>' % (uname, token, token)
    send_mail(subject, "", settings.EMAIL_FROM, [email], html_message=html_message)


@app.task
def send_register_success_email(uname, email):
    """发送注册成功邮件"""
    subject = "天天生鲜激活成功"
    html_message = '<h1>尊敬的用户 %s, 恭喜您激活成功！</h1>' \
                   '<br/><p>祝您购物愉快！</p>' % uname
    send_mail(subject, "", settings.EMAIL_FROM, [email], html_message=html_message)


@app.task
def generate_static_index_html():
    """生成主页静态html文件"""
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

    template = loader.get_template("index_for_static.html")
    html = template.render(context)
    with open("./static/index.html", "w") as f:
        f.write(html)
