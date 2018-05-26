<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title>微信弹出遮罩</title>
</head>
<body>
	<style type="text/css">
	*{margin:0; padding:0;}
	img{max-width: 100%; height: auto;}
	.test{height: 600px; max-width: 600px; font-size: 40px;}
	</style>
	<div class="test"><a href="http://mp.weixin.qq.com/mp/redirect?url=http://soft.hillsun.net:7788/box/static/zjbzs.apk#weixin.qq.com#wechat_redirect ">有效跳转</a></div>
	<script type="text/javascript" src="http://libs.useso.com/js/jquery/1.9.0/jquery.min.js"></script>
	<script type="text/javascript">
		function is_weixin() {
		    var ua = navigator.userAgent.toLowerCase();
		    if (ua.match(/MicroMessenger/i) == "micromessenger") {
		        return true;
		    } else {
		        return false;
		    }
		}
		var isWeixin = is_weixin();
		var winHeight = typeof window.innerHeight != 'undefined' ? window.innerHeight : document.documentElement.clientHeight;
		var weixinTip = $('<div id="weixinTip"><p><img src="live_weixin.png" alt="微信打开"/></p></div>');
		
		if(isWeixin){
			$("body").append(weixinTip);
		}
		$("#weixinTip").css({
			"position":"fixed",
			"left":"0",
			"top":"0",
			"height":winHeight,
			"width":"100%",
			"z-index":"1000",
			"background-color":"rgba(0,0,0,0.8)",
			"filter":"alpha(opacity=80)",
		});
		$("#weixinTip p").css({
			"text-align":"center",
			"margin-top":"10%",
			"padding-left":"5%",
			"padding-right":"5%"
		});
	</script>
</body>
</html>