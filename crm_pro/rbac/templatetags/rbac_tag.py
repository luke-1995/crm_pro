#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import re
from collections import OrderedDict
# 第三方模块
from django import template
from django.utils.module_loading import import_string
# 自定义模块
from rbac.models import Role, UserInfo
from django.conf import settings
from rbac.utils.url import mark_url as m_url

register = template.Library()


@register.inclusion_tag('rbac/first_menu.html')
def first_menu(request):
    li = request.session.get(settings.MENU_KEY)
    return locals()


@register.inclusion_tag('rbac/second_menu.html')
def second_menu(request):
    selected_id = request.selected_id
    menu_dic = request.session.get(settings.MENU_KEY)
    key_list = sorted(menu_dic)
    order_dic = OrderedDict()
    for key in key_list:
        order_dic[key] = menu_dic[key]
        for permission_dic in order_dic[key]['children']:
            if permission_dic['id'] == selected_id:
                permission_dic['class'] = 'active'
                order_dic[key]['class'] = ''
                break
            else:
                order_dic[key]['class'] = 'hide'
    return locals()


@register.inclusion_tag('rbac/nav_path.html')
def nav_path(request):
    return locals()


@register.filter
def has_permission(request, name):
    permission_dic = request.session.get(settings.PERMISSION_KEY)
    if not permission_dic:
        return False
    if name in permission_dic:
        return True


@register.simple_tag
def mark_url(name, request, *args, **kwargs):
    url = m_url(name, request, *args, **kwargs)
    return url


@register.inclusion_tag('rbac/import_change.html')
def import_change(formset, ):
    '''
    :param formset:
    :param type:区分是添加操作还是更新操作
    :return:
    '''
    return {'formset': formset, }


@register.filter
def role_permission(permission_id, role_id):
    if role_id and permission_id:
        flag = Role.objects.filter(permissions__pk=permission_id, pk=role_id).exists()
        return flag


@register.filter
def user_permission(permission_id, user_id):
    if user_id and permission_id:
        user_info = import_string(settings.RBAC_USER_MODEL_CLASS)
        flag = user_info.objects.filter(roles__permissions__pk=permission_id, pk=user_id).exists()
        return flag


@register.filter
def user_role(role_id, user_id):
    if user_id and role_id:
        user_info = import_string(settings.RBAC_USER_MODEL_CLASS)
        flag = user_info.objects.filter(roles__pk=role_id, pk=user_id)
        return flag
