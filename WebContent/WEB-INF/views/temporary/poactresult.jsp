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
<title>人气值活动</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
}

.content {
	padding-top: 20px;
	padding-bottom: 40px;
	background: url('${ctx}/static/11act/images/detailback.jpg') center;
}

.bottomdiv {
	width: 100%;
}

.bottomdiv img {
	width: 100%;
}

.title {
	width: 100%;
	text-align: center;
}

.title img {
	width: 60%;
}

.subtitle {
	margin-top: 10px;
	text-align: right;
}

.subtitle img {
	width: 50%;
}

.rowtitle {
	width: 80%;
	color: #e00000;
	font-size: 15px;
	margin: auto;
}

.jp1 {
	width: 80%;
	display: -webkit-box;
	margin: 10 auto 20;
}

}
.col1 {
	width: 20%;
}

.col1 img {
	width: 70px;
}

.col2 {
	width: 80px;
	text-align: center;
}

.col2 img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-top: 30px;
}

.col3 {
	font-size: 14px;
	color: #e00000;
	width: 35%;
	line-height: 99px;
}

.col4 {
	font-size: 14px;
	color: #e00000;
	width: 25%;
	line-height: 99px;
}

.man500 {
	width: 80%;
	overflow: hidden;
	margin: auto;
}

.man500 div {
	float: left;
	width: 33%;
	height: 40px;
	line-height: 40px;
	overflow: hidden;
}
</style>
</head>
<body>
	<div class="content">
		<div class="title">
			<img src="${ctx}/static/11act/images/rqztitle.png">
		</div>
		<div class="subtitle">
			<img src="${ctx}/static/11act/images/rqsubtitle.png">
		</div>
		<div class="rowtitle">第一名： iPhone6s Plus(64G)</div>
		<c:if test="${lw1count==0}">
			<section class="jp1">暂无数据</section>
		</c:if>
		<c:if test="${lw1count!=0}">
			<section class="jp1">
				<section class="col1">
					<img src="${ctx}/static/11act/images/phone6sp.png">
				</section>
				<section class="col2">
					<img src="${lw1[1]}">
				</section>
				<section class="col3">${lw1[0]}</section>
				<section class="col4">${lw1[2]}</section>
			</section>
		</c:if>
		<div class="rowtitle">第二名： iPhone6(64G)</div>
		<c:if test="${lw2count==0}">
			<section class="jp1">暂无数据</section>
		</c:if>
		<c:if test="${lw2count!=0}">
			<section class="jp1">
				<section class="col1">
					<img src="${ctx}/static/11act/images/iphone6.png">
				</section>
				<section class="col2">
					<img src="${lw2[1]}">
				</section>
				<section class="col3">${lw2[0]}</section>
				<section class="col4">${lw2[2]}</section>
			</section>
		</c:if>
		<div class="rowtitle">人气值满1000：500M流量/20元话费</div>
		<c:if test="${lw3count==0}">
			<section class="jp1">暂无数据</section>
		</c:if>
		<c:if test="${lw3count!=0}">
			<div class="man500">
				<c:forEach items="${lw3}" var="lw">
					<div>${lw[0]}</div>
				</c:forEach>
			</div>
			<c:if test="${lw3count==90}">
				<div>...</div>
			</c:if>
		</c:if>
		<div class="rowtitle">人气值满500：10元话费</div>
		<c:if test="${lw4count==0}">
			<section class="jp1">暂无数据</section>
		</c:if>
		<c:if test="${lw4count!=0}">
			<div class="man500">
				<c:forEach items="${lw4}" var="lw">
					<div>${lw[0]}</div>
				</c:forEach>
			</div>
			<c:if test="${lw4count==90}">
				<div>...</div>
			</c:if>
		</c:if>
	</div>
	<div class="bottomdiv">
		<img src="${ctx}/static/11act/images/bottom.jpg">
	</div>
</body>
</html>