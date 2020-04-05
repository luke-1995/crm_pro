#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect, HttpResponse
from django.urls import reverse
from django.forms import formset_factory
from django.utils.module_loading import import_string
from django.db.models import Q
# 本地库
from django.conf import settings
from rbac.models import *
from rbac.forms.menu import *
from rbac.utils.url import mark_reverse


def distribute_permission_list(request):
    '''一级菜单列表'''
    user_info = import_string(settings.RBAC_USER_MODEL_CLASS)
    user = user_info.objects.values('id', 'username')
    role = Role.objects.values('id', 'title', )
    uid = request.GET.get('uid')
    fid = request.GET.get('fid')
    rid = request.GET.get('rid')
    first_menu = FirstMenu.objects.values('id', 'title')
    if fid:
        if not rid and not uid:
            return HttpResponse('请选择用户或者角色')
        else:
            first_menu_obj = FirstMenu.objects.filter(pk=fid).first()
            second_menu = Permission.objects.filter(firstmenu__pk=fid).values('id', 'title', )
            menu_dic = {}
            for dic in second_menu:
                menu_dic[dic['id']] = dict(id=dic['id'], title=dic['title'], children=[])
                permission = Permission.objects.filter(parent_permission_id=dic['id']).values('id', 'title', )
                for dic1 in permission:
                    dic2 = dict(id=dic1['id'], title=dic1['title'], )
                    menu_dic[dic['id']]['children'].append(dic2)

    if request.method == 'POST':
        dic = request.POST
        role = Role.objects.filter(pk=rid).first() if rid else ''
        operation = dic.get('operation')
        if operation == 'userinfo2role':
            role_list = dic.getlist('role_id')
            if not role_list:
                return HttpResponse('角色选项为空,请重新提交')
            elif uid:
                user = user_info.objects.filter(pk=uid).first()
                if user:
                    user.roles.set(role_list)
                else:
                    return HttpResponse('用户不存在,请重新提交')
        elif operation == 'role2permission':
            permission_list = dic.getlist('permission_id')
            pk_list = Role.objects.filter(pk=rid).values('permissions__id', 'permissions__parent_permission__firstmenu',
                                                         'permissions__firstmenu')
            print(pk_list)
            for dic in pk_list:
                if int(fid) == dic['permissions__parent_permission__firstmenu'] or \
                        int(fid) == dic['permissions__firstmenu']:
                    continue
                permission_list.append(str(dic['permissions__id']))
            permission_list = list(set(permission_list))
            if not permission_list:
                return HttpResponse('权限选项为空,请重新提交')
            elif role:
                role.permissions.set(permission_list)
            else:
                return HttpResponse('角色不存在,请重新提交')
        else:
            return HttpResponse('操作有误,请重新提交')
        return HttpResponse('OK')

    return render(request, 'rbac/distribute_permission/distribute_permission_list.html', locals())
