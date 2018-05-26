<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>菜单资源管理</title>
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
	jQuery(document).ready(function() {
		window.parent.scroll(0, 0);
		$("#resource-resdesc").keyup(function() {
			$("#count").html($("#resource-resdesc").val().length + "/255");
		});
	});

	function formsubmit() {
		var menuLogo = "${showLogo}";
		var pResId = "${presId}";
		var pName = "${pname}";
		var action = "${action}";
		if ($("#resource-name").val() == null
				|| $.trim($("#resource-name").val()) == '') {
			window.parent.showAlert("资源名称不能为空！");
			$(this).focus();
			return false;
		} else if (action == 'create2'
				&& pResId != 'level1'
				&& ($("#resource-url").val() == null || $.trim($(
						"#resource-url").val()) == '')) {
			window.parent.showAlert("资源URL不能为空！");
			$(this).focus();
			return false;
		} else if (action == 'update2'
				&& pName != ''
				&& ($("#resource-url").val() == null || $.trim($(
						"#resource-url").val()) == '')) {
			window.parent.showAlert("资源URL不能为空！");
			$(this).focus();
			return false;
		} else if ($("#resource-sorts").val() == null
				|| $.trim($("#resource-sorts").val()) == '') {
			window.parent.showAlert("菜单资源顺序不能为空！");
			$(this).focus();
			return false;
		} else if (!$("#resource-sorts").val().match(/^\d+$/)) {
			window.parent.showAlert("菜单资源顺序编号必须是一个正整数！");
			$(this).focus();
			return false;
		} else if (menuLogo == 'yes'
				&& ($("#resource-logo").val() == null || $.trim($(
						"#resource-logo").val()) == '')) {
			window.parent.showAlert("一级菜单logo名称不能为空！");
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
					style="vertical-align: text-bottom;" />菜单资源管理
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>菜单资源管理
			</div>
		</div>
		<div class="portlet-body form">
			<form id="inputForm" action="${ctx}/system/resource/${action}"
				method="post" class="form-horizontal">
				<input type="hidden" name="resId" value="${resId}" /> <input
					type="hidden" name="presId" value="${presId}" />
				<fieldset>
					<div class="control-group">
						<label for="resource-name" class="control-label">菜单资源名称:</label>
						<div class="controls">
							<input type="text" id="resource-name" name="resourceName"
								style="height: 32px; width: 40%;" value="${resourceName}"
								class="span m-wrap required" maxlength="20" /> <span
								name="easyTip"></span>
						</div>
					</div>

					<div class="control-group">
						<label for="resource-name" class="control-label">父级菜单资源名称:</label>
						<div class="controls">
							<input type="text" id="resource-name" name="pname"
								style="height: 32px; width: 40%;" value="${pname}"
								class="span m-wrap required" maxlength="20" disabled="disabled" />
						</div>
					</div>

					<div class="control-group" id="urlDiv">
						<label for="resource-url" class="control-label">菜单资源URL:</label>
						<div class="controls">
							<input type="text" id="resource-url" name="resourceUrl"
								style="height: 32px; width: 40%;" value="${resourceUrl}"
								class="span m-wrap" maxlength="50" /> <span name="easyTip"></span>
						</div>
					</div>

					<div class="control-group">
						<label for="resource-resdesc" class="control-label">菜单资源简介:</label>
						<div class="controls">
							<textarea class="span m-wrap" style="width: 40%" rows="3"
								maxlength="255" name="resourceDesc" id="resource-resdesc">${resourceDesc}</textarea>
							<div id="count" style="color: gray;">0/255</div>
						</div>
					</div>

					<div class="control-group" id="urlDiv">
						<label for="resource-sorts" class="control-label">菜单资源显示循序:</label>
						<div class="controls">
							<input type="text" id="resource-sorts" name="resourceSorts"
								style="height: 32px; width: 40%;" value="${resourceSorts}"
								class="span m-wrap" maxlength="8" /> <span name="easyTip"></span>
						</div>
					</div>

					<c:if test="${showLogo == 'yes' }">
						<div class="control-group" id="logoDiv">
							<label for="resource-logo" class="control-label">菜单资源logo名称:</label>
							<div class="controls">
								<input type="text" id="resource-logo" name="resourceLogo"
									style="height: 32px; width: 40%;" value="${resourceLogo}"
									class="span m-wrap" maxlength="50" /> <span name="easyTip"></span>
							</div>
							<br />
						</div>
					</c:if>

					<div class="form-actions">
						<input id="submit_btn" class="btn blue" type="button"
							onclick="formsubmit()" value="保存" />&nbsp; <input
							id="cancel_btn" class="btn" type="button" value="取消"
							onclick="history.back()" />
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<script
		src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"
		type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"
		type="text/javascript"></script>
	<script>
		$(document).ready(function() {
			//聚焦第一个输入框
			//校验
			/* $("#inputForm")
					.validate(
							{
								rules : {
									name : {
										remote : "${ctx}/system/resource/checkName?rid=${resource.id}"
									}
								},
								messages : {
									name : {
										remote : "菜单资源名已存在"
									}
								}
							}); */

		});
	</script>
</body>
</html>
