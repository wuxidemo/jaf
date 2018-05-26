<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>信息不完善</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				&nbsp;商户信息   
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>商户信息
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form" style="min-height: 600px;height: auto;">
				<div style="height:500px; width:100%;font-size:20px;">
					<c:if test="${not empty msg }">
						${msg }
					</c:if>
					<c:if test="${empty msg }">
						您的商户信息不完善，等待运营方为你完善信息，之后方可操作！
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
