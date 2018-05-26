<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>设备绑定商家</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">
	var bindedstr = '${useridstr}';
	var merchantid='${merchant.id}'
	var idArr = bindedstr.split(",");
	$(document).ready(function(){
		initChecked();
	});
	
	function initChecked() {
		$(".check_item").each(function(){
			var valuestr = $(this).val();
			var valuemername=$(this).attr("mername");
			var valuemerid=$(this).attr("merid");
			if(idArr.indexOf(valuestr) >= 0){
				$(this).prop("checked",true);
			}
			if(merchantid != valuemerid && valuemername != null && valuemername.length >0) {
				$(this).prop("disabled",true);
			}
			
		});
	}

	function formsubmit() {
		
		var idstr = "";
		$(".check_item").each(function(){
			if($(this).prop("checked") == true) {
				idstr += "," + $(this).val();
			}
		});
		
		if(idstr == '') {
			window.parent.showAlert("你没有选择任何用户！");
		}else{
			$("#subForm").append('<input type="hidden" name="userids" value="'+idstr.substring(1)+'"/>');
			$("#subForm").submit();
		}
	}
</script>
<body>
	<form action="${ctx}/merchant/${action}" method="post" id="subForm" style="display:none;">
		<input type="hidden" name="merchantid" value="${merchant.id}"/>
	</form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />绑定账号
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>绑定账号
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form">
				<form id="inputForm" action="${ctx}/shake/${action}" method="post" class="form-horizontal">
					<input type="hidden" name="merchantid" value="${merchant.id}"/>
					<div class="control-group">
						<label for="merchantname" class="control-label">商家名称:</label>
						<div class="controls">
							<input type="text" id="merchantname" name="merchantname" readonly="readonly" style="height: 32px; width: 50%;" value="${merchant.name}" class="span m-wrap" maxlength="20" />
						</div>
					</div>
					<div class="control-group">
						<label for="username" class="control-label">选择账号:</label>
						<div class="controls">
							<div style="margin-top:0px; font-size:1.2em;">
								<c:forEach items="${userlist }" var="user" varStatus="status">
									<div style="margin-left:10px;margin-top:5px;float:left;width:400px;height:30px;">
										<input type="checkbox" value="${user.id}" class="check_item" mername="${user.merchant.name}" merid="${user.merchant.id}">&nbsp;&nbsp;${user.name}<span style="color:red;margin-top:2px;font-size:0.8em;">
										<c:if test="${user.merchant != null}">(${user.merchant.name})</c:if></span>&nbsp;&nbsp;
									</div>
									<c:if test="${(status.index+1)%3 == 0 }"><br/><br/></c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="form-actions">
						<input id="submit_btn" class="btn blue" type="button" value="保存"  onclick="formsubmit()"/>&nbsp; 
						<a class="btn grey" href="javascript:;" onclick="history.back()" class="btn">返回</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
