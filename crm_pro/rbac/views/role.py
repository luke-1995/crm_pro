#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect, HttpResponse
from django import forms
from django.urls import reverse
# 本地库
from rbac.models import *
from rbac.forms.role import RoleForm
from rbac.utils.get_all_url import get_all_url


def role_list(request):
    '''角色列表'''
    role = Role.objects.all()
    first_menu = FirstMenu.objects.filter(pk=1)
    for i in first_menu:
        dic = dict(title=i.title, children=[])  # icon=i.icon
        print(i.icon,type(i.icon),str(i.icon))
    return render(request, 'rbac/role/role_list.html', {'role': role})


def role_add(request):
    '''添加角色'''
    if request.method == 'POST':
        dic = request.POST
        form = RoleForm(dic)
        if form.is_valid():
            form.save()
            role_list_url = reverse('rbac:role_list')
            return redirect(role_list_url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    form = RoleForm()
    return render(request, 'rbac/change.html', {'form': form, })


def role_edit(request, role_pk):
    '''角色修改'''
    role = Role.objects.filter(id=role_pk).first()
    if request.method == 'POST':
        dic = request.POST
        form = RoleForm(instance=role, data=dic)  # 更新数据
        if form.is_valid():
            form.save()
            role_list_url = reverse('rbac:role_list')
            return redirect(role_list_url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    if role:
        form = RoleForm(instance=role)  # MODELFORM的方法
        return render(request, 'rbac/change.html', {'form': form, })
    else:
        return HttpResponse('404')


def role_del(request, role_pk):
    '''角色删除'''
    role = Role.objects.filter(id=role_pk).first()
    role_list_url = reverse('rbac:role_list')
    if not role:
        return HttpResponse('404')
    if request.method == 'POST':
        role.delete()
        return redirect(role_list_url)
    return render(request, 'rbac/delete.html', {'del_url': role_list_url})

