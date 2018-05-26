<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<title><c:if test="${pactname==null}">优惠活动</c:if> <c:if
		test="${pactname!=null}">${pactname}</c:if></title>

</head>

<style>
body {
	font-family: "微软雅黑";
}

.content {
	margin: 0;
	padding: 0;
	width: 100%;
}

.item {
	width: 94%;
	margin: 15px 3%;
	padding: 0px;
	border: 1px #ccc solid;
	border-radius: 0px;
}

.itemimg {
	width: 100%;
	/* height:200px; */
	margin-bottom: 6px;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
}

.itemcoverimg {
	width: 100%;
	/* height:100%; */
}

.itemdetail {
	width: 100%;
}

.itemtitle {
	width: 96%;
	color: #000;
	font-size: 20px;
	margin-top: 10px;
	margin-left: 2%;
	margin-right: 2%;
	word-wrap: break-word;
}

.itemintro {
	width: 96%;
	color: #898989;
	margin: 10px 2%;
	word-wrap: break-word;
}

.noact {
	width: 100%;
	height: 50px;
	line-height: 50px;
	font-size: 24px;
}

/*******************/
.loadcover {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
}

.loadimg {
	position: absolute;
	z-index: 1000;
	width: 25px;
	height: 25px;
	top: 50%;
	left: 50%;
	margin-top: -12px;
	margin-left: -12px;
}

.ball-clip-rotate {
	background-color: #fff;
	width: 15px;
	height: 15px;
	border-radius: 100%;
	margin: 2px;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
	border: 2px solid #fff;
	border-bottom-color: transparent;
	height: 25px;
	width: 25px;
	background: transparent !important;
	display: inline-block;
	-webkit-animation: rotate 0.75s 0s linear infinite;
	animation: rotate 0.75s 0s linear infinite;
}

@
-webkit-keyframes rotate { 0% {
	-webkit-transform: rotate(0deg);
	transform: rotate(0deg);
}

50%
{
-webkit-transform
:
 
rotate
(180deg);

            
transform
:
 
rotate
(180deg);
 
}
100%
{
-webkit-transform
:
 
rotate
(360deg);

            
transform
:
 
rotate
(360deg);
 
}
}
@
keyframes rotate { 0% {
	-webkit-transform: rotate(0deg);
	transform: rotate(0deg);
}
50%
{
-webkit-transform
:
 
rotate
(180deg);

            
transform
:
 
rotate
(180deg);
 
}
100%
{
-webkit-transform
:
 
rotate
(360deg);

            
transform
:
 
rotate
(360deg);
 
}
}
</style>


<body>
<!-- 
	<div class="loadcover"></div>
	<div class="loadimg">
		<div class="ball-clip-rotate"></div>
	</div>
 -->
	<div class="content">
		<c:if test="${fn:length(acts) == 0 }">
			<div class="noact">暂无优惠活动。。。</div>
		</c:if>
		<c:forEach items="${acts}" var="act">
			<div class="item"
				onclick="showdetail('${act.type}','${act.id}','${act.url}','${act.title}')">
				<div class="itemimg">
					<img alt="" src="${ctx}/${act.imgurl}" class="itemcoverimg">
				</div>
				<div class="itemdetail">
					<div class="itemtitle">${act.title}</div>
					<div class="itemintro">
						<!--<c:if test="${fn:length(act.subtitle) > 20}">${fn:substring(act.subtitle,0,20)}...</c:if>
					<c:if test="${fn:length(act.subtitle) <= 20}">${act.subtitle}</c:if>-->
						${act.subtitle}
					</div>
				</div>
			</div>
		</c:forEach>
	</div>


	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		var wechatInfo = navigator.userAgent
				.match(/MicroMessenger\/([\d\.]+)/i);
		if (!wechatInfo) {
			alert("本活动仅支持微信");
		}
		$(document).ready(
				function() {
					wx.config({
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
					//	$(".loadcover").css("display", "none");
					//	$(".loadimg").css("display", "none");
						//wx.hideOptionMenu();
					});
				});

		function showdetail(type, id, url, title) {
			$.post("${ctx}/wxpage/activity", {
				"id" : id,
				"name" : title
			}, function(d) {

			});
			if (type == 'tuwen') {
				window.location.href = "${ctx}/wxpage/actdetail?id=" + id;
			} else {
				if (url.indexOf("http://") >= 0) {
					window.location.assign(url);
				} else {
					window.location.assign("http://" + url);
				}
			}
		}
	</script>
</body>
</html>