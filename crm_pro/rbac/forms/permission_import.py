#!usr/bin/env python
# -*- coding:utf-8 -*-


import re

from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError
from django.db.models import Q

from rbac.models import *


class PermissionForm(forms.Form):
    '''批量添加权限校验'''
    title = forms.CharField(label='url名称', max_length=32, )
    url = forms.CharField(label='含有正则的url', max_length=64, )
    name = forms.CharField(label='url的别名', max_length=32, )
    parent_permission_id = forms.ChoiceField(label='父级菜单', widget=forms.Select(), choices=[(None, '----')],
                                             required=False)
    firstmenu_id = forms.ChoiceField(label='一级菜单', widget=forms.Select(), choices=[(None, '----')], required=False)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
        self.fields['firstmenu_id'].choices += FirstMenu.objects.values_list('id', 'title')
        self.fields['parent_permission_id'].choices += Permission.objects.filter(
            parent_permission_id__isnull=True).exclude(
            firstmenu__isnull=True).values_list('id', 'title')

    def clean_name(self):
        val = self.cleaned_data.get('name')
        ret = Permission.objects.filter(name=val)
        if not ret:
            return val
        else:
            raise ValidationError('该别名已存在')


class UpdatePermissionForm(forms.Form):
    '''批量更新权限'''
    id = forms.IntegerField()
    title = forms.CharField(label='url名称', max_length=32, )
    url = forms.CharField(label='含有正则的url', max_length=64, )
    name = forms.CharField(label='url的别名', max_length=32, )
    parent_permission_id = forms.ChoiceField(label='父级菜单', widget=forms.Select(), choices=[(None, '----')],
                                             required=False)
    firstmenu_id = forms.ChoiceField(label='一级菜单', widget=forms.Select(), choices=[(None, '----')], required=False)
    id.widget = widgets.HiddenInput()

    def clean_name(self):
        print(self.cleaned_data)
        id = self.cleaned_data.get('id')
        val = self.cleaned_data.get('name')
        ret = Permission.objects.filter(~Q(pk=id), name=val)
        print(ret)
        if not ret:
            return val
        else:
            raise ValidationError('该别名已存在')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
        self.fields['firstmenu_id'].choices += FirstMenu.objects.values_list('id', 'title')
        self.fields['parent_permission_id'].choices += Permission.objects.filter(
            parent_permission_id__isnull=True).exclude(
            firstmenu__isnull=True).values_list('id', 'title')
