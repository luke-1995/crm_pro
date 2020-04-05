#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect, HttpResponse
from django.urls import reverse
from django.forms import formset_factory
# 本地库
from rbac.models import *
from rbac.forms.menu import *
from rbac.utils.url import mark_reverse
from rbac.utils.permission_import import get_dic


def permission_import_add(request):
    '''批量导入菜单'''
    formset_class = formset_factory(PermissionForm, extra=2)
    # flag = False
    # msg = ''
    if request.method == 'POST':
        dic = request.POST
        formset = formset_class(dic)
        print(formset.errors)
        if formset.is_valid():
            for row in formset.cleaned_data:
                if row:
                    Permission(**row).save()
            return HttpResponse('OK')
        return render(request, 'rbac/import_change.html', locals())
    parent_permission = Permission.objects.filter(pk=request.session['second_menu_id']).first()
    # form = PermissionForm(initial={'parent_permission':parent_permission})
    formset = formset_class()
    return render(request, 'rbac/import_change.html', {'formset': formset, })


def permission_import_edit(request):
    '''批量修改菜单'''
    formset_class = formset_factory(UpdatePermissionForm, extra=0)
    permission = Permission.objects.filter(pk=2).values('pk', 'title', 'url', 'name', )
    print(permission)
    if request.method == 'POST':
        dic = request.POST
        formset = formset_class(data=dic)
        if formset.is_valid():
            for row in formset.cleaned_data:
                if row:
                    Permission(**row).save()
            return HttpResponse('OK')
        return render(request, 'rbac/import_change.html', locals())
    parent_permission = Permission.objects.filter(pk=request.session['second_menu_id']).first()
    formset = formset_class(initial=[{'pk': 2, 'title': '添加客户', 'url': '/customer/add/', 'name': 'customer_add'}])
    return render(request, 'rbac/import_change.html', {'formset': formset, })


def permission_import_list(request, ):
    operation = request.GET.get('operation')
    menu_list_url = mark_reverse('rbac:permission_import_list', request)
    if request.method == 'POST':
        if operation == 'add':
            dic = get_dic(add_data=request.POST, )
        elif operation == 'update':
            dic = get_dic(update_data=request.POST, )
        elif operation == 'del':
            dic = get_dic(is_del=True)
        else:
            dic = get_dic()
        return redirect(menu_list_url)
    elif operation == 'del':
        return render(request, 'rbac/delete.html', {'del_url': menu_list_url})
    else:
        dic = get_dic() # 自动搜索所有的url
    return render(request, 'rbac/permission_import/permission_import_list.html', dic)


def permission_import_del(request, permission_pk):
    menu = Permission.objects.filter(id=permission_pk).first()
    menu_list_url = mark_reverse('rbac:permission_import_list', request)
    if not menu:
        return HttpResponse('404')
    if request.method == 'POST':
        menu.delete()
        return redirect(menu_list_url)
    return render(request, 'rbac/delete.html', {'del_url': menu_list_url})
