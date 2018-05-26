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
					value="<c:if test="${wu!=null}">${wu.name}</c:if>"
					placeholder="请输入姓名">
			</div>
		</div>
		<div class="weui_cell weui_cell_select weui_select_after">
			<div class="weui_cell_hd">
				<label class="weui_label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<select class="weui_select" name="select2" id="mysex">
					<option value="1" <c:if test="${wu!=null and wu.sex==1}">selected=""</c:if> >男</option>
					<option value="2" <c:if test="${wu!=null and wu.sex==0}">selected=""</c:if> >女</option>
				</select>
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
		<div class="weui_cell" id="yzmdiv" style="display: none;">
			<div class="weui_cell_hd">
				<label class="weui_label">验&nbsp;&nbsp;证&nbsp;&nbsp;码 </label>
			</div>
			<div class="weui_cell_bd weui_cell_primary">
				<input class="weui_input" type="tel" maxlength="6" id="myyzm"
					placeholder="请输入验证码">
			</div>
		</div>
	</div>
	<div class="foot">
		<div class="btn">下一步</div>
	</div>
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent"></p>
		</div>
	</div>
	<div class="payfail" style="display: none">
		<div class="weui_mask_transparent"
			style="background-color: #333; opacity: 0.8;"></div>
		<div class="faildetail">
			<div class="failtop"></div>
			<div class="failtip">支付失败</div>
			<div class="failbutton">
				<div class="repaybtn">重新支付</div>
			</div>
		</div>
	</div>

	<div class="paysuccess" style="display: none;">
		<div class="weui_mask_transparent" style="background-color: white;"></div>
		<div class="successdetail">
			<img alt="" src="${ctx}/static/wxfile/yicang/image/paysuccess.png">
			<div class="okdiv">捐献成功</div>
			<div class="oktip">谢谢您未社区做出的贡献</div>
		</div>
	</div>
	<div id="oktoast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_toast"></i>
			<p class="weui_toast_content">发送成功</p>
		</div>
	</div>
	<div class="weui_dialog_confirm" id="dialog1" style="display: none;">
		<div class="weui_mask"></div>
		<div class="weui_dialog">
			<div class="weui_dialog_hd">
				<strong class="weui_dialog_title"></strong>
			</div>
			<div class="weui_dialog_bd">是否将个人信息保存到我的</div>
			<div class="weui_dialog_ft">
				<a href="javascript:;" onclick="subm(0)"
					class="weui_btn_dialog default">否</a> <a href="javascript:;"
					onclick="subm(1)" class="weui_btn_dialog primary">是</a>
			</div>
		</div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var oldphone = $("#myphone").val();
	var oldname = $("#myname").val();
	var oldsex=$("#mysex").val();
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	var issendmsg = false;
	if (!wechatInfo) {
		//alert("本活动仅支持微信");
	} else if (wechatInfo[1] < "5.0") {
		alert("本活动仅支持微信5.0以上版本");
	}
	$(document).ready(function() {
		initevent();
	});

	function initevent() {
		$(".btn").bind("click", function() {
			submit();
		});
		$(".repaybtn")
				.bind(
						"click",
						function() {
							window.location.href = "${ctx}/wxurl/redirect?url=wxcommunity/persondonation?comid=25";
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
			if ($(this).val() == "" || !testphone($(this).val())) {
				if ($(this).parent().parent().children().length == 3) {
					$($(this).parent().parent().children()[2]).remove();
				}
				$(this).parent().parent().append(error);
			} else {
				if ($(this).val() == oldphone) {
					$($(this).parent().parent().children()[2]).remove();
					$("#yzmdiv").hide();
				} else {
					if ($(this).parent().parent().children().length == 3) {
						$($(this).parent().parent().children()[2]).remove();
					}
					$(this).parent().parent().append(yzm);
					$("#yzmdiv").show();
				}
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
	function submit() {
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
			if ($("#myphone").val() == oldphone) {
				$($("#myphone").parent().parent().children()[2]).remove();
				$("#yzmdiv").hide();
			} else {
				//if ($("#myphone").parent().parent().children().length == 3) {
				//	$($("#myphone").parent().parent().children()[2]).remove();
				//}
				//$("#myphone").parent().parent().append(yzm);
				//$("#yzmdiv").show();
			}
		}

		if ($("#yzmdiv").css("display") != "none") {
			if ($("#myyzm").val() == "") {
				showerror($("#myyzm"));
				isok = false;
			} else {
				hideerror($("#myyzm"));
			}
		}
		if (!isok) {
			issubmit = false;
			return;
		}
		if ($("#yzmdiv").css("display") != "none") {
			checkcode();
		} else {
			issaveold();
		}
	}
	function checkcode() {
		$.post("${ctx}/wxcommunity/verifycaptcha", {
			phone : $("#myphone").val(),
			code : $("#myyzm").val()
		}, function(data) {
			if (data.result == 1) {
				issaveold();
			} else {
				issubmit = false;
				showalert("验证码错误", 1500);
			}
		});
	}
	var issave = 1;
	function issaveold() {
		if (oldphone != ""
				&& oldname != ""
				&& ($("#myphone").val() != oldphone || $("#myname").val() != oldname) ||$("#mysex").val()!=oldsex) {
			$("#dialog1").show();
		} else {
			savetmp();
		}
	}
	function subm(state) {
		$("#dialog1").hide();
		issave = state;
		savetmp();
	}
	function savetmp() {
		var data = {};
		data.openid = '${openid}';
		data.tmpid = '${tmpid}';
		data.name = $("#myname").val();
		data.sex = $("#mysex").val();
		data.phone = $("#myphone").val();
		data.issave = issave;

		$.post("${ctx}/wxcommunity/updatetmporder", data, function(d) {
			if (d.result == "1") {
				pay(d.appId, d.timeStamp, d.nonceStr, d.package1, d.signType,
						d.paySign);
			} else {
				showalert(d.msg, 1500);
				issubmit = false;
			}

		});

	}
	function pay(appId, timeStamp, nonceStr, package1, signType, paySign) {
		WeixinJSBridge.invoke('getBrandWCPayRequest', {
			"appId" : appId, //公众号名称，由商户传入     
			"timeStamp" : timeStamp + "", //时间戳，自1970年以来的秒数     
			"nonceStr" : nonceStr, //随机串     
			"package" : package1,
			"signType" : signType, //微信签名方式:     
			"paySign" : paySign
		//微信签名 
		}, function(res) {
			if (res.err_msg == "get_brand_wcpay_request:ok") {
				$(".paysuccess").show();
			} else {
				$(".payfail").show();
			}
		});

	}
	function sendyzm() {
		if (issendmsg) {
			return;
		}
		issendmsg = true;
		$.post("${ctx}/wxcommunity/sendsms", {
			"phone" : $("#myphone").val()
		}, function(data) {
			if (data.result == 1) {
				$("#oktoast").show();
				time = 10;
				cfdjs();
				$("#myphone").attr("readonly", "readonly");
				setTimeout(function() {
					$("#oktoast").hide();
				}, 1500);
			} else {
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