<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>商家管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	$(document).ready(function(){
		init_checkbox('.check_all','.check_item');
	});
	
	function resetAll() {
		$("#name").val("");
		$("#category").val("-1");
	}

	function deleteMerchant() {
		var ids=getIds('.check_item');
		if(ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
	}

	function sureDel() {
		var ids=getIds('.check_item');
		$("#deleteForm").append('<input name="ids" value="'+ids+'" />');
		$("#deleteForm").submit();
	}
	
	var merid2 = "";
	function askfordelete(merid) {
		merid2 = merid;
		parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel2);
	}
	
	function sureDel2() {
		$("#deleteForm").append('<input name="ids" value="'+merid2+'" />');
		$("#deleteForm").submit();
	}
	
</script>
<body>
	<form action="${ctx}/merchant/delete" id="deleteForm" style="display: none;" method="post"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				商家管理
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
			<form class="form-search" action="${ctx}/jsy">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">名称：</label> 
					<input type="text" id="name" name="search_LIKE_name" maxlength="20" style="float:left;width: 40%;" value="${LIKE_name }"> 
				</td>
				<td>
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
						<th style="width: 10%;">姓名</th>
						<th style="width: 15%;">电话</th>
						<th style="width: 10%;">推荐人姓名</th>
						<th style="width: 15%;">推荐人电话</th>
						<th style="width: 15%;">申请时间</th>
						<th style="width: 10%;">状态</th>
						<th style="width: 15%;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${jsys.totalPages!=0}">
					<c:forEach items="${jsys.content}" var="jsy" varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item" value="${jsy.id}" class="check_item"></td>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${jsy.name != null}">${jsy.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${jsy.telephone != null}">${jsy.telephone}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${jsy.referee != null}">${jsy.referee}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${jsy.refereephone != null}">${jsy.refereephone}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${jsy.createtime != null}">${fn:substring(jsy.createtime,0,19)}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:if test="${jsy.state == 0}">未联系</c:if>
								<c:if test="${jsy.state == 1}">已联系</c:if> &nbsp;
							</td>
							<td style="vertical-align: middle;">
								<c:if test="${jsy.state == 0}"><a href="${ctx}/jsy/contact?jsyid=${jsy.id}">联系</a></c:if> &nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${jsys.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${jsys}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>