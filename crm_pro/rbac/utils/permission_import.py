#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.forms import formset_factory
# 本地库
from rbac.models import Permission
from rbac.forms.permission_import import PermissionForm, UpdatePermissionForm
from rbac.utils.get_all_url import get_all_url


def add(router_name_set, permission_name_set, router_url_dict, data=None):
    formset_class = formset_factory(PermissionForm, extra=0)
    if data:
        formset = formset_class(data)
        if formset.is_valid():
            add_obj_list = []
            for row in formset.cleaned_data:
                if row:
                    obj=Permission(**row)
                    add_obj_list.append(obj)
            Permission.objects.bulk_create(add_obj_list,batch_size=20)
        else:
            return formset
    else:
        add_set = router_name_set - permission_name_set
        if add_set:
            add_list = [dic for name, dic in router_url_dict.items() if name in add_set]
            formset = formset_class(initial=add_list)
            return formset


def update(router_name_set, permission_name_set, permission_dic, router_url_dict, data=None):
    formset_class = formset_factory(UpdatePermissionForm, extra=0)
    if data:
        formset = formset_class(data=data)
        if formset.is_valid():
            for row in formset.cleaned_data:
                if row:
                    permission_id = row.pop('id')
                    row_object = Permission.objects.filter(id=permission_id).first()
                    for k, v in row.items():
                        setattr(row_object, k, v)  # 通过反射更新
                    row_object.save()
        else:
            return formset
    else:
        update_set = permission_name_set & router_name_set
        if update_set:
            for name in update_set:
                if permission_dic[name].get('url') != router_url_dict[name].get('url'):
                    permission_dic[name]['url'] = '路由和数据库中不一致'
            update_list = [dic for name, dic in permission_dic.items() if name in update_set]
            formset = formset_class(initial=update_list)
            return formset


def delete(router_name_set, permission_name_set, permission,is_del=False):
    del_set = permission_name_set - router_name_set
    if del_set:
        del_list = [obj for obj in permission if obj['name'] in del_set]
        if is_del:
            for dic in del_list:
                Permission.objects.get(pk=dic['id']).delete()
                return None
        else:
            del_list = [obj for obj in permission if obj['name'] in del_set]
        return del_list


def get_dic(update_data=None,add_data=None,is_del=False):
    permission_qs = Permission.objects.values('id','title', 'url', 'name', 'firstmenu_id', 'parent_permission_id')
    permission_qs_del = Permission.objects.values('id','title', 'url', 'name', 'firstmenu__title','parent_permission__title')
    r_dic = get_all_url()  # 自动获取路由器中的url
    r_set = set(r_dic.keys())  # 自动获取路由器中的url的keys的集合
    p_dic = {}
    p_set = set()
    for permission in permission_qs:
        p_dic[permission['name']] = permission
        p_set.add(permission['name'])
    add_formset = add(r_set, p_set, r_dic, data=add_data)
    update_formset = update(r_set, p_set, p_dic, r_dic,data=update_data)
    dic = dict(add_formset=add_formset, update_formset=update_formset,
               del_list=delete(r_set, p_set, permission_qs_del,is_del=is_del))
    return dic
