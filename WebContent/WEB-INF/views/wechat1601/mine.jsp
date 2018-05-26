<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>我的</title>
<link type="text/css" href="${ctx}/static/wxfile/main1601/css/mine.css"
	rel="stylesheet" />
</head>
<body>
	<div id="head">
		<div id="head1">
			<img alt="" src="${url}">
		</div>
		<div id="head2">${name}</div>
	</div>

	<div class="rowdiv"
		onclick="javascript:window.location.href='${ctx}/wxpage/towxuserinfo'"
		style="margin-top: 10px; border-top: 1px solid #e1e3e1;">
		<div class="logo"
			style="background:url('${ctx}/static/wxfile/main1601/image/myinfo.png') center no-repeat;background-size: 20px;"></div>
		<div class="title">个人信息</div>
		<div class="go">></div>
	</div>
	<div class="rowdiv"
		onclick="javascript:window.location.href='${ctx}/wxpage/ord'">
		<div class="logo"
			style="background:url('${ctx}/static/wxfile/main1601/image/myorder.png') center no-repeat;background-size: 20px;"></div>
		<div class="title">我的订单</div>
		<div class="go">></div>
	</div>
	<div class="rowdiv"
		onclick="javascript:window.location.href='${ctx}/wxpage/red'">
		<div class="logo"
			style="background:url('${ctx}/static/wxfile/main1601/image/myredbag.png') center no-repeat;background-size: 20px;"></div>
		<div class="title">我的红包</div>
		<div class="go">></div>
	</div>
	<div class="rowdiv"
		onclick="javascript:window.location.href='${ctx}/wxurl/redirect?url=wxcard/mycardlist'">
		<div class="logo"
			style="background:url('${ctx}/static/wxfile/main1601/image/mycard.png') center no-repeat;background-size: 20px;"></div>
		<div class="title">我的优惠券</div>
		<div class="go">></div>
	</div>

	<%@ include file="foot.jsp"%>
</body>
</html>