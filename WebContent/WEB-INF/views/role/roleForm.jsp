<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>角色管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/mydatetimepicker.css" />
	<script type="text/javascript" src="${ctx}/static/mt/media/js/mydatetimepicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		window.parent.scroll(0,0);
		$("#role-desc").keyup(function(){
			$("#count").html($("#role-desc").val().length+"/255");
		});
	});
	
	function formsubmit() {
		if($.trim($("#role-name").val()).length == 0) {
			window.parent.showAlert("角色名称不能为空！");
			return false;
		}else{
			$("#inputForm").submit();
		}
	}
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> <a href="${ctx}/system/role">角色管理</a>
				<i class="icon-angle-right"></i>&nbsp;创建角色
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>创建角色
			</div>
		</div>
		<div class="portlet-body form">
			<form id="inputForm" action="${ctx}/system/role/${action}" method="post" class="form-horizontal">
				<input type="hidden" name="id" value="${role.id}" />
				<fieldset>
					<div class="control-group">
						<label for="role-name" class="control-label">角色名称:</label>
						<div class="controls">
							<input type="text" id="role-name" name="name" style="height: 32px; width: 50%;" value="${role.name}"
								class="span m-wrap required" maxlength="20" />
								<span name="easyTip"></span>
						</div>
					</div>
					<div class="control-group">
					<label for="role-desc" class="control-label">角色简介:</label>
						<div class="controls">
							<textarea class="span m-wrap" style="width: 50%;height: 20%;max-width: 50%;max-height: 20%" rows="3" maxlength="255" name="roledesc" id="role-desc">${role.roledesc}</textarea>
							<div id="count" style="color: gray;">0/255</div>
						</div>
					</div>
					<input type="hidden" id="page" name="page" value="${page}">
					<div class="form-actions">
						<input id="submit_btn" class="btn blue" type="button" value="保存"  onclick="formsubmit()"/>&nbsp; 
						<a class="btn grey" href="${ctx}/system/role?page=${page}" class="btn">返回</a>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
							//聚焦第一个输入框
				$("#user-name").focus();
				//校验
				$("#inputForm")
						.validate(
								{
									rules : {
										name : {
											remote : "${ctx}/system/role/checkName?rid=${role.id}"
										}
									},
									messages : {
										name : {
											remote : "<span style=\"color:red;\">角色名已存在</span>"
										}
									}
								});

			});
	</script>
</body>
</html>
