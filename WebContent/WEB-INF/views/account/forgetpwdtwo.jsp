<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!doctype html>
<html>
<head>
<link rel="shortcut icon" href="${ctx}/static/images/headimg.jpg"
	type="image/x-icon" />
<style type="text/css">
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="度维,金阿福e服务" name="keywords">
<title>金阿福e服务</title>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<style type="text/css">
.backdiv {
	background: url('${ctx}/static/images/indexback.png') no-repeat center;
	background-color: #020304;
	height: 686px;
	min-width: 938px;
	width: 100%;
	height: 686px;
}

.centerdiv {
	background-color: white;
	border-radius: 10px;
	left: 50%;
	margin-left: 143px;
	padding-bottom: 20px;
	position: absolute;
	top: 220px;
	width: 400px;
}

.topdiv {
	height: 50px;
	margin-top: 25px;
}

.bottomdiv {
	text-align: center;
	color: #ff5e30;
	margin-top: 8px;
}

input {
	border: medium none;
	box-shadow: inset 0 0 0 1000px #fff;;
	font-size: 20px;
	height: 38px;
	margin-left: 0;
	outline: none;
	width: 99%;
}

.checkbtn {
	background-color: #44b549;
	border: 0 none;
	border-radius: 3px;
	color: white;
	cursor: pointer;
	font-size: 17px;
	padding: 5px 20px;
	width: 70%;
	text-decoration: none;
}

.headtitle {
	background: rgba(0, 0, 0, 0) url("/nsh/static/images/indextitle.png")
		no-repeat scroll 215px 7px;
	height: 85px;
	width: 100%;
}

.dltitle {
	border-bottom: 1px solid #898989;
	font-size: 25px;
	height: 30px;
	line-height: 20px;
	width: 100%;
}

.dltitle p {
	margin-left: 60px;
}

.formdiv {
	width: 100%;
	padding-top: 15px;
}

.formrow {
	margin-top: 10px;
	text-align: left;
	width: 100%;
}

.inputdiv {
	border: 1px solid #e8e8e8;
	height: 80%;
	margin-left: 22px;
	padding: 3px 3px;
	position: relative;
	width: 60%;
}

.sendbtndiv {
	float: right;
	width: 26%;
	height: 80%;
	margin-top: -36px;
	padding-top: 0;
	padding-bottom: 0;
	padding-left: 5px;
	padding-right: 23px;
}

.tiplabel {
	font-size: 11px;
	padding: 5px;
	color: red;
}

.odiv {
	height: 80%;
	margin: auto;
	padding-left: 23px;
	padding-right: 23px;
	text-align: left;
}

.checkbox {
	width: 19px;
	cursor: pointer;
}

.loginlink {
	margin-left: 77px;
	color: #848585;
	cursor: pointer;
	text-decoration: none;
}

.loginlink:hover {
	color: #626262;
	text-decoration: none;
}

body {
	margin: 0;
	font-family: 'Helvetica Neue', ' Hiragino Sans GB ', ' MicrosoftYaHei ',
		' 黑体 ', Arial, sans-serif;
	min-width: 800px;
}

.foot {
	width: 100%;
	text-align: center;
	color: #9fa0a0;
	line-height: 100px;
}
</style>
</head>
<body>
	<div class="headtitle"></div>
	<div id="filldiv" class="backdiv"></div>
	<div class="centerdiv">
		<div class="dltitle">
			<p>重设密码</p>
		</div>
		<div class="formdiv">
			<div class="formrow">
				<div class="inputdiv">
					<input type="password" name="password" placeholder="新密码"
						id="password" value="" />
				</div>
				<div class="sendbtndiv">
					<label class="tiplabel" id="tiplabel">6-18位字母或数字</label>
				</div>
			</div>
			<div class="formrow">
				<div class="inputdiv">
					<input type="password" name="password2" placeholder="确认密码"
						id="password2" value="" />
				</div>
			</div>
			<div id="error"
				style="text-align: left; color: red; font-size: 15px; width: 75%; margin: auto;">
			</div>
			<input type="hidden" name="telephone" id="telephone" value="${tel}">
			<div class="formrow">
				<div class="odiv">
					<button class="checkbtn" onclick="resetpwd()">提交</button>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">合作方：腾讯、无锡农村商业银行</div>

	<script type="text/javascript">
	
		function resetpwd() {
			
			var newpass1 = $("#password").val();
			var newpass2 = $("#password2").val();
			var telephone = $("#telephone").val();
			
			if(telephone.trim() == '') {
				$("#error").html("");
				$("#error").html("系统繁忙，稍后再试！");
				return;
			}else if(newpass1==null||$.trim(newpass1)==''){
				$("#error").html("");
				$("#error").html("新密码不能为空");
				$(this).focus();
				return;
			} else if(newpass2==null||$.trim(newpass2)==''){
				$("#error").html("");
				$("#error").html("确认密码不能为空");
				$(this).focus();
				return;	
			} else if(newpass1!=newpass2){
				$("#error").html("");
				$("#error").html("两次 密码输入不一致");
				$(this).focus();
				return;
			} else if(!(/^[a-zA-Z0-9]+[a-zA-Z0-9_]*$/gi.test(newpass1)) || newpass1.length < 6 || newpass1.length > 18){
				$("#error").html("");
				$("#error").html("新密码只能为6-18位的字母和数字");
				$(this).focus();
				return;
			} else{
				  var url="${ctx}/forget/password/changenewpassword";
				  $.post(url,{"newpassword":newpass1,"telephone":telephone},function(d){
					  if(d.result == 1) {
						  alert(d.msg);
						 /*  window.location.href="${ctx}"; */
						  setTimeout("tologin()",1000);
					  }else {
						  $("#error").html("");
						  $("#error").html(d.msg);
						  return ;
					  }
				  });
				 
		    }
		}
		
		function tologin() {
			window.location.href="${ctx}";
		}
		
	</script>

</body>