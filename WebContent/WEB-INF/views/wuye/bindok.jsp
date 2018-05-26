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
	height: 90px;
	top: 40%;
	margin-top: -45px;
	left: 50%;
	margin-left: -100px;
	text-align: center;
}

.cen img {
	width: 60px;
	margin-bottom: 10px;
}
</style>
<title>绑定成功</title>
</head>
<body> 
	<div class="cen">
		<div>
			<img src="${ctx}/static/wxfile/wuye/image/mjbindok.png">
		</div>
		<div>绑定成功</div>
	</div>
</body>
</html>