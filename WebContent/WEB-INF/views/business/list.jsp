<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%String district=""; 
if(request.getParameter("search_EQ_categoryValue.id")!=null)
	district=new String (request.getParameter("search_EQ_categoryValue.id").getBytes("ISO-8859-1"),"UTF-8");
%>

<html>
<head>
	<title>商圈管理</title>
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
	var url='${ctx}/system/getcategoryvalue';
	$.post(url,{"value":"商圈区域"},function(data){
		var html='';
		html+='<option value="-1">--请选择--</option>';
		$("#search_district").empty();
		$("#edit_district").empty();
		if(data.result){
			var category=data.obj;
			var length=data.obj.length;
			for(var i=0;i<length;i++){
				html+='<option value="'+category[i].id+'">'+category[i].value+'</option>';
			}
			$("#search_district").html(html);
			$("#edit_district").html(html);
			var district='<%=district%>';
			if(district!=''){
				$("#search_district").val(district);
			}
		}
	});
	
})
function resetAll() {
	$("#search_name").val('');
	$("#search_district").val('-1');
	
}
function deleteBusiness() {
	var ids=getIds('.check_item');
	if(ids.length == 0) {
		parent.window.showAlert("请选择一条记录！");
		return;
	}
	parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
}

function sureDel() {
	var ids=getIds('.check_item');
	 $.post('${ctx}/business/delete',{"ids":ids},function(data){
		if(data.result){
			window.parent.showAlert("删除成功");
			window.location.href = '${ctx}/business';
		}else{
			window.parent.showAlert("删除失败");
		}
	}); 
}
function show_add(){
	$("#id").val('');
	$("#name").val('');
	$("#edit_district").val('-1');
	$("#telephone").val('');
	$("#form_categorytype").modal('show');
}
function show_edit(id,value,cid,telephone){
	$("#id").val(id);
	$("#name").val(value);
	$("#edit_district").val(cid);
	$("#telephone").val(telephone);
	$("#form_categorytype").modal('show');
}
function Check_Submit(){
	var id=$("#id").val();
	var name=$("#name").val();
	var cid=$("#edit_district").val();
	if($.trim(name).length == 0) {
		window.parent.showAlert("商圈名称不能为空！");
		return false;
	}
	if(cid=='-1'){
		window.parent.showAlert("商圈区域不能为空！");
		return false;
	}
	var url='${ctx}/business/checkname';
	$.post(url,{"id":id,"name":name,"cid":cid},function(data){
		if(data.result){
			$("#inputForm").submit();
		}else{
			window.parent.showAlert(data.msg);
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
				商圈管理
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
			<form class="form-search" action="${ctx}/business" method="post">
			<table style="width: 100%">
			<tr>
				<td style="width: 33%;">
					<label class="control-label" style="float:left">商圈名称：</label> 
				<input type="text" id="search_name" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%;height: 32px;" class="" value="${LIKE_name }"> 
				</td>
				<td style="width: 33%;">
					<label class="control-label" style="float:left">商圈区域：</label> 
					<select id="search_district" name="search_EQ_categoryValue.id" maxlength="20" style="float:left;width: 60%;height: 32px;" class="">
						<option value="-1">--请选择--</option>
					</select> 
				</td>
				<td style="width: 33%;">
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
				<a href="javascript:;" class="btn red" onclick="deleteBusiness()"><i class=""></i>删除</a> 
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
				<thead><tr><th style="width: 2%"><input type="checkbox" id="check_all" value="" class="check_all"></th><th>序号</th><th>商圈名称</th><th>商圈区域</th><th>变更人</th><th>变更时间</th><th>管理</th></tr></thead>
				<tbody>
				<c:if test="${business.totalPages!=0}">
						<c:forEach items="${business.content}" var="b" varStatus="status">
					<tr>
						<td><input type="checkbox" id="check_item" value="${b.id}" class="check_item"></td>
						<td>${status.count}</td>
						<td>${b.name}</td>
						<td>${b.categoryValue.value}</td>
						<td>${b.user.realname}</td>
						<td>${fn:substring(b.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${b.id}','${b.name}','${b.categoryValue.id}','${b.telephone}')">修改</a>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				<c:if test="${business.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${business}" paginationSize="5"/>
		</div>
	</div>
	<div class="modal hide fade" id="form_categorytype" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">
				<span id="form_title">新增/修改商圈</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<form action="${ctx}/business/create" method="post" id="inputForm"  class="form-horizontal">
			<div class="control-group">
				<label class="control-label">商圈名称:</label>
				<div class="controls">
					<input type="text" id="name"  name="name"  maxlength="20" style="width:60% ;height: 32px" 
						class="title required" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">商圈区域:</label>
				<div class="controls">
					<select id="edit_district" name="categoryValue.id"  style="float:left;width: 60%;height: 32px;" class="">
						<option value="-1">--请选择--</option>
					</select> 
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">联系方式:</label>
				<div class="controls">
					<input type="text" id="telephone"  name="telephone"  maxlength="12" style="width:60% ;height: 32px" 
						class="title required" />
					<input type="hidden" id="id" name="id" value="">
				</div>
			</div>
		</form>
		</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()"
					value="保存" />&nbsp; 
			<!--	<a class="btn green" onclick="">保存</a>-->
			<!-- <a class="btn" onclick="closeLonding()">取消</a> -->
		</div>
	</div>
</body>
</html>
