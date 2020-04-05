#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.urls import reverse
from django.http import QueryDict


# 本地库

def mark_url(name, request, *args, **kwargs):
    '''对url进行标志'''
    basic_url = reverse(name, args=args, kwargs=kwargs)
    query_dict = QueryDict(mutable=True)
    query_dict["_pack"] = request.GET.urlencode()
    url = basic_url + '?' + query_dict.urlencode()
    return url


def mark_reverse(name, request, *args, **kwargs):
    '''反向解析'''
    basic_url = reverse(name, args=args, kwargs=kwargs)
    _pack = request.GET.get('_pack')
    url = basic_url + '?' + _pack if _pack else basic_url
    return url
