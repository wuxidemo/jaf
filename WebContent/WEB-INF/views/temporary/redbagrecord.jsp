<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>全城抽奖</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	function resetAll() {
		$("#datepicker").val("");
		$("#datepicker1").val("");
	}
	$(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	});
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />红包记录
			</h3>
		</div>
	</div>
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-search" id="myform"
				action="${ctx}/sharerecord/redbag" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">开始时间：</label><input type="text"
							id="datepicker" name="search_GTE_createtime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_createtime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">结束时间：</label><input type="text"
							id="datepicker1" name="search_LTE_createtime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_createtime}"></td>



						<td style="width: 33%">
							<button class="btn blue" id="search_btn" onclick="forsubmit()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="reset_btn"
								onclick="resetAll()">重置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/sharerecord/refreshrb" style="margin-top: -10px;"
					class="btn blue">重发红包</a>
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all" value=""
							class="check_all"></th>
						<th>昵称</th>
						<th>编号</th>
						<th>时间</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${srs.totalPages!=0}">
						<c:forEach items="${srs.content}" var="tr" varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item" value="${tr.id}"
									class="check_item"></td>
								<td style="vertical-align: middle;">${tr.name}</td>
								<td style="vertical-align: middle;">${tr.openid}</td>
								<td style="vertical-align: middle;">${fn:substring(tr.createtime,0,10)}</td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.state==1}">正常</c:if> <c:if test="${tr.state==2}">发送失败</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${srs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${srs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>