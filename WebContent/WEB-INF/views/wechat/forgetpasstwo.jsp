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
	top: 140px;
	width: 100%;
	min-height: 280px;
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
	padding-left: 50px;
	background-color: white;
	border-bottom: solid 1px #e8e8e8;
}

.checkbox {
	width: 19px;
	cursor: pointer;
	color: #898989;
	font-size: 17px;
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

.logdiv {
	width: 100%;
	text-align: center;
	padding-top: 20px;
}

.logdiv img {
	width: 100px;
	height: 121px;
}

.namei {
	background: rgba(0, 0, 0, 0) url("${ctx}/static/images/indexname.png")
		no-repeat scroll center center;
	display: inline-block;
	height: 20px;
	left: 18px;
	position: absolute;
	top: 17px;
	width: 20px;
}

.passwordi {
	background: url('${ctx}/static/images/indexpassword.png') no-repeat
		center;
	display: inline-block;
	position: absolute;
	top: 17px;
	width: 20px;
	height: 20px;
	left: 18px;
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
		$("#myform").submit(function() {
			$("#error").html("");
			if ($("#name").val().trim() == "") {
				$("#error").html("请输入手机号码");
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
	document.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
</script>
<body>
	<div class="logdiv">
		<img src="${ctx}/static/wxfile/images/wxlog.png">
	</div>
	<div class="formdiv">
		<div class="row whiteback">
			<i class="passwordi"></i><input id="password" name="password" class="textinput" type="password" placeholder="新密码">
		</div>


		<div class="row whiteback">
			<i class="passwordi"></i><input id="password2" name="password2" class="textinput" type="password" placeholder="确认密码">
		</div>


		<div class="row" style="text-align: left; margin-top: 10px;">
			<div id="error"
				style="text-align: left; color: red; font-size: 15px; margin-left: 20px;">
				<c:if test="${message!=null}">${message}</c:if>
			</div>

		</div>
		
		<input type="hidden" name="telephone" id="telephone" value="${tel}">

		<div class="row" style="position: absolute; bottom: 100px; width: 100%;">
			<input class="btn" type="button" value="确认更改密码" onclick="resetpwd()"/>
		</div>
	</div>
	
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
				  var url="${ctx}/wxpage/password/changenewpassword";
				  $.post(url,{"newpassword":newpass1,"telephone":telephone},function(d){
					  if(d.result == 1) {
						  alert(d.msg);
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
			window.location.href="${ctx}/wxorder/login";
		}
		
	</script>

</body>
</html>