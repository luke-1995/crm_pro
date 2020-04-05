#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render
from django.urls import re_path
from django.utils.safestring import mark_safe

# 本地库
from stark.utils.stark_site import ModelHandler, mark_reverse, StarkForm
from web.utils.prevent_xss import xss


class ConsultRecordHandler(ModelHandler):
    field = ['note', 'consultant', 'date', '_edit', '_delete']
    per_page_count = 5
    list_html = 'web/consult_record_list.html'

    def get_main_url(self):
        li = []
        li.extend([
            re_path(r'^list/(?P<customer_id>\d+)/$', self.wrapper(self.list_view), name=self.get_url_name('list')),
            re_path(r'^add/(?P<customer_id>\d+)/$', self.wrapper(self.add_view), name=self.get_url_name('add')),
            re_path(r'^change/(?P<pk>\d+)/(?P<customer_id>\d+)/$', self.wrapper(self.change_view), name=self.get_url_name('change')),
            re_path(r'^del/(?P<pk>\d+)/(?P<customer_id>\d+)/$', self.wrapper(self.delete_view), name=self.get_url_name('del')),
        ])
        li.extend(self.extra_url())
        return li

    def get_query_set(self, *args, **kwargs):
        customer_id = kwargs.get('customer_id')
        user = self.request.user
        return self.model_class.objects.filter(consultant=user,customer_id=customer_id)

    def get_finally_result(self,request, pk=None, obj=None, operation=None, *args, **kwargs):
        '''
        对输出结果进行最后的过滤预留钩子
        :param request:
        :param pk:
        :param operation: 增删改查
        :param args:
        :param kwargs:
        :return:
        '''
        customer_id = kwargs.get('customer_id')
        consultant = request.user

        # if operation != 'list' and operation != 'add':
        if operation == 'list' or 'add':
            pass
        else:
            is_exists = self.model_class.objects.filter(customer_id=customer_id, consultant=consultant, pk=pk).exists()
            if not is_exists:
                return render(request, 'web/prompt.html', dict(prompt='无权访问'))
        return None


    def add_btn(self, *args, **kwargs):
        customer_id = kwargs.get('customer_id')
        url = mark_reverse(self.get_url_name('add', add_namespace=True), self.request,
                           customer_id) if self.have_add_btn else ''
        return mark_safe('<a href="%s" class="btn btn-info" style="margin: 5px 10px 5px 0;">添加</a>' % url)

    def get_model_form(self, *args, **kwargs):
        class StarkModelForm(StarkForm):
            class Meta:
                model = self.model_class
                fields = ['note']

            def clean(self):
                note = self.cleaned_data['note']
                self.cleaned_data['note'] = xss(note)
                return self.cleaned_data

        return StarkModelForm

    def save(self, form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        customer_id = kwargs.get('customer_id')
        consultant = self.request.user
        form.instance.customer_id = customer_id
        form.instance.consultant = consultant
        form.save()



