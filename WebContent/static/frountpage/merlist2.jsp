<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
	<title>商家列表</title>
</head>
<script type="text/javascript">
	$(document).ready(function(){
		alert("hellop");
		var searchurl = "${ctx}/merchant/getallmerchant";
		$.post(searchurl,{"businessgroup" : "","name" : ""},function(data) {
			if (data.result == '1') {
				var dataobj = data.data
				for (var i = 0; i < dataobj.length; i++) {
					$("#datacontent").append('<div style="width: 100%; height: 100px; margin-bottom:10px;">'
											+	'<div style="float:left;width: 45%">'
											+		'<img alt="" src="images/nsh/haidilao.png" width="150px;" height="100px;">'
											+	'</div>'
											+	'<div style="float:right;width: 55%;padding-top:10px;">'
											+		'<div style="width: 100%; padding-left:20px;">'+dataobj[i].name+'</div>'
											+		'<div style="width: 100%; padding-left:20px;">标签：'+dataobj[i].category+'</div>'
											+		'<div style="width: 100%; padding-left:20px;">电话：'+dataobj[i].telephone+'</div>'
											+		'<div style="width: 100%; padding-left:20px;">地址：'+dataobj[i].address+'</div>'
											+	'</div>'
											+'</div>'
											+'<div style="width: 100%;"><hr/></div>'
							);
				}
			}
		});
	});
	
	
	
	
</script>
<style>
h1 {

}
</style>
<body>
	<div data-role="page">
		<div data-role="header" data-position="fixed" style="vertical-align: middle;">
			<h1><b>商家列表</b></h1>
			<img class="ui-btn-right" src="images/nsh/search2.png" width="50px" height="30px" style="margin-top:5px;">
		</div>
		<div data-role="content" id="datacontent">
			<div style="width: 100%; height: 100px; margin-bottom:10px;">
				<div style="float:left;width: 45%">
					<img alt="" src="images/nsh/haidilao.png" width="150px;" height="100px;">
				</div>
				<div style="float:right;width: 55%;padding-top:10px;">
					<div style="width: 100%; padding-left:20px;">海底捞</div>
					<div style="width: 100%; padding-left:20px;">标签：</div>
					<div style="width: 100%; padding-left:20px;">电话：</div>
					<div style="width: 100%; padding-left:20px;">地址：</div>
				</div>
			</div>
			
			<div style="width: 100%;"><hr/></div>
			
		</div>
	</div>

	
</body>


</html>