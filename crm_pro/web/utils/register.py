#!usr/bin/env python
# -*- coding:utf-8 -*-
from web.forms.user import UserInfoForm as UserForm
from web.models import UserInfo


def get_flag(request):
    dic = request.POST
    form = UserForm(dic)
    flag = dict(status=True, msg=None)
    if form.is_valid():
        username = dic.get('username')
        name = dic.get('name')
        pwd = dic.get('password')
        extra_fields = {}
        file_obj = request.FILES.get('avatar', )
        if file_obj:
            extra_fields['avatar'] = file_obj
        UserInfo.objects.create_user(username=username, password=pwd,name=name, **extra_fields)
    else:
        flag['msg'] = form.errors
        flag['status'] = False
    return flag
