<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
}

.contentdiv {
	text-align: justify;
	padding: 0 20px;
	margin: 0;
	background-color: white;
	padding-bottom: 30px;
}

.innerdiv {
	width: 100%;
	margin: auto;
}

.innerdiv img {
	width: 100%;
}

.head {
	padding: 0px 20px;
	margin-top: 15px;
}

.title {
	margin-bottom: 10px;
	width: 100%;
	font-size: 18px;
	color: #F7BB20;
}

.timelogo {
	width: 23px;
	display: table-cell;
	position: relative;
	top: 12px;
}

.readlogo {
	background: url('${ctx}/static/wxfile/main1601/image/readcount1.png')
		center no-repeat;
	width: 18px;
	height: 100%;
	display: table-cell;
	background-size: 75%;
	height: 100%;
	display: table-cell;
}

.time {
	display: table-cell;
}

.readcount {
	display: table-cell;
	text-align: right;
}

.detail {
	width: 100%;
	height: 40px;
	line-height: 40px;
	display: table;
	color: #9FA1A0;
	border-top: 1px solid #D6D6D6;
}

.readcountimg {
	margin-right: 4px;
	width: 17px;
}

.timeimg {
	width: 14px;
	position: absolute;
}

.middle {
	padding: 0px 20px;
	margin-bottom: 20px;
}

.middle1 {
	
}

.middle2 {
	margin-top: 10px;
}

.dakuang {
	padding: 0px 20px;
	margin-top: 20px;
}

.dakuang img {
	width: 100%;
}

.foot {
	width: 100%;
	text-align: center;
	overflow: hidden;
	margin-top: 20px;
	margin-bottom: 20px;
}

.foot div {
	margin: auto;
	width: 65%;
	background-color: #F8BA1E;
	height: 40px;
	color: #ffffff;
	line-height: 40px;
	font-size: 18px;
	border-radius: 5px;
}
</style>
<title>服务详情</title>
</head>
<body>
	<div class="head">
		<div class="title">${data.name}</div>
		<div class="detail">
			<div class="timelogo">
				<img class="timeimg"
					src="${ctx}/static/wxfile/main1601/image/time1.png">
			</div>
			<div class="time">${fn:substring(data.createtime,0,10)}</div>
			<div class="readcount">
				<img class="readcountimg"
					src="${ctx}/static/wxfile/main1601/image/readcount1.png">${data.count}
			</div>
		</div>
	</div>
	<div class="middle">
		<div class="middle1">[报名时间]</div>
		<div class="middle2">${fn:substring(data.starttime,0,16)}-----${fn:substring(data.endtime,0,16)}</div>
	</div>
	<div class="contentdiv">
		<div class="innerdiv">${data.content}</div>
	</div>

	<div class="dakuang">
		<div
			style="text-align: center; padding: 10px; border: 1px solid #eeeff0;">
			<img alt="" src="${data.picurl}">
		</div>
	</div>
	<div class="foot">
		<c:if test="${state == 0}">
			<div onclick="qushenq();">我要申请</div>
		</c:if>
		<c:if test="${state == 1}">
			<div style="background-color: #D8D8D8; color: #FFFFFF;">活动已结束</div>
		</c:if>
		<c:if test="${state == 2}">
			<div onclick="chakanshenq();">查看申请</div>
		</c:if>
		<c:if test="${state == 3}">
			<div style="background-color: #D8D8D8; color: #FFFFFF;">名额已满</div>
		</c:if>
	</div>
</body>
<script type="text/javascript">
	/* $(document).ready(function() {
	
	});*/

	//我要申请跳转链接
	function qushenq() {
		window.open("${ctx}/wxpage/toaddinfo?type=1&sqactid=${data.id}");
	}

	//查看申请跳转链接
	function chakanshenq() {
		window.open("${ctx}/wxpage/showdetail?id=${data1.id}");
	}
</script>
</html>