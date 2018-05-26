<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<%@ include file="../quote.jsp"%>
<title>交易结算</title>
<style type="text/css">
body {
	height: 500px;
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

.tip {
	margin-bottom: 10px;
	color: #fe4819;
}
</style>
</head>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/jygl.png"
					style="vertical-align: text-bottom;" /> 交易结算
			</h3>
		</div>
	</div>
	<form id="myform" class="form-horizontal " action=""
		style="margin-top: 25px; border: 1px solid #e8e8e8; padding-top: 20px;"
		method="post">
		<div class="control-group">
			<label for="merchantname" class="control-label">交易金额(元):</label>
			<div class="controls">
				<input type="text" id="price" style="height: 32px; width: 50%;"
					value="" class="span m-wrap" maxlength="20" />
			</div>
		</div>
		<div class="form-actions" style="margin-bottom: 0px">
			<input id="mybtn" class="btn blue" type="button" value="生成二维码" />&nbsp;
		</div>
	</form>

	<div class="showcode" style="display: none">
		<div class="qrcode">
			<img alt="" id="codeimg" src="" style="width: 300px; height: 300px">
			<div class="codetitle">支付金额:0.0元</div>
			<div class="codecontent">客户扫描二维码，完成付款</div>
			<div id="tip1" class="tip"></div>
			<div id="tip2" class="tip"></div>
			<div class="backdiv" style="display: ">
				<button id="back">返回</button>
			</div>
		</div>
	</div>
</body>
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

			$.post("${ctx}/order/getpaycode", {
				"price" : price
			}, function(d) {
				if (d.result == "1") {

					$(".codetitle").html("支付金额：" + price + "元");
					//$(".backdiv").css("display", "none");
					$("#codeimg").attr("src", d.url);
					$(".showcode").show();
					checkstate();
				} else {
					window.parent.showAlert("获取二维码失败");
				}
			});
		});

		$(".backdiv button").bind("click", function() {
			$("#price").val("0");

			$(".showcode").hide();
		});
		$("#price").blur(function() {
			if ($(this).val() != "") {
				getprice();
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
		var pprice = $("#price").val();
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
		window.parent.showAlert(str);
	}
</script>
</html>