<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>鸡蛋活动管理</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<%@ include file="../quote.jsp"%>
</head>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
		
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
		 
		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	});
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" /> 1元抢鸡蛋活动管理
			</h3>
		</div>
	</div>

	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-search" id="myform" action="${ctx}/tmp/egg">
				<table style="width: 100%">
					<tr> 

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px;margin-top: 10px;">开始时间：</label><input type="text"
							id="datepicker" name="search_GTE_createtime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_createtime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px;margin-top: 10px;">结束时间：</label><input type="text"
							id="datepicker1" name="search_LTE_createtime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_createtime}"></td>



						<td style="width: 33%">
							<button class="btn blue" id="search_btn" onclick="forsubmit()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="reset_btn"
								onclick="resetAll()">重置</button>
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
			<div class="actions"></div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<div class="row-fluid" style="font-size: 20px;">汇总结果</div>
			<div class="row-fluid"
				style="margin-top: 10px; margin-left: 50px; margin-bottom: 10px;">领取总数（份）：${totalcount}
				&nbsp;&nbsp;&nbsp;支付总额（元）：${maxprice/100.0}&nbsp;&nbsp;&nbsp;红包总额（元）：${maxrebateprice/100.0}
				</div>
			
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>微信昵称</th>
						<th>支付时间</th>
						<th>支付金额</th>
						<th>红包金额</th>
						<th>状态</th>

					</tr>
				</thead>
				<tbody>
					<c:if test="${tmps.totalPages!=0}">
						<c:forEach items="${tmps.content}" var="tmp" varStatus="status">
							<tr>
								<td style="vertical-align: middle;">${status.count}</td>
								<td style="vertical-align: middle;">${tmp.name}</td>
								<td style="vertical-align: middle;">${fn:substring(tmp.paytime,0,16)}</td>
								<td style="vertical-align: middle;">${tmp.price/100.0}</td>
								<td>${tmp.rebateprice/100.0}</td>
								<td style="vertical-align: middle;"><c:if
										test="${tmp.state==0}">未支付</c:if> <c:if test="${tmp.state==1}">已支付未领取</c:if>
									<c:if test="${tmp.state==2}">已领取</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${tmps.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${tmps}" paginationSize="5" />
		</div>
	</div>
</body>
</html>