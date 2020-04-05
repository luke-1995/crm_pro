#!usr/bin/env python
# -*- coding:utf-8 -*-


import re

from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError
from django.utils.safestring import mark_safe
from django.db.models import Q

from rbac.models import *


class MenuForm(forms.ModelForm):
    class Meta:
        model = FirstMenu
        fields = ['title', 'icon', ]

    # def clean_title(self):
    #     val = self.cleaned_data.get('title')
    #     ret = FirstMenu.objects.filter(title=val)
    #     if not ret:
    #         return val
    #     else:
    #         raise ValidationError('该一级菜单已存在')

    def __init__(self, *args, **kwargs):
        super(MenuForm, self).__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
            if name == 'icon':
                icon = list(Icon.objects.all().values_list('id', 'content'))
                for i in range(len(icon)):
                    icon[i] = list(icon[i])
                    icon[i][1] = mark_safe(icon[i][1])
                field.widget = widgets.RadioSelect(choices=icon)


class SecondMenuForm(forms.ModelForm):
    class Meta:
        model = Permission
        fields = ['title', 'url', 'name', 'icon', 'firstmenu']

    # def clean_title(self):
    #     val = self.cleaned_data.get('title')
    #     ret = Permission.objects.filter(title=val)
    #     if not ret:
    #         return val
    #     else:
    #         raise ValidationError('该二级菜单已存在')

    def __init__(self, *args, **kwargs):
        super(SecondMenuForm, self).__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
            if name == 'icon':
                icon = list(Icon.objects.all().values_list('id', 'content'))
                for i in range(len(icon)):
                    icon[i] = list(icon[i])
                    icon[i][1] = mark_safe(icon[i][1])
                field.widget = widgets.RadioSelect(choices=icon)

    # def clean_url(self):
    #     val = self.cleaned_data.get('url')
    #     ret = Permission.objects.filter(url=val)
    #     if not ret:
    #         return val
    #     else:
    #         raise ValidationError('该url已存在')


class PermissionForm(forms.Form):
    # id = forms.IntegerField()
    # id.widget = widgets.HiddenInput()
    title = forms.CharField(label='url名称', max_length=32, )
    url = forms.CharField(label='含有正则的url', max_length=64, )
    name = forms.CharField(label='url的别名', max_length=32, )
    # id = forms.CharField(max_length=32)
    #
    # id.widget = widgets.HiddenInput()



    # icon = forms.CharField(label='图标', max_length=32, )
    # parent_permission = forms.CharField(label='父菜单', max_length=32,)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
            if name == 'parent_permission':
                field.widget.attrs['class'] = 'form-control'
                field.widget.attrs['readonly'] = 'readonly'

    def clean_name(self):
        val = self.cleaned_data.get('name')
        ret = Permission.objects.filter(name=val)
        if not ret:
            return val
        else:
            raise ValidationError('该别名已存在')


# class UpdatePermissionForm(forms.Form):
#     id = forms.IntegerField(label='id', )
#     title = forms.CharField(label='url名称', max_length=32, )
#     url = forms.CharField(label='含有正则的url', max_length=64, )
#     name = forms.CharField(label='url的别名', max_length=32, )
#     id.widget = widgets.HiddenInput()
#
#     def clean_name(self):
#         print(self.cleaned_data)
#         id = self.cleaned_data.get('id')
#         val = self.cleaned_data.get('name')
#         ret = Permission.objects.filter(~Q(pk=id), name=val)
#         print(ret)
#         if not ret:
#             return val
#         else:
#             raise ValidationError('该别名已存在')


class UpdatePermissionForm(PermissionForm):
    # id = forms.CharField(max_length=32)
    #
    # id.widget = widgets.HiddenInput()
    pk = forms.IntegerField()

    pk.widget = widgets.HiddenInput()
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


'''
<QueryDict: {'csrfmiddlewaretoken': ['Yelh5YMYydddz4ngN1E24IEAepT0Cj6X4MAVehalN5TxMGrywL0vNUAKnTjsVRrB'], 
'form-TOTAL_FORMS': ['1'], 'form-INITIAL_FORMS': ['1'], 'form-MIN_NUM_FORMS': ['0'], 'form-MAX_NUM_FORMS': ['1000'], 
'form-0-title': ['客户列表'],
 'form-0-url': ['/customer/list/'], 'form-0-name': ['customer_list.3'], 'form-0-id': ['1']}>

'''
'''
<QueryDict: {'csrfmiddlewaretoken': ['BHwqK2no2NNCt4emGLnhf4V4gHokks0RHfL4TlLLhFtWGGiEpvJKYgRepbOMD0lv'],
 'form-TOTAL_FORMS': ['1'], 'form-INITIAL_FORMS': ['1'], 'form-MIN_NUM_FORMS': ['0'], 'form-MAX_NUM_FORMS': ['1000'], 
 'form-0-title': ['添加客户'], 'form-0-url': ['/customer/add/'], 'form-0-name': ['customer_add'], 'form-0-id': ['2']}>


'''