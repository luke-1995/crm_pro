#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect
# 本地库
from stark.utils.url import mark_reverse
from web.forms.user import ResetPwdForm


def reset_password_view(self, request, pk, *args, **kwargs):
    """
    重设密码
    :param request:
    :param pk:
    :return:
    """
    obj = self.model_class.objects.all().filter(pk=pk).first()
    model_form = ResetPwdForm
    if request.method == 'POST':
        dic = request.POST
        form = model_form(dic)  # 更新数据
        if form.is_valid():
            pwd = dic.get('password')
            obj.set_password(pwd)
            obj.save()
            _url = mark_reverse(self.get_url_name('list', add_namespace=True), self.request)
            return redirect(_url)
        return render(request, self.change_html, {'form': form, 'form.errors': form.errors})
    if obj:
        form = model_form()
        return render(request, self.change_html, dict(form=form))
    else:
        return render(request, self.not_find_html)  # 404
