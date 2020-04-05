from django.db import models
from django.contrib.auth.models import AbstractUser


# Create your models here.

class Permission(models.Model):
    '''
    权限表
    '''
    id = models.AutoField(primary_key=True)
    title = models.CharField(verbose_name='url名称', max_length=32, )
    url = models.CharField(verbose_name='含有正则的url', max_length=64, )
    name = models.CharField(verbose_name='url的别名', max_length=32, unique=True)
    icon = models.ForeignKey(verbose_name='图标', to='Icon', on_delete=models.CASCADE, null=True, blank=True)
    firstmenu = models.ForeignKey(verbose_name='一级菜单', to='FirstMenu', on_delete=models.CASCADE, null=True, blank=True)
    parent_permission = models.ForeignKey('self', null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.title


class FirstMenu(models.Model):
    '''
    一级菜单
    '''
    id = models.AutoField(primary_key=True)
    title = models.CharField(verbose_name='一级菜单', max_length=32, unique=True)
    icon = models.ForeignKey(verbose_name='图标', to='Icon', on_delete=models.CASCADE)

    def __str__(self):
        return self.title


class Role(models.Model):
    '''
    角色表
    '''
    id = models.AutoField(primary_key=True)
    title = models.CharField(verbose_name='角色名称', max_length=32, )
    permissions = models.ManyToManyField(verbose_name='所拥有的的权限', to='Permission')

    def __str__(self):
        return self.title


class UserInfo(AbstractUser):
    '''
    用户表
    '''
    id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50, unique=True)
    roles = models.ManyToManyField(verbose_name='出任的角色', to=Role, )
    # 去掉引号,否则继承后,会找不到role,同时role类要写在前面

    def __str__(self):
        return self.username

    class Meta:
        abstract = True # 当做父类被继承的配置


class Icon(models.Model):
    '''
    图标表
    '''
    id = models.AutoField(primary_key=True)
    content = models.CharField(verbose_name='图标', max_length=200, )

    def __str__(self):
        return self.content
