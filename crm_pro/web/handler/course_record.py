#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.urls import re_path
from django.shortcuts import render
from django.shortcuts import reverse
from django.utils.safestring import mark_safe
from django.forms.models import modelformset_factory
# 本地库
from stark.utils.stark_site import ModelHandler,StarkForm,Pagination
from web import models


class CourseRecordHandler(ModelHandler):
    '''
    上课记录
    '''
    field = [
        '_checkbox',
        'class_object',
        'day_num',
        'teacher',
        'date',
        '_student_record',
        '_edit',
        '_delete'
    ]
    batch_operation = dict(batch_create_record='批量生成班级学生考勤表')
    per_page_count = 5

    def batch_create_record(self,*args,**kwargs):
        '''批量生成班级学生考勤表'''
        pk_list = self.request.POST.getlist('pk')
        class_id = kwargs.get('class_id')
        user = self.request.user
        for pk in pk_list:
            course_record=self.model_class.objects.filter(class_object_id=class_id,pk=pk,teacher=user).first()
            if not course_record:
                continue
            is_exists = models.StudyRecord.objects.filter(course_record=course_record).exists()
            if is_exists:
                continue
            student= models.Student.objects.filter(class_list__id=class_id)
            student_record = [models.StudyRecord(student=obj,course_record=course_record) for obj in student]
            models.StudyRecord.objects.bulk_create(student_record,batch_size=50)

    def get_main_url(self, *args, **kwargs):
        li = []
        li.extend([
            re_path(r'^list/(?P<class_id>\d+)/$', self.wrapper(self.list_view), name=self.get_url_name('list')),
            re_path(r'^add/(?P<class_id>\d+)/$', self.wrapper(self.add_view), name=self.get_url_name('add')),
            re_path(r'^change/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.change_view),
                    name=self.get_url_name('change')),
            re_path(r'^del/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.delete_view),
                    name=self.get_url_name('del')),
            re_path(r'^student_record/(?P<pk>\d+)/(?P<class_id>\d+)/$', self.wrapper(self.student_record_view),
                    name=self.get_url_name('student_record')),
        ])
        li.extend(self.extra_url())
        return li

    def student_record_view(self, request, pk, *args, **kwargs):
        """
        学生考勤页面
        :param request:
        :param pk:
        :return:
        """
        formset_class = modelformset_factory(models.StudyRecord,form=self.get_student_record_form( *args, **kwargs),extra=0)
        queryset= models.StudyRecord.objects.filter(course_record_id=pk)
        pager = Pagination(
            current_page=request.GET.get('page'),
            all_count=queryset.count(),
            base_url=request.path_info,
            query_params=Pagination.get_query_params(request),
            per_page=self.per_page_count,
        )
        queryset = queryset.order_by('pk')[pager.start:pager.end]
        formset = formset_class(queryset=queryset)
        if request.method == 'POST':
            formset = formset_class(queryset=queryset,data=request.POST)
            if formset.is_valid():
                formset.save()
            return render(request, 'web/student_record.html', {'formset': formset})
        result = self.get_finally_result(request, pk, opeation='student_record', *args, **kwargs)
        return result or render(request, 'web/student_record.html', dict(formset=formset,pager=pager))

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
            is_exists = models.CourseRecord.objects.filter(class_object_id=class_id, teacher=user,id=pk).exists()
            if not is_exists:
                return render(request, 'web/prompt.html', dict(prompt='无权访问'))
        return None

    def get_model_form(self, form=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = self.model_class
                fields = ['day_num']

        return StarkModelForm

    def get_student_record_form(self, form=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = models.StudyRecord
                fields = ['record']

        return StarkModelForm


    def save(self, form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        class_id = kwargs.get('class_id')
        user = self.request.user
        form.instance.class_object_id = class_id
        form.instance.teacher = user
        form.save()

    @staticmethod
    def _student_record(obj=None,*args,**kwargs):
        class_id = kwargs.get('class_id')
        url = reverse('stark:web_courserecord_student_record',args=(obj.pk,class_id)) if obj else '#'
        return ['学生考勤记录', mark_safe('<a href="%s" target="_blank">学生考勤记录</a>' % url)]
