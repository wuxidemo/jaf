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
	top: 20px;
	width: 100%;
	position: absolute;
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

.whiteback {
	padding-left: 120px;
	background-color: white;
	border-bottom: solid 1px #e8e8e8;
}

.titlediv {
	width: 100%;
	text-align: left;
	padding-top:11px;
	padding-left:20px;
	height:20px;
	line-height:20px;
}
.titlediv div {
	width: 100%;
}

.namei {
	display: inline-block;
	height: 20px;
	left: 18px;
	position: absolute;
	top: 17px;
	width: 43px;
	font-size: 20px;
}

.passwordi {
	display: inline-block;
	position: absolute;
	top: 17px;
	width: 43px;
	height: 20px;
	left: 18px;
	font-size: 20px;
}

.valcode {
	display: inline-block;
	position: absolute;
	top: 17px;
	width: 65px;
	height: 20px;
	left: 18px;
	font-size: 20px;
}

.valcodeinput {
	height: 55px;
	width: 50%;
	border: none;
	font-size: 20px;
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
<title>添加银行卡</title>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
</head>
	
<script type="text/javascript">
	$(document).ready(function() {
	
	});
	
	function formsubmit() {
		$("#error").html("");
		
		var name = $("input[name='name']").val();
		var bankcard = $("input[name='bankcard']").val();
		var valcode = $("input[name='valcode']").val();
		
		if (name.trim() == "") {
			$("#error").html("请输入持卡人姓名");
			return false;
		}else if (bankcard.trim() == "") {
			$("#error").html("请输入持卡人银行卡卡号");
			return false;
		}else if(valcode.trim() == "") {
			$("#error").html("请输入验证码");
			return false;
		}else{
			$.post("${ctx}/wxpage/checkvalcode",{"valcode":valcode},function(data){
				if(data){
					$.post("${ctx}/wxpage/savebankcard",{"name":name.trim(),"bankcard":bankcard.trim()},function(result){
						if(result.result == '1') {
							$("#error").html(result.message);
							window.location.href="${ctx}/wxurl/redirect?url=wxcard/mybankcard";
						}else{
							$("#error").html(result.message);
							$("img").attr("src","${ctx}/wxpage/getvalidcode?rand="+Math.random());
						}
					});
				}else{
					$("#error").html("验证码错误或已失效");
					$("img").attr("src","${ctx}/wxpage/getvalidcode?rand="+Math.random());
					
				}
			});
		}
	}
	
	document.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
	
</script>
<body>
	<div class="titlediv">
		<div>请绑定持卡人本人的银行卡</div>
	</div>
	<div class="formdiv">
		<div class="row whiteback">
			<label class="namei">姓名</label><input id="name" name="name" class="textinput"
				placeholder="请输入持卡人姓名" maxlength="15">
		</div>


		<div class="row whiteback">
			<label class="passwordi">卡号</label><input id="bankcard" name="bankcard"
				class="textinput" type="text" placeholder="请输入持卡人卡号" maxlength="20">
		</div>
		
		<div class="row whiteback"  style="margin-top: 10px;padding-left:108px;">
			<label class="valcode">验证码</label>
			<input id="valcodeinput" name="valcode" class="valcodeinput" type="text" placeholder="请输入验证码" maxlength="10">
			<img alt="点击换一张" src="${ctx}/wxpage/getvalidcode?rand="+"Math.random()" style="float:right;background: transparent;" width="100px" height="55px" onclick="this.src='${ctx}/wxpage/getvalidcode?rand='+Math.random();">
		</div>


		<div class="row" style="text-align: left; margin-top: 10px;">
			<div id="error"
				style="text-align: left; color: red; font-size: 15px; margin-left: 20px;">
				<c:if test="${message!=null}">${message}</c:if>
			</div>

		</div>

		<div class="row"
			style="position: absolute; bottom: 100px; width: 100%;">

			<button class="btn" type="button" onclick="formsubmit()">绑定</button>
		</div>
	</div>

</body>
</html>