# Generated by Django 2.0.1 on 2019-12-21 11:46

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('web', '0002_customer_consultant'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userinfo',
            name='depart',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='web.Department', verbose_name='部门'),
        ),
    ]
