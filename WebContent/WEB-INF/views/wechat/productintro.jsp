<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<meta name="apple-touch-fullscreen" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta name="description" content="">
	<title>产品介绍</title>
	
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
	
</head>

<body>
	<div data-role="page" style="margin:0;padding:0;background-color: white;">
		<div style="width: 100%; text-align: center;margin-top:0;margin-bottom:0;">
			<img alt="" src="${ctx }/static/jsy/part1_v2.png" width="100%">
		</div>
		<div style="width: 100%;margin-top:0;margin-bottom:0;background-color:#87c150;color:#fff">
			<p style="padding:20px;line-height: 20px;text-shadow: none;">&emsp;&emsp;基于微信的智慧商业数据服务平台简称金数源，该产品面向的用户是服务业（如餐饮和服装等行业）的经营管理者，解决其核心需求“如何收集线下消费者体验的反馈信息和客户行为相关数据，通过数据分析挖掘和再造，为商户的精细化运营和顾客的私人化定制提供大数据支持。
			</p>
		</div>
		<div style="width: 100%; text-align: center;margin-top:0;margin-bottom:0;">
			<img alt="" src="${ctx }/static/jsy/part3.png" width="100%">
		</div>
	</div>
</body>
</html>