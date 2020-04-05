#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import functools
# 第三方模块
# 本地库
from django.conf import settings


def add_permission(func):
    '''添加权限验证'''

    @functools.wraps(func)
    def inner(self, *args, **kwargs):
        permission_dict = self.request.session.get(settings.PERMISSION_KEY)
        if self.get_url_name('add') not in permission_dict:
            return None
        return func(self, *args, **kwargs)

    return inner


def edit_permission(func):
    '''编辑权限验证'''

    @functools.wraps(func)
    def inner(self, *args, **kwargs):
        permission_dict = self.request.session.get(settings.PERMISSION_KEY)
        if self.get_url_name('change') not in permission_dict:
            print(self.get_url_name('change'))
            return None
        return func(self, *args, **kwargs)

    return inner


def del_permission(func):
    '''删除权限验证'''

    @functools.wraps(func)
    def inner(self, *args, **kwargs):
        permission_dict = self.request.session.get(settings.PERMISSION_KEY)
        if self.get_url_name('del') not in permission_dict:
            print(self.get_url_name('del', add_namespace=True))
            return None
        return func(self, *args, **kwargs)

    return inner
