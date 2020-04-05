#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import re
# 第三方模块
from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import HttpResponse
# 本地库
from django.conf import settings


class RbacMiddleware(MiddlewareMixin):
    """
    用户权限中间件处理
    """

    def process_request(self, request):
        white_list = settings.WHITE_LIST
        login_white_list = settings.LOGIN_WHITE_LIST
        permission_dic = request.session.get(settings.PERMISSION_KEY)
        flag = False
        path = request.path_info
        username = request.user.username
        nav_path = [
            {'title': '首页', 'url': '/index/'}
        ]

        for url in white_list:
            if re.match(url, path):
                return None
        if not username:
            return HttpResponse('未登录')
        for url in login_white_list:
            if re.match(url, path):
                request.selected_id = 0
                request.nav_path = nav_path
                return None
        for permission in permission_dic.values():
            url = r'^%s$' % permission['url']
            if re.match(url, path):
                flag = True
                request.selected_id = permission['parent_permission_id'] or permission['id']  # 被选中的id存到request中
                if permission['parent_permission_id']:
                    dic = dict(title=permission['parent_permission_title'], url=permission['parent_permission_url'])
                    dic1 = dict(title=permission['title'], url=permission['url'])
                    # nav_path.extend([dic,dic1])
                    nav_path.append(dic)
                    nav_path.append(dic1)
                else:
                    dic = dict(title=permission['title'], url=permission['url'])
                    nav_path.append(dic)
                    request.selected_id = permission['id']
                request.nav_path = nav_path
                break
        if not flag:
            return HttpResponse('无权访问1')


'''
for url in login_white_list:
    if re.match(url, path):
        request.selected_id = 0
        request.nav_path = nav_path
        return None

'''
