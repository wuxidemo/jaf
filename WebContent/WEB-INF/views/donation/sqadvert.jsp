<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>义仓广告轮播图管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	$(document).ready(function(){
		init_checkbox('.check_all','.check_item');
	});

	var idTemp = '';
	function askfordelete(id) {
		idTemp = id;
		parent.window.showConfirm("你确定要删除该广告吗?",sureDel);
	}
	
	function askfordelbath(){
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		idTemp = ids;
		parent.window.showConfirm("确定要将选中的数据删除吗?", sureDel);
	}
	
	function sureDel() {
		$("#deleteForm").empty();
		$("#deleteForm").append('<input name="delids" value="'+idTemp+'" />');
		$("#deleteForm").submit();
	}
	
	function resetAll() {
		$("#community").val("-1");
	}
</script>
<body>
	<form action="${ctx}/sqadvert/delete" id="deleteForm" method="post" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				社区广告轮播图管理
			</h3>
		</div>
	</div>
	
	<div class="portlet box grey" style="margin-bottom:0px;height:auto; <c:if test="${commuser == 1}">display:none;</c:if> ">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/sqadvert" method="post">
			<table style="width: 100%">
				<tr>
					<td style="width:33%;">
						<label class="control-label" style="float:left">社区：</label> 
						<select id="community" style="width:60%; height: 32px;" name="search_EQ_community.id">
							<c:choose>
								<c:when test="${EQ_community_id == '-1'}">
									<option value="-1" selected="selected">--选择社区--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择社区--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${communitys}" var="community">
								<c:choose>
									<c:when test="${community.id == EQ_community_id}">
										<option selected="selected" value="${community.id}">${community.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${community.id}">${community.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td style="width:33%;">
						<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
						<button type="button" class="btn" id="reset_btn" onclick="resetAll()">重置</button>
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
				<a href="javascript:;">&nbsp;</a> 
				<c:if test="${commuser == 1}">
					<a href="${ctx}/sqadvert/create" class="btn blue"> 新增</a> 
				</c:if>
				<a href="javascript:;" class="btn red" onclick="askfordelbath()"> 删除</a> 
				
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
						<th>序号</th>
						<th>标题</th>
						<th>类型</th>
						<c:if test="${commuser == 0 }"><th>社区</th></c:if>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${sqadverts.totalPages!=0}">
					<c:forEach items="${sqadverts.content}" var="sqadvert" varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item" value="${sqadvert.id}" class="check_item"></td>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${sqadvert.title != null}">${sqadvert.title}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:if test="${sqadvert.type == 1}">图文</c:if> 
								<c:if test="${sqadvert.type == 2}">URL</c:if> 
							</td>
							<c:if test="${commuser == 0 }">
								<td>${sqadvert.community.name}</td>
							</c:if>
							<td style="vertical-align: middle;">
								<a href="${ctx}/sqadvert/view/${sqadvert.id}" >查看</a>&nbsp;
								<c:if test="${commuser == 1}">
									<a href="${ctx}/sqadvert/update/${sqadvert.id}" >编辑</a>&nbsp;
								</c:if>
								<a href="javascript:;" onclick="askfordelete('${sqadvert.id}')">删除</a>&nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${sqadverts.totalPages==0}">
						<tr class="odd gradeX">
							<c:if test="${commuser == 1}">
								<td colspan="5" style="text-align: center;">无记录</td>
							</c:if>
							<c:if test="${commuser == 0}">
								<td colspan="6" style="text-align: center;">无记录</td>
							</c:if>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${sqadverts}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>