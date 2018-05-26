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
<title>抢钱！约吗？</title>
<style type="text/css">

body {
	margin: 0;
	background-color: #FFE55A;
}

div.content {
	width:100%;
	text-align:center;
	padding-bottom:50px;
}

div.backimgdiv {
	width:100%;
}

img.backimg {
	width:100%;
}

img.canclick {
	width:80%;
	margin:0 auto;
}

div.role {
	width:100%;
	margin-top:20px;

}

div.title {
	width:40%;
	height:40px;
	line-height:40px;
	font-size:20px;
	font-weight: bold;
	color:red;
}

table {
	width:100%;
	text-align:left;
	padding-left:10%;
	padding-right:10%;
	font-size:18px;
	color:#5B4D44;
	/* font-weight: bold; */
}

td {
	height:30px;
}

</style>
</head>
<body>

	<div class="content">
		<div class="backimgdiv">
			<img alt="" src="${ctx}/static/11act/rob/new1.png" class="backimg">
		</div>
		<%-- <div class="backimgdiv">
			<img alt="" src="${ctx}/static/11act/rob/aaa_02.jpg" class="backimg">
		</div> --%>
		<div class="backimgdiv">
			<img alt="" src="${ctx}/static/11act/rob/new2.png" class="canclick" onclick="showcard()">
		</div>
		<%-- <div class="backimgdiv">
			<img alt="" src="${ctx}/static/11act/rob/aaa_04.jpg" class="backimg">
		</div> --%>
		
		<div class="role">
			<div class="title">活动规则:</div>
			<table>
				<tr>
					<td style="width:5%;vertical-align: top;">1.</td>
					<td style="width:95%;vertical-align: top;">打折以后金额满100元即可使用一张，可累加使用，最多不超过4张。</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">2.</td>
					<td style="width:95%;vertical-align: top;">每个粉丝每家商铺可抢4张抵用券。</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">3.</td>
					<td style="width:95%;vertical-align: top;">抵用券需要在指定的合作商铺内使用。</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">4.</td>
					<td style="width:95%;vertical-align: top;">使用截止日期为2015年11月30日，逾期无效。</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">5.</td>
					<td style="width:95%;vertical-align: top;">结算需刷无锡农村商业银行卡。</td>
				</tr>
			</table>
		</div>
	</div>
	
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function showcard() {
		window.location.href = "${ctx}/wxurl/redirect?url=wxcard/cardlist";
	}
</script>
</html>