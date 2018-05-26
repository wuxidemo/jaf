<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", -10);
%>


<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>下载金阿福商家助手</title>
<meta http-equiv="refresh" content="0; url=itms-services://?action=download-manifest&url=https://dn-dowi.qbox.me/manifest.plist"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="luzhenwei">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=0">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="${ctx}/static/demo/js/jquery-1.9.1.min.js"></script>
<style type="text/css">
	*{margin:0; padding:0;}
	img{max-width: 100%; height: auto;}
</style>
</head>
<body id="body" style="width:320px;margin:0 auto;">

<div style="text-align: center; width:320px;overflow: hidden;margin : 30% auto;" >
	<h3 align="center">免费下载金阿福商家助手</h3>
	<br/>
	<a href="itms-services://?action=download-manifest&url=https://dn-dowi.qbox.me/manifest.plist" target="_blank"> 
		<img src="ic_launcher.png" style="display: inline; border: none;">
	</a>
	<br/>
	<a href="itms-services://?action=download-manifest&url=https://dn-dowi.qbox.me/manifest.plist" target="_blank"> 
		<img src="download.png" style="display: inline; border: none;">
	</a>
	<!-- <p align="center">微信扫描后，如果点击图片无法下载，请在右上角下拉菜单中选择"<span style="color : red">在浏览器中打开</span>"</p> -->
</div>
<script type="text/javascript">
function count() {
	$.get("${ctx}/api/updateAccNum");
}
</script>
<script type="text/javascript">
		function is_weixin() {
		    var ua = navigator.userAgent.toLowerCase();
		    if (ua.match(/MicroMessenger/i) == "micromessenger") {
		        return true;
		    } else {
		        return false;
		    }
		}
		var isWeixin = is_weixin();
		var winHeight = typeof window.innerHeight != 'undefined' ? window.innerHeight : document.documentElement.clientHeight;
		var winWidth  = typeof window.innerWidth != 'undefined' ? window.innerWidth : document.documentElement.clientWidth;
		function loadHtml(){
			var div = document.createElement('div');
			div.id = 'weixin-tip';
			div.innerHTML = '<p><img src="live_weixin.png" alt="微信打开"/></p>';
			document.body.appendChild(div);
		}
		
		function loadStyleText(cssText) {
	        var style = document.createElement('style');
	        style.rel = 'stylesheet';
	        style.type = 'text/css';
	        try {
	            style.appendChild(document.createTextNode(cssText));
	        } catch (e) {
	            style.styleSheet.cssText = cssText; //ie9以下
	        }
            var head=document.getElementsByTagName("head")[0]; //head标签之间加上style样式
            head.appendChild(style); 
	    }
	    
		var browser = {
				versions : function() {
					var u = navigator.userAgent, app = navigator.appVersion;
					return {//移动终端浏览器版本信息
						trident : u.indexOf('Trident') > -1, //IE内核
						presto : u.indexOf('Presto') > -1, //opera内核
						webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
						gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
						mobile : !!u.match(/AppleWebKit.*Mobile.*/)
								|| !!u.match(/AppleWebKit/), //是否为移动终端
						ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
						android : u.indexOf('Android') > -1
								|| u.indexOf('Linux') > -1, //android终端或者uc浏览器
						iPhone : u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
						iPad : u.indexOf('iPad') > -1, //是否iPad
						webApp : u.indexOf('Safari') == -1
					//是否web应该程序，没有头部与底部
					};
				}(),
				language : (navigator.browserLanguage || navigator.language)
						.toLowerCase()
			}
			
			if (browser.versions.ios || browser.versions.iPhone
					|| browser.versions.iPad) {
				var cssText = "#weixin-tip{position: fixed; left:0; top:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80); width: 100%; height:100%; z-index: 100;} #weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}";
				if(isWeixin){
					loadHtml();
					loadStyleText(cssText);
				}
			} else if (browser.versions.android) {
				window.location = "androidNotSupport.jsp";
			}
		
</script>
</body>
</html>