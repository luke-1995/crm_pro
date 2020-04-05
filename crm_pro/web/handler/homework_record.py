#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import os
# 第三方模块
from django.shortcuts import render
from django.urls import re_path
from django.utils.safestring import mark_safe
from django import forms
from django.conf import settings
# 本地库
from stark.utils.stark_site import ModelHandler,mark_url
from web import models


class HomeworkRecordHandler(ModelHandler):
    field = [
        'homework',
        'homework_status',
        '_edit',
        'mark',
    ]
    per_page_count = 5
    have_add_btn = False

    def get_main_url(self, *args, **kwargs):
        li = []
        li.extend([
            re_path(r'^list/$', self.wrapper(self.list_view), name=self.get_url_name('list')),
            re_path(r'^change/(?P<pk>\d+)/$', self.wrapper(self.change_view), name=self.get_url_name('change')),
        ])
        li.extend(self.extra_url())
        return li

    def _edit(self, obj=None, *args, **kwargs):
        url = mark_url(self.get_url_name('change', add_namespace=True), self.request, pk=obj.pk, *args,
                       **kwargs) if obj else '#'
        return ['提交作业', mark_safe('<a href="%s" class="btn btn-default btn-sm">提交作业</a>' % url)]

    def get_model_form(self, form=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = self.model_class
                fields = ['file']
                widgets = {
                    "file": forms.widgets.FileInput(attrs={'class': 'form-control'}),
                }

        return StarkModelForm

    def save(self, form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        file_obj = self.request.FILES.get('file',)
        form.instance.homework_status = 2
        if file_obj.content_type != 'application/x-zip-compressed':
            return render(self.request, 'web/prompt.html', dict(prompt='请提交zip文件类型'))
        if form.instance.file:
            path = os.path.join(settings.MEDIA_ROOT,str(form.instance.file))
            if os.path.isfile(path):
                os.remove(path)
        file_obj.name = '%s的作业' % str(form.instance.student)
        form.instance.file = file_obj
        if form.instance.file_count == 2:
            return render(self.request, 'web/prompt.html', dict(prompt='超过提交次数'))
        form.instance.file_count += 1
        form.save()


    @staticmethod
    def get_finally_result(request, pk=None, obj=None, operation=None, *args, **kwargs):
        '''
        对输出结果进行最后的过滤预留钩子
        :param request:
        :param pk:
        :param operation: 增删改查
        :param args:
        :param kwargs:
        :return:
        '''
        user = request.user
        if operation == 'list':
            pass
        else:
            is_exists = models.HomeworkRecord.objects.filter(student__userinfo=user,pk=pk).exists()
            if not is_exists:
                return render(request, 'web/prompt.html', dict(prompt='无权访问'))
        return None

    def get_query_set(self, *args, **kwargs):
        '''为quest_set过滤预留钩子'''
        user = self.request.user
        return self.model_class.objects.filter(student__userinfo__id=user.id)







