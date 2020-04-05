from django.db import models
from rbac.models import UserInfo as RbacUserInfo


class Department(models.Model):
    """
    部门表
    """
    title = models.CharField(verbose_name='部门名称', max_length=16)

    def __str__(self):
        return self.title


class UserInfo(RbacUserInfo):
    """
    员工表
    """
    name = models.CharField(verbose_name='真实姓名', max_length=16)
    phone = models.CharField(verbose_name='手机号', max_length=32)
    gender_choices = (
        (1, '男'),
        (2, '女'),
    )
    gender = models.IntegerField(verbose_name='性别', choices=gender_choices, default=1)

    depart = models.ForeignKey(verbose_name='部门', to="Department",on_delete=models.CASCADE,null=True,blank=True)

    def __str__(self):
        return self.name or self.username


class Course(models.Model):
    """
    课程表
    如：
        Linux基础
        Linux架构师
        Python自动化
        Python全栈
    """
    name = models.CharField(verbose_name='课程名称', max_length=32)

    def __str__(self):
        return self.name


class ClassList(models.Model):
    """
    班级表
    如：
        Python全栈  面授班  5期  10000  2017-11-11  2018-5-11
    """
    course = models.ForeignKey(verbose_name='课程名称', to='Course',on_delete=models.CASCADE)
    semester = models.PositiveIntegerField(verbose_name="班级(期)")
    tech_teachers = models.ManyToManyField(verbose_name='任课老师', to='UserInfo', related_name='teach_classes', blank=True,
                                           limit_choices_to={'depart__title__in': ['教学部',]})
    def __str__(self):
        return "{0}({1}期)".format(self.course.name, self.semester)


class Customer(models.Model):
    """
    客户表
    """
    name = models.CharField(verbose_name='姓名', max_length=32)
    qq = models.CharField(verbose_name='联系方式', max_length=64,help_text='QQ号/微信/手机号')
    status_choices = [
        (1, "已报名"),
        (2, "未报名")
    ]
    status = models.IntegerField(verbose_name="状态", choices=status_choices, default=2)
    gender_choices = ((1, '男'), (2, '女'))
    gender = models.SmallIntegerField(verbose_name='性别', choices=gender_choices)
    consultant = models.ForeignKey(verbose_name="课程顾问", to='UserInfo',
                                   null=True, blank=True,
                                   limit_choices_to={'depart__title': '销售部'},on_delete=models.CASCADE)


    def __str__(self):
        return "姓名:{0}".format(self.name)


class ConsultRecord(models.Model):
    """
    客户跟进记录
    """
    customer = models.ForeignKey(verbose_name="所咨询客户", to='Customer',on_delete=models.CASCADE)
    consultant = models.ForeignKey(verbose_name="跟踪人", to='UserInfo',on_delete=models.CASCADE)
    note = models.TextField(verbose_name="跟进内容")
    date = models.DateField(verbose_name="跟进日期", auto_now_add=True)





class Student(models.Model):
    """
    学生表
    """
    userinfo = models.OneToOneField(verbose_name='用户信息', to='UserInfo',on_delete=models.CASCADE)
    class_list = models.ManyToManyField(verbose_name="已报班级", to='ClassList', blank=True)
    student_status_choices = [
        (1, "申请中"),
        (2, "在读"),
        (3, "毕业"),
        (4, "退学")
    ]
    student_status = models.IntegerField(verbose_name="学员状态", choices=student_status_choices, default=1)


    def __str__(self):
        return self.userinfo.name




class CourseRecord(models.Model):
    """
    上课记录表
    """
    class_object = models.ForeignKey(verbose_name="班级", to="ClassList",on_delete=models.CASCADE)
    day_num = models.IntegerField(verbose_name="节次")
    teacher = models.ForeignKey(verbose_name="讲师", to='UserInfo',on_delete=models.CASCADE)
    date = models.DateField(verbose_name="上课日期", auto_now_add=True)

    def __str__(self):
        return "{0} day{1}".format(self.class_object, self.day_num)


class StudyRecord(models.Model):
    """
    学生考勤记录
    """
    course_record = models.ForeignKey(verbose_name="第几天课程", to="CourseRecord",on_delete=models.CASCADE)
    student = models.ForeignKey(verbose_name="学员", to='Student',on_delete=models.CASCADE)
    record_choices = (
        ('checked', "已签到"),
        ('vacate', "请假"),
        ('late', "迟到"),
        ('noshow', "缺勤"),
        ('leave_early', "早退"),
    )
    record = models.CharField("上课纪录", choices=record_choices, default="checked", max_length=64)


class HomeworkRecord(models.Model):
    """
    作业提交记录
    """
    student = models.ForeignKey(verbose_name="学生", to='Student',on_delete=models.CASCADE)
    homework = models.ForeignKey(verbose_name="作业", to='Homework',on_delete=models.CASCADE)
    file = models.FileField(verbose_name="作业文件",upload_to='homework/',null=True,blank=True,help_text='提交次数最大两次')
    file_count = models.PositiveIntegerField(verbose_name="提交次数",default=0)
    homework_status_choices = [
        (1, "未提交"),
        (2, "已提交"),
    ]
    homework_status = models.IntegerField(verbose_name="作业提交状态", choices=homework_status_choices, default=1)
    mark = models.PositiveIntegerField(verbose_name="学生成绩",null=True,blank=True)




class Homework(models.Model):
    '''
    作业表
    '''
    title = models.CharField(max_length=50, verbose_name='作业标题')
    content = models.CharField(max_length=500, verbose_name='作业内容')
    create_time = models.DateTimeField(verbose_name='创建时间', auto_now_add=True)
    class_object = models.ForeignKey(verbose_name="班级", to="ClassList", on_delete=models.CASCADE)
    teacher = models.ForeignKey(verbose_name="讲师", to='UserInfo', on_delete=models.CASCADE)

    def __str__(self):
        return self.title





