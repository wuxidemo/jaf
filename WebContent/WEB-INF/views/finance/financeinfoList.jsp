<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>金融信息管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	$(document).ready(function(){
		init_checkbox('.check_all','.check_item');
	});
	
	var oneid = '';
	function delone(fid) {
		$("#deleteForm").empty();
		oneid = fid;
		window.parent.showConfirm("你确定要删除该条信息吗？",sureDelOne);
	}
	
	function sureDelOne() {
		$("#deleteForm").append('<input name="ids" value="'+oneid+'" />');
		$("#deleteForm").submit();
	}
	
	function delbatch() {
		$("#deleteForm").empty();
		var delstr = '';
		$(".check_item").each(function(){
			if($(this).attr("checked") == 'checked') {
				delstr += "," + $(this).val(); 
			}
		});
		if(delstr == '') {
			window.parent.showAlert("请选择一条要删除的信息");
			return;
		}
		
		window.parent.showConfirm("你确定要删除所选择的信息吗？",sureDel);
	}
	
	function sureDel() {
		var suredelstr = '';
		$(".check_item").each(function(){
			if($(this).attr("checked") == 'checked') {
				suredelstr += "," + $(this).val(); 
			}
		});
		suredelstr = suredelstr.substring(1,suredelstr.length);
		$("#deleteForm").append('<input name="ids" value="'+suredelstr+'" />');
		$("#deleteForm").submit();
	}
	
</script>
<body>
	<form action="${ctx}/financeinfo/delete/${finance.id}" id="deleteForm" style="display: none;" method="post"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				金融信息管理
			</h3>
		</div>
	</div>

	 <%-- <div class="portlet box grey" style="margin-bottom:0px;height:auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/merchant">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">名称：</label> 
					<input type="text" id="name" name="search_LIKE_name" maxlength="20" style="float:left;width: 40%;" value="${LIKE_name }"> 
				</td>
				<td>
					<label class="control-label" style="float:left">标签：</label> 
					<select id="category" style="width:60%; height: 32px;" name="search_EQ_category">
						<c:choose>
							<c:when test="${EQ_category == '-1'}">
								<option value="-1" selected="selected">--选择商家标签--</option>
							</c:when>
							<c:otherwise>
								<option value="-1">--选择商家标签--</option>
							</c:otherwise>
						</c:choose>
						<c:forEach items="${category}" var="category">
							<c:choose>
								<c:when test="${category.id == EQ_category}">
									<option selected="selected" value="${category.id}">${category.value}</option>
								</c:when>
								<c:otherwise>
									<option value="${category.id}">${category.value}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<td>
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
					<button type="button" class="btn" id="reset_btn" onclick="resetAll()">重置</button>
				</td>
				</tr>
				
			</table>
		    </form>
	    </div>
    </div> --%>
    
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/financeinfo/create" class="btn blue" >新增</a>
				<a href="javascript:;" class="btn red" onclick="delbatch()">批量删除</a>
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
						<th style="width: 50%;">标题</th>
						<th style="width: 10%;">状态</th>
						<th style="width: 30%;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${finances.totalPages!=0}">
					<c:forEach items="${finances.content}" var="finance" varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item" value="${finance.id}" class="check_item"></td>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${finance.title != null}">${finance.title}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:if test="${finance.state == '0' || finance.state == null}"><span class="label label-default">未发布</span></c:if>
								<c:if test="${finance.state == '1'}"><span class="label label-success">已发布</span></c:if>
							</td>
							<td style="vertical-align: middle;">
								<a href="${ctx}/financeinfo/view/${finance.id}" >查看</a>&nbsp;
								<a href="${ctx}/financeinfo/update/${finance.id}">修改</a>&nbsp;
								<c:if test="${finance.state == '0' || finance.state == null}">
									<a href="${ctx}/financeinfo/online/${finance.id}">上线</a>&nbsp;
								</c:if>
								<c:if test="${finance.state == '1'}">
									<a href="${ctx}/financeinfo/offline/${finance.id}">下线</a>&nbsp;
								</c:if>
								<a href="JavaScript:;" onclick="delone('${finance.id}')">删除</a>&nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${finances.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${finances}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>