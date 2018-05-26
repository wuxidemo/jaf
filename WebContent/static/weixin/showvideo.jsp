<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link media="all" href="${ctx}/static/css/reset.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/common.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/list-2.css" type="text/css" rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
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
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
      
        <!-- Mobile Devices Support @begin -->
            
            <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
            <meta content="no-cache" http-equiv="pragma">
            <meta content="0" http-equiv="expires">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes"> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
        <!-- Mobile Devices Support @end -->
  <title>视频预览</title>

  <!-- Include the VideoJS Library -->
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {
	  var data=new QueryString();
	  $("#video").attr("src",data.path);
		$("#video").css("width",$("#content").css("width"));
		 //VideoJS.setupAllWhenReady();
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

  <!-- Include the VideoJS Stylesheet -->
</head>
 <body onselectstart="return true;" ondragstart="return false;">
        <link rel="stylesheet" type="text/css" href="${ctx}/static/css/font-awesome.css" media="all">

	<div class="weimob-page" style="display:block;">
				
	
				<div id="content" class="weimob-content">
	<video id="video" src="movie.ogg" controls="controls">
	您的浏览器不支持 video 标签。
	</video>
						
		</div>

</div>        			
</body>
</html>