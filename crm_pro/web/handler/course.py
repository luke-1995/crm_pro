#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
# 本地库
from stark.utils.stark_site import ModelHandler


class CourseHandler(ModelHandler):
    field = ['name', '_edit', '_delete']
    search_list = ['name__contains']
    per_page_count = 5

