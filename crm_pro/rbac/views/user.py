#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect, HttpResponse
from django.urls import reverse
from django.utils.module_loading import import_string
# 本地库
from django.conf import settings
from rbac.forms.user import UserInfoForm, UpdateUserForm, ResetPwdForm

UserInfo = import_string(settings.RBAC_USER_MODEL_CLASS)


def user_list(request):
    '''用户列表'''
    user = UserInfo.objects.all()
    return render(request, 'rbac/user/user_list.html', {'user': user})


def user_add(request):
    '''添加用户'''
    if request.method == 'POST':
        dic = request.POST
        form = UserInfoForm(dic)
        if form.is_valid():
            username = dic.get('username')
            password = dic.get('password')
            UserInfo.objects.create_user(username=username, password=password)
            url = reverse('rbac:user_list')
            return redirect(url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    form = UserInfoForm()
    return render(request, 'rbac/change.html', {'form': form, })


def user_edit(request, user_pk):
    user = UserInfo.objects.filter(id=user_pk).first()
    if request.method == 'POST':
        dic = request.POST
        form = UpdateUserForm(instance=user, data=dic)  # 更新数据
        if form.is_valid():
            form.save()
            url = reverse('rbac:user_list')
            return redirect(url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    if user:
        form = UpdateUserForm(instance=user)  # MODELFORM的方法
        return render(request, 'rbac/change.html', {'form': form, })
    else:
        return HttpResponse('404')


def user_del(request, user_pk):
    user = UserInfo.objects.filter(id=user_pk).first()
    user_list_url = reverse('rbac:user_list')
    if not user:
        return HttpResponse('404')
    if request.method == 'POST':
        user.delete()
        return redirect(user_list_url)
    return render(request, 'rbac/delete.html', {'del_url': user_list_url})


def user_reset_pwd(request, user_pk):
    '''重设密码'''
    user = UserInfo.objects.filter(id=user_pk).first()
    if request.method == 'POST':
        dic = request.POST
        form = ResetPwdForm(dic)
        if form.is_valid():
            pwd = dic.get('password')
            user.set_password(pwd)
            user.save()
            url = reverse('rbac:user_list')
            return redirect(url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    if user:
        form = ResetPwdForm()  # MODELFORM的方法
        return render(request, 'rbac/change.html', {'form': form, })
    else:
        return HttpResponse('404')
