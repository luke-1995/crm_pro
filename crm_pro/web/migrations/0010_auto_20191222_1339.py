# Generated by Django 2.0.1 on 2019-12-22 13:39

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0009_auto_20191222_1305'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='homeworkrecord',
            name='first_file',
        ),
        migrations.RemoveField(
            model_name='homeworkrecord',
            name='second_file',
        ),
        migrations.AddField(
            model_name='homeworkrecord',
            name='file',
            field=models.FileField(blank=True, null=True, upload_to='homework/', verbose_name='作业文件'),
        ),
        migrations.AddField(
            model_name='homeworkrecord',
            name='file_count',
            field=models.PositiveIntegerField(default=0, verbose_name='提交次数'),
        ),
        migrations.AlterField(
            model_name='student',
            name='userinfo',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='用户信息'),
        ),
    ]
