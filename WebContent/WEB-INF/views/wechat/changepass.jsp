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
	top: 20px;
	width: 100%;
	min-height: 500px;
}

.row {
	text-align: center;
	position: relative;
}

.title {
	text-align: left;
	font-size: 20px;
}

.textinput {
	height: 55px;
	width: 100%;
	border: none;
	font-size: 20px;
}

.row:FIRST-CHILD {
	border-top: solid 1px #e8e8e8;
	margin-top: 20px;
}

.btn {
	background-color: #2bc4b6;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	margin-top: 10px;
	width: 90%;
	border-radius: 5px;
}

.mar {
	margin-bottom: 20px;
}

.whiteback {
	padding-left: 110px;
	background-color: white;
	border-bottom: solid 1px #e8e8e8;
}

.logdiv {
	width: 100%;
	text-align: center;
	padding-top: 20px;
}

.logdiv img {
	width: 100px;
	height: 121px;
}

.passwordi {
	display: inline-block;
	position: absolute;
	top: 17px;
	width: 86px;
	height: 20px;
	left: 18px;
	font-size: 20px;
	float:left;
	text-align: left;
}

.nopass {
	text-decoration: none;
	float:right;
	margin-right:20px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>修改密码</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
	
	function formsubmit() {
		$("#error").html("");
		var oldpass = $("#oldpassword").val();
		var pass = $("#password").val();
		var pass2 = $("#password2").val();
		
		if (oldpass.trim() == "") {
			$("#error").html("请输入旧密码");
			return false;
		}else if (pass.trim() == "") {
			$("#error").html("请输入密码");
			return false;
		}else if (pass2.trim() == "") {
			$("#error").html("请输入确认密码");
			return false;
		}else if(pass.trim() != pass2.trim()) {
			$("#error").html("两次输入的密码不一致");
			return false;
		}else{
			$.post("${ctx}/wxpage/checkoldpass",{"oldpass":oldpass},function(flag){
				if(flag) {
					$.post("${ctx}/wxpage/changeoldpass",{"pass":pass},function(data){
						if(data) {
							$("#error").html("");
							$("#error").html("密码修改成功，请重新登录");
							
							window.location.href="${ctx}/wxorder/login";
							
						}else{
							$("#error").html("");
							$("#error").html("密码修改失败");
						}
					});
				}else{
					$("#error").html("");
					$("#error").html("旧密码不正确");
				}
			});
		}
	}
	
	document.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
</script>
<body>
	<%-- <div class="logdiv">
		<img src="${ctx}/static/wxfile/images/wxlog.png">
	</div> --%>
	<div class="formdiv">
		<div class="row whiteback">
			<label class="passwordi">旧密码</label><input id="oldpassword" name="oldpassword"
			 class="textinput" type="password" placeholder="请输入旧密码">
		</div>


		<div class="row whiteback">
			<label class="passwordi">新密码</label><input id="password" name="password"
				class="textinput" type="password" placeholder="请输入6-18位字母和数字">
		</div>
		
		<div class="row whiteback">
			<label class="passwordi">确认密码</label><input id="password2" name="password2"
				class="textinput" type="password" placeholder="请再输入一次">
		</div>


		<div class="row" style="text-align: left; margin-top: 10px;">
			<div id="error"
				style="text-align: left; color: red; font-size: 15px; margin-left: 20px;">
				<c:if test="${message!=null}">${message}</c:if>
			</div>

		</div>

		<div class="row"
			style="position: absolute; bottom: 100px; width: 100%;">
			<button class="btn" type="button" onclick="formsubmit()">提交新密码</button>
		</div>
	</div>

</body>
</html>