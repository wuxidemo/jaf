<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>

<html>
<head>
	<title>有奖问答</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>
<style type="text/css">
#contentTable td{
	WORD-WRAP: break-word;
}
</style>
<script>

	jQuery(document).ready(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	});
	
	function resetAll() {
		$("#datepicker").val("");
		$("#datepicker1").val("");
	}
	
</script>
<body>

	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/zh1.png" style="vertical-align: text-bottom;"/> 
				答题送话费活动记录
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
			<form class="form-search" id="myform" action="${ctx}/servey" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">活动时间：</label><input type="text"
							id="datepicker" name="search_GTE_acttime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_acttime}"></td>
							
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">到</label><input type="text"
							id="datepicker1" name="search_LTE_acttime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_acttime}"></td>
							
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
			
			<div class="actions">
				<a href="javascript:;">&nbsp;</a>
				<a href="${ctx}/servey/outdata" class="btn blue">导出数据</a>
			</div>
			
		</div>
		<div class="portlet-body">
			
			<div id="message" class="alert alert-success">
				参与活动的人数为：<span style="color:red; font-size:20px;">${serveys.totalElements}</span>，
				有效的无锡号码个数为：<span style="color:red; font-size:20px;">${total}</span>
			</div>
		
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10%;">序号</th>
						<th style="width: 15%;">昵称</th>
						<!-- <th style="width: 20%;">编号</th> -->
						<th style="width: 15%;">手机号码</th>
						<th style="width: 20%;">是否为无锡号码（2500名之前默认全是）</th>
						<th style="width: 15%;">参与时间</th>
						<th style="width: 10%;">是否领取话费</th>
						<th style="width: 15%;">操作</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${serveys.totalPages!=0}">
						<c:forEach items="${serveys.content}" var="servey" varStatus="status">
							<tr>
								<td style="vertical-align: middle;">${status.count}&nbsp;</td>
								<td style="vertical-align: middle;">${servey.nickname}&nbsp;</td>
								<%-- <td style="vertical-align: middle;">${servey.openid}&nbsp;</td> --%>
								<td style="vertical-align: middle;">${servey.phone}&nbsp;</td>
								
								<td style="vertical-align: middle;">
									<c:if test="${servey.wuxi == 1 }"><span class="label label-success">是</span></c:if>
									<c:if test="${servey.wuxi == 0 }"><span class="label label-important">不是</span></c:if>
								</td>
								
								<td style="vertical-align: middle;">${fn:substring(servey.acttime,0,19)}&nbsp;</td>
								<td style="vertical-align: middle;">
									<c:if test="${servey.send == 1 }"><span class="label label-success">已领取</span></c:if>
									<c:if test="${servey.send == 0 }"><span class="label label-important">未领取</span></c:if>
								</td>
								<td style="vertical-align: middle;">
									<c:if test="${servey.send == 0 }">
								    	<a href="${ctx}/servey/setsend/${servey.id}">设置已领取话费</a>
								    </c:if> &nbsp;
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${serveys.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${serveys}" paginationSize="5"/>
		</div>
	</div>
</body>
</html>
