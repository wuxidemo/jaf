<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<title>最美服务员</title>
<style type="text/css">
body {
	margin: 0;
	font-family: Microsoft YaHei;
}

.div_img {
	width: 100%;
}

.div_img img {
	width: 100%;
	display: block;
}

.role {
	margin-top: -16px;
	width: 100%;
	position: relative;
}

.div_guize {
	margin: auto;
	background-color: #fe4a5d;
	color: white;
	border-radius: 8px;
	width: 26%;
	text-align: center;
	font-size: 17px;
	line-height: 33px;
	z-index: 99999;
}

.div_enter {
	margin: auto;
	margin-top: 45px;
	background-color: #ef2e2f;
	color: white;
	border-radius: 10px;
	width: 60%;
	text-align: center;
	font-size: 26px;
	line-height: 50px;
}

.text_check {
	text-align: center;
	font-size: 20px;
	margin-top: 18px;
}

.text_check p {
	margin-top: 4px;
	margin-bottom: 4px;
	color: #ef2e2f;
}

.div_joined p {
	text-align: center;
	font-size: 20px;
	color: #ef2e2f;
	margin-top: 10px;
	margin-bottom: 10px;
}

.div_joined div {
	margin: auto;
	background-color: #ef2e2f;
	color: white;
	border-radius: 10px;
	width: 60%;
	text-align: center;
	font-size: 26px;
	line-height: 50px;
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
    left: 44%;
    margin-top: -100px;
    margin-left: -90px;
    width: 225px;
    height: 210px;
    z-index: 10;
    background-color: white;
    position: fixed;
    border-radius: 5px;
    display: none;
}
.qr2 {
	width: 100%;
	height: 30px;
	color: black;
	line-height: 20px;
	text-align: center;
	font-size:large;
	margin-top: 20px;
}
.qr1 {
	width: 100%;
	height: 170px;
	text-align: center;
}

.qr1 img {
	width: 130px;
    height: 130px;
    margin-top: 5px;
}
</style>
</head>
<body>
	<div class="div_img">
		<img src="${ctx}/static/wxfile/newyear/image/reward.png">
	</div>
	<div class="role">
		<div class="div_guize" onclick="detail()">活动规则</div>
	</div>
	<c:if test="${state==1 }">
		<div class="div_enter" onclick="enter()">进入活动</div>
	</c:if>
	<c:if test="${state==2 }">
		<div class="div_joined">
			<p>您已参加过此活动</p>
			<div onclick="look()">查看我的信息</div>
		</div>
	</c:if>
	<c:if test="${state==3 }">
		<div class="text_check">
			<div>
				投稿正在审核阶段
				<p>1月16日开始投票</p>
				请密切关注金阿福微信平台
			</div>
		</div>
	</c:if>
	<c:if test="${state==4 }">
		<div class="div_enter" onclick="vote()">进行投票</div>
	</c:if>
	<c:if test="${state==5 }">
		<div class="div_joined">
			<p>活动已结束</p>
			<div onclick="reward()">查看获奖情况</div>
		</div>
	</c:if>
	<div class="cover"></div>
	<div class="qrdiv">	
		<div class="qr2">长按二维码进入公众号</div>
		<div class="qr1">
			<img src="">
		</div>
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
			title : '吃在湖滨街，看最美服务员', // 分享标题
			link : '${baseurl}/wxurl/redirect?url=waiter/', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/waitelogo.jpg' // 分享图标

		});

		wx.onMenuShareAppMessage({
			title : '吃在湖滨街，看最美服务员', // 分享标题
			desc : '自信的人最美，快来晒出你的微笑，参加“最美服务员”的活动吧！更有现金大奖等你来拿！', // 分享描述
			link : '${baseurl}/wxurl/redirect?url=waiter/', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/waitelogo.jpg' // 分享图标
		});
	});
	
	function enter(){
		isfocus(1);
	}	
	function look(){
		isfocus(2);
	}
	function vote(){
		isfocus(3);
	}
	function reward(){
		isfocus(4);
	}
	function detail() {
		window.location.href = "${ctx}/wxurl/tourl?url=newyear/actrules";
	}
	function isfocus(kind) {

		$
				.post(
						"${ctx}/newyearact/checkfocus?param=55000",
						function(d) {

							if (d.result == -1) {
								window.location.href = "${ctx}/wxurl/redirect?url=newyearact/";
								return false;
							} else if (d.result == 1) {
								if (kind == 1) {
									window.location.href = "${ctx}/wxurl/redirect?url=waiter/jump";
								} else if(kind == 2){
									window.location.href = "${ctx}/wxurl/redirect?url=waiter/jump";
								}else if(kind == 3){
									window.location.href ="${ctx}/wxurl/redirect?url=waiter/vote";
								}else {
									window.location.href ="${ctx}/waiter/winning";
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