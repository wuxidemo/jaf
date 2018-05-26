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
<script src="static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#form-id").submit(function() {
			$("#error").html("");
			if ($("#username").val().trim() == "") {
				$("#error").html("请输入账号");
				return false;
			}
			if ($("#password").val().trim() == "") {
				$("#error").html("请输入密码");
				return false;
			}
		});
		$("#issave").val("0");
		$("#issave").bind("change", function() {
			if ($("#issave").val() == "0") {
				$("#issave").val("1");
				$(".checkbox i").css("background-position", "-76px -260px");
			} else {
				$("#issave").val("0");
				$(".checkbox i").css("background-position", "0px -260px");
			}
		});
	});

	function forgetpd() {
		$("#tokenform").submit();
	}
</script>
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

.submitbtn {
	background-color: #44b549;
	border: 0 none;
	border-radius: 3px;
	color: white;
	cursor: pointer;
	font-size: 17px;
	padding: 5px 20px;
	width: 100%;
}

.headtitle {
	background: rgba(0, 0, 0, 0) url("${ctx}/static/images/indextitle.png")
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
	text-align: center;
	width: 100%;
}

.inputdiv {
	border: 1px solid #e8e8e8;
	height: 80%;
	margin: auto;
	padding: 3px 0 3px 52px;
	position: relative;
	width: 75%;
}

.odiv {
	height: 80%;
	margin: auto;
	padding-left: 23px;
	padding-right: 23px;
	text-align: left;
}

.namei {
	background: rgba(0, 0, 0, 0) url("${ctx}/static/images/indexname.png")
		no-repeat scroll center center;
	display: inline-block;
	height: 20px;
	left: 18px;
	position: absolute;
	top: 12px;
	width: 20px;
}

.passwordi {
	background: url('${ctx}/static/images/indexpassword.png') no-repeat
		center;
	display: inline-block;
	position: absolute;
	top: 12px;
	width: 20px;
	height: 20px;
	left: 18px;
}

.checkbox {
	width: 19px;
	cursor: pointer;
}

.checkbox i {
	background-image: url("${ctx}/static/mt/media/image/sprite.png");
	background-position: 0 -260px;
	display: inline-block;
	height: 20px;
	margin-top: -2px;
	vertical-align: middle;
	width: 20px;
}

.forget {
	margin-left: 135px;
	color: #848585;
	cursor: pointer;
}

.forget:hover {
	color: #626262;
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

.nopass {
	float: right;
	text-decoration: none;
	color: #898989;
}
</style>
</head>
<body>
	<div class="headtitle"></div>
	<div id="filldiv" class="backdiv"></div>
	<div class="centerdiv">
		<div class="dltitle">
			<p>登录</p>
		</div>
		<div class="formdiv">
			<form id="form-id" action="${ctx}/login" method="post" id="loginForm">
				<div class="formrow">
					<div class="inputdiv">
						<i class="namei"></i> <input type="text" value="" placeholder="手机号"
							name="username" id="username" />
					</div>
				</div>
				<div class="formrow">
					<div class="inputdiv">
						<i class="passwordi"></i><input type="password" placeholder="密码"
							name="password" id="password" value="" />
					</div>
				</div>
				<div id="error"
					style="text-align: left; color: red; font-size: 15px; width: 75%; margin: auto;">
					<c:if test="${message!=null}">${message}</c:if>
				</div>
				<div class="formrow">
					<div class="odiv">
						<label class="checkbox"><i></i><input type="checkbox"
							id="issave" name="issave" style="display: none">记住账号密码</label> <label
							class="forget" onclick="forgetpd()">忘记密码？</label>
					</div>
				</div>
				<div class="formrow">
					<div class="odiv">
						<button class="submitbtn" style="">登 录</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="foot">合作方：腾讯、无锡农村商业银行</div>

	<script type="text/javascript">
		if (self != top) {
			window.top.location = window.location;
		}
	</script>
	<form action="${ctx}/forget" id="tokenform" style="display: none"
		method="post">
		<input type="hidden" name="token" value="nshpwd" />
	</form>
</body>