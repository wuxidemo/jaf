<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>红包发放记录</title>

<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />





<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>

<style>
.ctl {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	padding: 2px
}
</style>

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
		$("#mycode").val("");
		$("#receivename").val("");
		$("#rebatename").val("0");
		$("#state").val("0");
		$("#datepicker").val("");
		$("#datepicker1").val("");
	}
</script>


<body>


	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/flhb.png"
					style="vertical-align: text-bottom;" />发放记录
			</h3>
		</div>
	</div>

	<div class="portlet box grey" style="height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-search" action="${ctx}/rrecord">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width:80px">订 &nbsp;单&nbsp;号：</label> <input
							type="text" id="mycode" name="search_LIKE_mycode" maxlength="50"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_mycode }"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">发送对象：</label> <input type="text"
							id="receivename" name="search_LIKE_receivename" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_receivename}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">红包名称：</label> <select class=""
							id="rebatename" style="width: 60%; height: 32px;"
							name="search_EQ_rebateid">
								<c:choose>
									<c:when test="${EQ_rebateid == '0'}">
										<option value="0" selected="selected">--全部--</option>
									</c:when>
									<c:otherwise>
										<option value="0">--全部--</option>
									</c:otherwise>
								</c:choose>
								<c:forEach items="${rebatename}" var="rb">
									<c:choose>
										<c:when test="${rb.id == EQ_rebateid}">
											<option selected="selected" value="${rb.id}">${rb.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${rb.id}">${rb.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
						<td>
					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">开始时间：</label><input type="text"
							id="datepicker" name="search_GTE_createdate" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_createdate}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">结束时间：</label><input type="text"
							id="datepicker1" name="search_LTE_createdate" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_createdate}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">红包状态：</label> <select class=""
							id="state" style="width: 60%; height: 32px;"
							name="search_EQ_state">
								<option value="0">--全部--</option>
								<option value="1"
									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>已发放</option>
								<option value="2"
									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>已领取</option>
								<option value="3"
									<c:if test="${EQ_state==3}" > selected="selected" </c:if>>已退款</option>
						</select></td>
					</tr>

					<tr>
						<td></td>
						<td></td>
						<td style="width: 33%; text-align: left">
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
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

		</div>
		<div class="portlet-body">

			<div class="row-fluid" style="font-size: 20px;">汇总结果</div>
			<div class="row-fluid" style="margin-top: 10px; margin-left: 50px;">红包数量（笔）：${totalcount}
				&nbsp;&nbsp;&nbsp;红包总额（元）：${maxprice }</div>
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>

			<table id="contentTable"
				class="table table-striped table-bordered table-hover"
				style="margin-top: 20px">
				<thead>
					<tr>
						<th style="width: 5%; text-align: center">序号</th>
						<th style="width: 25%; text-align: center">订单号</th>
						<th style="width: 10%; text-align: center">商家</th>
						<th style="width: 18%; text-align: center">发放时间</th>
						<th style="width: 10%; text-align: center">红包名称</th>
						<th style="width: 10%; text-align: center">发送对象</th>
						<th style="width: 10%; text-align: center">红包金额（元）</th>
						<th style="width: 10%; text-align: center">红包状态</th>

					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="rrecord" varStatus="aa">
							<tr class="odd gradeX">

								<td style="vertical-align: middle; text-align: center">${aa.count}</td>
								<td style="vertical-align: middle; text-align: center">${rrecord.mycode}</td>
								<td style="vertical-align: middle; text-align: center">${rrecord.merhchantname}</td>
								<td style="vertical-align: middle; text-align: center">${fn:substring(rrecord.createdate, 0, 16)}</td>
								<td style="vertical-align: middle; text-align: center">${rrecord.rebatename}</td>
								<td style="vertical-align: middle; text-align: center">${rrecord.receivename}</td>
								<td style="vertical-align: middle; text-align: center">${rrecord.price/100.0}</td>

								<td style="vertical-align: middle; text-align: center"><c:if
										test="${rrecord.state==0}">发放失败</c:if> <c:if
										test="${rrecord.state==1}">已发放</c:if> <c:if
										test="${rrecord.state==2}">已领取
</c:if> <c:if test="${rrecord.state==3}">已退款</c:if></td>

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