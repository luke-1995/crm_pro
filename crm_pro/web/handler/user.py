#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.urls import re_path
from django.utils.safestring import mark_safe
# 本地库
from stark.utils.stark_site import ModelHandler
from stark.utils.url import mark_url
from web.models import UserInfo
from web.forms.user import UserInfoForm, UpdateUserForm
from web.views.user import reset_password_view


class UserInfoHandler(ModelHandler):
    field = ['_checkbox', 'id', 'username', '_reset_pwd', 'depart', '_edit', '_delete', ]
    search_list = ['name__contains']
    batch_operation = dict(batch_delete='批量删除')
    per_page_count = 5
    add_model_form = UserInfoForm
    update_model_form = UpdateUserForm
    reset_password_view = reset_password_view

    # search_group = [
    #     GroupSearch('gender', is_multi=True),
    #     GroupSearch('depart', {'id__gt': 2}),
    # ]
    def _reset_pwd(self, obj=None):
        url = mark_url(self.get_url_name('reset_pwd', add_namespace=True), self.request, obj.pk) if obj else '#'
        return ['重置密码', mark_safe('<a href="%s" class="btn btn-default btn-sm">重置密码</a>' % url)]

    def save(self, form, is_update=False):
        if is_update:
            form.save()
        else:
            form.cleaned_data.pop('r_pwd')
            UserInfo.objects.create_user(**form.cleaned_data)

    def extra_url(self):
        li = [re_path(r'^reset_pwd/(?P<pk>\d+)/$', self.wrapper(self.reset_password_view),
                      name=self.get_url_name('reset_pwd')), ]
        return li
