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
<!-- <script type="text/javascript" src="http://stc.weimob.com/src/jQuery.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/scroller.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/dialog.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/main.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/menu.js?2014-05-21"></script> -->

<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/scroller.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/menu.js"></script> 


<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
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
	$.get('${ctx}/api/xxyl/detail?clientid=00:00:00:00:00:01&sellerid='+sellerid,function(map){
		if(map["data"] != null && map["data"] != '') {
			var str = '';
			for(var i=0;i< map["data"].length; i++) {
				var temp = map["data"][i];
				str += "<li onclick=\"showDetail("+temp.id+")\">";
				str += "	<div>";
				str += "		<img src=\""+temp.url+"\"  width=\"65px\" height=\"65px\" />";
				str += "	</div>";
				str += "	<div>";
				str += "		<h3>"+temp.name+"</h3>";
				str += "		<p><span class=\"sales\"><strong class=\"sale_10\"></strong></span></p>";
				str += "		<div class=\"info\"></div>";
				str += "	</div>";
				str += "	<div class=\"price_wrap\">";
				/* str += "		<strong>&yen;<span class=\"unit_price\">"+temp.price+"</span></strong>";
				str += "		<div class=\"fr\" max=\"-1\">";
				str += "			<a href=\"javascript:void(0);\" class=\"btn add\"></a>";
				str += "		</div>"; */
				str += "		<input autocomplete=\"off\" class=\"number\" type=\"hidden\" name=\"dish[1126][woi_number]\" value=\"\" />";
				str += "		<input autocomplete=\"off\" type=\"hidden\" name=\"dish[1126][wdd_name]\" value=\""+temp.name+"\" />";
				str += "		<input autocomplete=\"off\" type=\"hidden\" name=\"dish[1126][wdd_price]\" value=\""+temp.price+"\" />";
				str += "	</div>";
				str += "</li>";
			}
			$("#xxyl").append(str);
		}
	});
});
</script>
<script type="text/javascript">
function toMendian() {
	var sellerid = $("#sellerid").val();
	window.location.href = "${ctx}/static/weixin/xxyl_seller_info.jsp?sellerid="+sellerid;
}
function showDetail(proid) {
	var sellerid = $("#sellerid").val();
	window.location.href = "${ctx}/static/weixin/xxyl_pro_detail.jsp?proid="+proid+"&sellerid="+sellerid;
}
</script>
<body onselectstart="return true;" ondragstart="return false;">
	<div class="container">
	<header class="nav menu">
		<div>
			<a href="javascript:;" class="on">项目列表</a>
			<a href="javascript:;" onclick="toMendian()">商家详情</a>
		</div>
	</header>
	<form name="cart_form" action="#" method="post">
		<input type="hidden" id="sellerid" value="${sellerid}">
	<section class="menu_wrap" id="menuWrap">
		<div id="menuNav" class="menu_nav">
			<!-- <div class="ico_menu_wrap clearfix"><span class="ico_menu" id="icoMenu"><i></i></span></div>
			<div class="side_nav" id="sideNav">
				<ul>
					<li><a href="javascript:void(0);">休闲娱乐</a></li>
				</ul>
			</div> -->
		</div>		
		<div class="menu_container">
			<div class="menu_tt"><h2>休闲娱乐</h2></div>
			<ul class="menu_list" id="xxyl">
				<!-- <li>
					<div>
						<img src="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729180258_59697.jpg" alt="" url="http://hs-album.oss.aliyuncs.com/static/1c/38/3c/image/20140729/20140729180258_59697.jpg" />
					</div>
					<div>
						<h3>中影国际</h3>
						<p>累计售票超过<span class="sale_num">30000</span>多张<span class="sales"><strong class="sale_10"></strong></span></p>
						<div class="info"></div>
					</div>
					<div class="price_wrap">
						<strong>&yen;<span class="unit_price">28.5</span></strong>
						<div class="fr" max="-1">
							<a href="javascript:void(0);" class="btn add"></a>
						</div>
						<input autocomplete="off" class="number" type="hidden" name="dish[1218][woi_number]" value="" />
						<input autocomplete="off" type="hidden" name="dish[1218][wdd_name]" value="中影国际" />
						<input autocomplete="off" type="hidden" name="dish[1218][wdd_price]" value="28.5" />
					</div>
				</li> -->
			</ul>
		</div>
	</section>
	<footer class="shopping_cart">
		<div class="fixed">
			<!-- <div class="cart_bg">
				<span class="cart_num" id="cartNum"></span>
			</div>
			<div>
				&yen;<span id="totalPrice">0</span>
			</div> -->
			<div>
				<!-- <span class="comm_btn disabled" style="display: none;">还差<span
					id="sendCondition">0</span>起送 
				</span>--> <a id="settlement" href="javascript:;" onclick="tip();"
					class="comm_btn">我要预约</a>
			</div>
		</div>
	</footer>
	<input autocomplete="off" name="cart_total_num" type="hidden" value=""/>
	<input autocomplete="off" name="cart_total_price" type="hidden" value="0"/>
	</form>
	<!-- <div class="menu_detail" id="menuDetail">
		<img style="display: none;" />
		<div class="nopic"></div>
		<a href="javascript:void(0);" class="comm_btn" id="detailBtn">来一份</a>
		<dl>
			<dt>价格：</dt>
			<dd class="highlight">&yen;<span class="price"></span></dd>
		</dl>
		<p>月售<span class="sale_num"></span>份<span class="sales"><strong></strong></span></p>
		<dl>
			<dt>介绍：</dt>
			<dd class="info"></dd>
		</dl>
	</div> -->
</div></body>
<script type="text/javascript">
var num = 0;
function tip() {
	if(num == 0) {
		alert("预约成功！预约有效期限为6小时！");
		num += 1;
	}else {
		alert("你已经预约成功，请不要重复预约，进店请提供本人的微信号，关注本店微信号可享受9折优惠！");
	}
	
}
</script>
<script type="text/javascript">
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
		"timeLineLink": "http://1071.m.weimob.com/microtakeout/menu?sp_id=25355&wechat_id=fromUsername&aid=1071&weimob_id=0",
	"sendFriendLink": "http://1071.m.weimob.com/microtakeout/menu?sp_id=25355&wechat_id=fromUsername&aid=1071&weimob_id=0",
	"weiboLink": "http://1071.m.weimob.com/microtakeout/menu?sp_id=25355&wechat_id=fromUsername&aid=1071&weimob_id=0",
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
</script>
</html>