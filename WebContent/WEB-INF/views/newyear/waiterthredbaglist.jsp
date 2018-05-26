<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>最美服务员投票红包中奖名单</title>
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
		$("#datepicker").val("");
	}
	
</script>
<body>
	<form action="" id="deleteForm" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				红包中奖名单
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
			<form class="form-search" action="${ctx}/waiter/listwaiterthredbag" method="post">
			<table style="width: 100%">
			<tr>
				<td style="width:33%;">
					<label class="control-label" style="float:left">微信昵称：</label> 
					<input type="text" id="nickname" name="search_LIKE_nickname" maxlength="20" style="float:left;width: 60%; height: 32px;" class="" value="${LIKE_nickname }"> 
				</td>
				<td style="width:33%;">
					<label class="control-label"
							style="float: left; width: 100px">中奖时间：</label><input type="text"
							id="datepicker" name="search_EQ_createtime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${EQ_createtime}">
				</td>
				<td style="width:33%;">
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
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
			<div class="actions">
				<a href="javascript:;">&nbsp;</a> 
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
						<th>微信昵称</th>
						<th>投票对象</th>
						<th>中奖时间</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${redbags.totalPages!=0}">
					<c:forEach items="${redbags.content}" var="redbag" varStatus="status">
						<tr>
							<td style="vertical-align: middle;"><c:if test="${redbag.nickname != null}">${redbag.nickname}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag.waiter.name != null}">${redbag.waiter.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${redbag.createtime != null}">${fn:substring(redbag.createtime,0,16)}</c:if> &nbsp;</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${redbags.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="3" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${redbags}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>