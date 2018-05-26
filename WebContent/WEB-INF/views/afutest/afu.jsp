<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>金阿福测试</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var url = '${ctx}/wxpage/getnearbymerchant'
		$.post(url, 
			{
				"start":0,
				"size":10,
				"lat":31.11111111,
				"lon":121.1111111
			},
		    function(data) {
			alert(data.result);
		});
	});
</script>
<body>
	
</body>
</html>