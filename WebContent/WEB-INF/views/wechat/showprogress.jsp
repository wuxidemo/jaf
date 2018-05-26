<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	background-color: #dcdddd;
	margin: 0;
}

.topinfo {
	width: 100%;
}

.titleimg {
	width: 100%;
}

.titleimg img {
	width: 100%;
}

.titlecontent {
	width: 100%;
	text-align: center;
	background: url('${ctx}/static/images/contentback.png');
	background-size: 100%;
}

.content {
	width: 80%;
	text-align: left;
	margin: auto;
	color: white;
	padding-bottom: 10px;
	padding-top: 10px;
}

.jointitle {
	background-color: #2bc4b6;
	color: white;
	height: 40px;
	line-height: 40px;
}

.jointitle label:nth-child(1) {
	margin-left: 25px;
	font-size: 25px;
}

.jointitle label:nth-child(2) {
	font-size: 15px;
	margin-left: 15px;
}

.subdiv { 
	width: 100%;
	text-align: center;
}


.tip {
	color: #3e3a39;
	font-size: 13px;
	margin-top: 20px;
	text-align: center;
	margin-bottom: 30px;
}

.subdiv img {
	margin-top: 30px;
	width: 80%;
}

.applydiv {
	margin-top: 10px;
}

.showtip {
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 0.3125em;
	bottom: -30px;
	color: white;
	width: 150px;
	height: 30px;
	left: 50%;
	position: fixed;
	text-align: center;
	z-index: 999;
	line-height: 30px;
	margin-left: -75px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>联系我们</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<body>
	<div class="topinfo">
		<div class="titlecontent">
			<div class="content">
				<p>&emsp;&emsp;基于微信的智慧商业数据服务平台简称金数源，该产品面向的用户是服务业（如餐饮和服装等行业）的经营管理者，解决其核心需求“如何收集线下消费者体验的反馈信息和客户行为相关数据，通过数据分析挖掘和再造，为商户的精细化运营和顾客的私人化定制提供大数据支持。”</p>
				<p>&emsp;&emsp;金数源不同与传统的餐饮管理软件和大众点评之类的公共平台，主要是通过自助化的服务采集顾客的行为数据，形成商户自己的大数据，并通过大数据的运用和微信连接一起的能力做到精准化的传播和营销。</p>
			</div>
		</div>
		<div class="jointitle">
			<label>加入我们</label><label>(进度查询)</label>
		</div>
	</div>
	<div class="subdiv">
		<img alt="" src="${ctx}/static/images/applying.png">
		<div class="applydiv">受理中...</div>
	</div>
	<div class="tip">温馨提示： 我们会在3个工作日内联系您，请保持电话畅通。</div>
	<div id="showtip" class="showtip"></div>
</body>
</html>