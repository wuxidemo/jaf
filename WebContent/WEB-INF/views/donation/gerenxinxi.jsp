<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>个人信息</title>
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style type="text/css">
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
	background-color: #FFB420;
	text-align: center;
	/* line-height: 40px; */
	color: white;
	padding: 10px 5px;
	position: absolute;
	right: 0;
	top: 0;
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

.repaybtn {
	border: 1px solid #FFB420;
	width: 80%;
	margin: auto;
	height: 35px;
	line-height: 35px;
	color: #FFB420;
	border-radius: 5px;
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
</style>
</head>
<body>
	<div class="weui_cells ">
		<div class="weui_cell">
			<div class="weui_cell_hd">
				<label class="weui_label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">

				<input class="weui_input" maxlength="5" id="myname"
					value="" name="name"
					placeholder="请输入姓名">
			</div>
		</div>
		<div class="weui_cell weui_cell_select weui_select_after">
			<div class="weui_cell_hd">
				<label class="weui_label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<select class="weui_select" name="sex" id="mysex">
					<option value="1">男</option>
					<option value="2">女</option>
				</select>
			</div>
		</div>
		<div class="weui_cell">
			<div class="weui_cell_hd">
				<label class="weui_label">联系方式</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<input class="weui_input" type="tel" placeholder="请输入手机号"
					id="myphone" maxlength="11" name="phone"
					value="">
			</div>
		</div>
		<div class="weui_cell" id="yzmdiv" style="display: none;">
			<div class="weui_cell_hd">
				<label class="weui_label">验&nbsp;&nbsp;证&nbsp;&nbsp;码 </label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<input class="weui_input" type="tel" maxlength="6" id="myyzm"
					placeholder="请输入验证码">
			</div>
		</div>
		<input type="hidden" name="openid" value="${openid}" />
	</div>
	<div class="foot">
		<div class="btn">保存</div>
	</div>
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent"></p>
		</div>
	</div>
	<!--发送验证码提示  -->
	<div id="oktoast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_toast"></i>
			<p class="weui_toast_content">发送成功</p>
		</div>
	</div>
	<!--微信提示 -->
	<div class="weui_mask" style="display: none;"></div>
	<div class="weui_dialog" style="display: none;">
		<div class="weui_dialog_hd"><strong class="weui_dialog_title"></strong></div>
		<div class="weui_dialog_bd" id="weui_dialog_bd" style="padding-left: 30px;padding-right: 30px;"></div>
		<div class="weui_dialog_ft">
			<a href="javascript:;" class="weui_btn_dialog primary">确定</a>
		</div>
	</div> 
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	var issendmsg = false;
	if (!wechatInfo) {
		//alert("本活动仅支持微信");
	} else if (wechatInfo[1] < "5.0") {
		alert("本活动仅支持微信5.0以上版本");
	}
	
	$(document).ready(function() {
		$($("#myphone")).parent().parent().append(yzm);
		$("#yzmdiv").show();
		initevent();
	});
	
	function initevent() {
		$(".btn").bind("click", function() {
			submit();
		});
		$("#myname").blur(function() {
			if ($(this).val() == "") {
				showerror(this);
			} else {
				hideerror(this);
			}
		});
		$("#myphone").blur(function() {
			if (issendmsg) {
				return;
			}
			if ($("#myphone").val() == "") {
				$(".weui_mask").show();
				$(".weui_dialog").show();
				document.getElementById("weui_dialog_bd").innerHTML = "请输入联系方式";
				return false;
			}else if(!testphone($("#myphone").val())){
				$(".weui_mask").show();
				$(".weui_dialog").show();
				document.getElementById("weui_dialog_bd").innerHTML = "联系方式不正确";
				return false;
			}else{
				$(this).parent().parent().append(yzm);
				$("#yzmdiv").show();
			}
		});
		$("#myyzm").blur(function() {
			if ($(this).val() == "") {
				showerror(this);
			} else {
				hideerror(this);
			}
		});
	}
	var issubmit = false;
	function submit(){
		if(issubmit)
			{
			return ;
			}
		issubmit=true;
		var isok = true;
		if ($("#myname").val() == "") {
			showerror($("#myname"));
			isok = false;
		} else {
			hideerror($("#myname"));
		}
		
		if ($("#myphone").val() == "" || !testphone($("#myphone").val())) {
			if ($("#myphone").parent().parent().children().length == 3) {
				$($("#myphone").parent().parent().children()[2]).remove();
			}
			$("#myphone").parent().parent().append(error);
			isok = false;
		} else {
		}
		
		if ($("#myyzm").val() == "") {
			showerror($("#myyzm"));
			isok = false;
		} else {
			hideerror($("#myyzm"));
			checkcode();
		}
		if (!isok) {
			issubmit = false;
			return;
		}
	}
	function checkcode() {
		$.post("${ctx}/wxcommunity/verifycaptcha",
		{
			"phone" : $("#myphone").val(),
			"code" : $("#myyzm").val()
		},
		function(data){
			if (data.result == 1){
				savetmp();
			}else{
				issubmit = false;
				$(".weui_mask").show();
				$(".weui_dialog").show();
				document.getElementById("weui_dialog_bd").innerHTML = "验证码有误!";
			}
		});
	}
	function subm(state) {
		$("#dialog1").hide();
		issave = state;
		savetmp();
	}
	
	function savetmp(){
		var data = {};
		data.openid = '${openid}';
		data.name = $("#myname").val();
		data.sex = $("#mysex").val();
		data.phone = $("#myphone").val();
		
		$.post("${ctx}/wxcommunity/savemyinfo",data,function(d){
			if (d.result == "1") {
				window.location.href = "${ctx}/wxcommunity/myrecords?comid=${comid}";

			}else{
					showalert(d.msg, 1500);
					issubmit = false;
				}
		});
	}
	
	
	function sendsms(){
			if ($("#myphone").val() == "") {
				$(".weui_mask").show();
				$(".weui_dialog").show();
				document.getElementById("weui_dialog_bd").innerHTML = "请输入联系方式";
				return false;
			}else if(!testphone($("#myphone").val())){
				$(".weui_mask").show();
				$(".weui_dialog").show();
				document.getElementById("weui_dialog_bd").innerHTML = "联系方式不正确";
				return false;
			}else{
			$("#myyzm").html("");
			var telnum = $("#myphone").val();
			sendyzm(telnum);
		}
	}
	
	//点击发送验证码接口
	function sendyzm(){
		var telnum = $("#myphone").val();
		if (issendmsg) {
			return;
		}
		issendmsg = true;
		$.post("${ctx}/wxcommunity/sendsms",
		{
			"phone" : telnum
		},
		function(data){
			if (data.result == 1) {
				$("#oktoast").show();
				time = 10;
				cfdjs();
				$("#myphone").attr("readonly", "readonly");
				setTimeout(function() {
					$("#oktoast").hide();
				}, 1500);
			}else{
				showalert("发送失败", 1500);
			}
		});
	}
	
	var time = 10;
	function cfdjs() {
		if (time > 0) {
			$(".fsyzm").html(time + "秒后重发");
			time--;
			setTimeout("cfdjs()", 1000);
		} else {
			issendmsg = false;
			$(".fsyzm").html("发送验证码");
			$("#myphone").removeAttr("readonly");
		}
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
	
	$(".weui_dialog_ft").bind("click",function(){
		$(".weui_mask").hide();
		$(".weui_dialog").hide();
	});
	
	var yzm = '<div class="weui_cell_ft fsyzm" onclick=\'sendsms()\'>发送验证码</div>';
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