from django.urls import path, re_path, include
from web.views import account

urlpatterns = [
    path('login/', account.login, name='login'),
    path('index/', account.index, name='index'),
    path('logout/', account.logout, name='logout'),
    path('register/', account.register, name='register'),
]
