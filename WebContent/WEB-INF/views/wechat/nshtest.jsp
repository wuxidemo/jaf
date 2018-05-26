<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<title>评价成功</title>
</head>
<style>
html,body {
	margin:0;
	padding:0;
	overflow: hidden;
}
.content {
	width: 100%;
	height: 100%;
	top:0;
	z-index: -1; 
	position: absolute;
}

.content img {
	display: block;
	outline: none;
	border:0;
	height: 100%;
	width: 100%;
}
</style>
<script>
    javascript:window.history.forward(1); 
</script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var posturl = '${ctx}/wxpage/getmerbycommunity';
		$.post(posturl,{"lat":31.232323,"lon":121.252525,"commid":40,"start":0,"size":10},function(data){
			var da = data.data;
			//var juli = da[7][6]/1000.0+'';
			//var index = juli.indexOf(".");
			//juli = juli.substring(0,index+2);
			//alert(juli)
			for(var i=0;i<data.data.length;i++) {
				$(".content").append(da[i]+'<br/>');
			}
			
		});
		
		var one = 43.00;
		var two = 43.56
		var three = 43;
		
		//alert(parseFloat(one));
		//alert(parseFloat(two));
		//alert(parseFloat(three));
		
	});
</script>
<body>
	<div class="content">
		
	</div>
</body>
</html>