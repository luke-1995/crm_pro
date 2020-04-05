#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import re
from collections import OrderedDict
# 第三方模块
from django.utils.module_loading import import_string
from django.urls.resolvers import URLPattern, URLResolver

# 本地库
from django.conf import settings


def get_all_url():
    '''自动查找所有有别名的url'''
    url_order_dict = OrderedDict()  # 为了使字典变得有序
    model = import_string(settings.ROOT_URLCONF)  # 基于字符串导入模块
    recursion_urls(None, r'/', model.urlpatterns, url_order_dict)  # 递归去获取所有的路由
    return url_order_dict


def recursion_urls(pre_namespace, pre_url, url_patterns, url_order_dict):
    '''
    对url进行递归,然后字典的形式存储到url_order_dict
    :param pre_namespace: 若有名称空间,且有别名,则有前缀
    :param per_url: url的前缀
    :param url_patterns:路由关系列表
    :param url_order_dict: 用于存储递归中获取的所有路由
    :return:
    '''
    for i in url_patterns:
        if isinstance(i, URLPattern) and i.name:  # 非路由分发
            if pre_namespace:
                name = pre_namespace + ':' + i.name
            else:
                name = i.name
            url = pre_url + str(i.pattern)
            url = url.replace('^', '').replace('$', '')
            if check_url_exclude(url):
                continue
            url_order_dict[name] = dict(name=name, url=url)
        elif isinstance(i, URLResolver):
            if pre_namespace and i.namespace:
                namespace = pre_namespace + ':' + i.namespace
            elif not pre_namespace and i.namespace:
                namespace = i.namespace
            else:
                namespace = None
            # 当前url获取的另外一种方式 i.pattern.regex.pattern.strip("^$")
            recursion_urls(namespace, pre_url + str(i.pattern), i.url_patterns, url_order_dict)


def check_url_exclude(url):
    """
    排除一些特定的URL
    :param url:
    :return:
    """
    for regex in settings.AUTO_DISCOVER_EXCLUDE:  # 在配置文件中设置排除搜索的url名单
        if re.match(regex, url):
            return True
