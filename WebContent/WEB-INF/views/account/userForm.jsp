<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>后台用户管理</title>
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
	
	function goback() {
		window.location.href="${ctx}/system/user";
	}
	
	function formsubmit(){
		var action = '${action}';
		
		var telephone = $("#user-telephone").val();
		var realname = $("#user-realname").val();;
		
		var userrole = $("#user-role").val();
		
		if(realname == null || $.trim(realname) == '') {
			window.parent.showAlert("用户名称不能为空！");
			$(this).focus();
			return false;
		}else if(telephone == null || $.trim(telephone) == '') {
			window.parent.showAlert("用户手机号码不能为空！");
			$(this).focus();
			return false;
		}else if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(telephone))) {
			window.parent.showAlert("手机号码格式不对！");
			$(this).focus();
			return false;
		}else if(userrole == '0') {
			window.parent.showAlert("请为用户分配角色！");
			$(this).focus();
			return false;
		}
		
		$("#inputForm").submit();
	}
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> <a href="${ctx}/system/user">用户管理</a>
				<i class="icon-angle-right"></i>&nbsp;创建/修改用户
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>创建/修改用户
			</div>
		</div>
		<div class="portlet-body form">
			<form id="inputForm" action="${ctx}/system/user/${action}" method="post" class="form-horizontal">
			
					<input type="hidden" name="id" value="${user.id}" />
					
					<div class="control-group">
						<label for="user-telephone" class="control-label">用户手机:</label>
						<div class="controls">
							<input type="text" id="user-telephone" name="telephone"
								style="height: 32px; width: 30%;" class="span m-wrap required"
								value="${user.telephone}" maxlength="20" /><span name="easyTip"></span>
						</div>
					</div>
					
					<div class="control-group">
						<label for="user-realname" class="control-label">用户姓名:</label>
						<div class="controls">
							<input type="text" id="user-realname" name="realname" autocomplete="off"
								style="height: 32px; width: 30%;" class="span m-wrap"
								value="${user.realname}" maxlength="15" />
						</div>
					</div>
					
					
					<div class="control-group" style="display:none;">
						<label class="control-label">用户姓名:</label>
						<div class="controls">
							<input type="text" style="height: 32px; width: 30%;" class="span m-wrap" maxlength="15" />
						</div>
					</div>
					
					<c:if test="${user.role.name != 'admin' && user.role.id != '11'}">
						<div class="control-group">
							<label class="control-label" for="user-role">选择角色：</label> 
							<div class="controls">
								<select class="span m-wrap" id="user-role" style="width:30%;" name="role.id">
									<c:choose>
										<c:when test="${roleId == '0'}">
											<option value="0" selected="selected">--选择用户角色--</option>
										</c:when>
										<c:otherwise>
											<option value="0">--选择用户角色--</option>
										</c:otherwise>
									</c:choose>
									<c:forEach items="${Roles}" var="roles">
										<c:choose>
											<c:when test="${roles.id == roleId}">
												<option selected="selected" value="${roles.id}">${roles.name}</option>
											</c:when>
											<c:otherwise>
												<option value="${roles.id}">${roles.name}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
						</div>
					</c:if>
					
					<input type="hidden" id="page" name="page" value="${page}">
					
					<div class="form-actions">
						<input id="submit_btn" class="btn blue" type="button" onclick="formsubmit()" value="保存" />&nbsp; 
						<input id="cancel_btn" class="btn" type="button" value="取消" onclick="goback()" />
					</div>
			</form>
		</div>
	</div>
	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			window.parent.scroll(0,0);
			$("#inputForm").validate({
								rules : {
									name : {
										remote : "${ctx}/system/user/checkName?uid=${user.id}"
									},
									
									telephone : {
										remote : "${ctx}/system/user/checkTelephone?uid=${user.id}"
									}
									
			
								},
								messages : {
									name : {
										remote : "<span style=\"color:red;\">&nbsp;&nbsp;用户登录名已存在</span>"
									},
									
									telephone : {
										remote : "<span style=\"color:red;\">&nbsp;&nbsp;该手机号码已被注册</span>"
									}
								}
							});

			});
	</script>
</body>
</html>
