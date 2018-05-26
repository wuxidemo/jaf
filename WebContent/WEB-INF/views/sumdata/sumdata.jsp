<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>数据管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<form action="" id="deleteForm" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				数据管理
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;">&nbsp;</a> 
			</div>
		</div>
		 <div class="portlet-body">
			<c:if test="${not empty message}" >
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>统计项</th>
						<th>统计数据</th>
					</tr>
				</thead>
				<tbody>
					<%-- <tr>
						<td style="vertical-align: middle;">1</td>
						<td style="vertical-align: middle;">
							通过传单关注人数
						</td>
						<td style="vertical-align: middle;">${adcount }&nbsp;</td>
					</tr>
					<tr>
						<td style="vertical-align: middle;">2</td>
						<td style="vertical-align: middle;">
							阿福阿喜活动关注人数
						</td>
						<td style="vertical-align: middle;">${afaxcount}&nbsp;</td>
					</tr> --%>
					<tr>
						<td style="vertical-align: middle;">1</td>
						<td style="vertical-align: middle;">
							江南大学扫码关注人数
						</td>
						<td style="vertical-align: middle;">${jdcount}&nbsp;</td>
					</tr>
					<tr>
						<td style="vertical-align: middle;">2</td>
						<td style="vertical-align: middle;">
							太湖学院扫码关注人数
						</td>
						<td style="vertical-align: middle;">${thcount}&nbsp;</td>
					</tr>
				</tbody>
			</table>
		</div> 
	</div>
</body>
</html>