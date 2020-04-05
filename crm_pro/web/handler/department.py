#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
# 本地库
from stark.utils.stark_site import ModelHandler


class DepartmentHandler(ModelHandler):
    field = [ 'title', '_edit', '_delete']
    per_page_count = 5

