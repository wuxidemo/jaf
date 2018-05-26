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
<title>捐献</title>
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style>
body {
	margin: 0px;
	padding: 0px;
	font-size: 15px;
	font-family: Microsoft YaHei;
}

.head {
	background-color: #EEEEEE;
	width: 100%;
	height: 30px;
	border-bottom: 1px solid #E0E0E0;
	color: #4D4747;
}

.hleft {
	float: left;
	margin-left: 20px;
	height: 30px;
	line-height: 30px;
}

.hright {
	float: right;
	margin-right: 20px;
	height: 30px;
	line-height: 30px;
}

.gleft {
	width: 30%;
	height: 100%;
	position: relative;
	float: left;
}

.gright {
	width: 70%;
	height: 100%;
	float: left;
}

.goodrow {
	height: 80px;
	border-bottom: 1px solid #E0E0E0;
}

.goodshow {
	width: 70px;
	height: 70px;
	background: url('/nsh/static/wxfile/wnx/image/yesican000.jpg') no-repeat;
	background-size: cover;
	background-position: 50%;
	margin-top: 0px;
	left: 50%;
	position: absolute;
	margin-left: -35px;
	margin-top: 5px;
}

.grtop {
	width: 100%;
	height: 30px;
	line-height: 40px;
	color: #635E5B;
}

.gbottom {
	width: 100%;
	height: 50px;
}

.gbleft {
	width: 30%;
	height: 50px;
	line-height: 50px;
	color: #FFB420;
	font-size: 20px;
	float: left;
}

.gbright {
	width: 70%;
	height: 50px;
	line-height: 50px;
	float: left;
}

.addsub {
	width: 100px;
	height: 50px;
	float: right;
	margin-right: 10px;
}

.sub {
	background: url('${ctx}/static/wxfile/wnx/image/sub.png') no-repeat
		center;
	width: 35px;
	background-size: 85%;
	height: 50px;
	float: left;
}

.add {
	background: url('${ctx}/static/wxfile/wnx/image/add.png') no-repeat
		center;
	width: 35px;
	background-size: 85%;
	height: 50px;
	float: left;
}

.num {
	float: left;
	min-width: 20px;
	height: 50px;
	text-align: center;
	line-height: 50px;
	color: #AAAAAA;
}

.foot {
	position: fixed;
	width: 100%;
	bottom: 0;
	height: 50px;
	background-color: #EEEEEE;
	font-size: 18px;
}

.fleft {
	height: 100%;
	width: 60%;
	line-height: 50px;
	float: left;
}

.fleft font {
	margin-left: 10px;
	color: #5E5755;
}

.fright {
	height: 100%;
	width: 40%;
	line-height: 50px;
	background-color: #FFB420;
	color: white;
	float: left;
	text-align: center;
}

#goods {
	margin-bottom: 50px;
}

.weui_toast_content {
	padding: 2px 15px;
}

.weui_toast {
	width: 11.6em !important;
	margin-left: -5.8em !important;
}
</style>
</head>
<body>
	<div class="head">
		<div class="hleft">企业捐献</div>
		<div class="hright">></div>
	</div>
	<div id="goods"></div>
	<div class="foot">
		<div class="fleft">
			<font>共0元</font>
		</div>
		<div class="fright" onclick="submit()">立即捐赠</div>
	</div>
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent">请选择商品</p>
		</div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var openid = "${openid}";
	var comid = "${comid}";//getCookie("yccomid");
	if (comid == "") {
		showalert("请返回，选择社区后再操作", 999999999);
	}
	$(document).ready(function() {
		init();
	});
	function init() {
		setCookie("yccomid", "", 999999);
		getGoods();
		$(".head")
				.bind(
						"click",
						function() {
							window.location.href = "${ctx}/wxcommunity/corporatedonation?comid=${comid}";
						});
	}

	//获取商品
	function getGoods() {
		$
				.post(
						"${ctx}/wxcommunity/getlistbycomid?comid=" + comid,
						function(d) {
							for (var i = 0; i < d.length; i++) {
								$("#goods")
										.append(
												'<div class="goodrow"><div class="gleft"><div class="goodshow"></div></div><div class="gright"><div class="grtop">'
														+ d[i].name
														+ ' '
														+ d[i].format
														+ '</div><div class="gbottom"><div class="gbleft">￥'
														+ (d[i].price / 100)
														+ '</div><div class="gbright"><div class="addsub"><div class="sub" style="visibility: hidden;" ></div><div class="num" price="'
														+ d[i].price 
														+ '" numid="'
														+ d[i].id
														+ '" style="visibility: hidden;">0</div><div class="add"></div></div></div></div></div></div>');
							}

							bindclick();
						});

	}
	//绑定点击事件
	function bindclick() {
		$(".add").bind("touchstart", function() {
			if ($(this).prev().css("visibility") == "hidden") {
				$(this).prev().html("1");
				$(this).prev().css("visibility", "");
				$(this).prev().prev().css("visibility", "");
			} else {
				$(this).prev().html(parseInt($(this).prev().html()) + 1);
			}
			getall();
		});
		$(".sub").bind("touchstart", function() {
			var num = parseInt($(this).next().html());
			if (num == 1) {
				$(this).next().html("0");
				$(this).next().css("visibility", "hidden");
				$(this).css("visibility", "hidden");
			} else {
				$(this).next().html(num - 1);
			}
			getall();
		});
	}

	function getall() {
		var all = 0;
		$(".num").each(function() {
			all += parseInt($(this).attr("price")) * parseInt($(this).html());
		});
		$("font").html("共" + (all / 100) + "元");
	}

	var issubmit = false;
	function submit() {
		if (issubmit) {
			return;
		}
		if (comid == "") {
			showalert("请返回，选择社区后再操作", 999999999);
			return;
		}
		var allids = "";
		var allcount = "";
		$(".num").each(function() {
			if ($(this).html() != "0") {
				allids += $(this).attr("numid") + ",";
				allcount += $(this).html() + ",";
			}
		});
		if (allids == "") {
			showalert("请选择商品", 1500);
			return;
		}
		if (allids.endWith(",")) {
			allids = allids.substring(0, allids.length - 1);
		}
		if (allcount.endWith(",")) {
			allcount = allcount.substring(0, allcount.length - 1);
		}
		var data = {};
		data.openid = openid;
		data.comid = comid;
		data.allids = allids;
		data.allcount = allcount;
		issubmit = true;
		$
				.post(
						"${ctx}/wxcommunity/savetmporder",
						data,
						function(d) {
							issubmit = false;
							if (d.result == 1) {
								window.location.href = "${ctx}/wxcommunity/updatetmporderform?openid="
										+ openid
										+ "&tmpid="
										+ d.tmpid
										+ "&comid=" + comid;
							} else {
								showalert("保存失败，请稍后重试", 1500);
							}
						});
	}

	function showalert(str, time) {
		$("#toastcontent").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, time);
	}

	function getCookie(name) {
		var cookieArray = document.cookie.split("; "); //得到分割的cookie名值对    
		var cookie = new Object();
		for (var i = 0; i < cookieArray.length; i++) {
			var arr = cookieArray[i].split("="); //将名和值分开    
			if (arr[0] == name)
				return unescape(arr[1]); //如果是指定的cookie，则返回它的值    
		}
		return "";
	}

	//设置cookie方法
	function setCookie(key, val, time) {
		var date = new Date();
		var expiresDays = time;
		date.setTime(date.getTime() + expiresDays);
		document.cookie = key + "=" + val + ";expires=" + date.toGMTString()
				+ ";path=/";
	}
	String.prototype.endWith = function(str) {
		var reg = new RegExp(str + "$");
		return reg.test(this);
	}
</script>
</html>