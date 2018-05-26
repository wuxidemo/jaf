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
	text-align: center;
}

p {
	margin: 10px 0;
	font-family: Microsoft YaHei;
}

#imgdiv {
	width: 100%;
	display: none;
}

.imgdiv {
	width: 100%;
}

.imgdiv img {
	width: 100%;
}

.content {
	width: 90%;
	margin: auto;
	text-align: left;
}

.btn {
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 30px;
	margin-top: 10px;
	width: 80%;
	border-radius: 5px;
	background-color: #2bc4b6;
}

.btndiv {
	width: 100%;
	text-align: center;
}
</style>
</head>
<body>
	<div class="imgdiv"
		onclick="javascript:window.location.href='${ctx}/wxcard/jflist'">
		<img alt="" src="${ctx}/static/wxfile/images/jfrole.jpg">
	</div>
	<div class="content">
		<p class="redp">
			<strong>积分兑换规则</strong>
		</p>
		<p>1. 农商行卡积分以100：1的比例兑换现金券；</p>
		<p>2. 现金券分为面值：10元、20元、50元；</p>
		<p>3. 现金抵用券只能在指定商户使用；</p>
		<p>4. 本活动最终解释权归度维公司所有。</p>
	</div>
	<div class="btndiv">
		<button class="btn" onclick="javascript:window.location.href='${ctx}/wxcard/jflist'">返回</button>
	</div>


</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</html>