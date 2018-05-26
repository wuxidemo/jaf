<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<!-- saved from url=(0136)http://www.weimob.com/weisite/detail?pid=5236&bid=10726&did=12327&wechatid=ospGBjhDYhG9USredsDnVhSthjec&from=list&wxref=mp.weixin.qq.com -->
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">

<link media="all" href="${ctx}/static/css/reset.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/common.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/list-2.css" type="text/css" rel="stylesheet">
 <link rel="stylesheet" href="${ctx}/static/video-js/video-js.css" type="text/css" media="screen" title="Video JS">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
	 <script src="${ctx}/static/video-js/video.js" type="text/javascript" charset="utf-8"></script>
	

<title>旅游详细</title>
        
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
      
        <!-- Mobile Devices Support @begin -->
            
            <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
            <meta content="no-cache" http-equiv="pragma">
            <meta content="0" http-equiv="expires">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes"> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <!-- Mobile Devices Support @end -->
      
        <style>
            img{max-width:100%!important;}
			body{ background: #efefef;}
	html, body{height:100%;}
	.weimob-page{
		max-width:640px;
		margin:auto;
		padidng:10px;
	}
	.weimob-content{
		margin:10px;
		padding:15px;
		min-height:100%:;
		background:#fff;
		border-radius:10px;
	}
	h3{margin-bottom:3px;}
	.pub_time{
		display:inline-block;
		font-size:12px;
		color:#ccc;
		margin-bottom:8px;
	}
    table{
        width:auto!important;
    }
        </style>
        <script>
	
jQuery(document).ready(function() {
  var data=new QueryString();
  	//$("#content").append("<div><img onclick=\"window.open('${ctx}/static/weixin/showvideo.jsp?path="+data.url1+"')\" src=\""+data.url2+"\" style=\"width:100%;\"></div>");
  	$("#content").append("<div><img onclick=\"window.open('${ctx}/static/weixin/showvideo.jsp?path="+data.url1+"')\" src=\"${ctx}/static/images/video.gif\" style=\"width:100%;\"></div>");
  	$("#content").append("<div><img src=\""+data.url2+"\" style=\"width:100%;\"></div>");
	$("#content").append("<div><img src=\""+data.url3+"\" style=\"width:100%;\"></div>");
	
	
});
function QueryString()
{	
	var name,value,i;
	var str=location.href;
	var num=str.indexOf("?");
	str=str.substr(num+1);
	var arrtmp=str.split("&");
	for(i=0;i < arrtmp.length;i++)
	{
		num=arrtmp[i].indexOf("=");
		if(num>0)
		{
			name=arrtmp[i].substring(0,num);
			value=arrtmp[i].substr(num+1);
			this[name]=value;
		}
	}
}
	</script>
    <body onselectstart="return true;" ondragstart="return false;">
        <link rel="stylesheet" type="text/css" href="${ctx}/static/css/font-awesome.css" media="all">

	<div class="weimob-page" style="display:block;">
				
	
				<div id="content" class="weimob-content">

						
		</div>

</div>        			
</body>
</html>