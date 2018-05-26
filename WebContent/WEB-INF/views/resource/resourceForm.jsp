<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>菜单资源管理</title>
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">
jQuery(document).ready(function() {
	window.parent.scroll(0,0);
	var action = '${action}';
	$("#selectLevel").change(function(){
		if( action == 'create') {
			if($("#selectLevel").val() == 2) {
				$("#selectSupMenu").removeAttr("disabled");
			}else if($("#selectLevel").val() == 1){
				$("#selectSupMenu").val("0");
				$("#selectSupMenu").prop("disabled",true);
			}
		}
	});
	
	$("#resource-resdesc").keyup(function(){
		$("#count").html($("#resource-resdesc").val().length+"/255");
	});
});

function formsubmit(){
	if($("#resource-name").val() == null || $.trim($("#resource-name").val()) == '') {
		window.parent.showAlert("资源名称不能为空！");
		$(this).focus();
		return false;
	}else if($("#selectLevel").val() == null || $.trim($("#selectLevel").val()) == '0') {
		window.parent.showAlert("选择菜单级别！");
		$(this).focus();
		return false;
	}else if($.trim($("#selectLevel").val()) == '2' && $.trim($("#selectSupMenu").val()) == '0') {
		window.parent.showAlert("选择父菜单！");
		$(this).focus();
		return false;
	}else if($.trim($("#selectLevel").val()) == '2' && ($("#resource-url").val() == null || $.trim($("#resource-url").val()) == '')) {
		window.parent.showAlert("资源URL不能为空！");
		$(this).focus();
		return false;
	}else if($("#resource-sorts").val() == null || $.trim($("#resource-sorts").val()) == '') {
		window.parent.showAlert("菜单资源顺序不能为空！");
		$(this).focus();
		return false;
	}else if(!$("#resource-sorts").val().match(/^\d+$/)) {
		window.parent.showAlert("菜单资源顺序编号必须是一个正整数！");
		$(this).focus();
		return false;
	}else if($.trim($("#selectLevel").val()) == '1' && ($("#resource-logo").val() == null || $.trim($("#resource-logo").val()) == '')) {
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
					style="vertical-align: text-bottom;" /> <a href="${ctx}/system/resource">菜单资源管理</a>
				<i class="icon-angle-right"></i>&nbsp;菜单资源管理
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
			<form id="inputForm" action="${ctx}/system/resource/${action}" method="post" class="form-horizontal">
				<input type="hidden" name="id" value="${resource.id}" />
				<fieldset>
					<div class="control-group">
						<label for="resource-name" class="control-label">菜单资源名称:</label>
						<div class="controls">
							<input type="text" id="resource-name" name="name" style="height: 32px; width: 40%;" value="${resource.name}"
								class="span m-wrap required" maxlength="20" />
								<span name="easyTip"></span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" style="float:left">选择菜单级别：</label> 
						<div class="controls">
						<select class="span m-wrap" id="selectLevel" style="width:40%;" name="selectLevel" <c:if test="${action == 'update' }">disabled="disabled"</c:if>>					
							<c:choose>
								<c:when test="${level == '0'}">
									<option value="0" selected="selected">--选择菜单级别--</option>
								</c:when>
								<c:otherwise>
									<option value="0">--选择菜单级别--</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${level == '1'}">
									<option value="1" selected="selected">一级菜单</option>
								</c:when>
								<c:otherwise>
									<option value="1">一级菜单</option>
								</c:otherwise>
							</c:choose>
							<c:if test="${dontshow != 'dontshow'}">
							<c:choose>
								<c:when test="${level == '2'}">
									<option value="2" selected="selected">二级菜单</option>
								</c:when>
								<c:otherwise>
									<option value="2">二级菜单</option>
								</c:otherwise>
							</c:choose>
							</c:if>
						</select>
						</div>
					</div>
					
					
					<div class="control-group" id="selectSubDiv">
						<label class="control-label" style="float:left">选择父菜单：</label>
						<div class="controls">
						<select class="span m-wrap" id="selectSupMenu" style="width:40%;" name="selectSupMenu" <c:if test="${action == 'update' && sub == 'one'}">disabled="disabled"</c:if>>				
							<c:choose>
								<c:when test="${supMenuId == '0'}">
									<option value="0" selected="selected">--选择父菜单--</option>
								</c:when>
								<c:otherwise>
									<option value="0">--选择父菜单--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${SupMenus}" var="supmenu">
								<c:choose>
									<c:when test="${supmenu.id == supMenuId}">
										<option selected="selected" value="${supmenu.id}">${supmenu.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${supmenu.id}">${supmenu.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> 
						</div>
					</div>
					
					
					<div class="control-group" id="urlDiv">
						<label for="resource-url" class="control-label">菜单资源URL:</label>
						<div class="controls">
							<input type="text" id="resource-url" name="url" style="height: 32px; width: 40%;" value="${resource.url}"
								class="span m-wrap" maxlength="50" />
								<span name="easyTip"></span>
						</div>
					</div>
					
					<div class="control-group">
						<label for="resource-resdesc" class="control-label">菜单资源简介:</label>
						<div class="controls">
							<textarea class="span m-wrap" style="width: 40%" rows="3" maxlength="255" name="resdesc" id="resource-resdesc">${resource.resdesc}</textarea>
							<div id="count" style="color: gray;">0/255</div>
						</div>
					</div>
					
					<div class="control-group" id="urlDiv">
						<label for="resource-sorts" class="control-label">菜单资源显示循序:</label>
						<div class="controls">
							<input type="text" id="resource-sorts" name="sorts" style="height: 32px; width: 40%;" value="${resource.sorts}"
								class="span m-wrap" maxlength="50" />
								<span name="easyTip"></span>
						</div>
					</div>
					
					<div class="control-group" id="logoDiv">
						<label for="resource-logo" class="control-label">菜单资源logo名称:</label>
						<div class="controls">
							<input type="text" id="resource-logo" name="logo" style="height: 32px; width: 40%;" value="${resource.logo}"
								class="span m-wrap" maxlength="50"/>
								<span name="easyTip"></span>
						</div>
						<br/>
					</div>
					
					<div class="form-actions">
						<input id="submit_btn" class="btn blue" type="button" onclick="formsubmit()" value="保存" />&nbsp; 
						<input id="cancel_btn" class="btn" type="button" value="取消" onclick="history.back()" />
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
				//校验
				/* $("#inputForm")
						.validate(
								{
									rules : {
										name : {
											remote : "${ctx}/resource/checkName?rid=${resource.id}"
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
