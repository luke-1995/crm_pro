#!usr/bin/env python
# -*- coding:utf-8 -*-
# 内置模块
# 第三方模块
# 本地库
from stark.utils.stark_site import site
from web.handler.classlist import ClassListHandler
from web.handler.consult_record import ConsultRecordHandler
from web.handler.course import CourseHandler
from web.handler.course_record import CourseRecordHandler
from web.handler.customer import CustomerHandler
from web.handler.department import DepartmentHandler
from web.handler.homework import HomeworkHandler
from web.handler.homework_record import HomeworkRecordHandler
from web.handler.user import UserInfoHandler
from web.models import *

site._registry.append(site.register(UserInfo, UserInfoHandler))

site._registry.append(site.register(Department, DepartmentHandler))

site._registry.append(site.register(Course, CourseHandler))
site._registry.append(site.register(ClassList, ClassListHandler))

site._registry.append(site.register(Customer,CustomerHandler))

site._registry.append(site.register(ConsultRecord, ConsultRecordHandler))

site._registry.append(site.register(CourseRecord, CourseRecordHandler))

site._registry.append(site.register(Homework, HomeworkHandler))

site._registry.append(site.register(HomeworkRecord, HomeworkRecordHandler))

