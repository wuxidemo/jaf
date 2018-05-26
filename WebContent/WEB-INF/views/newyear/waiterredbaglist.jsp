<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>服务员拉粉统计表</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>
<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
		
	});
	
	function resetAll() {
		$("#nickname").val("");
		$("#mername").val("");
		$("#datepicker").val("");
	}
	
	function sendredbag() {
		//$("#sendredForm").empty();
		var datestr = $("#datepicker").val();
		if(datestr == '') {
			window.parent.showAlert("请选择日期");
			return false;
		}else{
			window.parent.showConfirm("你确定要发送当日红包吗？",suresend);
		}
	}
	
	function suresend() {
		var datestr = $("#datepicker").val();
		var redurl = '${ctx}/waiter/sendtodayredbag';
		$.post(redurl,{"datestr":datestr},function(data){
			window.parent.showAlert(data.msg);
			window.location.href='${ctx}/waiter/listwaiterredbag?search_EQ_createtime='+datestr;
		});
	}
	
</script>
<body>
	<form action="${ctx}/waiter/sendtodayredbag" id="sendredForm" method="post" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				统计列表
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
			<form class="form-search" action="${ctx}/waiter/listwaiterredbag" method="post">
			<table style="width: 100%">
			<tr>
				<td style="width:33%;">
					<label class="control-label" style="float:left">微信昵称：</label> 
					<input type="text" id="nickname" name="search_LIKE_nickname" maxlength="20" style="float:left;width: 60%; height: 32px;" class="" value="${LIKE_nickname }"> 
				</td>
				
				<td style="width:33%;">
					<label class="control-label" style="float:left">所属商户：</label> 
					<input type="text" id="mername" name="search_LIKE_mername" maxlength="20" style="float:left;width: 60%; height: 32px;" class="" value="${LIKE_mername }"> 
				</td>
				
				<td style="width:33%;">
					<label class="control-label"
							style="float: left; width: 100px">中奖时间：</label><input type="text"
							id="datepicker" name="search_EQ_createtime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${EQ_createtime}">
				</td>
			</tr>
			<tr>
				<td style="width:33%;">&nbsp;</td>
				<td style="width:33%;">&nbsp;</td>
				<td style="width:33%;">
					<label class="control-label" style="float:left">&nbsp;</label> 
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
					<button type="button" class="btn" id="reset_btn" onclick="resetAll()">重置</button>&nbsp;&nbsp;
					<button type="button" class="btn red" id="sedred_btn" onclick="sendredbag()">发送红包</button>
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
			</div>
		</div>
		 <div class="portlet-body">
			<div id="message" class="alert alert-success">
				今日新增关注：<span style="color:red;font-size:22px;">${newfocus}</span>&nbsp;&nbsp;&nbsp;&nbsp;
				历史累计关注：<span style="color:red;font-size:22px;">${totalfocus}</span>&nbsp;&nbsp;&nbsp;&nbsp;
				今日应发红包：<span style="color:red;font-size:22px;">${todayred}</span>&nbsp;&nbsp;&nbsp;&nbsp;
				今日已发红包：<span style="color:red;font-size:22px;">${newredyes}</span>&nbsp;&nbsp;&nbsp;&nbsp;
				累计应发红包：<span style="color:red;font-size:22px;">${totalred}</span>
			</div>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>参赛者微信昵称</th>
						<th>参赛者姓名</th>
						<th>今日新增关注</th>
						<th>累计关注</th>
						<th>今日应该发放红包金额</th>
						<th>今日已发放红包金额</th>
						<th>今日未发放红包金额</th>
						<th>累计应该发放红包金额</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${redbags.totalPages!=0}">
					<c:forEach items="${redbags.content}" var="redbag" varStatus="status">
						<tr>
							<td style="vertical-align: middle;"><c:if test="${redbag[1] != null}">${redbag[1]}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[2] != null}">${redbag[2]}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[3] != null}">${redbag[3]}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[4] != null}">${redbag[4]}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[3] != null}">${redbag[3]*0.5}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[5] != null}">${redbag[5]*0.5}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[6] != null}">${redbag[6]*0.5}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag[4] != null}">${redbag[4]*0.5}</c:if> &nbsp;</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${redbags.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<%-- <tags:pagination page="${redbags}" paginationSize="5"/> --%>
		</div> 
	</div>
</body>
</html>