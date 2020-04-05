#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
from bs4 import BeautifulSoup


# 本地库


def xss(old):
    valid_tag = {
        'p': ['class', 'id'],
        'img': ['src'],
        'div': ['class']
    }

    soup = BeautifulSoup(old, 'html.parser')  # html.parser内置的解析器，将html标签解析为对象

    tags = soup.find_all()
    for tag in tags:
        if tag.name not in valid_tag:
            tag.decompose()
        if tag.attrs:
            for k in list(tag.attrs.keys()):
                if k not in valid_tag[tag.name]:
                    del tag.attrs[k]
        if tag.name == 'img':
            # 过滤掉含有alert字眼的src
            if tag.attrs:
                for k in list(tag.attrs.keys()):
                    if k == 'src':
                        print(tag['src'])
                        if 'alert' in tag['src']:
                            tag.decompose()
    content_str = soup.decode()
    return content_str
