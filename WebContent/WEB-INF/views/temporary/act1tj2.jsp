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
</style>
</head>
<body>
	<a onclick="setnum()">转到朋友圈</a>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		wx.config({
			debug : false,
			appId : '${config.appId}',
			timestamp : '${config.timestamp}',
			nonceStr : '${config.nonceStr}',
			signature : '${config.signature}',
			jsApiList : [ 'hideOptionMenus', 'onMenuShareTimeline' ]
		});
		wx.error(function(res) {
			alert("加载错误:" + JSON.stringify(res));
		});
		wx.ready(function() {
			//wx.hideOptionMenu();
		
			wx.onMenuShareTimeline({
			title : '分享测试', // 分享标题
			link : '${url}', // 分享链接
			imgUrl : 'www.baidu.com/img/bdlogo.png', // 分享图标
			success : function() {
				//alert("cc");
				// 用户确认分享后执行的回调函数
				$.post("${ctx}/wxact/ygz/${openid}",function(d){
					//alert("cc");
				});
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});
		});

	});
	function setnum() {
		//alert("aa");
		
	}
</script>
</html>