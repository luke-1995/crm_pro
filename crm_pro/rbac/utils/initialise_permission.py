#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
# 本地库
from django.conf import settings
from rbac.models import *


def user_permission(request, user):
    permission_dic = {}
    menu_dic = {}
    url = Permission.objects.filter(url__isnull=False, role__userinfo=user).distinct()
    first_menu = FirstMenu.objects.filter(permission__role__userinfo=user)

    for i in first_menu:
        dic = dict(title=i.title, icon=str(i.icon), children=[])  # icon对象不能直接写到字典中,应该转换成字符串
        menu_dic[i.pk] = dic

    for i in url:
        if i.firstmenu_id:
            dic = dict(id=i.pk, title=i.title, url=i.url, icon=str(i.icon))  # icon对象不能直接写到字典中,应该转换成字符串
            menu_dic[i.firstmenu_id]['children'].append(dic)
        if i.parent_permission_id:
            dic1 = dict(id=i.pk, url=i.url, title=i.title, parent_permission_id=i.parent_permission_id,
                        parent_permission_title=i.parent_permission.title,
                        parent_permission_url=i.parent_permission.url)  # 获取权限存放一个字典
        else:
            dic1 = dict(id=i.pk, url=i.url, title=i.title, parent_permission_id=i.parent_permission_id, )  # 获取权限存放一个字典
        permission_dic[i.name] = dic1
    request.session[settings.PERMISSION_KEY] = permission_dic
    request.session[settings.MENU_KEY] = menu_dic



