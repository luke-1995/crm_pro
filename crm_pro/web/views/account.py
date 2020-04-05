#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect,reverse
from django.contrib import auth
from django.http import JsonResponse
# 本地库
from web.models import UserInfo
from web.forms.user import UserInfoForm
from web.utils.login import login_flag
from web.utils.register import get_flag


def login(request):
    if request.method == 'POST':
        return JsonResponse(login_flag(request))
    else:
        index_url = reverse('web:index', args=())
        next_url = request.GET.get('next', index_url)
        return render(request, 'login.html', locals())


def register(request):
    if request.is_ajax():
        return JsonResponse(get_flag(request))
    form = UserInfoForm()

    return render(request, 'register.html', locals())


def index(request):
    return render(request, 'index.html')


def logout(request):
    auth.logout(request)
    index_url = reverse('web:index', args=())
    next_url = request.GET.get('next', index_url)
    return redirect('/login/?next=%s' % next_url)