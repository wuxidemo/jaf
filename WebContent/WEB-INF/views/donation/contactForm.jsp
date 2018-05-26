<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>社区联系方式-编辑</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				社区联系方式-编辑
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>社区联系方式-编辑
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/community/saveupdate" id="inputForm" class="form-horizontal" method="post">
			
				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						设置该联系方式是方便企业捐献时向社区进行预约。
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">姓:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" id="firstname" name="firstname" style="width: 40%;" value="${community.firstname}" maxlength="2">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">名:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" id="lastname" name="lastname" style="width: 40%;" value="${community.lastname}" maxlength="2">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">性别:</label>
					<div class="controls">
						<select class="span2 m-wrap" style="width: 40%;" name="contactsex" id="contactsex">
							<option value="-1">--请选择性别--</option>
							<option value="1" <c:if test="${community.contactsex == 1}">selected="selected"</c:if>>男</option>
							<option value="2" <c:if test="${community.contactsex == 2}">selected="selected"</c:if>>女</option>
						</select>
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" class="span3 m-wrap" id="contactphone" name="contactphone" style="width: 40%;" value="${community.contactphone}">
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
					<input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function formsubmit() {
			var firstname = $("#firstname").val();
			var lastname = $("#lastname").val();
			var contactsex = $("#contactsex").val();
			var contactphone = $("#contactphone").val();
			
			if(firstname == '') {
				window.parent.showAlert("请填写联系人的姓");
				return false;
			}else if(lastname == '') {
				window.parent.showAlert("请填写联系人的名");
				return false;
			}else if(contactsex == '-1') {
				window.parent.showAlert("请选择联系人的性别");
				return false;
			}else if(contactphone == '') {
				window.parent.showAlert("请填写联系人的联系电话");
				return false;
			}else if(contactphone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1
					&& contactphone.search(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/) == -1) {
				window.parent.showAlert("联系电话格式不对");
				return false;
			}else{
				$("#inputForm").submit();
			}
		}
		
	</script>
</body>
</html>
