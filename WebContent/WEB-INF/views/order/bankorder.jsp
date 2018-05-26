<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>交易记录</title>

<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />





<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>


</head>

<script type="text/javascript">
	$(function() {
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	})
	$(function() {
		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	})

	function resetAll() {
		$("#wxcode").val("");
		$("#code").val("");

		$("#state").val("3");
		$("#datepicker").val("");
		$("#datepicker1").val("");
	}
	function forsubmit() {
		// 		alert("gdfsgfdsgsf");
		var data = getMap($("#myform").serialize());
		if (data.search_GTE_paytime != "" && data.search_LTE_paytime != "") {
			if (data.search_GTE_paytime > data.search_LTE_paytime) {
				window.parent.showAlert("开始时间必须小于结束时间");
				return false;
			} else {
				return true;
			}
		}
	}
</script>
<body>


	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/jygl.png"
					style="vertical-align: text-bottom;" />交易记录
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
			<form class="form-search" id="myform" action="${ctx}/bankorder " method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 25%">订 &nbsp;单 &nbsp;号：</label> <input type="text"
							id="code" name="search_LIKE_code" maxlength="50"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_code }"></td>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 25%">微信支付单号：</label> <input type="text"
							id="wxcode" name="search_LIKE_wxcode" maxlength="50"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_wxcode }"></td>


					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 25%">开始时间：</label><input type="text"
							id="datepicker" name="search_GTE_paytime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_paytime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 25%">结束时间：</label><input type="text"
							id="datepicker1" name="search_LTE_paytime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_paytime}"></td>



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
				<i class="icon-globe"></i>详细数据
			</div>

		</div>
		<div class="portlet-body">
			<div class="row-fluid" style="font-size: 20px;">汇总结果</div>
			<div class="row-fluid"
				style="margin-top: 10px; margin-left: 50px; margin-bottom: 10px;">
				订单数量（笔）：${totalcount} &nbsp;&nbsp;&nbsp;
				  订单总额（元）：${maxprice}&nbsp;&nbsp;&nbsp;
				已支付（元）：${maxpayprice}
			</div>
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>

			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 3%; text-align: center">序号</th>
						<th style="width: 10%; text-align: center">订单号</th>
						<th style="width: 15%; text-align: center">交易时间</th>
						<th style="width: 5%; text-align: center">微信支付单号</th>
						<th style="width: 10%; text-align: center">微信号</th>
						<th style="width: 8%; text-align: center">交易状态</th>

						<th style="width: 9%; text-align: center">支付金额(元)</th>


					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="order" varStatus="aa">
							<tr class="odd gradeX">

								<td style="vertical-align: middle; text-align: center">${aa.count}</td>
								<td style="vertical-align: middle; text-align: center">${order.code}</td>

								<td style="vertical-align: middle; text-align: center">${fn:substring(order.paytime, 0, 16)}</td>
								<td style="vertical-align: middle; text-align: center">${order.wxcode}</td>
								<td style="vertical-align: middle; text-align: center">${order.payname}</td>
								<td style="vertical-align: middle; text-align: center"><c:if
										test="${order.state==0}">未支付</c:if> <c:if
										test="${order.state==1}">支付
</c:if> <c:if test="${order.state==2}">取消</c:if></td>

								<td style="vertical-align: middle; text-align: center">${order.payprice/100.0}</td>



							</tr>
						</c:forEach>
					</c:if>


					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>