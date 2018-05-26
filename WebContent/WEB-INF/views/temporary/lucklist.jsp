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
</head>

<script type="text/javascript">
	
</script>
<body>
	<form action="${ctx}/activity/delete" id="deleteForm"
		style="display: none;" method="post"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />全城抽奖
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/ticketrecord/luckform" class="btn blue">抽奖</a> <a
					href="javascript:;" class="btn red" onclick="askfordelete()">删除</a>
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
						<th>流水号</th>
						<th>昵称</th>
						<th>编号</th>
						<th>时间</th>
						<th>图片</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${trs.totalPages!=0}">
						<c:forEach items="${trs.content}" var="tr" varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item" value="${tr.id}"
									class="check_item"></td>
								<td style="vertical-align: middle;">${tr.code}</td> 
								<td style="vertical-align: middle;">${tr.name}</td>
								<td style="vertical-align: middle;">${tr.openid}</td>
								<td style="vertical-align: middle;">${fn:substring(tr.createtime,0,10)}</td>
								<td style="vertical-align: middle;"><a
									href="http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=${token}&media_id=${tr.url}"
									target="_blank">查看</a></td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.state==1}">正常</c:if> <c:if test="${tr.state==2}">已中奖</c:if>
									<c:if test="${tr.state==3}">废票</c:if></td>
								<td><a href="${ctx}/ticketrecord/del/${tr.id}">废票</a></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${trs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${trs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>