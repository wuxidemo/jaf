<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta name="format-detection" content="telphone=no" />
<title>捐献</title>
<style>
body {
	margin: 0px;
	padding: 0px;
	font-size: 15px;
	font-family: Microsoft YaHei;
	color: #433837;
}

.head {
	padding-left: 5%;
	height: 55px;
	line-height: 55px;
}

.phone {
	width: 100%;
	border-top: 1px solid #F1F1F1;
	border-bottom: 1px solid #F1F1F1;
	height: 50px;
}

.phonelogo {
	height: 100%;
	float: right;
	width: 25%;
	border-left: 1px solid #F1F1F1;
	background: url('${ctx}/static/wxfile/yicang/image/phone.png') no-repeat
		center;
	background-size: auto 60%;;
}

.phoneshow {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	display: inline;
	padding-left: 5%;
	line-height: 50px;
	height: 100%;
	float: left;
	width: 65%;
}

.phonego {
	height: 100%;
	float: right;
	line-height: 50px;
	margin-right: 10px;
}

a {
	text-decoration: none;
}

a:link {
	color: #000000;
	text-decoration: none;
}

a:visited {
	color: #000000
}

a:hover {
	text-decoration: underline
}

a:active {
	color: #000000
}
</style>
</head>
<body>
	<div class="head">
		请联系${com.firstname}<c:if test="${com.contactsex==1}">先生</c:if><c:if test="${com.contactsex==2}">女士</c:if>
	</div>
	<div class="phone">

		<div class="phoneshow">联系电话：${com.contactphone}</div>
		<a href="tel:${com.contactphone}"><div class="phonelogo"></div> </a>
	</div>

</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
	debug : false,
	appId : '${config.appId}',
	timestamp : '${config.timestamp}',
	nonceStr : '${config.nonceStr}',
	signature : '${config.signature}',
	jsApiList : [ 'onMenuShareTimeline', 'onMenuShareAppMessage' ]
});
wx.error(function(res) {
	//alert("加载错误:" + JSON.stringify(res));
});
wx.ready(function() {
	wx.onMenuShareTimeline({
		title : '捐献联系方式', // 分享标题
		link : '${baseurl}/wxurl/redirect?url=wxcommunity/donation',// 分享链接
		imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标
	});
	wx.onMenuShareAppMessage({
		title : '捐献联系方式', // 分享标题
		desc : '', // 分享描述
		link : '${baseurl}/wxurl/redirect?url=wxcommunity/donation',// 分享链接
		imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标
	});
});
</script>
</html>