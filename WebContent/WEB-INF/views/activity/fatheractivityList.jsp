<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>父活动管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	$(document).ready(function(){
		init_checkbox('.check_all','.check_item');
	});
	
	function askfordelete() {
		$("#deleteForm").empty();
		var delstr = '';
		$(".check_item").each(function(){
			if($(this).attr("checked") == 'checked') {
				delstr += "," + $(this).val(); 
			}
		});
		if(delstr == '') {
			window.parent.showAlert("请选择一条要删除的活动");
			return;
		}
		
		window.parent.showConfirm("你确定要删除所选择的活动吗？",sureDel);
	}
	
	function sureDel() {
		var suredelstr = '';
		$(".check_item").each(function(){
			if($(this).attr("checked") == 'checked') {
				suredelstr += "," + $(this).val(); 
			}
		});
		suredelstr = suredelstr.substring(1,suredelstr.length);
		$("#deleteForm").append('<input name="delstr" value="'+suredelstr+'" />');
		$("#deleteForm").submit();
	}
	
	
</script>
<body>
	<form action="${ctx}/fatheractivity/delete" id="deleteForm" style="display: none;" method="post"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				优惠活动管理
			</h3>
		</div>
	</div>

    
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/fatheractivity/create" class="btn blue">新增</a>
				<a href="javascript:;" class="btn red" onclick="askfordelete()">删除</a>
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
						<th style="width: 3%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 7%;">序号</th>
						<th style="width: 20%;">父活动</th>
						<th style="width: 60%;">选择子活动</th>
						<th style="width: 10%;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fatheractivitys.totalPages!=0}">
					<c:forEach items="${fatheractivitys.content}" var="fatheractivity" varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item" value="${fatheractivity[0]}" class="check_item"></td>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;">${fatheractivity[1]}</td>
							<td style="vertical-align: middle;">${fatheractivity[3]}</td>
							<td style="vertical-align: middle;">
								<a href="${ctx}/fatheractivity/update/${fatheractivity[0]}">修改</a>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${fatheractivitys.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="5" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${fatheractivitys}" paginationSize="5"/>
		</div> 
	</div>

	
</body>
</html>