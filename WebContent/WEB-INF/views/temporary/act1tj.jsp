<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>优惠活动</title>
<style type="text/css">
body {
	margin: 0;
}
</style>
</head>
<body>
	已领取：${state2} 人次
	<br> 支付未领取：${state1} 人次
	<br> 限制:
	<input value="${num}" id="num">
	<input value="${id}" id="id" type="hidden">
	<a onclick="setnum()">设置</a>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	function setnum(){ 
		$.post("${ctx}/tmpactivity/setnum?id="+$("#id").val()+"&num="+$("#num").val(),function(d){
			if(d=="1")
				{alert("OK");}
			window.location.reload();
		});
	}
</script>
</html>