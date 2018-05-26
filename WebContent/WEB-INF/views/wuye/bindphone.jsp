<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<title>个人信息</title>
<style>
body {
	margin: 0px;
	padding: 0px;
	font-size: 15px;
	font-family: Microsoft YaHei;
}

.weui_cell:before {
	left: 0 !important;
}

.weui_label {
	width: 5em !important;
}

.weui_cells {
	margin-top: 0px !important;
}

.weui_select {
	padding-left: 0px !important;
}

.fsyzm {
	background-color: #fff;
	border: 2px solid #FFB420;
	border-radius:5px;
	text-align: center;
	/* line-height: 40px; */
	color: #FFB420;
	padding: 3px 2px;
	font-size: 13px;
/* 	position: absolute; */
/* 	right: 0; */
/* 	top: 0; */
}

.foot {
	margin-top: 100px;
	width: 100%;
	text-align: center;
}

.btn {
	width: 80%;
	background-color: #FFB420;
	height: 40px;
	color: white;
	text-align: center;
	margin: auto;
	line-height: 40px;
	border-radius: 5px;
}

.faildetail {
	width: 200px;
	height: 170px;
	top: 50%;
	margin-top: -85px;
	left: 50%;
	margin-left: -100px;
	background-color: white;
	z-index: 999;
	position: fixed;
}

.faildetail div {
	text-align: center;
}

.failtop {
	width: 100%;
	height: 80px;
	background: url('${ctx}/static/wxfile/yicang/image/payfail.png')
		no-repeat center;
	background-size: 25%;
}

.failtip {
	height: 40px;
	font-size: 18px;
	line-height: 20px;
}

.failbutton {
	width: 100%;
	height: 80px;
}

.successdetail {
	width: 200px;
	height: 170px;
	top: 20%;
	left: 50%;
	margin-left: -100px;
	background-color: white;
	z-index: 999;
	position: fixed;
}

.successdetail img {
	width: 100%;
}

.okdiv {
	margin-top: 5px;
	font-size: 24px;
	color: #E82052;
	text-align: center;
}

.oktip {
	font-size: 14px;
	text-align: center;
	color: #B5B5B5;
}

.title {
	position: relative;
	padding-left: 35px;
	color: #80BE27;
}

.title img {
	position: absolute;
	width: 23px;
	left: 0;
}

.weui_cells {
	font-size: 14px !important;
}
.onn{
	color:#ccc;
	border:2px solid #ccc;
}
</style>
</head>
<body>
	<div class="weui_cells ">
		<div class="weui_cell">
			<div class="title">
				<img src="${ctx}/static/wxfile/images/dianhua.png">
				输入户主手机号查询物业费
			</div>
		</div>
		<div class="weui_cell">
			<div class="weui_cell_hd">
				<label class="weui_label">联系方式</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<input class="weui_input" type="tel" placeholder="请输入手机号"
					id="myphone" maxlength="11"
					value="<c:if test="${wu!=null}">${wu.phone}</c:if>">
			</div>
		</div>
		<div class="weui_cell" id="yzmdiv">
			<div class="weui_cell_hd">
				<label class="weui_label">验&nbsp;&nbsp;证&nbsp;&nbsp;码 </label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<input class="weui_input" type="tel" maxlength="6" id="myyzm"
					placeholder="请填写收到的验证码">
			</div>
			<div class="weui_cell_ft">
				<div class="weui_cell_ft fsyzm" id="fsyzm" onclick='sendyzm()'>获取验证码</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<div class="btn">保存</div>
	</div>
<!-- 	<div id="toast" style="display: none;"> -->
<!-- 		<div class="weui_mask_transparent"></div> -->
<!-- 		<div class="weui_toast"> -->
<!-- 			<i class="weui_icon_msg weui_icon_warn"></i> -->
<!-- 			<p class="weui_toast_content" id="toastcontent"></p> -->
<!-- 		</div> -->
<!-- 	</div> -->

<!-- 	<div id="oktoast" style="display: none;"> -->
<!-- 		<div class="weui_mask_transparent"></div> -->
<!-- 		<div class="weui_toast"> -->
<!-- 			<i class="weui_icon_toast"></i> -->
<!-- 			<p class="weui_toast_content">发送成功</p> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 弹窗提示模块1 -->
		<div class="weui_allll" id="weui_al" style="display: none;">
			<div class="weui_mask" id="onetishi" style="display: none;"></div>
			<div class="weui_dialog" id="onetishi2" style="display: none;">
				<div class="weui_dialog_hd">
					<strong class="weui_dialog_title"></strong>
				</div>
				<div class="weui_dialog_bd" id="weui_dialog_bd" style="color: #000;">才能描述不能为空!</div>
				<div class="weui_dialog_ft">
					<a href="javascript:void(0);" class="weui_btn_dialog primary"
						onclick="closeHint()" style="color: #FFB420;">确定</a>
				</div>
			</div>
		</div>
	<div class="container" id="container"
		style="display: none; position: fixed; left: 0; right: 0; top: 0; background-color: white; z-index: 22;">
		<div class="msg">
			<div class="weui_msg">
				<div class="weui_icon_area">
					<i class="weui_icon_success weui_icon_msg"></i>
				</div>
				<div class="weui_text_area">
					<h2 class="weui_msg_title">保存成功</h2>
					<p class="weui_msg_desc"></p>
				</div>
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a href="javascript:;" class="weui_btn weui_btn_primary"
							onclick="toshow()">确定</a>
					</p>
				</div>
				<div class="weui_extra_area"></div>
			</div>
		</div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wuye/js/wuye.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var issendmsg = false;
	$(document).ready(function() {
		initevent();
	});

	function initevent() {
		$(".btn").bind("click", function() {
			submit();
		});
	}
	var issubmit = false;
	function submit() {
		if (issubmit) {
			return;
		}
		if ($("#myphone").val() == "") {
			showHint("请输入手机号");
// 			showalert("请输入手机号", 1500);
			return;
		}
		if (!testphone($("#myphone").val())) {
			showHint("手机号输入错误");
// 			showalert("手机号输入错误", 1500);
			return;
		}

		if ($("#myyzm").val() == "") {
			showHint("请输入验证码");
// 			showalert("请输入验证码", 1500);
			return;
		}
		issubmit = true;
		checkcode();
	}
	function checkcode() {
		$.post("${ctx}/wxcommunity/verifycaptcha", {
			phone : $("#myphone").val(),
			code : $("#myyzm").val()
		}, function(data) {
			if (data.result == 1) {
				savetmp();
			} else {
				issubmit = false;
				showHint("验证码错误");
// 				showalert("验证码错误", 1500);
			}
		});
	}
	function subm(state) {
// 		$("#dialog1").hide();
		savetmp();
	}
	function savetmp() {
		var data = {};
		data.openid = '${openid}';
		data.phone = $("#myphone").val();

		$.post("${ctx}/wxcommunity/savebind", data, function(d) {
			if (d.result == "1") {
				$("#container").show();//保存成功后页面
			} else {
				showHint(d.msg);
// 				showalert(d.msg, 1500);
				issubmit = false;
			}

		});

	}
	function sendyzm() {
		
		if (issendmsg) {
			return;
		}
		if ($("#myphone").val() == "") {
			showHint("请输入手机号");
// 			showalert("请输入手机号", 1500);
			return;
		}
		if (!testphone($("#myphone").val())) {
			showHint("手机号输入错误");
// 			showalert("手机号输入错误", 1500);
			return;
		}
		issendmsg = true;
		$.post("${ctx}/wxcommunity/sendsms", {
			"phone" : $("#myphone").val()
		}, function(data) {
			if (data.result == 1) {
// 				$("#oktoast").show();
				showHint("短信发送成功");
				time = 60;
				cfdjs();
				$("#myphone").attr("readonly", "readonly");
// 				setTimeout(function() {
// 					$("#oktoast").hide();
// 				}, 1500);
			} else {
				showHint("发送失败");
// 				showalert("发送失败", 1500);
			}
		});
	}
	//验证码时间
	var time = 60;
	//验证码倒计时控制
	function cfdjs() {
		if (time > 0) {
			$(".fsyzm").html(time + "s后重新获取");
			$("#fsyzm").addClass("onn");
			time--;
			setTimeout("cfdjs()", 1000);
		} else {
			issendmsg = false;
			$("#fsyzm").removeClass("onn");
			$(".fsyzm").html("发送验证码");
			$("#myphone").removeAttr("readonly");
		}
	}
	function toshow() {
		window.open('${ctx}/wxcommunity/showwyjf');
	}
	function showerror($this) {
		if ($($this).parent().parent().children().length != 3) {
			$($this).parent().parent().append(error);
		}
	}
	function hideerror($this) {
		if ($($this).parent().parent().children().length == 3) {
			$($($this).parent().parent().children()[2]).remove();
		}
	}
	var yzm = '<div class="weui_cell_ft fsyzm" onclick=\'sendyzm()\'>发送验证码</div>';
	var error = '<div class="weui_cell_ft"><i class="weui_icon_warn"></i></div>';
	function showalert(str, time) {
		$("#toastcontent").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, time);
	}
	function testphone(str) {
		return (/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/i
				.test(str));
	}
</script>
</html>