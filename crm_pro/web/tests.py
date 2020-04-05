from django.test import TestCase

# Create your tests here.
import functools


def clean(self):
    password = self.cleaned_data['password']
    self.cleaned_data['password'] = gen_md5(password)
    return self.cleaned_data