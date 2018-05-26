<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>详细志愿者信息</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
	<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
	<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>
</head>
<body>
<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				用户详情
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>用户详情
			</div>
		</div>
		<div class="portlet-body form">
		<form id="inputForm" class="form-horizontal">
			    <div class="control-group" >
					<label class="control-label">头像:</label>
					<div class="controls">
						<img alt="头像" style="width: 200px;"  src="${volunteer[1]}?imageView2/2/w/258/h/170/q/85" id="headimgurl" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">姓名:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap" style="width: 40%;"  disabled="disabled" 
						name="name" value="${volunteer[2]}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">性别:</label>
					<div class="controls">
						<input type="text" id="sex" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						name="sex" value="<c:if test="${volunteer[4]==1}" >男</c:if><c:if test="${volunteer[4]==2}" >女</c:if>"  maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">年龄:</label>
					<div class="controls">
						<input type="text" id="age" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="age" value="${volunteer[5]}" maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" id="phone" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="phone" value="${volunteer[7]}" maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">才能类型:</label>
					<div class="controls">
						 <textarea id="ability" rows="" cols="" style="width:40%; height: 50px;"disabled="disabled" name="ability">${volunteer[8]}</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">才能描述:</label>
					<div class="controls">
						 <textarea id="abilitydescrib" rows="" cols="" style="width:40%; height: 50px;"disabled="disabled" name="abilitydescrib">${volunteer[9]}</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">服务时间:</label>
					<div class="controls">
						<input type="text" id="servertime" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="servertime" value="${volunteer[6]}" maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">意向报酬:</label>
					<div class="controls">
						<input type="text" id="paytype" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="paytype" value="<c:if test='${volunteer[10]== 0}'>无偿</c:if><c:if test='${volunteer[10]== 1}'>有偿</c:if>" maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">参考价:</label>
					<div class="controls">
						<input type="text" id="pay" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="pay" value="<c:if test='${volunteer[10]== 0}'>免费</c:if><c:if test='${volunteer[10]== 1}'>${volunteer[11]}</c:if>" maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">状态:</label>
					<div class="controls">
						<input type="text" id="isshow" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="isshow" value="<c:if test='${volunteer[12]== 0}'>待审核</c:if><c:if test='${volunteer[12]== 2}'>拒绝</c:if><c:if test='${volunteer[12]== 1}'><c:if test='${volunteer[13]== 1}'>线上</c:if><c:if test='${volunteer[13]== 0}'>线下</c:if></c:if>" maxlength="30">
					</div>
				</div>

					<c:if test="${community!=null}">
					<div class="control-group">
					<label class="control-label">社区:</label>
					<div class="controls">
						<input type="text" id="isshow" class="span3 m-wrap" style="width: 40%;" disabled="disabled" 
						 name="isshow" value="${volunteer[18]}" maxlength="30">
					</div>
				</div>			
                   </c:if>
				<div class="form-actions">
						<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
				</div>
				</form>
		</div>
	</div>
</body>
</body>
</html>