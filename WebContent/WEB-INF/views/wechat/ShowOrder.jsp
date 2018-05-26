<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	margin: 0;
}

#payprice {
	color: red;
	font-size: 30px;
}

.head {
	border-bottom: 1px dashed #e8e8e8;
	font-size: 25px;
}

.priceipt {
	border: 0.5px solid #e8e8e8;
	border-radius: 5px;
	font-size: 20px;
	height: 40px;
	width: 95%;
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
	width: 150px;
	height: 30px;
	left: 50%;
	position: fixed;
	text-align: center;
	z-index: 999;
	line-height: 30px;
	margin-left: -75px;
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
	height: 450px;
	left: 50%;
	margin-left: -200px;
	margin-top: -225px;
	position: absolute;
	text-align: center;
	top: 50%;
	width: 400px;
}

.codetitle {
	height: 50px;
	line-height: 50px;
	text-align: center;
	font-size: 25px;
}

.codecontent {
	height: 20px;
	text-align: center;
	margin-bottom: 10px;
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

.formdiv {
	position: absolute;
	margin-left: -150px;
	width: 300px;
	height: 300px;
	left: 50%;
	top: 50%;
	margin-top: -150px;
}

.row {
	height: 50px;
	line-height: 50px;
	text-align: center;
}

.title {
	color: black;
	float: left;
	text-align: left;
}

.ftitle {
	color: #8e8e8e;
	font-size: 15px;
	line-height: 54px;
	text-align: left;
}

.btn {
	border-radius: 3px;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	margin-top: 10px;
	width: 300px;
}

.scbtn {
	background-color: #2bc4b6;
}

.tcbtn {
	background-color: #b5b5b6;
}

.marleft {
	margin-left: 20px;
}

.tip {
	margin-bottom: 10px;
	color: #fe4819;
}

.greyback {
	background-color: #efefef;
}

.floatclass {
	float: left;
}

table {
	height: 100%;
	width: 100%;
	padding: 0;
	margin: 0;
	padding-left: 18px;
}

td {
	text-align: left;
}

td:nth-child(1) {
	width: 50px;
}

td:nth-child(2) {
	
}

td:nth-child(3) {
	width: 50px;
}

.topborder {
	border-top: 0.5px solid #e8e8e8;
}

.bottomborder {
	border-bottom: 0.5px solid #e8e8e8;
}

.floatbottom {
	left: 50%;
	margin-left: -150px;
	position: absolute;
	width: 300px
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>${mer.name}</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mybtn").bind("click", function() {
			var price = getprice();
			if (price == 0) {
				return;
			}
			$.post("${ctx}/wxorder/rebatestate", function(d) {
				if (d.rf == "1") {
					$("#tip1").html("· 首次支付刷无锡农村商业银行卡享惊喜现金红包");
				} else {
					$("#tip1").html("");
				}
				if (d.r == "1") {
					$("#tip2").html("· 支付刷无锡农村商业银行卡享更多现金红包");
				} else {
					$("#tip2").html("");
				}
			});
			$.post("${ctx}/wxorder/getpaycode", {
				"price" : price
			}, function(d) {
				if (d.result == "1") {

					$(".codetitle").html("支付金额：" + price + "元");
					$(".backdiv").css("display", "none");
					$("#codeimg").attr("src", d.url);
					$(".showcode").show();
					checkstate();
				}
			});
		});

		$(".backdiv button").bind("click", function() {
			$(".priceipt").val("0");

			$(".showcode").hide();
		});
		$(".priceipt").blur(function() {
			//if (isprice($(this).val())) {
			//	getprice();
			//} else {
			//	alerttip("金额输入错误!", 2000);
			//}

		});
	});
	function checkstate() {
		$.post("${ctx}/wxorder/checkstate",
				function(d) {
					if (d.returndata == "1") {
						if (d.result == "1") {
							$(".codetitle").html("支付完成");
							$(".codecontent").html("登陆商户后台查看更多详情...");
							$(".backdiv").css("display", "");
							$("#codeimg").attr("src",
									"${ctx}/static/images/orderok.png");
						} else {
							checkstate();
						}
					} else {
						$(".codetitle").html("支付失败");
						$(".codecontent").html("支付二维码已过期,请重新生成并支付");
						$(".backdiv").css("display", "");
						$("#codeimg").attr("src",
								"${ctx}/static/images/orderfail.png");
					}
				});
	}
	function getprice() {
		var pprice = $(".priceipt").val();
		if (pprice == "") {
			alerttip("请输入金额!", 2000);
			return 0;
		}
		if (!isprice(pprice)) {
			alerttip("金额输入错误!", 2000);
			return 0;
		}

		return pprice;
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
	document.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
</script>
<body>
	<div class="row bottomborder">
		<div class="title marleft">交易金额</div>
		<div class="ftitle">（商户输入金额，生成付款二维码）</div>
	</div>
	<div class="row greyback bottomborder">
		<table>
			<tr>
				<td>金额:</td>
				<td><input id="name" name="name" class="priceipt"
					placeholder="请输入交易金额"></td>
				<td>元</td>
			</tr>
		</table>
	</div>

	<div class="row floatbottom" style="bottom: 20%;height: 100px">
		<button class="btn scbtn" id="mybtn">生成二维码</button>
		<button class="btn tcbtn"
			onclick="window.location.href='${ctx}/wxorder/loginout'">退出登陆</button>
	</div>
	<div class="row floatbottom" style="bottom: 10%">
		
	</div>
	<div class="showcode" style="display: none">
		<div class="qrcode">
			<img alt="" id="codeimg" src="" style="width: 300px; height: 300px">
			<div class="codetitle">支付金额:0.0元</div>
			<div class="codecontent">客户扫描二维码，完成付款</div>
			<div id="tip1" class="tip"></div>
			<div id="tip2" class="tip"></div>
			<div class="backdiv" style="display: none">
				<button id="back">返回</button>
			</div>
		</div>
	</div>
	<div id="showtip" class="showtip"></div>
</body>
</html>