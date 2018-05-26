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
}

.contentdiv {
	text-align: justify;
	padding: 0 20px;
	margin: 0;
	background-color: white;
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
	height: 20px;
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

.btndiv {
	width: 100%;
	text-align: center;
}

.btn {
	width: 80%;
	height: 40px;
	background-color: #F7BB20;
	color: white;
	font-size: 18px;
	margin: auto;
	line-height: 40px;
	margin-top: 30px;
	border-radius: 6px;
}
</style>
<title>详情</title>
</head>
<body>
	<div class="head">
		<div class="title">${art.title}</div>
		<div class="detail"></div>
	</div>
	<div class="contentdiv">
		<div class="innerdiv">${art.content}</div>
	</div>
	<c:if test="${art.btnname!=null}">
		<div class="btndiv">
			<div class="btn">${art.btnname}</div>
		</div>
	</c:if>

</body>
</html>