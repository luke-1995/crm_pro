from django.test import TestCase

# Create your tests here.

import rbac.models
from rbac.models import *
'''
/web/userinfo/change/(?P<pk>\d+)/
/role_edit/(?P<role_pk>\d+)/
'''
li = [1,2,3]
li = set(li)
li1 = [1,2,3,4]


first_menu = FirstMenu.objects.filter(pk=1)
for i in first_menu:
    dic = dict(title=i.title, children=[])  # icon=i.icon
    print(i.icon['content'])

'''
                          if( is_check.length>1 )
                          { $obj.attr({'disabled':'disabled','checked':'checked'}); }
                          else if( is_check.length ===1 && $obj.prop('checked') )
                          { $obj.removeAttr('disabled');$obj.removeAttr('checked'); }
                          else if( is_check.length ===1 && !$obj.prop('checked') )
                          { $obj.attr({'disabled':'disabled','checked':'checked'}); }
                          
                          
                          if( is_check.length === 1 )
                          {
                          if( !$obj.prop('checked') )
                          { $obj.prop("checked", true);}
                          }
                          else if ( is_check.length === 0 )
                          { $obj.prop("checked", false);}
                          else
                          { $obj.prop("checked", true);}
'''
