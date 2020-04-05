#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.urls import re_path
from django.shortcuts import render
from django.shortcuts import reverse,HttpResponse
from django.utils.safestring import mark_safe
from django.forms.models import modelformset_factory
from django import forms
# 本地库
from stark.utils.stark_site import ModelHandler,Pagination
from web import models
from web.utils.prevent_xss import xss


class HomeworkHandler(ModelHandler):
    field = [
        '_checkbox',
        'title',
        'teacher',
        'class_object',
        'create_time',
        '_homework_record',
        '_edit',
        '_delete'
    ]
    per_page_count = 5

    batch_operation = dict(batch_create_record='批量给班级学生布置作业')

    @staticmethod
    def _homework_record(obj=None,*args,**kwargs):
        class_id = kwargs.get('class_id')
        url = reverse('stark:web_homework_homework_record',args=(obj.pk,class_id)) if obj else '#'
        return ['学生提交作业记录', mark_safe('<a href="%s" target="_blank">学生提交作业记录</a>' % url)]


    def batch_create_record(self,*args,**kwargs):
        '''批量生成班级学生提交作业表'''
        pk_list = self.request.POST.getlist('pk')
        class_id = kwargs.get('class_id')
        user = self.request.user
        for pk in pk_list:
            homework=self.model_class.objects.filter(class_object_id=class_id,pk=pk,teacher=user).first()
            if not homework:
                continue
            is_exists = models.HomeworkRecord.objects.filter(homework=homework).exists()
            if is_exists:
                continue
            student= models.Student.objects.filter(class_list__id=class_id)
            homework_record = [models.HomeworkRecord(student=obj,homework=homework) for obj in student]
            models.HomeworkRecord.objects.bulk_create(homework_record,batch_size=50)

    def get_homework_record_form(self, form=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = models.HomeworkRecord
                fields = [
                    'mark',
                ]

        return StarkModelForm

    def homework_record_view(self, request, pk, *args, **kwargs):
        """
        学生提交作业记录页面
        :param request:
        :param pk:
        :return:
        """

        formset_class = modelformset_factory(models.HomeworkRecord,form=self.get_homework_record_form( *args, **kwargs),extra=0)
        queryset= models.HomeworkRecord.objects.filter(homework_id=pk)
        pager = Pagination(
            current_page=request.GET.get('page'),
            all_count=queryset.count(),
            base_url=request.path_info,
            query_params=Pagination.get_query_params(request),
            per_page=self.per_page_count,
        )
        queryset = queryset.order_by('-homework_status')[pager.start:pager.end]
        formset = formset_class(queryset=queryset)
        if request.method == 'POST':
            formset = formset_class(queryset=queryset,data=request.POST)
            if formset.is_valid():
                formset.save()
            return render(request, 'web/homework_record.html', dict(formset=formset,pager=pager))
        result = self.get_finally_result(request, pk, opeation='student_record', *args, **kwargs)
        return result or render(request, 'web/homework_record.html', dict(formset=formset,pager=pager))

    def get_main_url(self, *args, **kwargs):
        li = []
        li.extend([
            re_path(r'^list/(?P<class_id>\d+)/$', self.wrapper(self.list_view), name=self.get_url_name('list')),
            re_path(r'^add/(?P<class_id>\d+)/$', self.wrapper(self.add_view), name=self.get_url_name('add')),
            re_path(r'^change/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.change_view),
                    name=self.get_url_name('change')),
            re_path(r'^del/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.delete_view),
                    name=self.get_url_name('del')),
            re_path(r'^homework_record/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.homework_record_view),
                    name=self.get_url_name('homework_record')),
        ])
        li.extend(self.extra_url())
        return li

    def get_model_form(self, form=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = self.model_class
                fields = ['title','content']
                widgets = {
                    "content": forms.widgets.Textarea(attrs={'class': 'form-control'})
                }

            def clean(self):
                title = self.cleaned_data['title']
                self.cleaned_data['title'] = xss(title)
                content = self.cleaned_data['content']
                self.cleaned_data['content'] = xss(content)
                return self.cleaned_data

        return StarkModelForm

    def save(self, form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        class_id = kwargs.get('class_id')
        user = self.request.user
        form.instance.class_object_id = class_id
        form.instance.teacher = user
        form.save()

    def get_query_set(self, *args, **kwargs):
        user = self.request.user
        return self.model_class.objects.filter(teacher=user).all()

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
        class_id = kwargs.get('class_id')
        user = request.user
        if operation == 'list' or 'add':
            pass
        else:
            is_exists = models.Homework.objects.filter(class_object_id=class_id, teacher=user, id=pk).exists()
            if not is_exists:
                return render(request, 'web/prompt.html', dict(prompt='无权访问'))
        return None
