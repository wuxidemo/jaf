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
<title>长按二维码关注公众号</title>
<style type="text/css">
body {
	margin: 0;
	text-align: center;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
}

.headdiv {
	width: 100%;
}

.headdiv img {
	width: 100%;
}

.qrcodediv {
	margin-bottom: 20px;
	position: relative;
	width: 100%;
	text-align: center;
}

.qrcodediv img {
	width: 150px;
	height: 150px;
	margin: auto;
}

.worddiv {
	font-size: 20px;
	margin-top: 5px;
	height:35px;
	width: 100%;
}

.rolediv {
	width: 100%;
	text-align: center;
	background: url('${ctx}/static/11act/images/rqznrbottom.jpg');
	padding-top: 20px;
	padding-bottom: 20px;
}

.rolediv img {
	position: absolute;
	left: 0;
	width: 100%;
}

.rolecontent {
	width: 100%;
	text-align: center;
}

.content {
	width: 90%;
	margin: auto;
}

.content table {
	font-size: 14px;
}

.content table tr td:FIRST-CHILD {
	color: #921a1c;
	vertical-align: top;
	width: 70px;
}

.content table tr td:nth-child(2) {
	vertical-align: top;
}

.bottomdiv {
	width: 100%;
	bottom: 0;
}

.bottomdiv img {
	width: 100%;
}

.handdiv {
	position: absolute;
	right: 10%;
	top: 50px;
}

.handdiv img {
	width: 50px;
	height: auto;
}
</style>
</head>
<body>
	<div class="headdiv">
		<img src="${ctx}/static/11act/images/rqznrhead.jpg">
	</div>
	<div class="qrcodediv">

		<img
			src="<c:if test="${pic!=''}">${pic}</c:if><c:if test="${pic==''}">${ctx}/static/11act/images/qrcode.jpg</c:if>">
		<div class="handdiv">
			<img src="${ctx}/static/11act/images/pinkhand.jpg">
		</div>
		<div class="worddiv">
			长按二维码<font style="color: red; font-size: 22px;">关注</font>公众号
		</div>
		<div class="worddiv">
		<!-- 
			参与活动<font style="color: red; font-size: 22px;">赢大奖</font>
			 -->
		</div>
	</div>
	<div class="bottomdiv">
		<img src="${ctx}/static/11act/images/bottom.jpg">
	</div>

</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</html>