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
	margin:0;
	padding:0;
}

h1, a{
	font-color:#000;
}

div.content {
	width:100%;
	text-align: center;
	
	padding-top:20px;
	padding-bottom:100px;
	
	background-color: #FDE2E7;
	filter:alpha(opacity=80); 
	-moz-opacity:0.8; 
	opacity:0.8;
}

.headdiv {
	width: 90%;
	text-align: center;
	margin:0 auto;
}

.headdiv img {
	width: 100%;
}

.rolediv {
	width: 80%;
	margin: auto;
	color: #ed304e;
	font-size: 20px;
	text-align: left;
	height: 60px;
	line-height: 70px;
}

.roledetail {
	width: 80%;
	height:40px;
	margin: auto;
	text-align: left;
}

.buttondiv {
	width: 80%;
	margin: auto;
}

button {
	box-shadow: none;
	width: 80%;
	height: 40px;
	border: none;
	color: white;
	font-size: 20px;
	border-radius: 0.6em;
	margin-top: 20px;
}


/****************/

div.tail {
	width:100%;
	height:30px;
	background-color:#FFA904;
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
	
	function seemore() {
		window.location.href = "${ctx}/wxpage/actlist";
	}
	
</script>

<body>

	<div class="content">
	
		<div class="headdiv">
			<img alt="" src="${ctx}/static/11act/images/queresult.jpg">
		</div>
		
		<div class="rolediv" style="margin-top:10%;">恭喜你获得10元话费 ：</div>
		<div class="rolediv" style="margin-bottom:10px;font-size:45px;font-style: oblique;text-align: left;">${phone}</div>
		
		
		<div class="buttondiv">
			<button style="background-color: #ed304e;" onclick="seemore()">更多优惠活动</button>
		</div>
		
		<div class="rolediv" style="margin-top:40px;">领奖规则：</div>
		
		<div class="roledetail" style="margin-bottom:20px;">
			<table>
				<tr>
					<td style="width:5%;vertical-align: top;">1.</td>
					<td style="width:95%;vertical-align: top;">输入正确手机号码，领取奖项，如填写错误，则无法领奖；</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">2.</td>
					<td style="width:95%;vertical-align: top;">手机号码归属地需为无锡，否则无效；</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">3.</td>
					<td style="width:95%;vertical-align: top;">话费会根据获奖用户所填手机号，在活动结束后7个工作日发放完毕；如未填，则默认放弃奖项。</td>
				</tr>
			</table>
		
		</div>
		
	</div>
	
	<div class="tail"></div>
	
</body>
</html>