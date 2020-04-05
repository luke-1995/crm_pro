#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from django.shortcuts import render, redirect, HttpResponse
from django.urls import reverse
from django.forms import formset_factory
# 本地库
from rbac.models import *
from rbac.forms.menu import *
from rbac.utils.url import mark_reverse


def menu_list(request):
    '''一级菜单列表'''
    first_menu = FirstMenu.objects.all()
    first_menu_id = request.GET.get('fid')
    if first_menu_id:
        second_menu = Permission.objects.filter(firstmenu__pk=first_menu_id)
        request.session['first_menu_id'] = first_menu_id
        if second_menu:
            second_menu_id = request.GET.get('sid')
            if second_menu_id:
                permission = Permission.objects.filter(parent_permission_id=second_menu_id)
                if permission:
                    request.session['second_menu_id'] = second_menu_id
    return render(request, 'rbac/menu/menu_list.html',locals())


def menu_add(request):
    '''添加菜单'''
    if request.method == 'POST':
        dic = request.POST
        form = MenuForm(dic)
        if form.is_valid():
            form.save()
            return redirect(mark_reverse('rbac:menu_list', request))
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    form = MenuForm()
    return render(request, 'rbac/change.html', {'form': form, })


def menu_edit(request, menu_pk):
    menu = FirstMenu.objects.filter(id=menu_pk).first()
    if request.method == 'POST':
        dic = request.POST
        form = MenuForm(instance=menu, data=dic)  # 更新数据
        if form.is_valid():
            form.save()
            url = mark_reverse('rbac:menu_list', request)
            return redirect(url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    if menu:
        form = MenuForm(instance=menu)  # MODELFORM的方法
        return render(request, 'rbac/change.html', {'form': form, })
    else:
        return HttpResponse('404')


def menu_del(request, menu_pk):
    menu = FirstMenu.objects.filter(id=menu_pk).first()
    menu_list_url = mark_reverse('rbac:menu_list', request)
    if not menu:
        return HttpResponse('404')
    if request.method == 'POST':
        menu.delete()
        return redirect(menu_list_url)
    return render(request, 'rbac/delete.html', {'del_url': menu_list_url})


def second_menu_add(request):
    '''添加菜单'''
    if request.method == 'POST':
        dic = request.POST
        form = SecondMenuForm(dic)
        if form.is_valid():
            form.save()
            return redirect(mark_reverse('rbac:menu_list', request))
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    first_menu_id = request.session['first_menu_id']
    form = SecondMenuForm(initial={"firstmenu":first_menu_id})
    return render(request, 'rbac/change.html', {'form': form, })


def second_menu_edit(request, second_menu_pk):
    menu = Permission.objects.filter(id=second_menu_pk).first()
    if request.method == 'POST':
        dic = request.POST
        form = SecondMenuForm(instance=menu, data=dic)  # 更新数据
        if form.is_valid():
            form.save()
            url = mark_reverse('rbac:menu_list', request)
            return redirect(url)
        return render(request, 'rbac/change.html', {'form': form, 'form.errors': form.errors})
    if menu:
        form = SecondMenuForm(instance=menu)  # MODELFORM的方法
        return render(request, 'rbac/change.html', {'form': form, })
    else:
        return HttpResponse('404')


def second_menu_del(request, second_menu_pk):
    menu = Permission.objects.filter(id=second_menu_pk).first()
    menu_list_url = mark_reverse('rbac:menu_list', request)
    if not menu:
        return HttpResponse('404')
    if request.method == 'POST':
        menu.delete()
        return redirect(menu_list_url)
    return render(request, 'rbac/delete.html', {'del_url': menu_list_url})

