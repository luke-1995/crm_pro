#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
import functools
# 第三方模块
from django.urls import path, re_path
from django.conf.urls import url
from django.utils.safestring import mark_safe
from django.shortcuts import HttpResponse, render, redirect
from django.db.models import Q, ForeignKey, ManyToManyField
from django import forms
from django.core.exceptions import ValidationError
# 本地库
from stark.utils.paginator import Pagination
from stark.utils.url import mark_url, mark_reverse
from stark.forms.stark import StarkForm
from web.utils.decorator import add_permission, edit_permission, del_permission


class ModelHandler:
    field = []
    per_page_count = 10
    have_add_btn = True
    add_model_form = None
    update_model_form = None
    order_list = []
    search_list = []  # 定制在哪一列进行搜索
    batch_operation = {}
    search_group = []
    list_html = 'stark/list.html'
    add_html = 'stark/change.html'
    change_html = 'stark/change.html'
    del_html = 'stark/delete.html'
    not_find_html = 'stark/not_find.html'
    StarkForm = StarkForm

    def __init__(self, site, model_class, prev=None):
        self.site = site
        self.model_class = model_class
        self.prev = prev
        self.app_name = model_class._meta.app_label
        self.model_name = model_class._meta.model_name
        self.request = None

    def get_field(self, *args, **kwargs):
        '''为用户自定义列预留钩子'''
        li = []
        li.extend(self.field)
        # li.append('_edit')
        # li.append('_delete')
        return li

    def get_search_group(self):
        '''组合搜索钩子'''
        return self.search_group

    @edit_permission
    def _edit(self, obj=None, *args, **kwargs):
        url = mark_url(self.get_url_name('change', add_namespace=True), self.request, pk=obj.pk, *args,
                       **kwargs) if obj else '#'
        return ['编译', mark_safe('<a href="%s" class="btn btn-default btn-sm">编译</a>' % url)]

    @del_permission
    def _delete(self, obj=None, *args, **kwargs):
        url = mark_url(self.get_url_name('del', add_namespace=True), self.request, pk=obj.pk, *args,
                       **kwargs) if obj else '#'
        return ['删除', mark_safe('<a href="%s" class="btn btn-default btn-sm">删除</a>' % url)]

    @add_permission
    def add_btn(self, *args, **kwargs):
        url = mark_reverse(self.get_url_name('add', add_namespace=True), self.request, *args,
                           **kwargs) if self.have_add_btn else ''
        return mark_safe('<a href="%s" class="btn btn-info" style="margin: 5px 10px 5px 0;">添加</a>' % url)

    @staticmethod
    def _checkbox(obj=None, *args, **kwargs):
        checkbox = mark_safe('<input type="checkbox" name="pk" value="%s" />' % obj.pk) if obj else ''
        return ['选择', checkbox]

    def batch_delete(self, *args, **kwargs):
        '''批量删除'''
        pk_list = self.request.POST.getlist('pk')
        self.model_class.objects.filter(id__in=pk_list).delete()

    def get_query_set(self, *args, **kwargs):
        '''为quest_set过滤预留钩子'''
        return self.model_class.objects.all()

    def get_filter_query_set(self, *args, **kwargs):
        '''过滤经过搜索栏搜索或者组合搜索的query_set对象'''
        query_set = self.get_query_set(*args, **kwargs)
        search_value = self.request.GET.get('q', '')
        conn = Q()
        conn.connector = 'OR'
        search_group_condition = self.get_group_search_condition(*args, **kwargs)
        if search_value:
            for i in self.search_list:
                conn.children.append((i, search_value))
        query_set = query_set.filter(conn).filter(**search_group_condition).order_by(
            *self.get_order_list())
        return query_set

    def get_group_search_condition(self, *args, **kwargs):
        '''获取组合搜索条件'''
        condition = {}
        dic = self.request.GET
        for obj in self.get_search_group_list():
            if obj.field in dic:
                if obj.is_multi:
                    pk_list = dic.getlist(obj.field)
                    if not pk_list:
                        continue
                    condition['%s__in' % obj.field] = pk_list
                else:
                    pk = dic.get(obj.field)
                    if not pk:
                        continue
                    condition[obj.field] = pk
        return condition

    def get_search_group_list(self, *args, **kwargs):
        '''获取组合搜索的面板信息'''
        search_group = self.get_search_group()
        search_group_list = []
        condition = ''
        if search_group:
            for i in search_group:
                search_group_list.append(i.get_special_field(self.model_class, self.request, *args, **kwargs))
        return search_group_list

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
        return None

    def list_view(self, request, *args, **kwargs):
        """
        列表页面
        :param request:
        :return:
        """
        obj = self.get_filter_query_set(*args, **kwargs)
        pager = Pagination(
            current_page=request.GET.get('page'),
            all_count=obj.count(),
            base_url=request.path_info,
            query_params=Pagination.get_query_params(request),
            per_page=self.per_page_count,
        )
        self.query_set = obj[pager.start:pager.end]
        if request.method == 'POST':
            dic = request.POST
            batch_operation = dic.get('batch_operation')
            if batch_operation and batch_operation in self.batch_operation:
                ret = getattr(self, batch_operation)(*args, **kwargs)
                if ret:
                    return ret
            else:
                return HttpResponse('选项错误,请重新操作')
        thead_list, tbody_list = self.get_list_table(*args, **kwargs)
        result = self.get_finally_result(request=request, obj=obj, operation='list', *args, **kwargs)
        return result or render(request, self.list_html,
                                dict(thead_list=thead_list,
                                     tbody_list=tbody_list,
                                     pager=pager,
                                     add_btn=self.add_btn(*args, **kwargs) if self.have_add_btn else '',
                                     search_list=self.search_list,
                                     search_value=request.GET.get('q', ''),
                                     batch_operation=self.batch_operation,
                                     search_group_list=self.get_search_group_list()
                                     ))

    def get_list_table(self, *args, **kwargs):
        thead_list = []
        tbody_list = []
        if self.get_field(*args, **kwargs):
            for i in self.get_field(*args, **kwargs):
                if hasattr(self.model_class, i):
                    verbose_name = self.model_class._meta.get_field(i).verbose_name
                    if verbose_name:
                        thead_list.append(verbose_name)
                    else:
                        thead_list.append(i)
                else:
                    if hasattr(self, i):
                        func = getattr(self, i)
                        if not func(*args, **kwargs):
                            continue
                        thead_list.append(func(*args, **kwargs)[0])
                    else:
                        raise KeyError('组件不支持该字段或model_class中没有该字段')
            for row in self.query_set:
                tr_list = []
                for i in self.get_field(*args, **kwargs):
                    if hasattr(self.model_class, i):
                        method = "get_%s_display" % i
                        if hasattr(row, method):
                            func = getattr(row, method)
                            tr_list.append(func())
                        else:
                            model_class = self.model_class._meta.get_field(i)
                            if isinstance(model_class, ManyToManyField):
                                m2m = ''
                                queryset = getattr(row, i).all()
                                for model_class in queryset:
                                    m2m += '%s,' % str(model_class)
                                tr_list.append(m2m)
                            else:
                                tr_list.append(getattr(row, i))
                    else:
                        if hasattr(self, i):
                            func = getattr(self, i)
                            if not func(obj=row, *args, **kwargs):
                                continue
                            tr_list.append(func(obj=row, *args, **kwargs)[1])
                        else:
                            raise KeyError('组件不支持该字段或model_class中没有该字段')
                tbody_list.append(tr_list)
        else:
            thead_list.append(self.model_name)
            tbody_list.append(self.model_class.objects.all())
        return (thead_list, tbody_list)

    def get_order_list(self):
        return self.order_list or ['-id', ]

    def add_view(self, request, *args, **kwargs):
        """
        添加页面
        :param request:
        :return:
        """
        model_form = self.add_model_form if self.add_model_form else self.get_model_form(*args, **kwargs)
        form = model_form()
        if request.method == 'POST':
            dic = request.POST
            form = model_form(dic)
            if form.is_valid():
                result = self.save(form, *args, **kwargs)
                _url = mark_reverse(self.get_url_name('list', add_namespace=True), self.request, *args, **kwargs)
                return result or redirect(_url)
            return render(request, self.add_html, {'form': form, 'form.errors': form.errors})
        result = self.get_finally_result(request, opeation='add', *args, **kwargs)
        return result or render(request, self.add_html, dict(form=form))

    def change_view(self, request, pk, *args, **kwargs):
        """
        编辑页面
        :param request:
        :param pk:
        :return:
        """
        obj = self.get_query_set(*args, **kwargs).filter(pk=pk).first()
        model_form = self.update_model_form if self.update_model_form else self.get_model_form(*args, **kwargs)
        if request.method == 'POST':
            dic = request.POST
            form = model_form(instance=obj, data=dic)  # 更新数据
            if form.is_valid():
                result = self.save(form, is_update=True, *args, **kwargs)
                _url = mark_reverse(self.get_url_name('list', add_namespace=True), self.request, *args, **kwargs)
                return result or redirect(_url)
            return render(request, self.change_html, {'form': form, 'form.errors': form.errors})
        if obj:
            form = self.get_edit_form(model_form, obj)
            result = self.get_finally_result(request, pk, obj=obj, operation='change', *args, **kwargs)
            return result or render(request, self.change_html, dict(form=form))
        else:
            return render(request, self.not_find_html)  # 404

    @staticmethod
    def get_edit_form(model_form, obj):
        '''为编辑页面的form对象预留钩子'''
        return model_form(instance=obj)

    @staticmethod
    def save(form, is_update=False, *args, **kwargs):
        '''保存表单前提供了钩子,以便做处理'''
        form.save()
        return None

    def delete_view(self, request, pk, *args, **kwargs):
        """
        删除页面
        :param request:
        :param pk:
        :return:
        """
        obj = self.get_query_set(*args, **kwargs).filter(pk=pk).first()
        _url = mark_reverse(self.get_url_name('list', add_namespace=True), self.request, *args, **kwargs)
        if not obj:
            return render(request, self.not_find_html)  # 404
        if request.method == 'POST':
            result = self.delete(obj, *args, **kwargs)
            return result or redirect(_url)
        result = self.get_finally_result(request, pk, obj=obj, operation='del', *args, **kwargs)
        return result or render(request, self.del_html, {'del_url': _url})

    @staticmethod
    def delete(obj, *args, **kwargs):
        '''删除前前提供了钩子,以便做处理'''
        obj.delete()
        return None

    def wrapper(self, func):
        '''避免函数再次传参,直接调用self的属性即可'''

        @functools.wraps(func)
        def inner(request, *args, **kwargs):
            self.request = request
            return func(request, *args, **kwargs)

        return inner

    def get_main_url(self, *args, **kwargs):
        li = []
        li.extend([
            re_path(r'^list/$', self.wrapper(self.list_view), name=self.get_url_name('list')),
            re_path(r'^add/$', self.wrapper(self.add_view), name=self.get_url_name('add')),
            re_path(r'^change/(?P<pk>\d+)/$', self.wrapper(self.change_view), name=self.get_url_name('change')),
            re_path(r'^del/(?P<pk>\d+)/$', self.wrapper(self.delete_view), name=self.get_url_name('del')),
        ])
        li.extend(self.extra_url())
        return li

    def extra_url(self):
        '''添加路由url钩子'''
        return []

    def get_url_name(self, operation, add_namespace=False):
        name = '%s_%s_%s_%s' % (self.app_name, self.model_name, self.prev, operation) if self.prev else '%s_%s_%s' % (
            self.app_name, self.model_name, operation)
        if add_namespace and self.site.namespace:
            name = '%s:%s' % (self.site.namespace, name)
        return name

    def get_model_form(self, form=None, li=None, *args, **kwargs):
        form = form or self.StarkForm

        class StarkModelForm(form):
            class Meta:
                model = self.model_class
                fields = li or '__all__'

        return StarkModelForm


class GroupSearch:
    def __init__(self, field, condition=None, is_multi=False, text_func=None, value_func=None):
        '''

        :param field:
        :param condition:类型是字典
        '''
        self.field = field
        self.text_func = text_func
        self.value_func = value_func
        self.condition = condition if not condition else {}
        self.group_search_row = None
        self.verbose_name = None
        self.is_multi = is_multi

    def get_condition(self, request, *args, **kwargs):
        '''预留条件钩子'''
        return self.condition

    def get_special_field(self, model_class, request, *args, **kwargs):
        obj = model_class._meta.get_field(self.field)
        verbose_name = obj.verbose_name
        if isinstance(obj, ForeignKey) or isinstance(obj, ManyToManyField):
            condition = self.get_condition(request)
            print(model_class.objects.filter(**condition))
            related_model = obj.related_model.objects.filter(**condition)
            li = []
            for i in related_model:
                li.append((i.pk, str(i)))
            return GroupSearchHandler(li, verbose_name, request, self)
        elif hasattr(obj, 'choices'):
            return GroupSearchHandler(obj.choices, verbose_name, request, self)
        else:
            raise ValueError('输入的参数不是外键的字段或者有choice属性的字段')


class GroupSearchHandler:
    def __init__(self, group_search_list, verbose_name, request, group_search_obj):
        self.group_search_list = group_search_list
        self.verbose_name = verbose_name
        self.text_func = group_search_obj.text_func
        self.value_func = group_search_obj.value_func
        self.field = group_search_obj.field
        self.is_multi = group_search_obj.is_multi
        self.request = request

    def __iter__(self):
        yield '<div class="whole">%s</div>' % self.verbose_name
        yield '<div class="others">'
        _url, active = self.get_whole_url()
        yield "<a href='?%s' class='%s' >全部</a>" % (_url, active)

        for i in self.group_search_list:
            text = self.get_text(i)
            _url, active = self.get_url(i)
            yield "<a href='?%s' class='%s' >%s</a>" % (_url, active, text)
        yield '</div>'

    def get_text(self, field_list):
        if self.text_func:
            return self.text_func(self.group_search_list)
        return field_list[1]

    def get_url(self, field_list):
        query_dict = self.request.GET.copy()
        query_dict._mutable = True
        pk = query_dict.get(self.field)
        value = str(self.get_value(field_list))
        active = ''
        if pk:
            if self.is_multi:
                pk_list = query_dict.getlist(self.field)
                if value in pk_list:
                    active = 'active'
                    query_dict.pop(self.field)
                else:
                    active = ''
                    pk_list.append(value)
                    query_dict.setlist(self.field, pk_list)
            else:
                if pk == value:
                    active = 'active'
                    query_dict.pop(self.field)
                else:
                    active = ''
                    query_dict[self.field] = value
        else:
            query_dict[self.field] = self.get_value(field_list)
        return [query_dict.urlencode(), active]

    def get_whole_url(self):
        query_dict = self.request.GET.copy()
        query_dict._mutable = True
        pk_list = query_dict.getlist(self.field)
        active = ''
        if pk_list:
            query_dict.pop(self.field)
        else:
            # query_dict[self.field] = pk_list
            active = 'active'
        return [query_dict.urlencode(), active]

    def get_value(self, field_list):
        if self.value_func:
            return self.value_func(self.group_search_list)
        return field_list[0]


class StarkSite:
    def __init__(self):
        self._registry = []
        self.app_name = 'stark'
        self.namespace = 'stark'

    def get_urls(self):
        li = []
        for dic in self._registry:
            model_class = dic.get('model_class')
            handler = dic.get('handler')
            prev = dic.get('prev')
            app_label = model_class._meta.app_label
            model_name = model_class._meta.model_name
            prev_url = r'^%s/%s/' % (app_label, model_name) + prev + '/' if prev else '^%s/%s/' % (
                app_label, model_name)
            li.append(re_path(prev_url, (handler.get_main_url(), None, None)))
        return li

    @property
    def url(self):
        return (self.get_urls(), self.app_name, self.namespace)

    def register(self, model_class, handler_class=ModelHandler, prev=None):
        '''
        用于给model对象注册
        :param model_class:
        :param handler_class:一个用于处理表格增删改查的类 ,默认使用ModelHandler,也可以继承后自定义相应的功能
        :param prev: 路由前缀
        :return:
        '''
        return dict(model_class=model_class, handler=handler_class(self, model_class, prev), prev=prev)


site = StarkSite()
