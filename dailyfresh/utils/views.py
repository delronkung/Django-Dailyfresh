from django.contrib.auth.decorators import login_required
from django.db import transaction
from functools import wraps
from django.http import JsonResponse


class LoginRequiredMixin(object):
    """提供要求用户登录功能"""
    @classmethod
    def as_view(cls, *args, **kwargs):
        view = super(LoginRequiredMixin, cls).as_view(*args, **kwargs)
        return login_required(view)


def login_required_json(view_func):
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated():
            return JsonResponse({"code": 1, "message": "用户未登录"})
        else:
            return view_func(request, *args, **kwargs)
    return wrapper


class LoginRequiredJsonMixin(object):
    """提供要求用户登录功能，返回json"""
    @classmethod
    def as_view(cls, *args, **kwargs):
        view = super(LoginRequiredJsonMixin, cls).as_view(*args, **kwargs)
        return login_required_json(view)


class TransactionAtomicMixin(object):
    """事务支持扩充"""
    @classmethod
    def as_view(cls, *args, **kwargs):
        view = super(TransactionAtomicMixin, cls).as_view(*args, **kwargs)
        return transaction.atomic(view)

