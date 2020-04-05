"""crm_pro URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, re_path
from django.views.static import serve
from crm_pro import settings
from rbac.views import role, user, menu, permission_import,distribute_permission

urlpatterns = [
    path('role_list/', role.role_list, name='role_list'),
    path('role_add/', role.role_add, name='role_add'),
    re_path(r'^role_edit/(?P<role_pk>\d+)/$', role.role_edit, name='role_edit'),
    re_path(r'^role_del/(?P<role_pk>\d+)/$', role.role_del, name='role_del'),
    # path('user_list/', user.user_list, name='user_list'),
    # path('user_add/', user.user_add, name='user_add'),
    # re_path(r'^user_edit/(?P<user_pk>\d+)/$', user.user_edit, name='user_edit'),
    # re_path(r'^user_reset_pwd/(?P<user_pk>\d+)/$', user.user_reset_pwd, name='user_reset_pwd'),
    # re_path(r'^user_del/(?P<user_pk>\d+)/$', user.user_del, name='user_del'),
    path('menu_list/', menu.menu_list, name='menu_list'),
    path('menu_add/', menu.menu_add, name='menu_add'),
    re_path(r'^menu_edit/(?P<menu_pk>\d+)/$', menu.menu_edit, name='menu_edit'),
    re_path(r'^menu_del/(?P<menu_pk>\d+)/$', menu.menu_del, name='menu_del'),
    path('second_menu_add/', menu.second_menu_add, name='second_menu_add'),
    re_path(r'^second_menu_edit/(?P<second_menu_pk>\d+)/$', menu.second_menu_edit, name='second_menu_edit'),
    re_path(r'^second_menu_del/(?P<second_menu_pk>\d+)/$', menu.second_menu_del, name='second_menu_del'),
    path('permission_import_list/', permission_import.permission_import_list, name='permission_import_list'),
    re_path(r'permission_import_del/(?P<permission_pk>\d+)/$', permission_import.permission_import_del,
         name='permission_import_del'),

    path('distribute_permission_list/', distribute_permission.distribute_permission_list, name='distribute_permission_list'),

]
