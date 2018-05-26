<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>菜单资源管理</title>
	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
function resetAll() {
	$("#resourceName").val("");
	$("#selectSubResource").val("0");
	$("#resourceName").focus();
}

var idTemp = '';
function askfordelete(id) {
	idTemp = id;
	parent.window.showConfirm("你确定要删除该资源?",sureDel);
}

function sureDel() {
	$.post('${ctx}/system/resource/delete'+'/'+idTemp,function(){
		window.location.href = '${ctx}/system/resource';
	});
} 

</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				资源管理
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
			<form class="form-search" action="${ctx}/system/resource">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">菜单资源名称：</label> 
					<input type="text" id="resourceName" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%;" class="" value="${LIKE_name }"> 
				</td>
				<td>
					<label class="control-label" style="float:left">选择父菜单资源：</label> 
					<select class="" id="selectSubResource" style="width:60%;" name="search_EQ_resource.id">
						<c:choose>
							<c:when test="${EQ_resource_id == '0'}">
								<option value="0" selected="selected">--选择父菜单资源--</option>
							</c:when>
							<c:otherwise>
								<option value="0">--选择父菜单资源--</option>
							</c:otherwise>
						</c:choose>
						<c:forEach items="${subResoucesList}" var="subresource">
							<c:choose>
								<c:when test="${subresource.id == resourceId}">
									<option selected="selected" value="${subresource.id}">${subresource.name}</option>
								</c:when>
								<c:otherwise>
									<option value="${subresource.id}">${subresource.name}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 
				</td>
				<td>
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:70px;">查询</button>&nbsp;&nbsp;
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
				<a href="${ctx}/system/resource/create" class="btn blue"><i class="icon-plus"></i> 新增</a> 
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>菜单资源名称</th>
						<th>资源访问链接</th>
						<th>父菜单名称</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${Resources.totalPages!=0}">
					<c:forEach items="${Resources.content}" var="resource" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td><c:if test="${resource.name != null}">${resource.name}</c:if> &nbsp;</td>
							<td><c:if test="${resource.url != null}"><%-- <a href="javascript:;" onclick="window.open('${ctx}${resource.url}')"> --%>${resource.url}<!-- </a> --></c:if> &nbsp;</td>
							<td><c:if test="${resource.resource.name != null}">${resource.resource.name}</c:if> &nbsp;</td>
							<td><c:if test="${resource.createtime != null}">${fn:substring(resource.createtime,0,19)}</c:if> &nbsp;</td>
							<td>
								<a href="${ctx}/system/resource/update/${resource.id}">修改</a>&nbsp;
								<a href="javascript:;" onclick="askfordelete(${resource.id})">删除</a>&nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${Resources.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${Resources}" paginationSize="5"/>
		</div>
	</div>
</body>
</html>
