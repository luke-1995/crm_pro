# Generated by Django 2.0.1 on 2019-12-22 09:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0007_auto_20191222_0910'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='homeworkrecord',
            name='date',
        ),
        migrations.AlterField(
            model_name='homeworkrecord',
            name='first_file',
            field=models.FileField(blank=True, null=True, upload_to='homework/', verbose_name='第一份作业'),
        ),
        migrations.AlterField(
            model_name='homeworkrecord',
            name='second_file',
            field=models.FileField(blank=True, null=True, upload_to='homework/', verbose_name='第二份作业'),
        ),
    ]
