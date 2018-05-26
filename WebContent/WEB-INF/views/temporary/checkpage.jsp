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
	margin: 0;
}

.center {
	width: 100%;
	height: 50px;
	top: 50%;
	margin-top: -25px;
	position: absolute;
	text-align: center;
}

.btn {
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 50px;
	width: 80%;
	border-radius: 5px;
	background-color: #2bc4b6;
}
</style>
</head>
<body>
	<div class="center">
		<button class="btn" onclick="check()">扫一扫</button>
	</div>
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
		jsApiList : [ 'scanQRCode', 'closeWindow' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	wx.ready(function() {

		//	alert("ready");
	});
	wx.error(function(res) {
		//alert("加载错误:" + res.msg);
	});
	function check() {
		wx.scanQRCode({
			needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
			success : function(res) {
				$.post("${ctx}/tmpactivity/checkcode?str=" + res.resultStr,
						function(d) {
							alert(d);
						})
			}
		});
	}
</script>
</html>