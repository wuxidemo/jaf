<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sellerid = request.getParameter("sellerid");
%>
<c:set var="sellerid" value="<%=sellerid%>" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="css/main.css" media="all" />
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/swipe_min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<%-- <script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script> --%>
<title></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<!-- Mobile Devices Support @end -->
<!-- <link rel="shortcut icon" href="http://stc.weimob.com/img/favicon.ico" /> -->
</head>
<script type="text/javascript">
$(document).ready(function(){
	var sellerid = $("#sellerid").val();
	$.get('${ctx}/api/cyms/oneseller?sellerid='+sellerid,function(map){
		if(map["data"] != null && map["data"] != '') {
			var temp = map["data"];
			var str = '';
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>商家名称："+temp.name+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			/* str += "<li>";
			str += "	<a href=\"javascript:;"\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>标签："+temp.label+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>"; */
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>人均消费："+temp.averagemoney+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>星级评价："+temp.stars+"星级</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>空闲餐桌："+temp.sparetables+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>预计等待分钟数："+temp.waitminutes+"分钟</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>"; 
			str += "<li>"; 
			str += "	<a href=\"tel:"+temp.telephone+"\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>电话："+temp.telephone+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			str += "<li>";
			str += "	<a href=\"javascript:;\">";
			str += "		<span><i class=\"\"></i></span>";
			str += "		<strong>地址："+temp.address+"</strong>";
			str += "		<span><i class=\"ico_arrow\"></i></span>";
			str += "	</a>";
			str += "</li>";
			
			$("#sellerinfo").append(str);
		}
	});
});
</script>
<script type="text/javascript">
function toMenu() {
	var sellerid = $("#sellerid").val();
	window.location.href = "${ctx}/static/weixin/cyms_pro_list.jsp?sellerid="+sellerid;
}
</script>
<body onselectstart="return true;" ondragstart="return false;">
	<form action="#">
		<input type="hidden" id="sellerid" value="${sellerid}">
	</form>
	<div class="container">
	<header class="nav">
		<div>
			<a href="javascript:;" onclick="toMenu()">菜单</a>
			<a href="javascript:;" class="on">商家详情</a>
		</div>
	</header>
	<section>
		<div id="imgSwipe" class="img_swipe">
			<!-- <ul>
				<li><a href=""><img src="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729170935_32349.jpg" /></a></li>
				<li><a href=""><img src="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729170951_90679.jpg" /></a></li>
				<li><a href=""><img src="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729171017_69596.jpg" /></a></li>
				<li><a href=""><img src="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729171042_49722.jpg" /></a></li>
			</ul> -->
			<ol id="swipeNum">
				<li class="on"></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
		<!-- <div class="store_info">
			<span><strong>30</strong>送达/分钟</span>
			<span><strong>0</strong>起送价/元</span>
			<span><strong>0</strong>配送费/元</span>
		</div> -->
		<ul class="box" id="sellerinfo">
			<!-- <li>
				<a href="tel:021-36386066">
					<span><i class="ico_tel"></i></span>
					<strong>电话：021-36386066</strong>
					<span><i class="ico_arrow"></i></span>
				</a>
			</li>
			<li>
				<a href="http://api.map.baidu.com/geocoder?address=上海市宝山区长逸路258号&output=html">
					<span><i class="ico_addres1"></i></span>
					<strong>上海市宝山区长逸路258号</strong>
					<span><i class="ico_arrow"></i></span>
				</a>
			</li> -->
		</ul>
		<!-- <ul class="box">
			<li>营业时间： 00:00 ~ 23:59</li>
			<li>服务半径：5公里</li>
			<li>区域：湖滨商业街</li>
		</ul> -->
	</section>
	<footer class="go_menu">
		<div class="fixed">
			<a href="javascript:;" onclick="gotoSellerList()">返回商家列表</a>
		</div>
	</footer>
</div></body>
<script type="text/javascript">
function gotoSellerList() {
	window.location.href = "${ctx}/static/weixin/cyms_seller_list.jsp";
}
</script>
<!-- <script type="text/javascript">
(function() {
	var wtj = document.createElement('script'); wtj.type = 'text/javascript'; wtj.async = true;
	wtj.src = 'http://tj.weimob.com/wtj.js?url=' + encodeURIComponent(location.href);
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(wtj, s);
})();
function weimobAfterShare(shareFromWechatId,sendFriendLink,shareToPlatform){
	var wmShare = document.createElement('script'); wmShare.type = 'text/javascript'; wmShare.async = true;
    wmShare.src = 'http://tj.weimob.com/api-share.js?fromWechatId=' + shareFromWechatId + '&shareToPlatform=';
	wmShare.src += shareToPlatform + '&pid=1071&sendFriendLink=' + encodeURIComponent(sendFriendLink);
    var stj = document.getElementsByTagName('script')[0]; stj.parentNode.insertBefore(wmShare, stj);
}
</script> -->
<!-- 
<script type="text/javascript">
/**
 * 默认分享出去的数据
 *
 */
function getShareImageUrl(){

	var share_imgurl = "";
	if("" == share_imgurl){
		var shareImgObj = document.getElementsByClassName("shareImgUrl")[0];
		if('undefined' != typeof(shareImgObj)){
			share_imgurl = shareImgObj.src;
		}
	}
	return share_imgurl;
}

window.shareData = window.shareData || {
	"timeLineLink": "http://1071.m.weimob.com/microtakeout/menu?aid=1071&pid=1071&sp_id=25355&wechat_id=fromUsername&weimob_id=0",
	"sendFriendLink": "http://1071.m.weimob.com/microtakeout/menu?aid=1071&pid=1071&sp_id=25355&wechat_id=fromUsername&weimob_id=0",
	"weiboLink": "http://1071.m.weimob.com/microtakeout/menu?aid=1071&pid=1071&sp_id=25355&wechat_id=fromUsername&weimob_id=0",
	"tTitle": document.title,
	"tContent": document.title,
	"fTitle": document.title,
	"fContent": document.title,
	"wContent": document.title}
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	// 发送给好友
	WeixinJSBridge.on('menu:share:appmessage', function (argv) {
		WeixinJSBridge.invoke('sendAppMessage', { 
			"img_url": getShareImageUrl(),
			"img_width": "640",
			"img_height": "640",
			"link": window.shareData.sendFriendLink,
			"desc": window.shareData.fContent,
			"title": window.shareData.fTitle
		}, function (res) {
			if('send_app_msg:cancel' != res.err_msg){
				weimobAfterShare("",window.shareData.sendFriendLink,'appmessage');
			}
			//_report('send_msg', res.err_msg);
		})
	});

	// 分享到朋友圈
	WeixinJSBridge.on('menu:share:timeline', function (argv) {
		WeixinJSBridge.invoke('shareTimeline', {
			"img_url": getShareImageUrl(),
			"img_width": "640",
			"img_height": "640",
			"link": window.shareData.timeLineLink,
			"desc": window.shareData.tContent,
			"title": window.shareData.tTitle
		}, function (res) {
			if('share_timeline:cancel' != res.err_msg){
				//如果用户没有取消
				weimobAfterShare("",window.shareData.timeLineLink,'timeline');
			}
			//_report('timeline', res.err_msg);
		});
	});

	// 分享到微博
	WeixinJSBridge.on('menu:share:weibo', function (argv) {
		WeixinJSBridge.invoke('shareWeibo', {
			"content": window.shareData.wContent,
			"url": window.shareData.weiboLink
		}, function (res) {
			if('share_weibo:cancel' != res.err_msg){
				weimobAfterShare("",window.shareData.weiboLink,'weibo');
			}
			//_report('weibo', res.err_msg);
		});
	});
}, false);
</script> -->
</html>