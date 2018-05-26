<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>优惠活动</title>
<style type="text/css">
body {
	margin: 0 15px;
}

p {
	margin: 0;
	font-family: Microsoft YaHei;
}

#imgdiv {
	width: 100%;
	display: none;
}

.headtitle {
	font-size: 25px;
	margin-top: 5px;
}

.imgdiv {
	margin-top: 8px;
	width: 100%;
}

.imgdiv img {
	width: 100%;
}

.redp {
	color: #fd4239;
}

.content {
	margin-top: 5px;
}

.content p {
	margin-bottom: 10px;
}

.btndiv {
	width: 100%;
	margin-top: 10px;
}

.btn {
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	margin-top: 10px;
	width: 100%;
	border-radius: 5px;
	font-family: Microsoft YaHei;
}

.green {
	background-color: #2bc4b6;
}

.grey {
	background-color: #b5b5b6;
}

.content img {
	width: 90%;
}

.tip {
	width: 100%;
	text-align: center;
	font-size: 20px;
}

.codediv {
	margin-top: 10px;
	width: 100%;
	text-align: center;
}

.codediv img {
	width: 60%;
}

.address {
	margin-top: 10px;
	width: 100%;
	text-align: center;
}
</style>
</head>
<body>
	<div class="headtitle">2斤鸡蛋疯狂一元购</div>
	<div class="imgdiv">
		<img alt="" src="${ctx}/static/wxfile/images/eggtitle.jpg">
	</div>
	<div class="content">
		<c:choose>
			<c:when test="${actinfo==1 and tmp.state==1}">
				<div class="tip redp">出示二维码换取鸡蛋</div>
				<div class="address">地址：XXXX路xxxx超市</div>
				<div class="codediv">
					<img src="${ctx}/${tmp.qrcode}">
				</div>
			</c:when>
			<c:otherwise>
				<p class="redp">活动流程：</p>
				<p>1.点击下方支付按钮以原价支付;</p>
				<p>2.支付完成后将生成的二维码给收银员验证即可领取鸡蛋;</p>
				<p>3.用农商行卡支付立返差额红包，即以1元购得两斤鸡蛋。</p>
				<p>地址：XXXX路xxxx超市</p>
				<p class="redp">只有用农商行卡支付才能收到红包哦~</p>
				
			</c:otherwise> 
		</c:choose>
	</div>
	<div class="btndiv">

		<c:if test="${actinfo==0}">
			<button class="btn grey">未找到此活动</button>
		</c:if>
		<c:if test="${actinfo==2}">
			<button class="btn grey">活动还未开始,敬请期待</button>
		</c:if>
		<c:if test="${actinfo==3}">
			<button class="btn grey">活动已结束</button>
		</c:if>
		<c:if test="${actinfo==1}">
			<c:if test="${tmp==null}">
				<button class="btn green" onclick="pay()">点我一元抢鸡蛋</button>
			</c:if>
			<c:if test="${tmp!=null}">
				<c:if test="${tmp.state==1}">
				</c:if>
				<c:if test="${tmp.state==2}">
					<button class="btn grey">已领取</button>
				</c:if>
				<c:if test="${tmp.state==0}">
					<button class="btn green" onclick="pay()">点我一元抢鸡蛋</button>
				</c:if>
			</c:if>
		</c:if>
	</div>


	<input value="${id}" id="id" type="hidden">

</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		//alert("本活动仅支持微信");
	} else if (wechatInfo[1] < "5.0") {
		alert("本活动仅支持微信5.0以上版本");
	}
	$(document).ready(function() {

	});
	function pay() {
		$
				.post(
						"${ctx}/tmpactivity/checknum?id=" + $("#id").val(),
						function(d) {
							if (d == "1") {
								WeixinJSBridge
										.invoke(
												'getBrandWCPayRequest',
												{
													"appId" : "${appId}", //公众号名称，由商户传入     
													"timeStamp" : "${timeStamp}", //时间戳，自1970年以来的秒数     
													"nonceStr" : "${nonceStr}", //随机串     
													"package" : "${package1}",
													"signType" : "${signType}", //微信签名方式:     
													"paySign" : "${paySign}" //微信签名 
												},
												function(res) {
													if (res.err_msg == "get_brand_wcpay_request:ok") {
														$
																.post(
																		"${ctx}/tmpactivity/code?id=${tmp.id}",
																		function(
																				d) {
																			if (d.result == "1") {
																				$(
																						".content")
																						.html(
																								'<div class="tip redp">出示二维码领取鸡蛋</div><div class="address">地址：XXXX路xxxx超市</div><div class="codediv"><img src="${ctx}/'+d.url+'"></div>');
																				$(
																						".btndiv")
																						.html(
																								"");
																			} else {
																				alert("获取二维码失败");
																			}
																		})
													}
												});
							} else {
								alert(d);
							}
						});

	}
	function onBridgeReady() {

	}
	if (typeof WeixinJSBridge == "undefined") {
		if (document.addEventListener) {
			document.addEventListener('WeixinJSBridgeReady', onBridgeReady,
					false);
		} else if (document.attachEvent) {
			document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
			document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		}
	} else {
		onBridgeReady();
	}
</script>
</html>