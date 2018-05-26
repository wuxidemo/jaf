<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新申请用户管理</title>

<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />





<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>



</head>

<script type="text/javascript">
$(document).ready(function(){
	init_checkbox('.check_all','.check_item')});
// 	$(function() {
// 		$("#datepicker").datepicker({
// 			dateFormat : 'yyyy mm dd',
// 			rtl : App.isRTL()
// 		});})
// 		$(function() {
// 		$("#datepicker1").datepicker({
// 			dateFormat : 'yyyy mm dd',
// 			rtl : App.isRTL()
// 		});})

	

	var idTemp = '';
	function askforaccept(id) {
		idTemp = id;
		parent.window.showConfirm("你确定联系过商户么?", sureDel);
	}
	function sureDel() {
		$.post('${ctx}/system/apply/updateState' + '/' + idTemp, function() {
			window.location.href = '${ctx}/system/apply';
		});
	}
	
	function askfordelete(id) {
		idTemp = id;
		parent.window.showConfirm("你确定要删除该资源?", sureDel1);
	}
	function sureDel1() {
		$.post('${ctx}/system/apply/delete' + '/' + idTemp, function() {
			window.location.href = '${ctx}/system/apply/';
		});
	}
	function del() {
		var noticeids = "";
		$("[id=check_item]").each(function(){
			if($(this).attr("checked") == "checked") {
				noticeids+=","+ $(this).val();
			}
		});
		
		if(noticeids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		}else{
			window.parent.showConfirm("你确定要删除所选记录？",sureDel2);
		}
	}
	
	function sureDel2() {
		var noticeids = "";
		$("[id=check_item]").each(function(){
			if($(this).attr("checked") == "checked") {
				noticeids+=","+ $(this).val();
			}
		});
		var ids = noticeids.substring(1);
		$("#delForm").append('<input name="ids" value='+ids+'>');
		$("#delForm").submit();
		
		}
	
// 	function resetAll() {
// 		$("#name").val("");
// 		$("#telephone").val("");
// 		$("#state").val("0");
// 		$("#datepicker").val("");
// 		$("#datepicker1").val("");}
		
</script>


<body>
	<form action="${ctx}/system/apply/delete1/apply" id="delForm" style="display: none;"></form>

	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/hzhb.png" style="vertical-align: text-bottom;" /> 合作伙伴
			</h3>
		</div>
	</div>

	<!-- 	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;"> -->
	<!-- 		<div class="portlet-title"> -->
	<!-- 			<div class="caption"> -->
	<!-- 				<i class="icon-search"></i>查询条件 -->
	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 		<div class="portlet-body" style="padding-top: 25px;"> -->
	<%-- 			<form class="form-search" action="${ctx}/system/apply"> --%>
	<!-- 				<table style="width: 100%"> -->
	<!-- 					<tr> -->
	<!-- 						<td style="width: 33%"><label class="control-label" -->
	<!-- 							style="float: left">用户姓名：</label> <input type="text" id="name" -->
	<!-- 							name="search_LIKE_name" maxlength="20" -->
	<!-- 							style="float: left; width: 60%; height: 32px;" class="" -->
	<%-- 							value="${LIKE_name }"></td> --%>
	<!-- 						<td style="width: 33%"><label class="control-label" -->
	<!-- 							style="float: left">用户电话：</label> <input type="text" -->
	<!-- 							id="telephone" name="search_LIKE_telephone" maxlength="20" -->
	<!-- 							style="float: left; width: 60%; height: 32px;" class="" -->
	<%-- 							value="${LIKE_telephone}"></td> --%>
	<!-- 						<td style="width: 33%"><label class="control-label" -->
	<!-- 							style="float: left">审核状态：</label> <select class="" id="state" -->
	<!-- 							style="width: 60%; height: 32px;" name="search_EQ_state"> -->
	<!-- 								<option value="0">——选择状态——</option> -->
	<!-- 								<option value="1" -->
	<%-- 									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>待审核</option> --%>
	<!-- 								<option value="2" -->
	<%-- 									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>审核通过</option> --%>

	<!-- 						</select></td> -->

	<!-- 					</tr> -->
	<!-- 					<tr> -->

	<!-- 						<td style="width: 33%"><label class="control-label" -->
	<!-- 							style="float: left">开始时间：</label><input type="text" -->
	<!-- 							id="datepicker" name="search_GTE_createtime" maxlength="20" -->
	<!-- 							style="float: left; width: 60%; height: 32px;" class="" -->
	<%-- 							value="${GTE_createtime}"></td> --%>
	<!-- 							<td style="width: 33%"><label class="control-label" -->
	<!-- 							style="float: left">结束时间：</label><input type="text" -->
	<!-- 							id="datepicker1" name="search_LTE_createtime" maxlength="20" -->
	<!-- 							style="float: left; width: 60%; height: 32px;" class="" -->
	<%-- 							value="${LTE_createtime}"></td> --%>


	<!-- 						<td style="width: 33%"> -->
	<!-- 							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp; -->
	<!-- 							<button type="button" class="btn" id="reset_btn" -->
	<!-- 								onclick="resetAll()">重置</button> -->
	<!-- 						</td> -->
	<!-- 					</tr> -->
	<!-- 				</table> -->
	<!-- 			</form> -->
	<!-- 		</div> -->
	<!-- 	</div> -->
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;">&nbsp;</a>
				<a href="javascript:;" class="btn red" onclick="del()"><i class=""></i>批量删除</a>
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
						<th style="width: 5%; text-align: center"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 5%; text-align: center">序号</th>
						<th style="width: 10%; text-align: center">姓名</th>
						<th style="width: 10%; text-align: center">联系电话</th>
						<th style="width: 33%; text-align: center">备注</th>
						<th style="width: 11%; text-align: center">提交时间</th>
						<th style="width: 10%; text-align: center">状态</th>
						<th style="width: 14%; text-align: center">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="apply" varStatus="aa">
							<tr class="odd gradeX">
								<td style="vertical-align: middle; text-align: center"><input type="checkbox" id="check_item" value="${apply.id}" class="check_item"></td>
								<td style="vertical-align: middle; text-align: center">${aa.count}</td>
								<td style="vertical-align: middle; text-align: center">${apply.name}</td>
								<td style="vertical-align: middle; text-align: center">${apply.telephone}</td>
								<td style="vertical-align: middle; text-align: center">${apply.memo}</td>
								<td style="vertical-align: middle; text-align: center">${fn:substring(apply.createtime, 0, 10)}</td>
								<td style="vertical-align: middle; text-align: center"><c:if test="${apply.state==1}">待联系</c:if> <c:if test="${apply.state==2}">已联系
</c:if></td>

								<%-- 								<td><a href="${ctx}/Storehouse/update/${art.id}">修改信息</a>&nbsp; --%>


								<td style="vertical-align: middle; text-align: center"><c:if test="${apply.state==1}">
										<a href="javascript:;" onclick="askforaccept(${apply.id})">已联系</a>&nbsp;</c:if> <c:if test="${apply.state==2}"></c:if> <a href="javascript:;" onclick="askfordelete(${apply.id})">删除</a>&nbsp;</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>