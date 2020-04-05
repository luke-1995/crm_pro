 //  点击注册按钮触发ajax事件

 $(function(){
                         $('.register_btn').click(function(){
                         var fd_obj = new FormData()
                         var request_data = $('form').serializeArray();
                         var login_url =  $('form').attr('login_url')
                         $.each(request_data,function (index,data) {
                             //key是字典的键(注意是否是索引)，也就是每个字段名称;value是每个字段的错误信息
                             fd_obj.append(data.name,data.value)
                             $('#id_'+data.name).next().html('');
                             $('#id_'+data.name).parent().removeClass('has-error');
                                             })
                         $.ajax({url:'',
                         type:'post',
                         data:fd_obj,
                         contentType:false,
                         processData:false,
                         success:function(data){
                         if(data.status){
                         alert('成功');
                         location.href = login_url

                         }else{
                         alert('失败');
                         wrong(data.msg);
                         }
                         }})})

                         })
//渲染错误信息
 function wrong(data)
                         {
                         $.each(data,function (key,value) {
                             //key是字典的键(注意是否是索引)，也就是每个字段名称;value是每个字段的错误信息
                              if(key === '__all__'){$('#id_'+'r_pwd').next().text(value[0]).css({'color':'red'}).attr('class','pull-right').parent().addClass('has-error')}
                              else{
                              $('#id_'+key).parent().addClass('has-error');
                             $('#id_'+key).next().text(value[0]).css({'color':'red'}).attr('class','pull-right')
                              }



                                                                      });

                         }

