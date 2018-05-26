<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	background-color: #efefef;
	margin: 0;
}

.formdiv {
	bottom: 0;
	position: absolute;
	top:110px;
	width: 100%;
	min-height: 400px;
}

.btn {
	background-color: #2bc4b6;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	line-height:40px;
	margin-top: 10px;
	text-align:center;
	margin-left:auto;
	margin-right:auto;
	width: 90%;
	border-radius: 5px;
}

.sendbtn {
	background-color: #2bc4b6;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	
	width:40%;
	height: 54px;
	line-height:54px;
	text-align:center;
	float:left;
	margin-top:0px;
	
	
}


.headdiv {
	width: 90%;
	height:100px;
	text-align: left;
	font-size:20px;
	color:#575759;
	padding-top:15px;
	margin:auto 5%;
}

.telephone {
	width:60%; 
	height: 54px;
	border: none;
	float:left;
	font-size: 20px; 
	padding-left:20px;
}

.captcha {
	height: 54px;
	width: 100%;
	border: none;
	font-size: 20px;
	margin-top:10px; 
	padding-left:20px;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<title>忘记密码</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<body>
	<div class="headdiv">
		你好，请输入您的手机号码，点击"发送验证码"，系统将通过短信将验证码发送到您的手机。
	</div>
	<div class="formdiv">
	
		<div class="whiteback">
			<input id="telephone" class="telephone" type="text" name="telephone" placeholder="手机号码" onkeyup="isexist(this.value)" maxlength="12">
			<div id="sendbtn" class="sendbtn" name="sendbtn" value="" onclick="sendsms()">发送验证码</div>
		</div>


		<div class="whiteback">
			<input id="captcha" class="captcha" name="captcha" type="text" placeholder="验证码" onkeyup="setval(this.value)" maxlength="8">
		</div>
		
		<div style="text-align: left; margin-top: 10px;">
			<div id="error"
				style="text-align: left; color: red; font-size: 15px; margin-left: 20px;">
				<c:if test="${message!=null}">${message}</c:if>
			</div>

		</div>

		<div style="position: absolute; bottom: 100px; width: 100%;text-align: center;">
			<div class="btn" onclick="validate()" >验证</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		var flag = null;
		var telnum = '';
		var chaval = '';
		var count = null;
		var timer = null;
		function isexist(tel) {
			flag = false;
			telnum = tel;
			var url = "${ctx}/wxpage/checktelephone";
			$.post(url, {
				"telephone" : telnum.trim()
			}, function(data) {
				if (data) {
					flag = true;
				} 
			});
		}
		
		function setval(cha) {
			chaval = cha;
		}
		
		function getCaptcha() {
			var sendurl = "${ctx}/wxpage/getcaptcha";
			$.post(sendurl, {
				"telephone" : telnum.trim()
			});
		}
		
		function timecount() {
			time--;
			var tipstr = "";
			if (time <= 0) {
				tipstr = "重新发送";
				$(".sendbtn").val(tipstr);
				clearInterval(timer);
				$(".sendbtn").attr("onclick", "sendsms()");
			} else {
				tipstr = time + "秒后重发";
				$(".sendbtn").val(tipstr);
				$(".sendbtn").removeAttr("onclick");
			}
		}
		
		function checkCaptcha() {
			var sendurl = "${ctx}/wxpage/checkcaptcha";
			$.post(sendurl, {
				"telephone" : telnum.trim(),
				"captcha" : chaval.trim()
			}, function(data) {
				if (data.result == 1) {
					alert(data.msg)
					window.location.href="${ctx}/wxpage/gonext?tel="+telnum.trim();
				} else if (data.result == 0) {
					$("#error").html("");
					$("#error").html(data.msg);
				}
			});
		}
		
		function sendsms() {
			
			$("#error").html("");
			if(telnum == '') {
				$("#error").html("请输入你的手机号码");
			}else if(telnum.search(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/) == -1) {
				$("#error").html("请输入正确的手机号码");
			}else if(!flag){
				$("#error").html("该手机号码未注册");
			}else{
				$(".sendbtn").removeAttr("onclick");
				time = 60;
				timer = setInterval(timecount,1000);
				getCaptcha();
			}
		}
		
		function validate() {
			
			$("#error").html("");
			if(telnum == '') {
				$("#error").html("请输入你的手机号码");
			}else if(telnum.search(/^(((1[34578][0-9]{1}))+\d{8})$/) == -1) {
				$("#error").html("请输入正确的手机号码");
			}else if(!flag){
				$("#error").html("该手机号码未注册");
			}else if(chaval == ''){
				$("#error").html("请输入验证码");
			}else{
				checkCaptcha();
			}
		}
		
		$(document).ready(function(){
			$("#telephone").val("");
			$("#captcha").val("");
		});

	</script>

</body>
</html>