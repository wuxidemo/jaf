<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link media="all" href="${ctx}/static/css/reset.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/common.css" type="text/css" rel="stylesheet">
<link media="all" href="${ctx}/static/css/list-2.css" type="text/css" rel="stylesheet">

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script>
	
jQuery(document).ready(function() {

$.get("${ctx}/api/wsp?clientid=80:ee:73:98:ef:b1",function(data){
	if(data)
		{
		if(data.result=="1")
			{
			for(var i=0;i<data.data.length;i++)
				{
				$("#content").append("	<div class=\"weimob-list\"><a class=\"weimob-list-item\" href=\"${ctx}/static/weixin/ly_detail.jsp?url1="+data.data[i][1]+"&url2="+data.data[i][2]+"&url3="+data.data[i][3]+"\">	<div class=\"weimob-list-item-line\"> <div class=\"weimob-list-item-img\">	<img src=\""+data.data[i][0]+"\">	</div></div></a></div>");
				}
			}
		}
});


					
});

</script>
<title>旅游导引</title>

<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<!-- Mobile Devices Support @begin -->

<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes">
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<!-- Mobile Devices Support @end -->

<body onselectstart="return true;" ondragstart="return false;">
	<link media="all" href="${ctx}/static/css/font-awesome.css" type="text/css" rel="stylesheet">

	<div class="weimob-page" style="margin-top: 10px">
	
		<div id="content" class="weimob-content">
			

		</div>
	</div>
</body>
</html>