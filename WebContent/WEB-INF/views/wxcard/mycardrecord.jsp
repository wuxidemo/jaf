<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>卡券领取记录</title>

<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	function resetAll() {
		$("#code").val("");
		$("#wxcode").val("");
		$("#mytype").val("-1");
		$("#datepicker").val("");
		$("#datepicker1").val("");
	}
	$(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	});
</script>


<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/hzhb.png"
					style="vertical-align: text-bottom;" /> 卡券领取记录
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
			<form class="form-search" id="myform"
				action="${ctx}/cardrecord/mylist" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">类型：</label> <select class=""
							id="mytype" style="width: 60%; height: 32px;"
							name="search_EQ_isbank">
								<option value="-1">--请选择--</option>
								<option value="1"
									<c:if test="${EQ_isbank==1}" > selected="selected" </c:if>>银行卡券</option>
								<option value="0"
									<c:if test="${EQ_isbank==0}" > selected="selected" </c:if>>本店卡券</option>

						</select></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">使用开始时间：</label><input
							type="text" id="datepicker" name="search_GTE_usetime"
							maxlength="20" readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_usetime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">使用结束时间：</label><input
							type="text" id="datepicker1" name="search_LTE_usetime"
							maxlength="20" readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_usetime}"></td>

					</tr>
					<tr>

						<td style="width: 33%"></td>
						<td style="width: 33%"></td>



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
			<!-- 			<div class="actions"> -->
			<!-- 				<a href="javascript:;" class="btn red" onclick="del()"><i -->
			<!-- 					class=""></i>批量删除</a> -->
			<!-- 			</div> -->
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>

			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<!-- 						<th style="width: 5%; text-align: center"><input -->
						<!-- 							type="checkbox" id="check_all" value="" class="check_all"></th> -->
						<th style="width: 5%; text-align: center">序号</th>
						<th style="text-align: center">卡券名称</th>
						<th style="text-align: center">类型</th>
						<th style="text-align: center">银行</th>
						<th style="text-align: center">拥有人</th>
						<th style="text-align: center">有效期</th>
						<th style="text-align: center">使用时间</th>
						<th style="text-align: center">使用商店</th>
						<th style="text-align: center">状态</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="wxcardrecord"
							varStatus="aa">
							<tr class="odd gradeX">
								<td style="vertical-align: middle; text-align: center">${aa.count}</td>
								<td style="vertical-align: middle; text-align: center">${wxcardrecord.cardname}</td>
								<td style="vertical-align: middle; text-align: center"><c:choose>
										<c:when test="${wxcardrecord.cardtype=='CASH'}">现金券</c:when>
										<c:when test="${wxcardrecord.cardtype=='DISCOUNT'}">折扣券</c:when>
										<c:otherwise>优惠券</c:otherwise>
									</c:choose></td>
								<td><c:if test="${wxcardrecord.isbank==1}">是</c:if> <c:if
										test="${wxcardrecord.isbank!=1}">否</c:if></td>
								<td style="vertical-align: middle; text-align: center">${wxcardrecord.ownname}</td>
								<td style="vertical-align: middle; text-align: center">${fn:substring(wxcardrecord.starttime, 0, 10)}-${fn:substring(wxcardrecord.endtime, 0, 10)}</td>
								<td style="vertical-align: middle; text-align: center">${fn:substring(wxcardrecord.usetime, 0, 10)}</td>
								<td style="vertical-align: middle; text-align: center">${wxcardrecord.merchantname}</td>
								<td style="vertical-align: middle; text-align: center"><c:if
										test="${wxcardrecord.state==1}">正常</c:if> <c:if
										test="${wxcardrecord.state==2}">已使用</c:if> <c:if
										test="${wxcardrecord.state==3}">已删除</c:if> <c:if
										test="${wxcardrecord.state==4}">过期</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="9" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>