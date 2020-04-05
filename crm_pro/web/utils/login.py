#!usr/bin/env python
# -*- coding:utf-8 -*-

from django.contrib import auth

from rbac.utils.initialise_permission import user_permission

def login_flag(request):
    flag = {'status': True, 'msg': None}
    dic = request.POST
    username = dic.get('user')
    pwd = dic.get('pwd')
    user = auth.authenticate(username=username, password=pwd)
    if user:
        auth.login(request, user)
        dic_get = request.GET
        user_permission(request, user)  # 用户初始化
        next_url = dic_get.get('next', '/index/')
    else:
        flag['status'] = False
        flag['msg'] = '用户名或密码错误'
    return flag
