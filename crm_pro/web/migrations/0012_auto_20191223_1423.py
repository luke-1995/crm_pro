# Generated by Django 2.0.1 on 2019-12-23 14:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0011_auto_20191223_1106'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customer',
            name='qq',
            field=models.CharField(help_text='QQ号/微信/手机号', max_length=64, verbose_name='联系方式'),
        ),
    ]
