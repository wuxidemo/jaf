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
<title>获奖名单</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
	text-align: center;
	background-color: #fdcb2c;
}

.bdiv {
	width: 95%;
	margin: auto;
}

.head {
	margin-top: 5px;
	height: 40px;
	background-color: #ffee7c;
	color: red;
	font-size: 20px;
	text-align: center;
	line-height: 40px;
	font-weight: 600;
}

.timechoise {
	height: 30px;
}

.jpcontent {
	margin-top: 5px;
	padding-top: 10px;
	background-color: #ffee7c;
}

.time {
	margin-top: 5px;
	height: 100%;
	display: -webkit-box;
}

.time section {
	width: 33%;
	line-height: 30px;
	color: red;
}

.leftarrow {
	
}

.rightarrow {
	
}

.nowtime {
	background-color: white;
}

.myjp {
	margin-bottom: 10px;
	width: 100%;
}

.jpss {
	text-align: center; padding : 13px; background-color : #fdf7d3; width :
	80%;
	margin: auto;
	padding: 13px;
	background-color: #fdf7d3;
	width: 80%;
}

.jpss table {
	margin: auto;
}
</style>
</head>
<body>
	<div class="head bdiv">获奖名单</div>
	<div class="timechoise bdiv">
		<section class="time">
			<section>前一天</section>
			<section class="nowtime">2015-10-24</section>
			<section>后一天</section>
		</section>
	</div>
	<div class="jpcontent bdiv">
		<div class="myjp">恭喜你获得二等奖</div>
		<div class="myjp">获奖手机号码为13812263371</div>
		<div class="jpss">
			<table>
				<tr>
					<td>一等奖</td>
					<td>1111、2222、333、444、555</td>
				</tr>
				<tr>
					<td>二等奖</td>
					<td>1111、2222、333、444、555</td>
				</tr>
				<tr>
					<td>三等奖</td>
					<td>1111、2222、333、444、555</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="bottom"></div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</html>