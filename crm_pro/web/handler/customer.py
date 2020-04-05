#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.utils.safestring import mark_safe
from django.shortcuts import reverse
# 本地库
from stark.utils.stark_site import ModelHandler,mark_url
from web.forms.customer import CustomerForm


class CustomerHandler(ModelHandler):
    field = [ 'name','_record', '_edit', '_delete']
    search_list = ['title__contains']
    per_page_count = 5
    add_model_form = CustomerForm


    def get_query_set(self):
        user = self.request.user
        return self.model_class.objects.filter(consultant=user)

    def _record(self, obj=None):
        url = reverse('stark:web_consultrecord_list', args=(obj.pk,)) if obj else '#'
        return ['跟踪记录', mark_safe('<a href="%s" target="_blank">跟踪记录</a>' % url)]


    def save(self,form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        if not is_update:
            user = self.request.user
            form.instance.consultant=user
        form.save()
        return None



