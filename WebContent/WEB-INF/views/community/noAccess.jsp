<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<html>
<head>
<title>信息不完善</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				&nbsp;社区信息
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>社区信息
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form" style="min-height: 600px;height: auto;">
				<div style="height:500px; width:100%;font-size:20px;">
					对不起当前用户不是社区用户，无权限查看此内容
				</div>
			</div>
		</div>
	</div>
</body>
</html>
