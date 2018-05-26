<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<link rel="stylesheet" href="jquery mobile/jquery.mobile-1.4.5.min.css">
<title>评估列表</title>
</head>
<body>
	<div data-role="page" id="table">
		<div data-role="content">
			<ul id="contentul" data-role="listview" data-inset="true" style="margin: 0;">
				<li><a href="#">收件箱</a></li>
				<li><a href="#">发件箱</a></li>
				<li><a href="#">垃圾箱</a></li>
			</ul>
		</div>

	</div>
</body>
<script src="mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script src="jquery mobile/jquery.mobile-1.4.5.min.js"></script>
<script>
	$(document).on("pageinit", "#table", function() {
		$.post("${ctx}/mapi/getalltask",function(d){
			if(d)
				{
				var html="";
				for(var i=0;i<d.length;i++)
					{
					html+='<li class="ui-first-child"><a class="ui-btn ui-btn-icon-right ui-icon-carat-r" href="${ctx}/static/m.jsp">'+d[i].content+'</a></li>'
					}
				$("#contentul").html(html);
				}
		});

	});
</script>
</html>