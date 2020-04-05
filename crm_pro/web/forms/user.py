#!usr/bin/env python
# -*- coding:utf-8 -*-

from django import forms
from django.forms import widgets
from django.core.exceptions import ValidationError
from django.utils.module_loading import import_string

from django.conf import settings
from web.models import UserInfo


class UserInfoForm(forms.ModelForm):
    r_pwd = forms.CharField(max_length=32,label='确认密码')
    class Meta:
        model = UserInfo
        fields = ['username','name', 'password', 'r_pwd',]
        labels = {
            "username": "用户名称",
        }

    def clean_username(self):
        val = self.cleaned_data.get('username')
        ret = UserInfo.objects.filter(username=val)
        if not ret:
            return val
        else:
            raise ValidationError('该用户已存在')

    def clean_r_pwd(self):
        """
        检测密码是否一致
        :return:
        """
        password = self.cleaned_data['password']
        r_pwd = self.cleaned_data['r_pwd']
        if password != r_pwd:
            raise ValidationError('两次密码输入不一致')
        return r_pwd

    def __init__(self, *args, **kwargs):
        super(UserInfoForm, self).__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'
            if name == 'password' or name == 'r_pwd':
                field.widget = widgets.PasswordInput(attrs={'class': 'form-control'})


class UpdateUserForm(forms.ModelForm):
    class Meta:
        model = UserInfo
        fields = ['name','depart' ]
        labels = {
            "username": "用户名称",
        }

    def __init__(self, *args, **kwargs):
        super(UpdateUserForm, self).__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'



class ResetPwdForm(forms.ModelForm):
    r_pwd = forms.CharField(max_length=32, label='确认密码', )

    class Meta:
        model = UserInfo
        fields = ['password', 'r_pwd']

    def __init__(self, *args, **kwargs):
        super(ResetPwdForm, self).__init__(*args, **kwargs)
        for name, field in self.fields.items():
            field.widget = widgets.PasswordInput(attrs={'class': 'form-control'})

    def clean_r_pwd(self):
        """
        检测密码是否一致
        :return:
        """
        password = self.cleaned_data['password']
        r_pwd = self.cleaned_data['r_pwd']
        if password != r_pwd:
            raise ValidationError('两次密码输入不一致')
        return r_pwd