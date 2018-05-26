<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>卡券子商户管理</title>
<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
	});

	function askfordelete() {
		var delstr = '';
		$(".check_item").each(function() {
			if ($(this).attr("checked") == 'checked') {
				delstr += "," + $(this).val();
			}
		});
		if (delstr == '') {
			window.parent.showAlert("请选择一条要删除的活动");
			return;
		}

		window.parent.showConfirm("你确定要删除所选择的活动吗？", sureDel);
	}

	function sureDel() {
		var suredelstr = '';
		$(".check_item").each(function() {
			if ($(this).attr("checked") == 'checked') {
				suredelstr += "," + $(this).val();
			}
		});
		suredelstr = suredelstr.substring(1, suredelstr.length);
		$("#deleteForm").append(
				'<input name="delstr" value="'+suredelstr+'" />');
		$("#deleteForm").submit();
	}

	function showqrcode(actid) {
		$.get("${ctx}/tmpactivity/getqrcode?id=" + actid, function(data) {
			window.open(data, "_blank");
		});
	}
</script>
<body>

	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" /> 卡券子商户管理
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/wxmer/refresh" style="margin-top: -9px;"
					class="btn blue">刷新子商户</a>
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 3%;"><input type="checkbox" id="check_all"
							value="" class="check_all"></th>
						<th>序号</th>
						<th>子商户编号</th>
						<th>名称</th>
						<th>协议截止时间</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${mers.totalPages!=0}">
						<c:forEach items="${mers.content}" var="mer" varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item"
									value="${activity.id}" class="check_item"></td>
								<td style="vertical-align: middle;">${status.count}</td>
								<td style="vertical-align: middle;">${mer.merchantid}</td>
								<td style="vertical-align: middle;">${mer.brandname}</td>
								<td style="vertical-align: middle;">${fn:substring(mer.endtime,0,10)}</td>
								<td style="vertical-align: middle;"><c:if
										test="${mer.status=='CHECKING'}">审核中</c:if> <c:if
										test="${mer.status=='APPROVED'}">已通过</c:if> <c:if
										test="${mer.status=='REJECTED'}">已驳回</c:if> <c:if
										test="${mer.status=='EXPIRED'}">协议已过期</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${mers.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${mers}" paginationSize="5" />
		</div>
	</div>
</body>
</html>