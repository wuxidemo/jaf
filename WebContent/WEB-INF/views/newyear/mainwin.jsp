<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html >
<html>
<head>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>最美校园</title>
<style type="text/css">
body {
	margin: 0;
	font-family: SimHei;
	color: #804a09;
	font-size: 15px;
}

.head {
	width: 100%;
}

.head img {
	width: 100%;
}

.info {
	width: 100%;
	text-align: center;
}

.info div {
	width: 85%;
	margin: auto;
	line-height: 50px;
	font-size: 20px;
	height: 50px;
}

.role {
	margin-top: 25px;
	width: 100%;
	text-align: center;
}

.role div {
	line-height: 40px;
	width: 105px;
	height: 40px;
	background: url('${ctx}/static/wxfile/newyear/image/muwen.png') center
		no-repeat;
	margin: auto;
	background-size: 100%;
	font-size: 18px;
}

.rkdiv {
	margin-top: 10px;
	width: 100%;
	position: relative;
}

.rkdiv img {
	width: 100%;
	display: block;
}

.jddiv {
	top: 0;
	position: absolute;
	width: 100%;
	height: 35%;
}

.thdiv {
	top: 35%;
	position: absolute;
	width: 100%;
	height: 30%;
}
</style>
</head>
<body>
	<div class="head">
		<img src="${ctx}/static/wxfile/newyear/image/newyearindexhead.png">
	</div>
	<div class="info">
		<div>活动已结束</div>
		<div>点击学校查看获奖情况</div>
	</div>
	<div class="role">
		<div onclick="detail()">活动规则</div>
	</div>
	<div class="rkdiv">
		<img src="${ctx}/static/wxfile/newyear/image/rkdiv.png">
		<div class="jddiv" onclick="jdcj()"></div>
		<div class="thdiv" onclick="thcj()"></div>
	</div>

</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'onMenuShareTimeline', 'openLocation',
				'onMenuShareAppMessage' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		wx.onMenuShareTimeline({
			title : '最美校园', // 分享标题
			link : '${baseurl}/wxurl/redirect?url=newyearact/', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标

		});

		wx.onMenuShareAppMessage({
			title : '最美校园', // 分享标题
			desc : '用你的镜头，记录最美的校园。', // 分享描述
			link : '${baseurl}/wxurl/redirect?url=newyearact/', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标
		});
	});
	function jdcj() {
		window.location.href = "${ctx}/newyearact/winresult?col=1";
	}
	function thcj() {
		window.location.href = "${ctx}/newyearact/winresult?col=0";
	}
	function detail() {
		window.location.href = "${ctx}/wxurl/tourl?url=newyear/roledetail";
	}
</script>
</html>