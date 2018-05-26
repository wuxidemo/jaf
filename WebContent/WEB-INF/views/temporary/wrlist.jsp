<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>获奖管理</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	function resetAll() {
		$("#code").val("0");
		$("#wxcode").val("0");
		$("#mytype").val("0");
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
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />获奖管理
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
			<form class="form-search" id="myform" action="${ctx}/winningrecord"
				method="post">
				<table style="width: 100%">
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">活动：</label> <select class=""
							id="mytype" style="width: 60%; height: 32px;"
							name="search_EQ_type">
								<option value="0">--请选择--</option>
								<option value="rqzhd"
									<c:if test="${EQ_type=='rqzhd'}" > selected="selected" </c:if>>人气值活动</option>
								<option value="gzfxhd"
									<c:if test="${EQ_type=='gzfxhd'}" > selected="selected" </c:if>>分享活动</option>
								<option value="qccjhd"
									<c:if test="${EQ_type=='qccjhd'}" > selected="selected" </c:if>>全城抽奖</option>
						</select></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">奖项：</label> <select class=""
							id="wxcode" style="width: 60%; height: 32px;"
							name="search_EQ_winname">
								<option value="0">--请选择--</option>
								<option value="1"
									<c:if test="${EQ_winname=='1'}" > selected="selected" </c:if>>一等奖</option>
								<option value="2"
									<c:if test="${EQ_winname=='2'}" > selected="selected" </c:if>>二等奖</option>
								<option value="3"
									<c:if test="${EQ_winname=='3'}" > selected="selected" </c:if>>三等奖</option>
								<option value="4"
									<c:if test="${EQ_winname=='4'}" > selected="selected" </c:if>>幸运奖</option>
								<option value="5"
									<c:if test="${EQ_winname=='5'}" > selected="selected" </c:if>>脱光奖</option>
						</select></td>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">状态：</label> <select class=""
							id="code" style="width: 60%; height: 32px;"
							name="search_EQ_state">
								<option value="0">--请选择--</option>
								<option value="1"
									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>正常</option>
								<option value="2"
									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>已处理</option>

						</select></td>

					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">活动时间：</label><input type="text"
							id="datepicker" name="search_GTE_wintime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_wintime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">到</label><input type="text"
							id="datepicker1" name="search_LTE_wintime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LTE_wintime}"></td>



						<td style="width: 33%">
							<button class="btn blue" id="search_btn" onclick="forsubmit()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="reset_btn"
								onclick="resetAll()">重置</button>
						</td>
					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 100px">昵称：</label><input name="search_LIKE_name"> </td>
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
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all" value=""
							class="check_all"></th>
						<th>昵称</th>
						<th>openid</th>
						<th>电话</th>
						<th>奖项</th>
						<th>奖品选择</th>
						<th>奖项时间</th>
						<th>活动</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${srs.totalPages!=0}">
						<c:forEach items="${srs.content}" var="tr" varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item" value="${tr.id}"
									class="check_item"></td>
								<td style="vertical-align: middle;">${tr.name}</td>
								<td style="vertical-align: middle;">${tr.openid}</td>
								<td style="vertical-align: middle;">${tr.phone}</td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.winname==1}">一等奖</c:if> <c:if
										test="${tr.winname==2}">二等奖</c:if> <c:if
										test="${tr.winname==3}">三等奖</c:if> <c:if
										test="${tr.winname==4}">四等奖</c:if></td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.subname==1}">500M流量
										</c:if> <c:if test="${tr.subname==0}">20元话费
										</c:if> <c:if test="${tr.subname==null}">
									</c:if></td>
								<td style="vertical-align: middle;">${fn:substring(tr.wintime,0,10)}</td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.type=='rqzhd'}">人气值活动</c:if> <c:if
										test="${tr.type=='gzfxhd'}">分享活动</c:if> <c:if
										test="${tr.type=='qccjhd'}">全城抽奖</c:if></td>
								<td style="vertical-align: middle;"><c:if
										test="${tr.state==1}">正常</c:if> <c:if test="${tr.state==2}">已处理</c:if>
								</td>
								<td><c:if test="${tr.state==1}">
										<a href="${ctx}/winningrecord/deal/${tr.id}">处理</a>
									</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${srs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="9" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${srs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>