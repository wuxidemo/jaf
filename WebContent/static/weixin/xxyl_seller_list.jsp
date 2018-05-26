<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="css/main.css" media="all" />
<!-- <script type="text/javascript" src="http://stc.weimob.com/src/jQuery.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/main.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/index.js?2014-05-21"></script>
<script type="text/javascript" src="http://stc.weimob.com/src/microtakeout/helper.js?2014-05-21"></script> -->
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
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
<body onselectstart="return true;" ondragstart="return false;">
<script type="text/javascript">
$(document).ready(function(){
	$.get('${ctx}/api/xxyl?clientid=00:00:00:00:00:01',function(map){
		if(map["data"] != null && map["data"] != '') {
			var str = '';
			for(var i=0;i< map["data"].length; i++) {
				var temp = map["data"][i];
				str += "<li onclick=\"toPro("+temp.id+")\" >";
				str += "	<div class=\"img_tt\">";
				str += "		<div>";
				str += "			<div class=\"nopic\" style=\"width: 65px;height:65px;\">";
				str += "				<img alt=\"\" src=\""+temp.url+"\" width=\"65px;\" height=\"65px;\"/>";
				str += "			</div>";
				str += "		</div>";
				str += "	</div>";
				str += "	<span class=\"main_info\">";
				str += "		<i class=\"not_ico_rest\"></i>";
				str += "		<h3>"+temp.name+"</h3>";
				str += "		<p class=\"sub_title\">"+temp.address+"</p>";
				str += "		<div>";
				str += "			<a href=\"javascript:;\"> 电话："+temp.telephone+" </a> <span class=\"ml13\"><span class=\"ico_addres\"></span>距离："+temp.juli+"</span>";
				str += "		</div>";
				str += "	</span>";
				str += "</li>";
			}
			$("ul").append(str);
		}
	});
});
</script>
<!-- <script>
	var uri = "/microtakeout/index/SpoutletJsonData/aid/1071/pid/1071/wechat_id/osXr8jkQbuWrXrwA4cvMk3JXlh1o/weimob_id/0";
	var APP = {
		urls:{
			getStores: uri
		}
	}
</script>
<script src="http://api.map.baidu.com/api?v=2.0&ak=R2iop4Bpf3nfXVAeTTEH1uep"></script>
<script>
$(function(){
	var pattern = /[`~!@#$%^&*()=|{}':;',\\.<>《》\/?~！@#￥……&*（）—|{}【】‘；：”“'。，、？]/;
	$('#searchTxt').on('keydown', function(e){
           if(e.keyCode == 13){
               var search_content = $.trim($("#searchTxt").val());
               var pattern = /[`~!@#$%^&*()=|{}':;',\\.<>《》\/?~！@#￥……&*（）—|{}【】‘；：”“'。，、？]/;
               if(pattern.test(search_content)){
				alert('搜索关键字不能包含特殊字符');
				return false;
			}            
               var url = "";
               	                if(null != search_content && search_content != "") {
                url = "/microtakeout/index/lists/aid/1071/pid/1071/wechat_id/osXr8jkQbuWrXrwA4cvMk3JXlh1o/weimob_id/0/count/3";
               	url += "/search_content/" + encodeURIComponent(search_content);
               }
               else
               {
                  url = "/microtakeout/index/lists/aid/1071/pid/1071/wechat_id/osXr8jkQbuWrXrwA4cvMk3JXlh1o/weimob_id/0/count/3";
               }
               location.href = url;
           }
       });
});
</script> -->
<script type="text/javascript">
function toPro(sellerid) {
	window.location.href = "${ctx}/static/weixin/xxyl_pro_list.jsp?sellerid="+sellerid;
}
</script>
<div class="container">
	<header class="search">
		<!-- <input type="text" placeholder="搜索店名或地址" id="searchTxt" value=""/> -->
	</header>
	<section>
		<ul id="storeList" class="store_list">
    		<!-- <div style="background:#eeeeee;color:#888888;padding-left:10px;line-height:30px;font-size:12px;">
      			  定位中...
    		</div> -->
    		<!-- <li onclick="location.href='/microtakeout/menu/index/sp_id/25355/wechat_id/osXr8jkQbuWrXrwA4cvMk3JXlh1o/aid/1071/weimob_id/0';">
        	<div class="img_tt">
	            <div>
	                <div class="nopic" style="background-image:url(http://hs-album.oss.aliyuncs.com/static…140729/20140729170922_77200.jpg);background-size: 100% 100%;"></div>
	            </div>
        	</div>
       		 <div class="main_info">
            	<i class="not_ico_rest"></i>
            	<h3>
              		  邻家小厨1号
           		 </h3>
            	<p class="sub_title">
                	上海市宝山区长逸路258号
           		</p>
            	<div>
               	 <a href="tel:021-36386066">
               		     电话：021-36386066
                </a>
                <span class="ml13"></span>
            </div>
            div>Fri Aug 22 2014 23:25:27 GMT+0800</div
        </div>
    </li> -->
</ul>
	</section>
		<footer class="order_btns">
			<!-- <div class="fixed">
				<a href="javascript:;"><i class="ico_order"></i>我的订单</a>
			</div> -->
		</footer>
</div>
</body>
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
	"timeLineLink": "http://1071.m.weimob.com/microtakeout/index?aid=1071&wechat_id=fromUsername&weimob_id=",
	"sendFriendLink": "http://1071.m.weimob.com/microtakeout/index?aid=1071&wechat_id=fromUsername&weimob_id=",
	"weiboLink": "http://1071.m.weimob.com/microtakeout/index?aid=1071&wechat_id=fromUsername&weimob_id=",
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