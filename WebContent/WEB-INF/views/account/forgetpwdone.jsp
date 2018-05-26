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
	width: 100%;
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

.sendbtn {
	background-color: #44b549;
	border: 0 none;
	border-radius: 3px;
	color: white;
	cursor: pointer;
	font-size: 17px;
	padding: 5px;
	width: 100%;
	text-decoration: none;
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
			<p>找回密码</p>
		</div>
		<div class="formdiv">
			<form id="checkform" action="" method="post">
				<div class="formrow">
					<div class="inputdiv">
						<input type="text" name="telephone" placeholder="注册时的手机号码"
							id="telephone" value="" />
					</div>
					<div class="sendbtndiv">
						<a class="sendbtn" href="javascript:;" onclick="sendsms()">发送验证码</a>
					</div>
				</div>
				<div class="formrow">
					<div class="inputdiv">
						<input type="text" name="captcha" placeholder="验证码" id="captcha"
							value="" />
					</div>
				</div>
				<div id="error"
					style="text-align: left; color: red; font-size: 15px; width: 75%; margin: auto;">
				</div>
				<div class="formrow">
					<div class="odiv">
						<a class="checkbtn" onclick="validate()">验证</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="${ctx}/login"
							class="loginlink">返回登录</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<form action="${ctx}/forget/gonext" id="nextForm" style="display: none"
		method="post"></form>

	<div class="foot">合作方：腾讯、无锡农村商业银行</div>

	<script type="text/javascript">
		var timer = '';
		var time = "";
		function sendsms() {
			
			$(".sendbtn").removeAttr("onclick");
			$(".sendbtn").css("cursor", "wait")

			var telephone = $("#telephone").val();

			$("#error").html("");
			if (telephone.trim() == "") {
				$(".sendbtn").attr("onclick", "sendsms()");
				$(".sendbtn").css("cursor", "pointer")
				$("#error").html("请输入你的手机号码");
				return false;
			} else {
				var url = "${ctx}/forget/checktelephone";
				$.post(url, {
					"telephone" : telephone.trim()
				}, function(data) {
					if (data) {
						time = 60;
						timer = setInterval(timecount, 1000);
						getCaptcha();
					} else {
						$(".sendbtn").attr("onclick", "sendsms()");
						$(".sendbtn").css("cursor", "pointer")
						$("#error").html("");
						$("#error").html("该手机号码未注册");
					}
				});

			}
		}

		function getCaptcha() {
			var sendurl = "${ctx}/forget/getcaptcha";
			$.post(sendurl, {
				"telephone" : $("#telephone").val().trim()
			});
		}

		
		function timecount() {
			time--;
			var tipstr = "";
			if (time <= 0) {
				tipstr = "重新发送";
				$(".sendbtn").html(tipstr);
				clearInterval(timer);
				$(".sendbtn").attr("onclick", "sendsms()");
				$(".sendbtn").css("cursor", "pointer")
			} else {
				tipstr = time + "秒后重发";
				$(".sendbtn").html(tipstr);
				$(".sendbtn").removeAttr("onclick");
				$(".sendbtn").css("cursor", "wait")
			}
		}

		function checkCaptcha() {
			var telephone = $("#telephone").val();
			var captchacode = $("#captcha").val();

			var sendurl = "${ctx}/forget/checkcaptcha";
			$.post(sendurl, {
				"telephone" : telephone.trim(),
				"captcha" : captchacode.trim()
			}, function(data) {
				if (data.result == 1) {
					$("#error").html("");
					$("#error").html(data.msg);
					gonext();
				} else if (data.result == 0) {
					$("#error").html("");
					$("#error").html(data.msg);
				}
			});
		}

		function validate() {

			$("#error").html("");

			if ($("#telephone").val().trim() == "") {
				$("#error").html("请输入你的手机号码");
				return false;
			}

			if (($("#telephone").val())
					.search(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/) == -1) {
				$("#error").html("请输入正确的手机号码");
				return false;
			}

			if ($("#captcha").val().trim() == "") {
				$("#error").html("请输入验证码");
				return false;
			} else {
				var url = "${ctx}/forget/checktelephone";
				$.post(url, {
					"telephone" : $("#telephone").val().trim()
				}, function(data) {
					if (data) {
						checkCaptcha();
					} else {
						$("#error").html("");
						$("#error").html("该手机号码未注册");
					}
				});
			}
		}

		function gonext() {
			$("#nextForm").append(
					'<input name="tel" value="' + $("#telephone").val().trim()
							+ '" />');
			$("#nextForm").submit();
		}
	</script>

</body>