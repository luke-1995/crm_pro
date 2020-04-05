
// 点击checkbox 之后,保存按钮才出现
$(function(){
            var is_uid = $('.role_area').attr('uid');
             $('.role_area').on("click",'[type="checkbox"]',
                          function(){
                          if( is_uid !== 'None')
                          { $('.role_area [type="submit"]').show() }

                          })
            })

$(function(){

             $('.checkbox-inline').on("click",'input',
                          function(){

                          $('.permission_area [type="submit"]').show()
                          // 点击checkbox 之后,保存按钮才出现
                          var is_check = $(this).parent().parent().parent().find(':checked');
                          var $obj = $(this).parent().parent().parent().find('.second_menu');
                         if ( is_check.length === 0 )
                          { $obj.prop("checked", false);}
                          else
                          { $obj.prop("checked", true);}




                          })
            })

$(function () {
            $('.check-all input:checkbox').change(function () {
                $(this).parent().parent().parent().find(':checkbox').prop('checked',$(this).prop('checked'));
            })
        })

