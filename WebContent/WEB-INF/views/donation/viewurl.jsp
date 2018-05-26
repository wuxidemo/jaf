<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>查看义仓广告轮播图</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
	<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				查看广告轮播图
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>查看广告轮播图
			</div>
		</div>
		<div class="portlet-body form">
			<form action="#" id="inputForm" class="form-horizontal" method="post">
			
				<div class="control-group" <c:if test="${commuser == 1}">style="display:none;"</c:if> >
					<label class="control-label">所属社区:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" style="width: 40%;" value="${sqadvert.community.name }" maxlength="50" disabled="disabled">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">广告条:</label>
					<div class="controls">
						<img alt="广告图片" src="${sqadvert.picurl }" id="introimg"  style="width:200px;height:150px;" />
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" value="${sqadvert.title }" maxlength="50" disabled="disabled">
					</div>
				</div>
				
				<div class="control-group" id="urldiv">
					<label class="control-label">URL:</label>
					<div class="controls">
						<input type="text" id="url" class="span3 m-wrap" style="width: 40%;" name="url" value="${sqadvert.url }" maxlength="255" disabled="disabled" >
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
