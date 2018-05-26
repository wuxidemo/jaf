<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>卡券管理</title>
<style type="text/css">
th {
	text-align: center !important;
	vertical-align: middle !important;
}

.table td {
	vertical-align: middle !important;
	text-align: center !important;
}

.unit {
	display: inline;
	line-height: 33px;
}

form td {
	width: 33%;
}

form tr {
	margin-bottom: 10px;
}

table {
	margin-top: 20px;
	width: 100%;
}
</style>
<%@ include file="../quote.jsp"%>

</head>




<body>
	<form action="${ctx}/card/updatecards" method="post"
		style="display: none" id="freshform"></form>
	<form action="${ctx}/card/setcard" method="post" style="display: none"
		id="setform">
		<input name="state" id="cardstate">
	</form>
	<div class="modal hide fade" id="per" tabindex="-1" role="dialog"
		style="top: 10%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">额度分配</h3>
		</div>
		<div id="" class="modal-body">
			<form id="inputForm" action="${ctx}/card/per" method="post"
				class="form-horizontal">
				<input id="myid" value="" name="id" type="hidden"> <input
					id="type" value="" type="hidden">
				<div class="control-group">
					<label for="user-name" class="control-label">农商行:</label>
					<div class="controls">
						<input type="text" id="bankper" name="bankper" value=""
							class="span m-wrap required" maxlength="8" />
						<p class="unit">元</p>
					</div>
				</div>
				<div class="control-group">
					<label for="user-name" class="control-label">商家:</label>
					<div class="controls">
						<input type="text" id="shopper" name="shopper" value=""
							class="span m-wrap required" maxlength="8" />
						<p class="unit">元</p>
					</div>
				</div>
				<div id="pricediv" class="control-group">
					<label for="user-name" class="control-label">小计:</label>
					<div class="controls">
						<input type="text" id="price" name="price" value=""
							readonly="readonly" class="span m-wrap required" maxlength="8" />
						<p class="unit">元</p>
					</div>
				</div>
			</form>

		</div>
		<div class="modal-footer">
			<a class="btn green " onclick="saveper()">保存</a> <a class="btn"
				onclick="perclose()">关闭</a>
		</div>
	</div>

	<div class="modal hide fade" id="setcount" tabindex="-1" role="dialog"
		style="top: 10%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">设置积分</h3>
		</div>
		<div id="" class="modal-body">
			<form id="setcountform" action="${ctx}/card/setcount" method="post"
				class="form-horizontal">
				<input id="countid" value="" name="id" type="hidden">
				<div class="control-group">
					<label for="user-name" class="control-label">积分:</label>
					<div class="controls">
						<input type="text" id="count" name="count" value=""
							class="span m-wrap required" maxlength="8" />
					</div>
				</div>
			</form>

		</div>
		<div class="modal-footer">
			<a class="btn green " onclick="savecount()">保存</a> <a class="btn"
				onclick="countclose()">关闭</a>
		</div>
	</div>


	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/hzhb.png"
					style="vertical-align: text-bottom;" /> 卡券管理
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body">
			<form class="form-search" id="myform" action="${ctx}/card"
				method="post">
				<table>
					<tr>
						<td><label class="control-label"
							style="float: left; width: 80px">系统类型：</label> <select class=""
							id="mytype" style="width: 60%; height: 32px;"
							name="search_EQ_mytype">
								<option value="-1">--请选择--</option>
								<option value="1"
									<c:if test="${EQ_mytype==1}" > selected="selected" </c:if>>微信卡券</option>
								<option value="2"
									<c:if test="${EQ_mytype==2}" > selected="selected" </c:if>>积分卡券</option>
								<option value="3"
									<c:if test="${EQ_mytype==3}" > selected="selected" </c:if>>活动卡券</option>
								<option value="0"
									<c:if test="${EQ_mytype==0}" > selected="selected" </c:if>>未分类</option>
						</select></td>

						<td><label class="control-label"
							style="float: left; width: 80px">卡券类型：</label> <select class=""
							id="state" style="width: 60%; height: 32px;"
							name="search_EQ_type">
								<option value="0">--请选择--</option>
								<option value="DISCOUNT"
									<c:if test="${EQ_type=='DISCOUNT'}" > selected="selected" </c:if>>折扣券</option>
								<option value="CASH"
									<c:if test="${EQ_type=='CASH'}" > selected="selected" </c:if>>代金券</option>
								<option value="GIFT"
									<c:if test="${EQ_type=='GIFT'}" > selected="selected" </c:if>>礼品券</option>
						</select></td>

						<td><label class="control-label"
							style="float: left; width: 80px">卡券名称：</label> <input type="text"
							id="name" name="search_LIKE_name" maxlength="10"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_name}"></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td style="text-align: left;">
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
				<a href="javascript:;" class="btn blue" onclick="yiban()"><i class=""></i>一般优惠券</a> 
				<a href="javascript:;" class="btn blue" onclick="jifen()"><i class=""></i>积分优惠券</a> 
				<a href="javascript:;" class="btn blue" onclick="huodong()"><i class=""></i>活动优惠券</a> 
				<a href="javascript:;" class="btn blue" onclick="refresh()"><i class=""></i>刷新卡券</a>
			</div>
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
						<th rowspan="2" style="width: 30px;"><input type="checkbox"
							id="check_all" value="" class="check_all"></th>
						<th rowspan="2" style="width: 50px;">序号</th>
						<th rowspan="2">名称</th>
						<th rowspan="2">卡券类型</th>
						<th rowspan="2">系统类型</th>
						<th rowspan="2">银行</th>
						<th rowspan="2">有效期</th>
						<th rowspan="2">状态</th>
						<th colspan="3">卡券额度</th>
						<th rowspan="2">积分</th>
						<th rowspan="2">操作</th>
					</tr>
					<tr>

						<th>农商行</th>
						<th>商家</th>
						<th>小计</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="wxcard" varStatus="aa">
							<tr class="odd gradeX">
								<td><input type="checkbox" id="check_item"
									value="${wxcard.id}" class="check_item"></td>
								<td>${aa.count}</td>
								<td>${wxcard.name}</td>
								<td><c:choose>
										<c:when test="${wxcard.type=='CASH'}">代金券</c:when>
										<c:when test="${wxcard.type=='DISCOUNT'}">折扣券</c:when>
										<c:otherwise>礼品券</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${wxcard.mytype==0}">未分类</c:when>
										<c:when test="${wxcard.mytype==null}">未分类</c:when>
										<c:when test="${wxcard.mytype==1}">微信卡券</c:when>
										<c:when test="${wxcard.mytype==2}">积分优惠卡</c:when>

									</c:choose></td>
								<td><c:if test="${wxcard.isbank==1}">是</c:if> <c:if
										test="${wxcard.isbank!=1}">否</c:if></td>
								<td><c:if test="${wxcard.datetype==1}">
								${fn:substring(wxcard.starttime, 0, 10)}到${fn:substring(wxcard.endtime, 0, 10)}
								</c:if> <c:if test="${wxcard.datetype==2}">
										<c:if test="${wxcard.delaytime==0}">当天</c:if>
										<c:if test="${wxcard.delaytime!=0}">${wxcard.delaytime}天后</c:if>生效,${wxcard.usetime}天有效期
										</c:if></td>
								<td><c:choose>
										<c:when test="${wxcard.state==1}">正常</c:when>
										<c:when test="${wxcard.state==2}">待审核</c:when>
										<c:when test="${wxcard.state==3}">审核失败</c:when>
										<c:when test="${wxcard.state==4}">已过期</c:when>
										<c:when test="${wxcard.state==0}">已删除</c:when>
									</c:choose></td>
								<c:choose>
									<c:when test="${wxcard.type=='CASH'}">
										<td><c:if test="${wxcard.bankper==null}">-</c:if> <c:if
												test="${wxcard.bankper!=null}">${wxcard.bankper/100.0}元</c:if></td>
										<td><c:if test="${wxcard.shopper==null}">-</c:if> <c:if
												test="${wxcard.shopper!=null}">${wxcard.shopper/100.0}元</c:if></td>
										<td><c:if test="${wxcard.price==null}">-</c:if> <c:if
												test="${wxcard.price!=null}">${wxcard.price/100.0}元</c:if></td>
									</c:when>
									<c:when test="${wxcard.type=='DISCOUNT'}">
										<td><c:if test="${wxcard.bankper==null}">-</c:if> <c:if
												test="${wxcard.bankper!=null}">${wxcard.bankper}%</c:if></td>
										<td><c:if test="${wxcard.shopper==null}">-</c:if> <c:if
												test="${wxcard.shopper!=null}">${wxcard.shopper}%</c:if></td>
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td><c:if test="${wxcard.bankper==null}">-</c:if> <c:if
												test="${wxcard.bankper!=null}">${wxcard.bankper/100.0}元</c:if>
										</td>
										<td><c:if test="${wxcard.shopper==null}">-</c:if> <c:if
												test="${wxcard.shopper!=null}">${wxcard.shopper/100.0}元</c:if></td>
										<td><c:if test="${wxcard.price==null or wxcard.price==0}">-</c:if>
											<c:if test="${wxcard.price!=null and wxcard.price!=0}">${wxcard.price/100.0}元</c:if></td>
									</c:otherwise>
								</c:choose>
								<td><c:if test="${wxcard.mytype==2}">${wxcard.count}</c:if>
									<c:if test="${wxcard.mytype!=2}">-</c:if></td>
								<td><a href="javascript:;"
									onclick="showper('${wxcard.type}','${wxcard.bankper}','${wxcard.shopper}','${wxcard.price}',${wxcard.id})">额度分配</a>
									<c:if test="${wxcard.mytype==2}">
										<a href="javascript:void(0)"
											onclick="setcount(${wxcard.id},'${wxcard.count}')">设置积分</a>
									</c:if> <c:if test="${wxcard.isbank==1}">
										<a href="${ctx}/card/cancelbank/${wxcard.id}">取消银行券</a>
									</c:if> <c:if test="${wxcard.isbank!=1}">
										<a href="${ctx}/card/setbank/${wxcard.id}">设置为银行券</a>
									</c:if></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="12" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
		$("#bankper").blur(function (){
			//不判断额度限制
			/**
			if($("#type").val()=="DISCOUNT")
				{
				if(testzs($(this).val()))
					{
						if(parseInt($(this).val())<=100){
						$("#shopper").val(100-parseInt($(this).val()));
						}
					}
				}
				else if($("#type").val()=="CASH")
					{
					if(isprice($(this).val())&&(parseFloat($(this).val())<=parseFloat($("#price").val())))
					{
						$("#shopper").val((parseInt(parseFloat($("#price").val())*100)-parseInt(parseFloat($(this).val())*100))/100);
					}
					}
				else 
					{
					if(isprice($(this).val())&&isprice($("#shopper").val()))
						{
						$("#price").val((parseInt(parseFloat($(this).val())*100)+parseInt(parseFloat($("#shopper").val())*100))/100);
						}
					}
			**/
		});
		$("#shopper").blur(function (){
			//不判断额度限制
			/**
			if($("#type").val()=="DISCOUNT")
				{
				if(testzs($(this).val()))
					{
					if(parseInt($(this).val())<=100){
						$("#bankper").val(100-parseInt($(this).val()));
					}
					}
				}
			else if($("#type").val()=="CASH")
			{
			if(isprice($(this).val())&&(parseFloat($(this).val())<=parseFloat($("#price").val())))
			{
				$("#bankper").val((parseInt(parseFloat($("#price").val())*100)-parseInt(parseFloat($(this).val())*100))/100);
			}
			}
			else 
			{
			if(isprice($(this).val())&&isprice($("#bankper").val()))
				{
				$("#price").val((parseInt(parseFloat($(this).val())*100)+parseInt(parseFloat($("#bankper").val())*100))/100);
				}
			}
			**/
		});
	});
	function resetAll() {
		$("#name").val("");
		$("#mytype").val("-1");
		$("#state").val("0");
	}

	function refresh() {
		$("#freshform").submit();
	}

	function yiban() {
		var noticeids = "";
		$("[id=check_item]").each(function() {
			if ($(this).attr("checked") == "checked") {
				noticeids += "," + $(this).val();
			}
		});
		if (noticeids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		}
		var ids = noticeids.substring(1);
		$("#setform").append('<input name="ids" value='+ids+'>');
		$("#cardstate").val("1");
		$("#setform").submit();
	}
	function jifen() {
		var noticeids = "";
		$("[id=check_item]").each(function() {
			if ($(this).attr("checked") == "checked") {
				noticeids += "," + $(this).val();
			}
		});
		if (noticeids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		}
		var ids = noticeids.substring(1);
		$("#setform").append('<input name="ids" value='+ids+'>');
		$("#cardstate").val("2");
		$("#setform").submit();
	}
	function huodong() {
		var noticeids = "";
		$("[id=check_item]").each(function() {
			if ($(this).attr("checked") == "checked") {
				noticeids += "," + $(this).val();
			}
		});
		if (noticeids.length == 0) {
			window.parent.showAlert("请选择一条记录！");
			return;
		}
		var ids = noticeids.substring(1);
		$("#setform").append('<input name="ids" value='+ids+'>');
		$("#cardstate").val("3");
		$("#setform").submit();
	}
	function showper(type,bank,shop,price,id){
		$("#myid").val(id);
		$("#type").val(type);
		if(type=="DISCOUNT")
			{
			$("#bankper").val(bank);
			$("#shopper").val(shop);
			$("#price").val(price);
			$(".unit").html("%");
			$("#pricediv").css("display","none");
			}
		else if(type=="CASH")
			{
			$("#bankper").val(bank/100.0);
			$("#shopper").val(shop/100.0);
			$("#price").val(price/100.0);
			$(".unit").html("元");
			$("#pricediv").css("display","block");
			$("#price").attr("readonly","readonly");
			}
		else
			{
			$("#bankper").val(bank/100.0);
			$("#shopper").val(shop/100.0);
			$("#price").val(price/100.0);
			$(".unit").html("元");
			$("#pricediv").css("display","block");
			$("#price").attr("readonly","");
			}
		$("#per").modal('show');
	}
	function perclose() {
		$('#per').modal('hide');
		//$("#checkcotent").html("");
	}
	function countclose() {
		$('#setcount').modal('hide');
		//$("#checkcotent").html("");
	}
	function saveper()
	{
		//不判断分配限制
		/**var type=$("#type").val();
		if(type=="DISCOUNT")
		{
			if(!testzs($("#bankper").val()))
				{
				window.parent.showAlert("农商行额度输入错误");
				return;
				}
			
			if(parseInt($("#bankper").val())>100)
			{
			window.parent.showAlert("农商行额度不能超过100");
			return;
			}
			
			
			if(!testzs($("#shopper").val()))
			{
			window.parent.showAlert("商家额度输入错误");
			return;
			}
			if(parseInt($("#shopper").val())>100)
			{
			window.parent.showAlert("商家额度不能超过100");
			return;
			}
			if(parseInt($("#bankper").val())+parseInt($("#shopper").val())!=100)
				{
				window.parent.showAlert("额度相加不等于100");
				return;
				}
		}
	else if(type=="CASH")
		{
		if(!isprice($("#bankper").val()))
		{
		window.parent.showAlert("农商行额度输入错误");
		return;
		}
		if(!isprice($("#shopper").val()))
		{
			window.parent.showAlert("商家额度输入错误");
			return;
		}
		if(parseFloat($("#bankper").val())+parseFloat($("#shopper").val())!=parseFloat($("#price").val()))
		{
			window.parent.showAlert("额度相加不等于小计");
			return;
		}
		
		}
	else
		{
		if(!isprice($("#bankper").val()))
		{
		window.parent.showAlert("农商行额度输入错误");
		return;
		}
		if(!isprice($("#shopper").val()))
		{
			window.parent.showAlert("商家额度输入错误");
			return;
		}
		if(parseFloat($("#bankper").val())+parseFloat($("#shopper").val())!=parseFloat($("#price").val()))
		{
			window.parent.showAlert("额度相加不等于小计");
			return;
		}
		}**/
		$("#inputForm").submit();
	}
	function setcount(id,count)
	{
		$("#count").val(count);
		$("#countid").val(id);
		$("#setcount").modal('show');
	}
	function closecount()
	{
		$("#setcount").modal('hide');
	}
	function savecount()
	{
		if(!testzzs($("#count").val()))
			{
			window.parent.showAlert("积分输入错误!");
			return ;
			}
		$("#setcountform").submit();
	}
</script>
</html>