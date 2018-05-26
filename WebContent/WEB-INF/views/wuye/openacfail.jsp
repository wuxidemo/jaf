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
	text-align: center;
}

.imgdiv {
	margin-top: 40%;
	width: 100%;
	margin-bottom: 10px;
}

.imgdiv img {
	width: 50px;
}

.btn {
	width: 80%;
	height: 30px;
	line-height: 30px;
	color: white;
	background-color: #F9BA1E;
	margin: auto;
	margin-top: 15px;
	border-radius: 5px;
}

.tip {
	color: #8A8A8A;
	margin-top: 20px;
}

.tip1 {
	color: #FD5B56;
	margin-top: 10px;
}
</style>
<title>开启失败</title>
</head>
<body>
	<div class="imgdiv">
		<img src="${ctx}/static/wxfile/wuye/image/openacfail.png">
	</div>
	<div class="tip">您未登记为本单元的住户</div>
	<div class="tip1">请到您的小区物业进行登记</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</html>