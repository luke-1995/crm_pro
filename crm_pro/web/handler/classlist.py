#!usr/bin/env python
# -*- coding:utf-8 -*-
# 第三方模块
from django.shortcuts import reverse
from django.utils.safestring import mark_safe
from django.shortcuts import render
# 本地库
from stark.utils.stark_site import ModelHandler
from web.models import ClassList


class ClassListHandler(ModelHandler):
    field = ['_course', 'tech_teachers', '_record','_homework' ,'_edit', '_delete']
    search_list = ['name__contains']
    per_page_count = 5

    def _course(self, obj=None):
        # url = mark_url(self.get_url_name('reset_pwd', add_namespace=True), self.request, obj.pk) if obj else '#'
        course = '%s %s期' % (obj.course, obj.semester) if obj else ''
        return ['课程', course]

    @staticmethod
    def _record(obj=None):
        url = reverse('stark:web_courserecord_list', args=(obj.pk,)) if obj else '#'
        return ['上课记录', mark_safe('<a href="%s" target="_blank">上课记录</a>' % url)]

    @staticmethod
    def _homework(obj=None):
        url = reverse('stark:web_homework_list', args=(obj.pk,)) if obj else '#'
        return ['布置作业', mark_safe('<a href="%s" target="_blank">布置作业</a>' % url)]

    @staticmethod
    def get_edit_form(model_form, obj):
        if obj.start_date:
            obj.start_date = obj.start_date.strftime('%Y-%m-%d')
        if obj.graduate_date:
            obj.graduate_date = obj.graduate_date.strftime('%Y-%m-%d')
        return model_form(instance=obj)

    def get_query_set(self, *args, **kwargs):
        '''为quest_set过滤预留钩子'''
        user = self.request.user
        return self.model_class.objects.all().filter(tech_teachers=user)
