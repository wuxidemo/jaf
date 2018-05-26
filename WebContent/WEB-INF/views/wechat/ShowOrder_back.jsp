<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
.foot {
	position: fixed;
	background-color: #f0f0f0;
	opacity: 0.85;
	bottom: 0;
	height: 50px;
	width: 100%;
	left: 0;
	line-height: 50px;
}

.foot span {
	float: right;
}

.foot button {
	background-color: #e00;
	border: 0 none;
	border-radius: 3px;
	color: white;
	float: right;
	font-size: 19px;
	height: 35px;
	margin-left: 10px;
	margin-right: 10px;
	margin-top: 9px;
	padding: 0 21px;
}

#payprice {
	color: red;
	font-size: 30px;
}

.head {
	border-bottom: 1px solid;
	font-size: 40px;
	height: 50px;
	left: 0;
	line-height: 50px;
	position: absolute;
	text-align: left;
	top: 0;
	width: 100%;
}

.content {
	width: 100%;
	margin-top: 50px;
}

.baserow {
	border-bottom: 1px dashed #e6e6e6;
	width: 100%;
	height: 60px;
}

.row {
	border-bottom: 1px dashed #e6e6e6;
	height: 100px;
	width: 100%;
}

.row .col {
	overflow: hidden;
	height: 100%;
	float: left;
}

.row .col:nth-child(1) {
	width: 70%;
}

.row .col:nth-child(2) {
	width: 30%;
	text-align: center;
	line-height: 100px;
}

.priceipt {
	float: right;
	font-size: 30px;
	height: 80%;
	margin-right: 10px;
	margin-top: 5px;
	text-align: center;
	width: 80%;
}

.title {
	height: 40%;
	line-height: 40px;
	padding: 0 20px;
	width: 90%;
	font-size: 20px;
}

.alltitle {
	height: 100%;
	line-height: 60px;
	padding: 0 20px;
	width: 90%;
	font-size: 20px;
}

.note {
	color: #9d9d9d;
	height: 60%;
	padding: 0 20px;
	width: 90%;
}

.allcol {
	height: 100%;
	float: left;
	width: 50%;
}

.ppcol {
	height: 100%;
	float: left;
	width: 50%;
}

.unit {
	
}

.pprice {
	color: green;
}

.nprice {
	color: #e6e6e6;
}

.showtip {
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 0.3125em;
	bottom: -30px;
	color: white;
	height: 30px;
	left: 50%;
	line-height: 30px;
	margin-left: -50px;
	position: fixed;
	text-align: center;
	width: 100px;
	color: white;
	height: 30px;
	left: 50%;
	line-height: 30px;
	margin-left: -50px;
	position: fixed;
	text-align: center;
	height: 30px;
	left: 50%;
	line-height: 30px;
	margin-left: -50px;
	position: fixed;
	text-align: center;
	z-index: 999;
	left: 50%;
	line-height: 30px;
	margin-left: -50px;
	position: fixed;
	text-align: center;
	line-height: 30px;
	margin-left: -50px;
	position: fixed;
	text-align: center;
	margin-left: -50px;
	position: fixed;
	text-align: center;
}

.showcode {
	background-color: white;
	bottom: 0;
	left: 0;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 10;
}

.qrcode {
	width: 300px;
	height: 400px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -200px;
	margin-left: -150px;
}

.codetitle {
	height: 50px;
	line-height: 50px;
	text-align: center;
	font-size: 25px;
}

.codecontent {
	height: 50px;
	text-align: center;
}

.backdiv {
	height: 50px;
	text-align: center;
}

.backdiv button {
	background-color: #e00;
	border: 0 none;
	border-radius: 3px;
	color: white;
	font-size: 19px;
	height: 35px;
	padding: 0 21px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>支付订单</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".foot button").bind("click", function() {
			var price = getprice();
			$.post("${ctx}/wxorder/getpaycode", {
				"price" : price
			}, function(d) {
				if (d.result == "1") {
					$(".codetitle").html("微信扫一扫支付");
					$(".codecontent").html("用无锡农商行卡支付,反红包。。。。");
					$(".backdiv").css("display","none");
					$("#codeimg").attr("src", d.url);
					$(".showcode").show();
					checkstate();
				}
			});
		});

		$(".backdiv button").bind("click", function() {
			$(".priceipt").val("0");
			$("#payprice").html("0.00");
			$(".showcode").hide();
		});
		$(".priceipt").blur(function() {
			if (isprice($(this).val())) {
				getprice();
			} else {
				alerttip("金额输入错误!", 2000);
			}

		});
	});
	function checkstate() {
		$.post("${ctx}/wxorder/checkstate",
				function(d) {
					if (d.returndata == "1") {
						if (d.result == "1") {
							$(".codetitle").html("支付完成");
							$(".codecontent").html("登陆商户后台查看更多详情...");
							$(".backdiv").css("display","");
							$("#codeimg").attr("src",
									"${ctx}/static/images/orderok.png");
						} else {
							checkstate();
						}
					} else {
						$(".codetitle").html("支付失败");
						$(".codecontent").html("支付二维码已过期,请重新生成并支付");
						$(".backdiv").css("display","");
						$("#codeimg").attr("src",
								"${ctx}/static/images/orderfail.png");
					}
				});
	}
	function getprice() {
		var pprice = $("#payprice").html($(".priceipt").val());
		if (isprice(pprice)) {
			alerttip("金额输入错误!", 2000);
			return 0;
		}

		return $("#payprice").html();
	}

	function isprice(num) {
		var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
		if (exp.test(num)) {
			return true;
		} else {
			return false;
		}
	}
	function hidetip() {
		$("#showtip").css("bottom", "-30px");
	}
	function alerttip(str, ms) {
		$("#showtip").html(str);
		$("#showtip").animate({
			bottom : "30px"
		}, 500);
		setTimeout("hidetip()", ms);
	}
</script>
<body>
	<div class="head">
		<strong style="margin-left: 15px">${mer.name}</strong>
	</div>
	<div class="content">
		<div class="baserow">
			<div class="allcol">
				<div class="alltitle">
					<strong>交易金额</strong>
				</div>

			</div>
			<div class="ppcol">
				<input class="priceipt" value="0">
			</div>
		</div> 
		<div class="row">
			<div class="col">
				<div class="title">
					<strong>银行活动</strong>
				</div>
				<div class="note">刷阿福卡立即打9折,满100反10元红包</div>

			</div>
			<div class="col">
				<strong class="nprice">￥00.00</strong>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<div class="title">
					<strong>银行活动</strong>
				</div>
				<div class="note">刷阿福卡立即打9折,满100反10元红包</div>

			</div>
			<div class="col">
				<strong class="pprice">￥-10.00</strong>
			</div>
		</div>

	</div>
	<div class="foot">
		<button>确认账单</button>
		<span>应付金额:￥<strong id="payprice">0.00</strong></span>

	</div>
	<div class="showcode" style="display: none">
		<div class="qrcode">
			<img alt="" id="codeimg" src="" style="width: 300px; height: 300px">
			<div class="codetitle">微信扫一扫支付</div>
			<div class="codecontent">用无锡农商行卡支付,反红包。。。。</div>
			<div class="backdiv" style="display: none">
				<button id="back">返回</button>
			</div>
		</div>
	</div>
	<div id="showtip" class="showtip"></div>
</body>
</html>