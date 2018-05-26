<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family: Microsoft YaHei;
	color: #8A8A8A;
}

.cen {
	position: fixed;
	width: 200px;
	margin-left: -100px;
	text-align: center;
	height: 180px;
	top: 40%;
	margin-top: -90px;
	left: 50%;
}

.cen img {
	width: 160px;
	margin-bottom: 10px;
}

.tip1 {
	color: #F9D475;
	font-size: 18px;
	margin-bottom: 10px;
}
</style>
<title>抢购详情</title>
</head>
<body>
	<div class="cen">
		<div>
			<img src="${qrurl}">
		</div>
		<div class="tip1">长按二维码关注</div>
		<div class="tip2">关注微信公众号后即可进行抢购</div>
	</div>
</body>
</html>