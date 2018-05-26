<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>社区联系方式</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				社区联系方式
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>社区联系方式
			</div>
		</div>
		<div class="portlet-body form">
			<form action="#" id="inputForm" class="form-horizontal" method="post">
			
				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						设置该联系方式是方便企业捐献时向社区进行预约。
					</div>
				</div>
			
				<div class="control-group">
					<label class="control-label">联系人:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" style="width: 40%;" value="${community.firstname}${community.lastname}" disabled="disabled">
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" style="width: 40%;" value="${community.contactphone}" disabled="disabled">
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<a href="${ctx}/community/updatecontact" class="btn blue">编辑</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
