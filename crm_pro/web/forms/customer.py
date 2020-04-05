#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
# 本地库

from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError
from django.utils.module_loading import import_string

from django.conf import settings
from web.models import Customer
from stark.utils.stark_site import ModelHandler
from web.utils.prevent_xss import xss
from stark.utils.stark_site import StarkForm


class CustomerForm(StarkForm):
    class Meta:
        model = Customer
        fields = '__all__'
        exclude = ['consultant', ]

    def clean(self):
        name = self.cleaned_data['name']
        qq = self.cleaned_data['qq']
        self.cleaned_data['name'] = xss(name)
        self.cleaned_data['qq'] = xss(qq)
        return self.cleaned_data
