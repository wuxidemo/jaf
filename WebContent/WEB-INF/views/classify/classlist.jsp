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
    <title>类别管理</title>
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
/* 重置 */
function resetAll() {
	$("#search_name").val('');
}

/* 选中*/
/* function checkbox(obj,value){
	    alert(value);
		if (obj.checked == true) {
			$.post('${ctx}/classify/checkbox',{"id":value},function(data){
				if(!data.result){
					for(var i=0;i<data.ids.length;i++){
						var ids=data.ids.get(i);
						var el = document.getElementsByTagName('input');
					}
					window.parent.showAlert("删除成功");
					window.location.href = '${ctx}/classify';
				}
			});
		}
} */

/* 删除*/
function deleteClassify() {
	var ids=getIds('.check_item');
	if(ids.length == 0) {
		parent.window.showAlert("请选择一条记录！");
		return;
	}else{
		$.post('${ctx}/classify/checkbox',{"ids":ids},function(data){
			if(data.result){
				parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
			}else{
				/* for(var i=0;i<data.list.length;i++){
					alert(data.list[i].id);
					$("#check_item")[data.list[i].id].checked = true;
					$("#check_item").val(data.list[i].id);
				} */
				parent.window.showConfirm("确定要将选中的数据及子类全部删除吗?",sureDel);
			}
		});
	}
}

function sureDel() {
	var ids=getIds('.check_item');
	 $.post('${ctx}/classify/delete',{"ids":ids},function(data){
		if(data.result){
			window.parent.showAlert("删除成功");
			window.location.href = '${ctx}/classify';
		}else{
			window.parent.showAlert("删除失败");
		}
	}); 
}
/* 新增 */
function show_add(pid){
	$("#id").val('');
	$("#classifyname").val('');
	$("#form_classify").modal('show');
	$("#pid").val(pid);
	$("#pid").removeAttr("disabled");
	$("#fclassify").show();
}
/* 修改 */
function show_edit(id,name,fname,fid){
	if(fname==''){
		$("#pid").val('');
		$("#fclassify").hide();
		/* $("#pid").attr('disabled',"true");  */
	}else{
		$("#fclassify").show();
	    $("#pid").val(fid);
	}
	$("#classifyname").val(name);
	$("#id").val(id);
	$("#form_classify").modal('show');
}
function Check_Submit(){
	var id=$("#id").val();
	var name=$("#classifyname").val();
	/* var reg = /^\w{0,20}$/;测试是否为小于20个字符的正则表达式  */
	if($.trim(name).length == 0) {
		window.parent.showAlert("类别名称不能为空！");
		return false;
	}else if(name.length>10){
		window.parent.showAlert("类别名称过大，应小于10位数！");
		return false;
	}
	var url='${ctx}/classify/checkclassify';
	$.post(url,{"id":id,"name":name},function(data){
		if(data.result){
			$("#inputForm").submit();
		}else{
			window.parent.showAlert(data.msg);
			$("#classifyname").val(name);
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
				类别管理
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
			<form class="form-search" action="${ctx}/classify" method="post">
			<table style="width: 100%">
			<tr>
				<td>
				<label class="control-label" style="float:left">类别名称：</label> 
                <input type="text" id="search_name" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%;height: 32px;" class="" value="${LIKE_name }"> 
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
				<a href="javascript:;" class="btn blue" onclick="show_add('')"><i class=""></i> 新增</a> 
				<a href="javascript:;" class="btn red" onclick="deleteClassify()"><i class=""></i>删除</a> 
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
				<thead><tr>
				<th style="width: 2%"><input type="checkbox" id="check_all" value="" class="check_all"></th>
				<th>序号</th><th>类别名称</th><th>父类别名称</th><th>变更人</th><th>变更时间</th><th>管理</th></tr></thead>
				<tbody>
<%-- 				<c:if test="${classify.totalPages!=0}">
					<c:forEach items="${classify.content}" var="classify" varStatus="status">
				    <c:if test="${classify.pid==null}">
					<tr>
						<td><input type="checkbox" id="check_item" value="${classify.id}" class="check_item"></td>
						<td>${status.count}</td>
						<td>${classify.name}</td>
						<td>&nbsp;</td>
						<td>${classify.user.realname}</td>
						<td>${fn:substring(classify.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${classify.id}','${classify.name}')">修改</a>
						<a href="javascript:;" onclick="show_edit1('${classify.name}','${classify.id}')">添加子项</a>
						</td>
					</tr>
					
					<c:forEach items="${requestScope['classifys']}"  var="classifys" varStatus="statuss">
				    <c:if test="${classify.id==classifys.pid&&classifys.pid!=null}">
					<tr>
						<td><input type="checkbox" id="check_item" value="${classifys.id}" class="check_item"></td>
						<td>&nbsp;</td>
						<td>${classifys.name}</td>
						<td>${classify.name}</td>
						<td>${classifys.user.realname}</td>
						<td>${fn:substring(classifys.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${classifys.id}','${classifys.name}')">修改</a>
						</td>
					</tr>
				    </c:if>
					</c:forEach>
					
				    </c:if>
					</c:forEach>
				</c:if>
				<c:if test="${classify.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
				</c:if> --%>
				
				<c:if test="${fn:length(classify)!=0}">
					<c:forEach items="${classify}" var="classify" varStatus="status">
				    <c:if test="${classify.pid==null}">
					<tr>
						<td><input type="checkbox" id="check_item" value="${classify.id}" class="check_item" onchange="checkbox(this,${classify.id})"></td>
						<td>${status.count}</td>
						<td>${classify.name}</td>
						<td>&nbsp;</td>
						<td>${classify.user.realname}</td>
						<td>${fn:substring(classify.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${classify.id}','${classify.name}','','')">修改</a>
						<a href="javascript:;" onclick="show_add('${classify.id}')">添加子项</a>
						</td>
					</tr>
					
					<c:forEach items="${classifys}"  var="classifys" varStatus="statuss">
				    <c:if test="${classify.id==classifys.pid&&classifys.pid!=null}">
					<tr>
						<td><input type="checkbox" id="check_item" value="${classifys.id}" class="check_item"></td>
						<td>&nbsp;</td>
						<td>${classifys.name}</td>
						<td>${classify.name}</td>
						<td>${classifys.user.realname}</td>
						<td>${fn:substring(classifys.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${classifys.id}','${classifys.name}','${classify.name}','${classify.id}')">修改</a>
						</td>
					</tr>
				    </c:if>
					</c:forEach>
					
				    </c:if>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(classify)==0}">
						<tr class="odd gradeX">
						<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
				</c:if> 
				
				</tbody>
			</table>
<%-- 			<tags:pagination page="${classify}" paginationSize="5"/> --%>
		</div>
	</div>
	<!-- 弹出窗口 -->
		<div class="modal hide fade" id="form_classify" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel"><span id="form_title">
			<img src="${ctx}/static/images/xtgl.png" style="vertical-align: baseline;" /> 
				<a href="${ctx}/system/categorytype">类别管理</a>&nbsp;<i class="icon-angle-right"></i>
				新增/修改类别</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<form action="${ctx}/classify/create" method="post" id="inputForm"  class="form-horizontal">
			<div class="control-group" id="fclassify">
				<label class="control-label">父类名称:</label>
				<div class="controls"> 
					<select id="pid" name="pid" class="sel_category" style="float:left;width: 60%;height: 32px;">
					        <option value="">--默认父类--</option>
							<c:if test="${fn:length(classify1)!=0}"> 
							      <c:forEach items="${classify1}" var="classify1" varStatus="status">
							      <c:if test="${classify1.pid==null}">
							      <option  value="${classify1.id}">${classify1.name}</option> 
							      </c:if>         
							      </c:forEach>
				            </c:if>
				    </select>	
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">类别名称:</label>
				<div class="controls">
					<input type="text" id="classifyname"  name="name"  maxlength="20" style="width:60% ;height: 32px" 
						class="title required" />
					<input type="hidden" id="id" name="id" value="">
				</div>
			</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()"
					value="保存" />&nbsp;
		</div>
		</form>
		</div>
	</div>
</body>
</html>