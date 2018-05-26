<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="scrHeight" value="${window.screen.height}"/>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8" />
<title>智慧驿站综合服务管理平台 登录 </title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="static/mt/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/style-responsive.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="static/mt/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="static/mt/media/css/login-soft.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="static/mt/media/image/favicon.ico" />
<style type="text/css">
#title{
	color: blue;
}
</style>
</head>
<body class="login" style="background: url(${ctx}/static/images/sky.png);">
<div id="form-div-id" style="background: url(${ctx}/static/images/login.png) no-repeat;background-position: center; min-width:1180px">
    <div class="content">
        <form id="form-id" class="form-vertical login-form" action="${ctx}/login" method="post" id="loginForm" style="margin-left:40%;">
           <!--  <div class="alert alert-error hide">
                <button class="close" data-dismiss="alert"></button>
                <span>请输入用户名和密码.</span>
            </div> -->
            	<c:if test="${not empty message}">
					 <div class="alert alert-error hide"  style="display: block;">
						<button class="close" data-dismiss="alert"></button>${message}
					</div> 
				</c:if>
            <div class="control-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie8 visible-ie9">用户名</label>
                <div class="controls">
                    <div class="input-icon left">
                        <i class="icon-user"></i>
                        <input class="m-wrap placeholder-no-fix" type="text" value="admin" placeholder="用户名" name="username" id="username" />
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label visible-ie8 visible-ie9">密码</label>
                <div class="controls">
                    <div class="input-icon left">
                        <i class="icon-lock"></i>
                        <input class="m-wrap placeholder-no-fix" type="password" placeholder="密码" name="password"  id="password" value="admin" />
                    </div>
                </div>
            </div>
             <!--  <div class="control-group">
                <label class="control-label visible-ie8 visible-ie9">验证码</label>
                <div class="controls">
                    <div class="input-icon left">
                        <i class="icon-bug"></i>
                        <input class="m-wrap placeholder-no-fix" type="text" style="width:160px" placeholder="验证码" name="captcha" value="11"  id="captcha" onkeydown='dl(this.form,event)'/>
                    </div>
                    <div class="input-icon left" style="width: 210px;">
                   	  	<a id="sendcaptcha" href="javascript:;" onclick="GetCaptcha()">发送验证码</a>&nbsp;&nbsp;&nbsp;<span id="title" class="hide"></span>
                   	  	 	<a href="javascript:;">验证验证码</a>		
                   	</div>
                </div>
            </div> -->
            <div class="form-actions">
               <!--  <label class="checkbox">
                    <input type="checkbox" id="rememberMe" name="rememberMe" />记住我
                </label> -->
                <button type="submit"  class="pull-right" style="background-image: url('${ctx}/static/images/buttonbackground.png'); width:100px;height:36px;color:white;" >
                    	登录 <i class="m-icon-swapright m-icon-white"></i>
                </button>  
                <%-- <button  type="button" onclick="checkCaptch()" class="pull-right" style="background-image: url('${ctx}/static/images/buttonbackground.png'); width:100px;height:36px;color:white;" >
                    	登录 <i class="m-icon-swapright m-icon-white"></i> 
                </button>  --%>
            </div>
            <!-- <div class="forget-password">
                <h4>Forgot your password ?</h4>
                <p>
                    no worries, click <a href="javascript:;" class="" id="forget-password">here</a>
                    to reset your password.
                </p>
            </div> -->
        </form>
    </div>
    <!-- <div style="position: fixed;bottom: 30px;margin-left:40%;">
        	法律声明 | 服务条款 | 联系我们 <br>
     	江苏晓山信息产业股份有限公司 版权所有 苏ICP备000000号
    </div> -->
  </div>
    <script src="static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="static/mt/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
	<script src="static/mt/media/js/excanvas.min.js"></script>
	<script src="static/mt/media/js/respond.min.js"></script>  
	<![endif]-->
    <script src="static/mt/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery.cookie.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery.uniform.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="static/mt/media/js/jquery.backstretch.min.js" type="text/javascript"></script>
    <script src="static/js/login.js" type="text/javascript"></script>
    <script>
        jQuery(document).ready(function () {
           // App.init();
           	Login.init();
           	//alert(document.documentElement.clientHeight);
           	$('#form-div-id').css('height',document.documentElement.clientHeight +'px');
           	$('#form-id').css('margin-top',document.documentElement.clientHeight/3 +'px');

           	//初始化页面时光标定位
           	document.getElementById('username').focus();
            //$("#loginForm").validate();
        });
       /*  var time=121;
        function checkCaptch(){
        	var username=$("#username").val();
        	var captcha=$("#captcha").val();
        	var url="${ctx}/cap/checkcaptcha";
        	$.post(url,{"username":username,"captcha":captcha},function(data){
        		if(!data.success){
        			alert(data.msg);
        			$("#captcha").val("");
        			$("#captcha").focus();
        		}else{
        			$("#form-id").submit();
        		}
        	});
        	return ;
        } */
        
        //让回车可以直接登录
        function dl(frm,event){
            var event=window.event?window.event:event;   
            if(event.keyCode==13){
               // checkCaptcha(frm);
            	frm.submit();
            }
        }
        
        function checkCaptcha(frm){
        	var username=$("#username").val();
        	var captcha=$("#captcha").val();
        	var url="${ctx}/cap/checkcaptcha";
        	$.post(url,{"username":username,"captcha":captcha},function(data){
        		if(!data.success){
        			alert(data.msg);
        			$("#captcha").val("");
        			$("#captcha").focus();
		        	return false;
        		}else{
        			frm.submit();
        		}
        	});
        }
       /*  var timer;
        function GetCaptcha(){
        	var username=$("#username").val();
        	var url="${ctx}/cap/captcha";
        	$.post(url,{"username":username},function(data){
        		if(!data){
        			alert("用户名输入错误");
        			$("#username").val("");
        			$("#username").focus();
        		}
        	});
        		time=121;
        		$("#title").show();
        		$("#sendcaptcha").html("重新发送");
        		timer=setInterval(showtime,1000);
        }
        var timer='';
        function showtime(){
        	time--;
        	if(time<='0'){
        		timer='验证码已失效';
        	}else{
        		timer=time+'秒后验证码失效';
        	}
        	$("#title").html(timer);
        } */
    </script>
    <script type="text/javascript">
  
	if (self != top){
		window.top.location = window.location;
	}

	</script>
</html>
