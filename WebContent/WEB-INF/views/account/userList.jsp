<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>用户管理</title>
	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<%@ include file="../quote.jsp"%>

<script type="text/javascript">
	function resetAll() {
		$("#userName").val("");
		$("#trueName").val("");
		$("#selectroles").val("0");
		$("#selectenabled").val("-1");
	}
	
	var userId = '';
	var cPage = '';
	function disable(userid,cpage) {
		userId = userid;
		cPage = cpage;
		window.parent.showConfirm("你确定要冻结该账号吗？",sureDisable);
	}
	function sureDisable() {
		var url = "${ctx}/system/user/disActivate/"+userId+"?page="+cPage;
		window.location.href = url;
	}
	
	function undisable(userid,cpage) {
		userId = userid;
		cPage = cpage;
		window.parent.showConfirm("你确定要激活该账号吗？",sureUnDisable);
	}
	function sureUnDisable() {
		var url = "${ctx}/system/user/activate/"+userId+"?page="+cPage;
		window.location.href = url;
	}
	var uId='';
	function remind(uid){
		uId=uid;
		window.parent.showConfirm("你确定要重置该账号密吗？",suDisable);
	}
	function suDisable(){
		var url="${ctx}/system/user/rest/"+uId;
		window.location.href = url;
	}
</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				用户管理
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
			<form class="form-search" action="${ctx}/system/user" method="post">
			<table style="width: 100%">
				<tr>
					<td style="width: 33%">
						<label class="control-label" style="float:left">用户账号：</label> 
						<input type="text" id="userName" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%; height: 32px;" class="" value="${LIKE_name }"> 
					</td>
					<td style="width: 33%">
						<label class="control-label" style="float:left">用户姓名：</label> 
						<input type="text" id="trueName" name="search_LIKE_realname" maxlength="20" style="float:left;width: 60%; height: 32px;" class="" value="${LIKE_realname}"> 
					</td>
					<td style="width: 33%">
						<label class="control-label" style="float:left">选择角色：</label> 
						<select class="" id="selectroles" style="width:60%; height: 32px;" name="search_EQ_role.id">
							<c:choose>
								<c:when test="${EQ_role_id == '0'}">
									<option value="0" selected="selected">--选择用户角色--</option>
								</c:when>
								<c:otherwise>
									<option value="0">--选择用户角色--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${Roles}" var="role">
								<c:choose>
									<c:when test="${role.id == roleId}">
										<option selected="selected" value="${role.id}">${role.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${role.id}">${role.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
					
				<tr>
					<td style="width: 33%">
						<label class="control-label" style="float:left;">选择状态：</label> 
						<select class="" id="selectenabled" style="width:60%; height: 32px;" name="search_EQ_enabled">
							<c:choose>
								<c:when test="${EQ_enabled == '-1'}">
									<option value="-1" selected="selected">--选择用户状态--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择用户状态--</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${EQ_enabled == '1'}">
									<option value="1" selected="selected">正常状态</option>
								</c:when>
								<c:otherwise>
									<option value="1">正常状态</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${EQ_enabled == '0'}">
									<option value="0" selected="selected">禁用状态</option>
								</c:when>
								<c:otherwise>
									<option value="0">禁用状态</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td style="width: 33%">
						&nbsp;
					</td>
					<td style="width: 33%">
						<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
				<a href="${ctx}/system/user/create" class="btn blue"> 新增</a> 
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 7%;">序号</th>
						<th style="width: 10%;">用户姓名</th>
						<th style="width: 10%;">用户角色</th>
						<th style="width: 10%;">登录账号</th>
						<th style="width: 15%;">创建时间</th>
						<th style="width: 13%;">关联商家名称</th>
						<th style="width: 10%;">所属社区名称</th>
						<th style="width: 10%;">用户状态</th>
						<th style="width: 15%;">用户管理</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${Users.totalPages!=0}">
					<c:forEach items="${Users.content}" var="user" varStatus="status">
						<tr>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${user.realname != null}">${user.realname}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<span id="editVal${status.count}" style="border:0;background-color:transparent;">${user.role.name}</span>  
								<%-- <c:if test="${user.role != null}">${user.role.name}</c:if> &nbsp; --%>
							</td>
							<td style="vertical-align: middle;"><c:if test="${user.telephone != null}">${user.telephone}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${user.registertime != null}">${fn:substring(user.registertime, 0, 19)}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${user.merchant.name != null}">${user.merchant.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;"><c:if test="${user.community.name != null}">${user.community.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:if test="${user.enabled == '1'}"><span class="label label-success">正常</span></c:if>
								<c:if test="${user.enabled == '0'}"><span class="label label-warning">冻结</span></c:if> &nbsp;
							</td>
							<td style="vertical-align: middle;">
								<c:if test="${user.role.name != 'admin' && user.enabled == '1' }">
									<a href="${ctx}/system/user/update/${user.id}?page=${Users.number+1}">修改信息</a>&nbsp;
								</c:if>
								<c:if test="${user.role.name != 'admin' && user.enabled == '1'}">
									<a href="javascript:;" onclick="disable('${user.id}','${Users.number+1}')">冻结账号</a>&nbsp;
									<%-- <a href="${ctx}/system/user/rest/${user.id}">重置密码</a>&nbsp; --%>
									<a href="javascript:;"onclick="remind('${user.id}')">重置密码</a>&nbsp;
								</c:if>
								<c:if test="${user.enabled == '0'}">
									<a href="javascript:;" onclick="undisable('${user.id}','${Users.number+1}')">激活账号</a>&nbsp;
								<%-- <a href="${ctx}/system/user/rest/${user.id}">重置密码</a>&nbsp; --%>
								<a href="javascript:;"onclick="remind('${user.id}')">重置密码</a>&nbsp;
								
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${Users.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="8" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${Users}" paginationSize="5"/>
		</div>
	</div>
</body>
</html>