# 程序开发环境
* django (2.0.1)
# 程序实现功能
1.  权限组件支持角色管理，根据业务需求分出销售、学员、讲师角色
2.  允许销售创建、跟进客户信息
3.  允许学员交作业、查成绩
4.  允许老师进行班级点名、批作业
# 程序的启动方式
1. 安装模块,打开命令行窗口,输入python3 pip install -i http://pypi.douban.com/simple/ django==2.0.1 --trusted-host pypi.douban.com
2. 确保数据库中有一个名叫book2的数据库
3. 打开命令行窗口，进去之后，首先切换到\PycharmProjects\book_pro\book_pro的路径下面，然后输入“python manage.py makemigrations”,按回车键，加载完成后,再输入'python manage.py migrate',按回车键,完成数据库迁移
4. 接着输入python3 manage.py runserver,启动服务
5. 在浏览器输入访问地址127.0.0.1:8000/login/
# 登录用户信息
* 需要用户登录用户名和密码进行验证
* 超级用户(用户名:alex,密码:alex1234,角色:超级管理员)
* 普通用户(用户名:a,密码123,角色:销售)
* 普通用户(用户名:b,密码123,角色:讲师)
* 普通用户(用户名:c,密码123,角色:讲师)
* 普通用户(用户名:d,密码123,角色:学生)
* 普通用户(用户名:e,密码123,角色:学生)
# 程序的运行效果
## 1 权限组件支持角色管理，根据业务需求分出销售、学员、讲师角色

![Image text](https://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSh*86M.oZwrug4LhzycvOBLu64yoUweDwunXsUc2e5f0Cl86KrS4mBTfLFpEIlhBEY44zmEuhimcvHt2x01pp.c!/b&bo=gAdPAwAAAAADB.k!&rf=viewer_4)

![Image text](https://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSoncChZ*Ca8v4NHWQCZ7liJwoCfEY0Ewzf8tAUY.1E*4vwqe72nDh0nhfRB5GZ3skpXdscm7LwgdGLHmEAFUcPw!/b&bo=gAdPAwAAAAADB.k!&rf=viewer_4 )

![Image text](https://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSl1pDoJishZPYhk0DXkFxkHd3CqGd8m7E3vKpGVuMJtMuy7Ah1z4EJmuhTsz4uCTN9pBSaRm3f1to5jaIoeskCo!/b&bo=gAdPAwAAAAADB.k!&rf=viewer_4)

## 2 允许销售创建、跟进客户信息

![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSgiMjfQKj65q7HyayR9ple9ek45jJuhlVBua0u2CvsdtCZIcGezLoo8vf*E6A4rLuhwT8WrRV6cjbJroVL8FAfc!/b&bo=LgemAwAAAAACN58!&rf=viewer_4 )


![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSqaah8ZOcDB1XLei*sL3VYhfX5HhnpPyqxAU3FZSNT.PkJ7OPOtTcs94lllp9Dy8ItNhuqkPIqv1hAvPZvE*Rf8!/b&bo=LAeoAwAAAAACN5M!&rf=viewer_4 )

## 3 允许学员交作业、查成绩

![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSm2GlsCKC4Uyk78rN4WHUQ*oelPWZT2Njo.CcLZ.jjotfKUJ5dZIh8LFbw8gv5jTvWbX1QUFx95Qcs1biyI4zQQ!/b&bo=MAcHBAAAAAACZ3c!&rf=viewer_4)

![Image text](https://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSvaosqwt824S.G2wbN4rM*EzPKoLab3u.NV0uo0uyvCqrgKpzZ3lDEJjGl5b8ZEj7faRsr1Zp7jfJCCfPn.nem8!/b&bo=gAdPAwAAAAADB.k!&rf=viewer_4)


## 3 允许老师进行班级点名、批作业

![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSrc*xY79hrWQrXrhEM80i68NgBTSt6V**7wKI9ipnrkjzmYXvGH0iS3DOqPydHfjllWxBR0i6Z0Z8zPjsJIKrRg!/b&bo=LAfcAwAAAAACR5c!&rf=viewer_4)

![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSoV7Kw4BfmnBLimBLN.K7NmIOyTuBVeE1VqvAYmXMC9T1aNee2fFt0wO1F8MsiVWsw.1sNc9rbeM5wR9RdlHF3s!/b&bo=LQf0AwAAAAACR74!&rf=viewer_4)

![Image text](http://m.qpic.cn/psc?/V13PfEOv0BnQfz/UEyoh0SDzKiAwcrP9ANXSqnrd1iAFOofk5sRYkYxh*aQbzUsEfiFMZD3aHmy0GvKLLJ31StzURPm9XPeBgdVtIwX.61jlHiFdC1ST2uKfsE!/b&bo=LAfxAwAAAAACR7o!&rf=viewer_4)



