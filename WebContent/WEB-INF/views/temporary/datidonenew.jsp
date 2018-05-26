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
<title>有奖问答</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
	filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
	background-color: #FDE2E7;
}

div.content {
	width:100%;
	margin:20px 0px;
	text-align: center;
}

.headdiv {
	width: 90%;
	text-align: center;
	margin:20px auto;
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
	height: 50px;
	line-height: 50px;
}

.roledetail {
	width: 80%;
	height:30px;
	margin: 20px auto;
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

div.imgdiv {
	width:100%;
}

img.imgcon {
	width:100%;
}

div.tail {
	width:100%;
	height:30px;
	background-color:#FFA904;
	position:absolute;
	left:0;
	right:0;
	bottom:0;
}


</style>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
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

</head>
<body>
	
	<div class="backimg">
		<div class="imgdiv">
			<img alt="" src="${ctx}/static/11act/images/question.jpg" class="imgcon">
		</div>
	</div>

	<div class="content">
	
		<div class="rolediv">您已经参加过有奖问答活动了</div>
		<%-- <div class="roledetail">您的排名为：<span style="color:red;font-size:18px;font-style:oblique;">${servey.rank}</span></div> --%>
		<div class="roledetail">您还可以参加其他优惠活动</div>
		<div class="roledetail">也可以查看您的答卷</div>
		
		<div class="buttondiv">
			<button style="background-color: #ed304e;" onclick="seemore()">更多优惠活动</button>
		</div>
		
		<div class="buttondiv">
			<button style="background-color: #ed304e;" onclick="seemy()">查看我的答卷</button>
		</div>
			

	</div>
	
	<div class="tail">
			
	</div>
	
</body>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function seemy() {
		window.location.href = "${ctx}/wxact/seemy";
	}
	
	function seemore() {
		window.location.href = "${ctx}/wxpage/actlist";
	}
	
</script>
</html>