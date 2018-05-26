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
	display: block;
}

.info {
	width: 100%;
	text-align: center;
	margin-top: -18px;
}

.info div {
	width: 85%;
	margin: auto;
	line-height: 18px;
	text-align: left;
	text-indent: 2em;
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

.cover {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 9;
	display: none;
}

.qrdiv {
	top: 50%;
	left: 50%;
	margin-top: -100px;
	margin-left: -90px;
	width: 180px;
	height: 200px;
	z-index: 10;
	background-color: white;
	position: fixed;
	border-radius: 5px;
	display: none;
}

.qr1 {
	width: 100%;
	height: 170px;
	text-align: center;
}

.qr2 {
	width: 100%;
	height: 30px;
	color: #555555;
	line-height: 20px;
	text-align: center;
}

.qr1 img {
	width: 150px;
	height: 150px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="head">
		<img src="${ctx}/static/wxfile/newyear/image/newyearindexhead.png">
	</div>
	<div class="info">
		<div>冬意渐浓，双旦将至。大学生活中总有些人与事与物让人难以忘怀，或是独自一人成日浸泡的图书馆；或是有恋人依偎你侬我侬的湖畔；又或是曾令你疯狂执着、感动幸福的点点滴滴。那么，就把你大学记忆里的难忘片段定格，收纳进镜头里，与我们一起分享吧。</div>
	</div>
	<div class="role">
		<div onclick="detail()">活动规则</div>
	</div>
	<div class="rkdiv">
		<img src="${ctx}/static/wxfile/newyear/image/rkdiv.png">
		<div class="jddiv" onclick="jdcj()"></div>
		<div class="thdiv" onclick="thcj()"></div>
	</div>
	<div class="cover"></div>
	<div class="qrdiv">
		<div class="qr1">
			<img src="">
		</div>
		<div class="qr2">长按二维码进入公众号</div>
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
		isfocus(1);
	}
	function thcj() {
		isfocus(2);
	}
	function detail() {
		window.location.href = "${ctx}/wxurl/tourl?url=newyear/roledetail";
	}

	function isfocus(kind) {

		$
				.post(
						"${ctx}/newyearact/checkfocus?param=99000",
						function(d) {

							if (d.result == -1) {
								window.location.href = "${ctx}/wxurl/redirect?url=newyearact/";
								return false;
							} else if (d.result == 1) {
								if (kind == 1) {
									window.location.href = "${ctx}/wxurl/redirect?url=newyearact/jump?col=1";
								} else {
									window.location.href = "${ctx}/wxurl/redirect?url=newyearact/jump?col=0";
								}
							} else {
								showqr(d.qrurl)
								return false;
							}
						});
	}
	function showqr(url) {
		$(".qr1 img").attr("src", url);
		$(".cover").show();
		$(".qrdiv").show();
	}
</script>

</html>