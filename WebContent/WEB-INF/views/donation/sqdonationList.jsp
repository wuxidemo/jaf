<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>个人捐献</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>

<script type="text/javascript">
	$(document).ready(function(){
		initDate();
	});
	function initDate(){
		if (jQuery().datepicker) {
	        $('#starttime').datepicker({
	            rtl : App.isRTL()
	        });
	    }
		if (jQuery().datepicker) {
	        $('#endtime').datepicker({
	            rtl : App.isRTL()
	        });
	    }
	}
	
	function resetAll() {
		$("#name").val("");
		$("#starttime").val("");
		$("#endtime").val("");
	}
	
	var delid;
	var cpage;
	function askfordel(doid,pageno) {
		delid = doid;
		cpage = pageno;
		window.parent.showConfirm("你确定要删除该条记录吗？",sureDel);
	}
	
	function sureDel() {
		$("#deleteForm").empty();
		$("#deleteForm").append('<input name="delid" value ="'+delid+'" />');
		$("#deleteForm").append('<input name="pageno" value ="'+cpage+'" />');
		$("#deleteForm").submit();
	}
	
</script>
<body>
	<form action="${ctx}/sqdonation/del" id="deleteForm" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				个人捐献
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
			<form class="form-search" action="${ctx}/sqdonation" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width:33%;">
							<label class="control-label" style="float:left">捐献人:&emsp;</label> 
							<input type="text" id="name" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%; height: 32px;" value="${LIKE_name }"> 
						</td>
						<td style="width:50%;">
							<label class="control-label" style="float:left">捐献时间:&emsp;</label> 
							<input type="text" id="starttime" name="search_EQ_starttime" maxlength="20" readonly="readonly" style="width:35%;height:32px;cursor: pointer;" value="${EQ_starttime }"> 
							到
							<input type="text" id="endtime" name="search_EQ_endtime" maxlength="20" readonly="readonly" style="width:35%;height:32px;cursor: pointer;" value="${EQ_endtime }"> 
						</td>
						<td style="width:17%;">
							<button type="submit" class="btn blue" id="search_btn" >查询</button>&nbsp;&nbsp;
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
						<th>交易编号</th>
						<th>捐献人</th>
						<th>性别</th>
						<th>价值</th>
						<th>捐献物品</th>
						<th>捐献时间</th>
						<th>联系方式</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${sqadverts.totalPages!=0}">
					<c:forEach items="${sqadverts.content}" var="sqadvert" varStatus="status">
						<tr>
							<td style="vertical-align: middle;">${sqadvert[1]}</td>
							<td style="vertical-align: middle;">${sqadvert[2]}</td>
							<td style="vertical-align: middle;">
								<c:if test="${sqadvert[3] == 1}">男</c:if>
								<c:if test="${sqadvert[3] == 2}">女</c:if>
							</td>
							<td style="vertical-align: middle;">${sqadvert[4]/100}&nbsp;元</td>
							<td style="vertical-align: middle;">${sqadvert[5]}</td>
							<td style="vertical-align: middle;">${fn:substring(sqadvert[6],0,10)}</td>
							<td style="vertical-align: middle;">${sqadvert[7]}</td>
							<td style="vertical-align: middle;">
								<a href="javascript:;" onclick="askfordel('${sqadvert[0]}','${sqadverts.number + 1}')">删除</a>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${sqadverts.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${sqadverts}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>