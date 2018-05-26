<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 2016-4-19 #袁伟 版本[1.0] -->
<title>详情(${commname})</title>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<style type="text/css">
p {
	margin: 0px;
	padding: 0px;
}

.sta {
	font-size: 16px;
	position: relative;
	top: -2px;
	width: 20%;
	text-align: left;
}

.img_time img {
	width: 13px;
	position: relative;
	top: 1px;
}

.img_time {
	display: inline-block;
	width: 78.5%;
	text-align: right;
}

.img_time time {
	color: #9FA0A0;
	font-size: 13px;
}

.sta2 {
	color: #FFB219;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${rapair!=null}">
			<!-- 报修详情存在时显示 -->
			<div class="contiler">
				<div class="tittle_det">
					<div class="bot_line">
						<!-- 判断状态显示不同颜色样式 -->
						<c:choose>
							<c:when test="${rapair.state==4}">
								<p class="sta sta1 fl">已解决</p>
							</c:when>
							<c:otherwise>
								<p class="sta sta2 fl">未解决</p>
							</c:otherwise>
						</c:choose>
						<!-- 时间显示(只截取到日期) -->
						<div class="img_time">
							<img alt="time" src="${ctx}/static/wxfile/wuye/image/timepic.png">
							<time>${fn:substring(rapair.createtime, 0, 10)}</time>
						</div>
					</div>
				</div>
				<!-- 具体报修内容 -->
				<div class="content_det">${rapair.content}</div>
				<c:if test="${''!=rapair.infourl || null==rapair.infourl}">
					<!-- 图片显示(有就显示，无就不显示) -->
					<div class="img_div_det">
						<img class="img_det" alt="" src="${rapair.infourl}?imageView2/2/w/300|imageMogr2/auto-orient">
					</div>
				</c:if>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 报修详情找不到时提示 -->
			<div class="sta2" style="width: 100%; font-size: 16px; text-align: center; margin-top: 30px;">
				${msg}
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>