<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<title>有奖问答</title>
	
</head>

<style>
body {
	font-family: "微软雅黑";
	background-color: #FDE2E7;
	margin:0;
	padding:0;
}
h1, a{
	font-color:#000;
}

div.content {
	width:100%;
	text-align: center;
	margin-bottom:50px;
}

div.titlediv {
	width:50%;
	margin:0 auto;
	margin-top:20px;
	margin-bottom:20px;
}

img.titleimg {
	width:100%
}

table {
	width:90%;
	margin:0 auto;
}


div.tail {
	width:100%;
	height:30px;
	background-color:#FFA904;
}

/***********************/

td {
	height:40px !important;
}


</style>


<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	$(document).ready(function() {wx.config({
			debug : false,
			appId : '${config.appId}',
			timestamp : '${config.timestamp}',
			nonceStr : '${config.nonceStr}',
			signature : '${config.signature}',
			jsApiList : [ 'hideOptionMenu', 'showMenuItems',
					'onMenuShareTimeline' ]
		});
		wx.error(function(res) {
			//alert("加载错误:" + JSON.stringify(res));
		});
		wx.ready(function() {
			wx.hideOptionMenu();
		});
	});
	
</script>


<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>

<body>
	
	<div class="content">
		<div class="titlediv">
			<img alt="" src="${ctx}/static/11act/images/myans.jpg" class="titleimg">
		</div>
		
		<table>
			<tr>
				<td style="width:10%;vertical-align: top;">1/5.</td>
				<td style="width:90%;vertical-align: top;">无锡城市吉祥物的名字叫什么？</td>
			</tr>
			<tr>
				<td style="width:10%;vertical-align: top;">&nbsp;</td>
				<td style="width:90%;vertical-align: top;color:red;">答案：阿福阿喜</td>
			</tr>
			
			
			<tr>
				<td style="width:10%;vertical-align: top;">2/5.</td>
				<td style="width:90%;vertical-align: top;">无锡农村商业银行的金阿福借记卡跨行ATM取现（同城）需要手续费吗？</td>
			</tr>
			<tr>
				<td style="width:10%;vertical-align: top;">&nbsp;</td>
				<td style="width:90%;vertical-align: top;color:red;">答案：不需要</td>
			</tr>
			
			
			<tr>
				<td style="width:10%;vertical-align: top;">3/5.</td>
				<td style="width:90%;vertical-align: top;">无锡市民卡具有公交卡、医保卡、银行卡等功能，市民卡合作银行是无锡农村商业银行吗？</td>
			</tr>
			<tr>
				<td style="width:10%;vertical-align: top;">&nbsp;</td>
				<td style="width:90%;vertical-align: top;color:red;">答案：是</td>
			</tr>
			
			
			<tr>
				<td style="width:10%;vertical-align: top;">4/5.</td>
				<td style="width:90%;vertical-align: top;">金阿福e服务平台疯狂双11系列活动中拼人气的大奖是什么？</td>
			</tr>
			<tr>
				<td style="width:10%;vertical-align: top;">&nbsp;</td>
				<td style="width:90%;vertical-align: top;color:red;">答案：iPhone 6s Plus(64G)</td>
			</tr>
			
			
			<tr>
				<td style="width:10%;vertical-align: top;">5/5.</td>
				<td style="width:90%;vertical-align: top;">疯狂双11系列活动包括哪些子活动</td>
			</tr>
			<tr>
				<td style="width:10%;vertical-align: top;">&nbsp;</td>
				<td style="width:90%;vertical-align: top;color:red;">答案：拼人气；全城抽奖；抢钱约吗；阿福脱光；有奖问答</td>
			</tr>
			
			
		</table>
		
	</div>
	<div class="tail">
			
	</div>
</body>
</html>