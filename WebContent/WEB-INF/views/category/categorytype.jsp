<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>字典管理</title>
	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<%@ include file="../quote.jsp"%>

</head>
<style type="text/css">
#contentTable td{
WORD-WRAP: break-word;
}
</style>
<script type="text/javascript">
$(function(){
	init_checkbox('.check_all','.check_item');
})
function resetAll() {
	$("#value").val('');
}
function deleteCategoty() {
	var ids=getIds('.check_item');
	if(ids.length == 0) {
		parent.window.showAlert("请选择一条记录！");
		return;
	}
	parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
}

function sureDel() {
	var ids=getIds('.check_item');
	 $.post('${ctx}/system/categorytype/delete',{"ids":ids},function(data){
		if(data.result){
			window.parent.showAlert("删除成功");
			window.location.href = '${ctx}/system/categorytype';
		}else{
			window.parent.showAlert("删除失败");
		}
	}); 
}
function show_add(){
	$("#id").val('');
	$("#categoryvalue").val('');
	$("#form_categorytype").modal('show');
}
function show_edit(id,value){
	$("#categoryvalue").val(value);
	$("#id").val(id);
	$("#form_categorytype").modal('show');
}
function Check_Submit(){
	var id=$("#id").val();
	var value=$("#categoryvalue").val();
	if($.trim(value).length == 0) {
		window.parent.showAlert("字典项名称不能为空！");
		return false;
	}
	var url='${ctx}/system/categorytype/checkcategorytype';
	$.post(url,{"id":id,"value":value},function(data){
		if(data.result){
			$("#inputForm").submit();
		}else{
			window.parent.showAlert(data.msg);
			$("#categoryvalue").val(value);
			return false;
		}
	});
}
</script>
<body>
<!-- BEGIN PAGE HEADER-->
<!-- 内容页 固定头部 -->
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				字典项管理
			</h3>
		</div>
	</div>
<!-- END PAGE HEADER-->

	<div class="portlet box grey" style="margin-bottom:0px;height:auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/system/categorytype" method="post">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">字典项：</label> 
				<input type="text" id="value" name="search_LIKE_value" maxlength="20" style="float:left;width: 60%;height: 32px;" class="" value="${LIKE_value }"> 
				</td>
				<td>
					<button type="submit" class="btn blue" id="search_btn" >查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
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
				<a href="javascript:;" class="btn blue" onclick="show_add()"><i class=""></i> 新增</a> 
				<a href="javascript:;" class="btn red" onclick="deleteCategoty()"><i class=""></i>删除</a> 
			</div>
		</div>
		<div class="portlet-body">
		<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close"></button>
					${message}
				</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead><tr><th style="width: 2%"><input type="checkbox" id="check_all" value="" class="check_all"></th><th>序号</th><th>字典项</th><th>变更人</th><th>变更时间</th><th>管理</th></tr></thead>
				<tbody>
				<c:if test="${categorytypes.totalPages!=0}">
						<c:forEach items="${categorytypes.content}" var="category" varStatus="status">
					<tr>
						<td><input type="checkbox" id="check_item" value="${category.id}" class="check_item"></td>
						<td>${status.count}</td>
						<td>${category.value}</td>
						<td>${category.user.realname}</td>
						<td>${fn:substring(category.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${category.id}','${category.value}')">修改</a>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				<c:if test="${categorytypes.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${categorytypes}" paginationSize="5"/>
		</div>
	</div>
	<div class="modal hide fade" id="form_categorytype" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel"><span id="form_title">
			<img src="${ctx}/static/images/xtgl.png" style="vertical-align: baseline;" /> 
				<a href="${ctx}/system/categorytype">字典项管理</a>&nbsp;<i class="icon-angle-right"></i>
				新增/修改字典项</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<form action="${ctx}/system/categorytype/create" method="post" id="inputForm"  class="form-horizontal">
			<div class="control-group">
				<label class="control-label">字典项:</label>
				<div class="controls">
					<input type="text" id="categoryvalue"  name="value"  maxlength="20" style="width:60% ;height: 32px" 
						class="title required" />
					<input type="hidden" id="id" name="id" value="">
				</div>
			</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()"
					value="保存" />&nbsp; 
			<!--	<a class="btn green" onclick="">保存</a>-->
			<!-- <a class="btn" onclick="closeLonding()">取消</a> -->
		</div>
		</form>
		</div>
	</div>
</body>
</html>
