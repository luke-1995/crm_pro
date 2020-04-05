// 极验互动验证码
var handlerPopup = function (captchaObj) {
    // appendTo方法用于将验证按钮插到宿主页面，使其显示在页面上。
    captchaObj.appendTo('#popup-captcha');
    // onReady监听验证按钮的 DOM 生成完毕事件,隐藏等待标签
    captchaObj.onReady(function () {
        $("#wait").attr('class', 'hidden');
    });

    // onSuccess:监听验证成功事件，滑动验证成功后,按钮解禁
    captchaObj.onSuccess(function () {
        $("#login-button").removeAttr('disabled');
        $("#login-button").removeAttr('title');
    });
    //  进行二次验证
    $("#login-button").click(function () {
        // getValidate:获取用户进行成功验证(onSuccess)所得到的结果，该结果用于进行服务端 SDK 进行二次验证。
        var validate = captchaObj.getValidate();
        if (!validate) {
            alert('验证失效,请刷新重试')
            return 0;
        } else {
            $.ajax({
                url: "/login/", // 进行二次验证
                type: "post",
                dataType: "json",
                data: {
                    username: $('input[name="user"]').val(),
                    password: $('input[name="pwd"]').val(),
                    csrfmiddlewaretoken: $("[name='csrfmiddlewaretoken']").val(),
                    geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode,},
                success: function (data) {
                    if (data.status) {
                        $('#error').text(data.msg).css({'color':'red','margin-left':'10px'})
                        setTimeout(function(){
                        $('#error').html('')},1000)
                        captchaObj.reset();  // 让验证回到初始状态
                        $("#login-button").attr('disabled', 'disabled');
                        $("#login-button").attr('title', '请完成人机识别验证');
                    } else {
                        location.href = data.msg;
                    }
                },
            });
        }
    });
};

// 当input框获取焦点时将之前的错误清空
$('input[name="user"],input[name="pwd"]').focus(function () {
    // 将之前的错误清空
    $('#error').text('');
});

// 验证开始需要向网站主后台获取id，challenge，success（是否启用failback）
$.ajax({
    url: "/pc-geetest/register?t=" + (new Date()).getTime(), // 加随机数防止缓存
    type: "get",
    dataType: "json",
    success: function (data) {
        // 使用initGeetest接口
        // 参数1：配置参数
        // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
        initGeetest({
            gt: data.gt,  // 验证 id，极验后台申请得到
            challenge: data.challenge,  // 验证流水号，后服务端 SDK 向极验服务器申请得到
            product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
            offline: !data.success, // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            width: '100%',  // 设置按钮的长度
            // 更多配置参数请参见：http://www.geetest.com/install/sections/idx-client-sdk.html#config
        }, handlerPopup);
    },
});

