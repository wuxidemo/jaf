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
	<div class="modal hide fade" id="loadingshow" tabindex="-1"
		role="dialog" style="top: 10%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="">输入卡券编号</h3>
		</div>
		<div id="" class="modal-body"
			style="font-size: 35; text-align: center;">

			<input type="text" id="cardcord" style="height: 32px; width: 50%;"
				value="" class="span m-wrap" maxlength="" />

		</div>
		<div class="modal-footer">
			<a class="btn blue" onclick="checkcode()">确认</a> <a class="btn"
				onclick="closeLonding()">关闭</a>
		</div>
	</div>
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
		<div class="control-group">
			<label for="merchantname" class="control-label">卡券:</label>
			<div class="controls">
				<input id="cardbtn" class="btn blue" type="button" value="添加卡券" />
				<input id="deletebtn" class="btn red" style="display: none" type="button" value="删除卡券" />
			</div>
		</div>
		<div class="control-group" style="display: none" id="mycarddiv">
			<label for="merchantname" class="control-label">卡券名称:</label>
			<div class="controls">
				<input type="text" id="cardname" style="height: 32px; width: 50%;"
					value="" class="span m-wrap" maxlength="20" readonly="readonly" />
			</div>
		</div>
		<div class="control-group">
			<label for="merchantname" class="control-label">支付金额(元):</label>
			<div class="controls">
				<input type="text" id="payprice" style="height: 32px; width: 50%;"
					value="" class="span m-wrap" maxlength="20" readonly="readonly" />
			</div>
		</div>
		<div class="form-actions" style="margin-bottom: 0px">
			<input id="mybtn" class="btn blue"  type="button" value="生成二维码" />&nbsp;
		</div>
	</form>

	<div class="showcode" style="display: none">
		<div class="qrcode">
			<img alt="" id="codeimg" src="" style="width: 300px; height: 300px">
			<div class="codetitle">支付金额:0.0元</div>
			<div class="codecontent">客户扫描二维码，完成付款</div>
			<div id="tip1" class="tip"></div>
			<div id="tip2" class="tip"></div>
			<div class="backdiv" style="display:">
				<button id="back">返回</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#price").focus();
		$("#mybtn").bind("click", function() {
			var price = getprice();
			//if (price == 0) {
			//	return;
		//	}
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
			var data={};
			data.price=$("#price").val();
			if(mycard!=null)
				{
				data.codes=mycard.code;
				}
			$.post("${ctx}/order/getpaycodecard",data, function(d) {
				if (d.result == "1") {
					if(is0){
						$(".showcode").css("display","");
						$(".codetitle").html("支付完成");
						$(".codecontent").html("登陆商户后台查看更多详情...");
						$(".backdiv").css("display", "");
						$("#codeimg").attr("src",
								"${ctx}/static/images/orderok.png");
					}else
					{
						$(".codetitle").html("支付金额：" + price + "元");
						//$(".backdiv").css("display", "none");
						$("#codeimg").attr("src", d.url);
						$(".showcode").show();
						checkstate();
					}
				} else {
					window.parent.showAlert(d.msg);
				}
			});
		});

		$(".backdiv button").bind("click", function() {
			$("#price").val("0");
			$(".showcode").hide();
			mycard = null;
			getprice();
			$("#deletebtn").css("display","none");
			$("#mycarddiv").css("display", "none");
		});
		$("#price").blur(function() {
			if ($(this).val() != "") {
				getprice();
			}

		});
		$("#cardbtn").bind("click", function() {
			$("#cardcord").val("");
			$('#loadingshow').modal('show');
			
		});
		$('#loadingshow').on('shown.bs.modal', function () {
			$("#cardcord").focus();
			})
		$("#deletebtn").bind("click",function(){
			$("#mycarddiv").css("display", "none");
		//	$("#cardname").val(d.data.name);
			mycard = null;
			getprice();
			$(this).css("display","none");
		});
	});

	function closeLonding() {
		$('#loadingshow').modal('hide');
		//$("#checkcotent").html("");
	}
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
	var mycard = null;
	function checkcode() {
		$.post("${ctx}/order/checkcard", {
			"code" : $("#cardcord").val()
		}, function(d) {
			if (d.result == "1") {
				mycard = d.data;
				//alert(d.data);
				$("#mycarddiv").css("display", "");
				$("#cardname").val(d.data.name);
				$("#deletebtn").css("display","");
				mycard.code=$("#cardcord").val(); 
				getprice();
			} else {
				window.parent.showAlert(d.msg);
			}
		});
		closeLonding();
	}
	function getprice() {
		var pprice = $("#price").val();
		if (pprice == "") {
			alerttip("请输入金额!", 2000);
			$("#mybtn").attr("disabled","disabled");
			$("#mybtn").val("无法支付");
			return 0;
		}
		if (!isprice(pprice)) {
			alerttip("金额输入错误!", 2000);
			$("#mybtn").attr("disabled","disabled");
			$("#mybtn").val("无法支付");
			return 0;
		}
		if (mycard != null) {
			if (mycard.type=="DISCOUNT") {
				pprice = pprice * (100 - mycard.price) / 100;
			}
			// 代金券
			else if (mycard.type=="CASH") {
				if (pprice >= mycard.leastprice/100.0) {
					pprice -= mycard.price/100.0;
					if(pprice<0)
						{pprice=0;}
				}else{
					window.parent.showAlert("未达到代金券使用条件");
					removecard();
				}
			} else {
				//pprice -= mycard.price;
				window.parent.showAlert("只支持折扣券与代金券");
				removecard();
			}
		}
		if(pprice==0)
		{
			if(mycard==null)
				{
				$("#mybtn").attr("disabled","disabled");
				$("#mybtn").val("无法支付");
				}
			else{
				$("#mybtn").removeAttr("disabled");
				$("#mybtn").val("完成支付");
			}
			
			is0=true;
		}else
		{
			$("#mybtn").removeAttr("disabled");
			$("#mybtn").val("生成二维码");
			is0=false;
		}
		$("#payprice").val(pprice);
		return pprice;
	}
	var is0=true;
	function removecard()
	{
		mycard = null;
		$("#deletebtn").css("display","none");
		$("#mycarddiv").css("display", "none");
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