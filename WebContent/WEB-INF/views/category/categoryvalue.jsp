<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%String cvalue=""; 
if(request.getParameter("search_EQ_categoryType.id")!=null)
	cvalue=new String (request.getParameter("search_EQ_categoryType.id").getBytes("ISO-8859-1"),"UTF-8");
%>

<html>
<head>
	<title>字典值管理</title>
	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
function resetAll() {
	$("#value").val('');
	$("#sel_category").val("-1");
}
$(function(){
	init_checkbox('.check_all','.check_item');
});
function deleteCategotyValue() {
	var ids=getIds('.check_item');
	if(ids.length == 0) {
		parent.window.showAlert("请选择一条记录！");
		return;
	}
	parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
}

function sureDel() {
	var ids=getIds('.check_item');
	 $.post('${ctx}/system/categorytypevalue/delete',{"ids":ids},function(data){
		if(data.result){
			window.parent.showAlert("删除成功");
			window.location.href = '${ctx}/system/categoryvalue';
		}else{
			window.parent.showAlert("删除失败");
		}
	}); 
}
$(function(){
		var url='${ctx}/system/getcategorytype';
		$.post(url,function(data){
			if(data.result){
				$(".sel_category").empty();
				var html='	<option value="-1">--请选择--</option>';
				for(var i=0;i<data.obj.length;i++){
					html+='<option value="'+data.obj[i].id+'">'+data.obj[i].value+'</option>';
				}
				$("#sel_category").html(html);
				$("#sel_category1").html(html);
				var value='<%=cvalue %>';
				if(value!=''){
					$("#sel_category").val(value);
				}
			}else{
				window.parent.showAlert("数据异常");
			}
		});
	$("#sel_category").on("change",function(){
		$("#cid").val($("#sel_category").val());
	});	
	$("#sel_category1").on("change",function(){
		$("#ctypeid").val($("#sel_category1").val());
	});
});
function show_add(){
	$("#id").val('');
	$("#categoryvalue").val('');
	$("#sel_category1").val('-1');
	$("#cid_category").show();
	$("#pid_category").hide();
	$("#pid").val(0);
	$("#sel_category1").removeAttr("disabled");
	$("#ctypeid").val('-1');
	$("#form_categorytype").modal('show');
}
function show_edit(id,value,cid,pid,cvalue,type){
	if(type==1){
		$("#pid_category").show();
		$("#cid_category").hide();
		$("#pid").val(id);
		$("#ctypeid").val(cid);
		$("#categoryvalue").val('');
		$("#form_categorytype").modal('show');
		$("#id").val('');
		$("#pcategory").val(value);
	}else{
		$("#cid_category").show();
		$("#pid_category").hide();
		$("#categoryvalue").val(value);
		$("#id").val(id);
		$("#sel_category1").val(cid);
		$("#sel_category1").attr({"disabled":"disabled"});
		$("#ctypeid").val(cid);
		$("#pid").val(pid);
		$("#form_categorytype").modal('show');
	}
	
}
function Check_Submit(){
	var id=$("#id").val();
	var value=$("#categoryvalue").val();
	var cid=$("#ctypeid").val();
	if($.trim(value).length==0){
		window.parent.showAlert("请输入字典值");
		return false;
	}
	if(cid=='-1'){
		window.parent.showAlert("请选择字典项");
		return false;
	}
	var url='${ctx}/system/categoryvalue/checkcategoryvalue';
	$.post(url,{"id":id,"value":value,"cid":cid},function(data){
		if(data.result){
			$("#inputForm").submit();
		}else{
			window.parent.showAlert(data.msg);
			$("#categoryvalue").val(value);
			return false;
		}
	});
}
function show_List(id,cvalue,ctype){
	var url='${ctx}/system/categoryvalue/getList';
	$.post(url,{"pid":id},function(data){
		if(data.result){
		var html='';
		$("#tbody").children().remove();
		var length=data.obj.length;
		var category=data.obj;
		for(var i=0;i<length;i++){
			html+='<tr>';
			html+='<td>'+(i+1)+'</td>';
			html+='<td>'+category[i].value+'&nbsp;</td>';
			html+='<td>'+cvalue+'&nbsp;</td>';	
			html+='<td>'+ctype+'&nbsp;</td>';
			html+='<td>'+category[i].user.name+'&nbsp;</td>';
			html+='<td>'+getLocalTime(category[i].createtime)+'&nbsp;</td>';
			html+='</tr>';
		}
		$("#tbody").append(html);
		$("#form_list").modal('show');
		}else{
			window.parent.showAlert(data.msg);
		}
	});
}
</script>
<style type="text/css">
#contentTable td{
WORD-WRAP: break-word;
}
</style>
<body>
<!-- BEGIN PAGE HEADER-->
<!-- 内容页 固定头部 -->
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				字典值管理
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
			<form class="form-search" action="${ctx}/system/categoryvalue" method="post">
			<table style="width: 100%">
			<tr>
			<td>
				<label class="control-label" style="float:left">字典值：</label> 
				<input type="text" id="value" name="search_LIKE_value" maxlength="20" style="float:left;width: 60%;height: 32px;" class="" value="${LIKE_value }"> 
				</td>
				<td>
				<label class="control-label" style="float:left">字典项：</label> 
				<select id="sel_category" class="sel_category" style="float:left;width: 60%;height: 32px;">
				<option value="-1">--请选择--</option>
				</select>
				 <input type="hidden" id="cid" name="search_EQ_categoryType.id" value="-1"  >
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
				<div class="actions">
				<a href="javascript:;" class="btn blue" onclick="show_add(0)"><i class=""></i> 新增</a> 
				<a href="javascript:;" class="btn red" onclick="deleteCategotyValue()"><i class=""></i>删除</a> 
			</div>
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
				<thead><tr><th style="width: 2%"><input type="checkbox" id="check_all" value="" class="check_all"></th><th>序号</th><th>字典值</th><th>父字典</th><th>字典项</th><th>变更人</th><th>变更时间</th><th>管理</th></tr></thead>
				<tbody>
				<c:if test="${categoryvalues.totalPages!=0}">
						<c:forEach items="${categoryvalues.content}" var="category" varStatus="status">
					<tr>
					<td><input type="checkbox" id="check_item" value="${category.id}" class="check_item"></td>
						<td>${status.count}&nbsp;</td>
						<td>${category.value}&nbsp;</td>
						<td>
						<c:if test="${category.categoryValue!=null}">
						${category.categoryValue.value}
						</c:if>
						&nbsp;</td>
						<td>${category.categoryType.value}&nbsp;</td>
						<td>${category.user.realname}&nbsp;</td>
						<td>${fn:substring(category.createtime, 0, 16)}&nbsp;</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${category.id}','${category.value}','${category.categoryType.id}','${category.categoryValue.id}','${category.categoryValue.value}')">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:;" onclick="show_edit('${category.id}','${category.value}','${category.categoryType.id}','${category.categoryValue.id}','${category.categoryValue.value}',1)">添加子项</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:;" onclick="show_List('${category.id}','${category.categoryValue.value}','${category.categoryType.value}')">查看子项</a>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				<c:if test="${categoryvalues.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${categoryvalues}" paginationSize="5"/>
		</div>
	</div>
	<div class="modal hide fade" id="form_categorytype" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel"><span id="form_title">
			<img src="${ctx}/static/images/xtgl.png" style="vertical-align: baseline;" /> 
				<a href="${ctx}/system/categoryvalue">字典值管理</a>&nbsp;<i class="icon-angle-right"></i>
				新增/修改字典值</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<form action="${ctx}/system/categoryvalue/create" method="post" id="inputForm"  class="form-horizontal">
			<div class="control-group hide" id="cid_category">
				<label class="control-label">字典项:</label>
				<div class="controls">
						<select id="sel_category1" class="sel_category" style="float:left;width: 60%;height: 32px;">
							<option value="-1">--请选择--</option>
				</select>
				</div>
			</div>
			<div class="control-group hide" id="pid_category">
				<label class="control-label">父字典:</label>
				<div class="controls">
						<input type="text" id="pcategory"  name="pcategory"  readonly="readonly" maxlength="20" style="width:60% ;height: 32px" 
						class="title required" />
						<input type="hidden" id="pid" name="pid" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">字典值:</label>
				<div class="controls">
					<input type="text" id="categoryvalue"  name="value"  maxlength="8" style="width:60% ;height: 32px" 
						class="title required" />
					<input type="hidden" id="id" name="id" value="">
					<input type="hidden" id="ctypeid" name="categoryType.id" value="">
				</div>
			</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()"
					value="保存" />&nbsp; 
			<!--<a class="btn green" onclick="">保存</a>-->
			<!-- <a class="btn" onclick="closeLonding()">取消</a> -->
		</div>
		</form>
		</div>
	</div>
	<div class="modal hide fade" id="form_list" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel"><span id="form_title">查看子字典项</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
				<tr><th>序号</th><th>字典值</th><th>父字典</th><th>字典项</th><th>创建者</th><th>创建时间</th></tr></thead>
				<tbody id="tbody">
				</tbody>
			</table>
			</div>
			</div>
	</div>
</body>
</html>
