<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>交易记录</title>
<style type="text/css">
#contentTable td {
	text-align: center !important;
}
#contentTable th {
	text-align: center !important;
}
</style>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />





<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>


</head>

<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item')
	});
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
		$("#merhchantname").val("0");
		$("#state").val("4");
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
	function del() {
		var noticeids = "";
		var states = "";
		$("[id=check_item]").each(function() {
			if ($(this).attr("checked") == "checked") {
				noticeids += "," + $(this).val();
				states += $(this).attr("state");

			}
		});
		if (states.indexOf("0") != -1) {
			window.parent.showAlert("有未付款项不能结算");
			return;
		}
		if (states.indexOf("3") != -1) {
			window.parent.showAlert("有已结算项不能结算");
			return;
		}
		if (noticeids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		} else {
			window.parent.showConfirm("你确定要结算所选记录？", sureDel2);
		}
	}

	function sureDel2() {
		var noticeids = "";
		$("[id=check_item]").each(function() {
			if ($(this).attr("checked") == "checked") {
				noticeids += "," + $(this).val();
			}
		});
		var ids = noticeids.substring(1);
		$("#delForm").append('<input name="ids" value='+ids+'>');
		$("#delForm").submit();

	}
	
	function detailclose() {
		$('#detail').modal('hide');
	}
	function showdetail(id)
	{
		$.post("${ctx}/order/detail?id="+id,function(d){
			var html='<table style="width: 100%;"><thead><tr><th style="width: 80px"></th><th style="width: %"></th><th style="width: 80px"></th><th style="width: %"></th><th style="width: 80px"></th><th style="width: %"></th></tr></thead><tr><td>订单号:</td><td>'+d.order.code+'</td><td>交易时间：</td><td>'+getLocalTime(new Date(d.order.paytime))+'</td><td>微信号:</td><td>'+(d.order.payname==null?'':d.order.payname)+'</td>	</tr><tr><td>交易金额:</td><td>'+d.order.price/100.0+'</td><td>支付金额：</td>	<td>'+d.order.payprice/100.0+'</td><td>状态:</td><td>'+(d.order.state==3?'已结算':'未结算')+'</td>	</tr></table>';
			for(var i=0;i<d.cards.length;i++)
				{
				var type="";
				if(d.cards[i].cardtype=="CASH")
					{type="代金券";}else if(d.cards[i].cardtype=="DISCOUNT")
						{type="折扣券";}
					else
						{
						type="礼品券";
						}
				html+='<div	style="border: 1px dashed; margin-top: 10px; padding: 10px 0; width: 100%;"><table style="width: 90%;"><thead><tr><th style="width: 80px"></th><th style="width: %"></th><th style="width: 80px"></th><th style="width: %"></th><th style="width: 80px"></th><th style="width: %"></th></tr></thead><tr><td>卡券类型:</td><td>'+type+'</td><td>卡券名称：</td>	<td>'+d.cards[i].cardname+'</td><td></td><td></td></tr><tr><td>卡券额度:</td>	<td>'+(d.cards[i].bankprice+d.cards[i].shopprice)/100.0+'</td><td>农商行:</td><td>'+(d.cards[i].bankprice)/100.0+'</td><td>商家:</td><td>'+(d.cards[i].shopprice)/100.0+'</td></tr></table></div>';
				}
			
			$("#ordercontent").html(html);
			window.parent.addChildAlert($("#detail"),"detail");
			//alert()
		});
		
	}
</script>
<body>
	<div class="modal hide fade" id="detail" tabindex="-1" role="dialog"
		style=" left: 10%; margin: 0; right: 10%; top: 10%; width: 80%;">
		<div class="modal-header">
			<h3 id="myModalLabel">详情</h3>
		</div>
		<div id="ordercontent" class="modal-body">


		</div>
		<div class="modal-footer">
			<a class="btn" onclick="removeChildAlert('detail')">关闭</a>
		</div>
	</div>
	<form action="${ctx}/ourorder/upState/ourorder" id="delForm"
		style="display: none;"></form>

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
			<form class="form-search" id="myform" action="${ctx}/ourorder " method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">订&nbsp单&nbsp号：</label> <input
							type="text" id="code" name="search_LIKE_code" maxlength="50"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_code }"></td>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">商户名称：</label> <select class=""
							id="merhchantname" style="width: 60%; height: 32px;"
							name="search_EQ_merchantid">
								<c:choose>
									<c:when test="${EQ_merchantid == '0'}">
										<option value="0" selected="selected">--全部--</option>
									</c:when>
									<c:otherwise>
										<option value="0">--全部--</option>
									</c:otherwise>
								</c:choose>
								<c:forEach items="${merhchantname}" var="rb">
									<c:choose>
										<c:when test="${rb.id == EQ_merchantid}">
											<option selected="selected" value="${rb.id}">${rb.name}</option>
										</c:when>
										<c:otherwise>
											<option value="${rb.id}">${rb.name}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">结算状态：</label> <select class=""
							id="state" style="width: 60%; height: 32px;"
							name="search_EQ_state">
								<option value="4">--选择状态--</option>
								<option value="3"
									<c:if test="${EQ_state==3}" > selected="selected" </c:if>>已结算</option>
								<option value="0"
									<c:if test="${EQ_state==0}" > selected="selected" </c:if>>未支付</option>
								<option value="1"
									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>已支付未结算</option>
								<!-- 								<option value="2" -->
								<%-- 									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>取消</option> --%>
						</select></td>


					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">开始时间：</label><input type="text"
							id="datepicker" name="search_GTE_paytime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${GTE_paytime}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 80px">结束时间：</label><input type="text"
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
			<div class="actions">
				<a href="javascript:;" class="btn blue" onclick="del()"><i
					class=""></i>结算</a>
			</div>

		</div>
		<div class="portlet-body">
			<div class="row-fluid" style="font-size: 20px;">汇总结果</div>
			<div class="row-fluid"
				style="margin-top: 10px; margin-left: 50px; margin-bottom: 10px;">订单数量（笔）：${totalcount}
				&nbsp;&nbsp;&nbsp;订单总额（元）：${maxprice}&nbsp;&nbsp;&nbsp;已支付（元）：${maxpayprice}
				&nbsp;&nbsp;&nbsp;卡券（张）：${cardcount}&nbsp;&nbsp;&nbsp;卡券银行总额（元）：${cardbankprice}
				&nbsp;&nbsp;&nbsp;卡券商户总额（元）：${cardshopprice}</div>
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>

			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10px;"><input type="checkbox"
							id="check_all" value="" class="check_all"></th>
						<th style="width: 10px;">序号</th>
						<th>订单号</th>
						<th>交易时间</th>
						<!-- <th>微信支付单号</th> -->
						<th>微信号</th>
						<th>交易状态</th>
						<th>交易金额(元)</th>
						<th>支付金额(元)</th>
						<th>卡券银行额度(元)</th>
						<th>结算状态</th>
						<th>商户名称</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="order" varStatus="aa">
							<tr class="odd gradeX">
								<td><input type="checkbox" id="check_item"
									value="${order[0]}" state="${order[7]}" class="check_item"></td>
								<td>${aa.count}</td>
								<td>${order[1]}</td>

								<td>${fn:substring(order[2], 0, 16)}</td>
								<!-- 	<td>${order[8]}</td> -->

								<td>${order[3]}</td>
								<td><c:if test="${order[7]==0}">未支付</c:if> <c:if
										test="${order[7]==1}">已支付
								</c:if> <c:if test="${order[7]==3}">已支付</c:if></td>
								<td>${order[4]/100.00}</td>
								<td>${order[5]/100.00}</td>
								<td>${order[6]/100.0}</td>
								<td><c:if test="${order[7]==3}">已结算</c:if> <c:if
										test="${order[7]!=3}">未结算</c:if></td>
								<td>${order[9]}</td>
								<td><a href="javascript:;"
									onclick="showdetail(${order[0]})">详情</a></td>
							</tr>
						</c:forEach>
					</c:if>


					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="11" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>
</body>
</html>