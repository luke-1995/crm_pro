from django.apps import AppConfig
from django.utils.module_loading import autodiscover_modules


class StarkConfig(AppConfig):
    name = 'stark'

    def ready(self):
        # 利用该钩子,可以在路由前执行该文件
        autodiscover_modules('stark')
        # 根据app注册顺序在每个app下面找stark的文件,并执行
