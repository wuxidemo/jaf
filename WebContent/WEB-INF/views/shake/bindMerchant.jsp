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
	function formsubmit() {
		if($("#merchantid").val() == '-1') {
			window.parent.showAlert("你没有选择商家！");
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
				<img src="${ctx}/static/images/sbgl.png"
					style="vertical-align: text-bottom;" />&nbsp;绑定商家
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>绑定商家
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form">
				<form id="inputForm" action="${ctx}/shake/${action}" method="post" class="form-horizontal">
					<div class="control-group">
						<label for="deviceid" class="control-label">设备id:</label>
						<div class="controls">
							<input type="text" id="deviceid" name="deviceid" readonly="readonly" style="height: 32px; width: 50%;" value="${deviceid}" class="span m-wrap" maxlength="20" />
						</div>
					</div>
					<div class="control-group">
						<label for="merchant.id" class="control-label">选择商家:</label>
						<div class="controls">
							<select id="merchantid" name="merchant.id"  class="span m-wrap" style="height: 32px; width: 50%;">
								<option value="-1">--选择商家--</option>
								<c:forEach items="${merchantList }" var="mer">
									<option value="${mer.id }">${mer.name }</option>
								</c:forEach>
							</select>
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
