<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>人气值活动</title>
<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		$("#over").bind("click", function() {
			$.post("${ctx}/popularity/stop", function(d) {
				if (d == "1")
					window.parent.showAlert("操作成功");
			});
		});
	});
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />人气值活动
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/popularity/pwinform" class="btn blue">查看奖项</a> <a
					id="over" href="javascript:void(0);" class="btn blue">活动结束</a>
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
						<th>分数</th>
						<th>操作</th>
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
								<td style="vertical-align: middle;">${tr.totalscore}</td>
								<td></td>
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