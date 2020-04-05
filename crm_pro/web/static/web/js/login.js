$(function(){$('.valid_img').click(function(){$(this)[0].src+="?"})})
         $(function(){
                                 $('.login_btn').click(function(){
                                 login()
                                 })

                                 })



$(function(){
             $('input').keydown
		(

			function(event)
			{
				if(event.keyCode === 13)
				{
				    console.log(123)
					login()
				}
			}
		)
            })

function login(){
                                 var next_url = $('form').attr('next_url');
                                 $.ajax({url:'',
                                 type:'post',
                                 data:$('form').serializeArray(),
                                 success:function(data){
                                 if(data.status){
                                 alert('成功');
                                 location.href = next_url

                                 }else{
                                 alert('失败');
                                 $('.login_btn').next().text(data.msg).css({'color':'red','margin-left':'10px'})
                                 setTimeout(function(){
                                 $('.login_btn').next().html('')},1000)
                                 }
                                 }})}