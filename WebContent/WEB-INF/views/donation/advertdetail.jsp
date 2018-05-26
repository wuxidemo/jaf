<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">

<link rel="stylesheet"
	href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
<title>${advert.title}</title>
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
<style>
.contentdiv img {
	width: 100%;
	height: 100%;
}

.innerdiv p {
	line-height: 20px;
	padding-left: 20px;
	padding-right: 20px;
}
</style>
<body>
	<div data-role="page"
		style="margin: 0; padding: 0; background-color: white;">
		<div style="width: 100%;">
			<img src="${sqadvert.picurl }" width="100%">
		</div>

		<div
			style="text-align: justify; padding: 0; margin: 0; width: 100%; background-color: white;"
			class="contentdiv">
			<div class="innerdiv">${sqadvert.context }</div>
		</div>
	</div>


</body>
</html>