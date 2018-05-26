<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>社区联系方式</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	function resetAll() {
		$("#fullname").val("");
		$("#community").val("-1");
	}
	
	var clearcomid = '';
	function askforclear(commid) {
		clearcomid = commid;
		window.parent.showConfirm("你确定要清除该社区捐赠联系人的信息吗？该操作不会删除社区信息",sureclear)
	}
	
	function sureclear() {
		var clearurl = '${ctx}/community/clearcontact?commid='+clearcomid;
		$.post(clearurl,function(data){
			window.parent.showAlert(data.msg);
			if(data.result == '1') {
				$("#full"+clearcomid).html("");
				$("#phone"+clearcomid).html("");
				$("#sex"+clearcomid).html("");
			}
		});
	}
	
</script>
<body>
	<form action="" id="deleteForm" style="display: none;"></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				社区联系方式
			</h3>
		</div>
	</div>
	
	<div class="portlet box grey" style="margin-bottom:0px;height:auto; <c:if test="${commuser == 1}">display:none;</c:if> ">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/community/viewcontact" method="post">
			<table style="width: 100%">
				<tr>
					<td style="width:33%;">
						<label class="control-label" style="float:left">联系人：</label> 
						<input type="text" id=fullname name="search_LIKE_fullname" maxlength="20" style="float:left;width: 60%; height: 32px;" value="${LIKE_fullname }"> 
					</td>
					<td style="width:33%;">
						<label class="control-label" style="float:left">社区：</label> 
						<select id="community" style="width:60%; height: 32px;" name="search_EQ_community.id">
							<c:choose>
								<c:when test="${EQ_community_id == '-1'}">
									<option value="-1" selected="selected">--选择社区--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择社区--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${communitys}" var="community">
								<c:choose>
									<c:when test="${community.id == EQ_community_id}">
										<option selected="selected" value="${community.id}">${community.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${community.id}">${community.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td style="width:33%;">
						<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
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
		</div>
		 <div class="portlet-body">
			<c:if test="${not empty message}" >
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>社区</th>
						<th>联系人</th>
						<th>联系方式</th>
						<th>性别</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${comms.totalPages!=0}">
					<c:forEach items="${comms.content}" var="comm" varStatus="status">
						<tr>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${comm.name != null}">${comm.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;" id="full${comm.id}">
								<c:if test="${comm.fullname != null}">${comm.fullname}</c:if>&nbsp;
							</td>
							<td style="vertical-align: middle;" id="phone${comm.id}">
								<c:if test="${comm.contactphone != null}">${comm.contactphone}</c:if>&nbsp;
							</td>
							<td style="vertical-align: middle;" id="sex${comm.id}">
								<c:if test="${comm.contactsex != null && comm.contactsex == 1}">男</c:if>&nbsp;
								<c:if test="${comm.contactsex != null && comm.contactsex == 2}">女</c:if>
							</td>
							<td style="vertical-align: middle;">
								<a href="javascript:;" onclick="askforclear('${comm.id}')" >删除</a>&nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${comms.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="5" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${comms}" paginationSize="5"/>
		</div> 
	</div>
</body>
</html>