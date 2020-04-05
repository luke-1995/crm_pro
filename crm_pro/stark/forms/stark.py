#!usr/bin/env python
# -*- coding:utf-8 -*-


from django import forms
from django.core.exceptions import ValidationError


class StarkForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name, field in self.fields.items():
            if isinstance(field, forms.fields.DateField):
                field.widget = forms.DateInput(attrs={'type': 'date', 'class': 'form-control'})
            else:
                field.widget.attrs['class'] = 'form-control'
