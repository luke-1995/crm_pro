#!usr/bin/env python
# -*- coding:utf-8 -*-


import re

from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User

from rbac.models import *


class RoleForm(forms.ModelForm):

    class Meta:
        model = Role
        fields = ['title', ]
        widgets = {
            "title": forms.TextInput(attrs={'class': 'form-control'})  # 可以使用widgets的方法 django.forms.widgets
        }
        labels = {
            "title": "角色名称",
        }



    def clean_title(self):
        val = self.cleaned_data.get('title')
        ret = Role.objects.filter(title=val)
        if not ret:
            return val
        else:
            raise ValidationError('该角色已存在')
