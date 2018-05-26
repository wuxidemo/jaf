<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>点击 领卡</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<body>
	<button id="batchAddCard">领取代金券</button>
</body>
<script type="text/javascript">
var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i) ;
if( !wechatInfo ) {
    alert("本活动仅支持微信") ;
} else if ( wechatInfo[1] < "6.0" ) {
    alert("本活动仅支持微信6.0以上版本") ;
}
	$(document).ready(function() {

	});
var ce='${card_ext}';
	var readyFunc = function onBridgeReady() {
		alert("OK");
		document
				.querySelector('#batchAddCard')
				.addEventListener(
						'click',
						function(e) {
							alert("aaa");
							WeixinJSBridge
									.invoke(
											'batchAddCard',
											{
												"card_list" : [ {
													"card_id" : "${cardid}",
													"card_ext" : ce
												} ]
											}, function(res) {
											});
						});
	}
	if (typeof WeixinJSBridge === "undefined") {
		document.addEventListener('WeixinJSBridgeReady', readyFunc, false);
	} else {
		readyFunc();
	}
</script>
</html>