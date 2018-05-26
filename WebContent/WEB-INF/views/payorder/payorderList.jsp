<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%

	String name=""; 
	if(request.getParameter("search_LIKE_nickname")!=null) {
		name=new String (request.getParameter("search_LIKE_nickname").getBytes("ISO-8859-1"),"UTF-8");
	}
	
%>


<html>
<head>
	<title>支付管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">
function resetAll() {
	$("#nickname").val('');
	
}
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				支付管理
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
			<form class="form-search" action="${ctx}/payorder" method="post">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">付款昵称：</label> 
					<input type="text" id="nickname" name="search_LIKE_nickname" maxlength="20" style="float:left;width: 40%; height: 32px;" value="${LIKE_nickname }"> 
				</td>
				<td>
					
				</td>
				<td>
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
					<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
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
			<c:if test="${not empty message}" >
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 15%;">付款金额</th>
						<th style="width: 15%;">商户id </th>
						<th style="width: 15%;">交易单号</th>
						<th style="width: 15%;">付款昵称</th>						
						<th style="width: 15%;">商户单号</th>
						<th >支付方式</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${payorderList.totalPages!=0}">
					<c:forEach items="${payorderList.content}" var="payorder" varStatus="status">
						<tr>
							<td style="vertical-align: middle;">${payorder.total}</td>
							<td style="vertical-align: middle;">${payorder.merchantid}</td>
							<td style="vertical-align: middle;">${payorder.ordernum}</td>
							<td style="vertical-align: middle;">${payorder.nickname}</td>
							<td style="vertical-align: middle;">${payorder.translatenum}</td>
							<td style="vertical-align: middle;">${payorder.paytype}</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${payorderList.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${payorderList}" paginationSize="5"/>
		</div> 
	</div>
	
	
	
</body>
</html>