<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<% 
String  title="";
if(request.getParameter("search_LIKE_title")!=null){
	title=new String(request.getParameter("search_LIKE_title").getBytes("ISO-8859-1"),"UTF-8"); 
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动页面管理</title>
<%@ include file="../quote.jsp"%>
</head>
<script>
	function resetAll() {
		$("#title").val('');
	}

	jQuery(document).ready(function() {
		init_checkbox('.check_all', '.check_item');

	});
	function deleteCommunity() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		} else {
			parent.window.showConfirm("确定要将选中的数据删除吗?", sureDel);
		}
	}

	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/art/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert("删除成功");
				window.location.href = '${ctx}/art';
			} else {
				window.parent.showAlert("删除失败");
			}
		});
	}
</script>
<body>
	<form action="${ctx}/art/delete" id="deleteForm"
		style="display: none;" method="post"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/zh.png"
					style="vertical-align: text-bottom;" /> 活动页面管理
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
			<form class="form-search" action="${ctx}/art">
				<table style="width: 100%">
					<tr>
						<td><label class="control-label" style="float: left">活动名称：</label>
							<input type="text" id="title" name="search_LIKE_title"
							maxlength="20" style="float: left; width: 40%;"value="<%=title%>"></td>
						<td>
							<button type="submit" class="btn blue" id="search_btn"
								style="margin-left: 50px;">查询</button>&nbsp;&nbsp;
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
				<a href="javascript:;">&nbsp;</a> <a href="${ctx}/art/create"
					class="btn blue"> 新增</a> <a href="javascript:;" class="btn red"
					onclick="deleteCommunity()"> 批量删除</a>
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
						<th style="width: 3%;"><input type="checkbox" id="check_all"
							value="" class="check_all"></th>
						<th style="width: 7%;">序号</th>
						<th style="width: 10%;">活动标题</th>
						<th style="width: 40%">活动详情(点击链接可查看)</th>
						<th style="width: 20%;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${articles.content}" var="article"
						varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item"
								class="check_item" value="${article.id}"></td>
							<td>${status.count}</td>
							<td>${article.title}</td>
							<td><a href="${ctx}/shake/viewactivitydetail?artid=${article.id}" target="_blank">点击查看</a></td>
							<td><a href="${ctx}/art/update/${article.id}">编辑</a></td>
						</tr>
					</c:forEach>
					<c:if test="${articles.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${articles}" paginationSize="5" />
		</div>
	</div>
</body>
</html>