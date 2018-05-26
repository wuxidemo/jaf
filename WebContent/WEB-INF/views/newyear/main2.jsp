<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>最美校园1</title>
</head>
<body>

	<input type="file">
	<a
		href="<c:if test="${state==1}">https://www.baidu.com/</c:if>
	<c:if test="${state==1}"></c:if>
	<c:if test="${state==1}"></c:if>
	<c:if test="${state==1}"></c:if>">江南大学</a>
	<a
		href="<c:if test="${state==1}">https://www.baidu.com/</c:if>
	<c:if test="${state==1}"></c:if>
	<c:if test="${state==1}"></c:if>
	<c:if test="${state==1}"></c:if>">太湖学院</a>
	<a href="${ctx}/wxurl/tourl?url=newyear/main3"
		onclick="javascript:location.replace(this.href);event.returnValue=false;">跳转</a>
	<a onclick="dd()">ddd</a>
	<form action="${ctx}/wxurl/tourl1?url=">
		<input name="url" value="newyear/main3">
	</form>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	javascript: window.history.forward(1);
	function dd() {
		$("form").submit();
		//javascript: location.replace("${ctx}/wxurl/tourl?url=newyear/main3");
		//event.returnValue = false;
	}
</script>
</html>