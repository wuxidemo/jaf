<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>角色管理</title>
	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
	var idTemp = '';
	var cPage = '';
	function askfordelete(id,cpage) {
		idTemp = id;
		cPage = cpage;
		parent.window.showConfirm("你确定要删除该角色吗?",sureDel);
	}
	
	function sureDel() {
		$("#deleteForm").attr("action","${ctx}/system/role/delete/"+idTemp);
		$("#deleteForm").append("<input name='page' value="+cPage+" >");
		$("#deleteForm").submit();
	}
	
	function resetAll() {
		$("#userName").val("");
	}
</script>
<body>
	<form action="" id="deleteForm" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				角色管理
			</h3>
		</div>
	</div>

	 <div class="portlet box grey" style="margin-bottom:0px;height:auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/system/role" method="post">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">角色名称：</label> 
					<input type="text" id="userName" name="search_LIKE_name" maxlength="20" style="float:left;width: 40%; height: 32px;" class="" value="${LIKE_name }"> 
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
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
				<a href="${ctx}/system/role/create" class="btn blue"> 新增</a> 
				<%-- <a href="${ctx}/system/role/allocate" class="btn red"><i class="icon-plus"></i> 分配</a> --%> 
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
						<th>角色名称</th>
						<th>角色描述</th>
						<th>角色管理</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${Roles.totalPages!=0}">
					<c:forEach items="${Roles.content}" var="role" varStatus="status">
						<tr>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${role.name != null}">${role.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${role.roledesc != null}">${role.roledesc}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:if test="${role.name == 'admin'}">
									<%-- <a href="${ctx}/system/role/updateResources/${role.id}" >修改权限</a>&nbsp; --%>
									<a href="${ctx}/system/role/treeview/${role.id}?page=${Roles.number+1}" >修改权限</a>&nbsp;
								</c:if>
								<c:if test="${role.name != 'admin'}">
									<%-- <a  href="${ctx}/system/role/updateResources/${role.id}" >修改权限</a>&nbsp; --%>
									<a href="${ctx}/system/role/treeview/${role.id}?page=${Roles.number+1}" >修改权限</a>&nbsp;
									<a href="javascript:;" onclick="askfordelete('${role.id}','${Roles.number+1}')">删除</a>&nbsp;
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${Roles.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="3" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${Roles}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>