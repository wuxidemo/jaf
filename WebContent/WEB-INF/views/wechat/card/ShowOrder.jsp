<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	height: 100%;
	margin: 0;
	min-height: 500px;
	position: absolute;
	width: 100%;
}



.head {
	border-bottom: 1px dashed #e8e8e8;
	font-size: 25px;
}

.priceipt {
	border: 1px solid #e8e8e8;
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
	width: 200px;
	height: 30px;
	left: 50%;
	position: fixed;
	text-align: center;
	z-index: 999;
	line-height: 30px;
	margin-left: -100px;
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

.padupdown {
	padding: 10px 0;
}

.row {
	padding-left: 30px;
	text-align: center;
	height: 50px;
}

.title {
	color: black;
	margin: 0;
	text-align: left;
	font-size: 18px;
	display: block;
}

.ftitle {
	color: #8e8e8e;
	font-size: 15px;
	text-align: left;
	margin: 0;
	margin-top: 2px;
}

.titles {
	width: 70%;
	float: left;
}

.loginoutdiv {
	float: left;
	height: 20px;
	margin-top: 10px;
	width: 30%;
}

.loginoutdiv a {
	text-decoration: none;
	color: blue;
}

.marleft {
	margin-left: 30px;
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

.tip {
	margin-bottom: 10px;
	color: #fe4819;
}

.greyback {
	background-color: #efefef;
	padding-top: 10px;
}

.floatclass {
	float: left;
}

table {
	height: 100%;
	width: 100%;
	padding: 0;
	margin: 0;
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
	border-top: 1px solid #e8e8e8;
}

.bottomborder {
	border-bottom: 1px solid #e6e6e6;
}

.floatbottom {
	left: 50%;
	margin-left: -150px;
	position: absolute;
	width: 300px
}

.paddingdiv {
	padding: 10px 26px;
}

.yhq {
	background: rgba(0, 0, 0, 0)
		url("/nsh/static/wxfile/images/yhqcheck.png") no-repeat scroll center
		center;
	display: inline-block;
	height: 25px;
	left: 0;
	position: absolute;
	width: 25px;
	margin-top: 14px;
}

.addyhq {
	position: relative;
	line-height: 50px;
	text-align: left;
	width: 100%;
	float: left;
	height: 100%;
}

.addyhq .left {
	background: url('${ctx}/static/wxfile/images/yhqleft.png') right center
		no-repeat;
	width: 10%;
	height: 100%;
	float: left;
}

.addyhq .center {
	float: left;
	width: 80%;
	height: 100%;
	background: url('${ctx}/static/wxfile/images/yhqcenter.png') center
		repeat-x;
	position: relative;
}

.addyhq .right {
	background: url('${ctx}/static/wxfile/images/yhqright.png') left center
		no-repeat;
	width: 10%;
	height: 100%;
	float: left;
}

.syhq {
	
}

.myyhq {
	background: rgba(0, 0, 0, 0)
		url("${ctx}/static/wxfile/images/yhqchecked.png") no-repeat scroll
		center center;
	display: inline-block;
	height: 25px;
	left: 3;
	position: absolute;
	width: 25px;
	margin-top: 47px;
}

.yhqnr {
	height: 50%;
	text-align: center;
}

.yhqnr p {
	margin-left: 10px;
	display: inline;
}

.row p {
	display: inline;
}

div:FOCUS {
	border: none;
	background: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>${mer.name}</title>
</head>

<body>
	<div class="row bottomborder greyback">
		<div class="titles">
			<p style="display: block;" class="title">交易金额</p>
			<p style="display: block;" class="ftitle">(商户输入金额,生成付款二维码)</p>
		</div>
		<div class="loginoutdiv">
			<a href="${ctx}/wxorder/choise" >返回</a>
		</div>
	</div>
	<div class="row  bottomborder padupdown ">
		<table>
			<tr>
				<td>金额:</td>
				<td><input id="name" name="name" class="priceipt"
					placeholder="请输入交易金额"></td>
				<td>元</td>
			</tr>
		</table>
	</div>
	<div class="row  bottomborder " id="yhqbtn">
		<a class="addyhq" ontouchstart="addsr()"><i class="yhq"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;优惠券</a>
	</div>
	<div class="row  bottomborder " id="yhqcontent"
		style="height: 120px; padding-right: 30px; display: none">
		<div class="addyhq">
			<div class="left"></div>
			<div class="center">
				<i id="yhqck" class="myyhq syhq" ontouchstart="yhqclk()"></i>
				<div ontouchstart="addsr()" style="margin: auto; width: 80%;">

					<div class="yhqnr" style="line-height: 80px;">
						<p style="width: 50px" id="yhqtype">优惠券</p>
						<p style="color: #ff5113; font-size: 18px" id="yhqname">满100减10元</p>
					</div>
					<div class="yhqnr" style="line-height: 30px;">
						<p>券码:</p>
						<p style="color: #8e8e8e" id="yhqcode">1607-1111-2222</p>
					</div>
				</div>
			</div>
			<div class="right"></div>
		</div>
	</div>
	<div class="row"
		style="font-size: 20px; line-height: 50px; padding: 0;">
		<p>支付金额:</p>
		<p style="color: #ff5113">
			<strong id="payprice">0.00</strong>
		</p>
		<p>元</p>
	</div>

	<div class="floatbottom" style="bottom: 100px;">
		<button class="btn scbtn" id="mybtn">生成二维码</button>
	</div>

	<div class="showcode" style="display: none">
		<div class="qrcode">
			<img alt="" id="codeimg" src="" style="width: 250px; height: 250px">
			<div class="codetitle">支付金额:0.0元</div>
			<div class="codecontent">客户扫描二维码，完成付款</div>
			<div id="tip1" class="tip"></div>
			<div id="tip2" class="tip"></div>
			<div class="backdiv" style="">
				<button id="back">返回</button>
			</div>
		</div>
	</div>
	<div id="showtip" class="showtip"></div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false, // 
		appId : '${appId}', // 必填，公众号的唯一标识
		timestamp : '${timestamp}', // 必填，生成签名的时间戳
		nonceStr : '${nonceStr}', // 必填，生成签名的随机串
		signature : '${signature}',// 必填，签名，见附录1
		jsApiList : [ 'scanQRCode','closeWindow' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	wx.ready(function() {

		//	alert("ready");
	});
	wx.error(function(res) {
		//alert("加载错误:" + res.msg);
	});
	var mycard=null;
	function addsr() {
		//alert("aaa");
		wx.scanQRCode({
			needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
			success : function(res) {
				var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
				//alert(result);
				$.post("${ctx}/wxcard/checkcard?code=" + result, function(d) {
					if (d.result == "1") {
						$("#yhqbtn").css("display","none");
						$("#yhqcontent").css("display","");
						$("#yhqname").html(d.data.name);
						$("#yhqcode").html(result);
						mycard=d.data;
						mycard.code=result;
						if(mycard.type=="DISCOUNT")
							{
							$("#yhqtype").html("折扣券");
							}
						else if(mycard.type=="CASH")
							{
							$("#yhqtype").html("代金券");
							}
						else
							{
							$("#yhqtype").html("优惠券");
							}
						getprice();
					} else {
						alerttip(d.msg,2000);
					}
				});
			}
		});
		return false;
	}
	$(document).ready(function() {
		$("#mybtn").bind("click", function() {
			var price = getprice();
			//if (price == 0) {
			//	return;
			//}
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
			data.price=$(".priceipt").val();
			if(mycard!=null&&ischeck==true)
				{
				data.codes=mycard.code;
				}
			$.post("${ctx}/wxcard/getpaycode",data, function(d) {
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
					$(".codetitle").html("支付金额：<p style=\"color:#fe4819;display:inline;\" >" + price + "</p>元");
					//$(".backdiv").css("display", "none");
					$("#codeimg").attr("src", d.url);
					$(".showcode").show(); 
					checkstate();
					}
				}else
					{
					alerttip(d.msg,2000);
					}
			});
		});

		$(".backdiv button").bind("click", function() {
			$("#payprice").val("0");
			$(".priceipt").val("");
			$(".showcode").hide();
			mycard=null;
			ischechoff=true;
			getprice();
			$("#yhqbtn").css("display","");
			$("#yhqcontent").css("display","none");
		});
		$(".priceipt").blur(function() {
			if (isprice($(this).val())) {
				getprice();
			} else {
				alerttip("金额输入错误!", 2000);
			}

		});
		$("#close").bind("click",function(){
			$.post("${ctx}/wxorder/loginout",function(){
				 
			 });
			 wx.closeWindow();
		});
	});
	function yhqclk() {
		if (ischeck) {
			$("#yhqck").css("background",
					"url('${ctx}/static/wxfile/images/yhqcheck.png')");
			ischeck = false;
			getprice();
		} else {
			$("#yhqck").css("background",
					"url('${ctx}/static/wxfile/images/yhqchecked.png')");
			ischeck = true;
			getprice();
		}
	}
	var ischeck = true;
	var ischechoff=false;
	function checkstate() {
		ischechoff=false;
		$.post("${ctx}/wxorder/checkstate",
				function(d) {
					if (d.returndata == "1") {
						if (d.result == "1") {
							$(".codetitle").html("支付完成");
							$(".codecontent").html("登陆商户后台查看更多详情...");
							//$(".backdiv").css("display", "");
							$("#codeimg").attr("src",
									"${ctx}/static/images/orderok.png");
						} else {
							if(!ischechoff){
								checkstate();
							}
							
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
		if (mycard != null&&ischeck==true) {
			if (mycard.type=="DISCOUNT") {
				pprice = pprice * (100 - mycard.price) / 100;
			}
			// 代金券
			else if (mycard.type=="CASH") {
				if (pprice >= mycard.leastprice/100.0) {
					pprice -= mycard.price/100.0;
					if(pprice<0)
					{pprice=0;}
				}else
					{
					alerttip("未达到代金券使用条件", 2000);
					removecard();
					}
			} else {
				//pprice -= mycard.price;
				alerttip("只支持折扣券与代金券", 2000);
				removecard();
			}
		}
		
		
		if($(".priceipt").val()==0)
			{
			$("#mybtn").attr("disabled","disabled");
			$("#mybtn").val("无法支付");
			alerttip("金额为0无法支付", 3000);
			}
		else  if(pprice==0&&$(".priceipt").val()!=0)
		{
			if(mycard==null)
				{
				$("#mybtn").attr("disabled","disabled");
				$("#mybtn").val("无法支付");
				alerttip("金额为0无法支付", 3000);
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
		$("#payprice").html(pprice);
		return pprice;
	}
	var is0=true;
	function removecard()
	{
		mycard=null;
		ischechoff=true;
		$("#yhqbtn").css("display","");
		$("#yhqcontent").css("display","none");
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
</html>