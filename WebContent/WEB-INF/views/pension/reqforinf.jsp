<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta name="format-detection"content="telephone=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 2016-4-22 #袁伟 版本[1.0] -->
<title>申请信息</title>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<style type="text/css">
.weui_cell_bd{
	color: #494949;
	font-size: 14px;
}
.weui_cell_ft{
	color: #9FA0A0;
	font-size: 12px;
}
.weui_btn_primary{
	background-color: #F8BA1E;
	font-size: 15px;
}
.weui_btn_primary:ACTIVE{
	background-color: #e3a706;
}
.button{
	position: fixed;
	bottom: 45px;
	left: 0px;
	width: 100%;
}
.jx_1{
	height: 12px;
	background-color: #eeeff0;
	width: 100%;
}
.weui_textarea{
	font-size: 13px;
}
</style>
</head>
<body>
	<div class="weui_cells">
		<!-- 姓名  -->
		<div class="weui_cell">
			<div class="weui_cell_bd weui_cell_primary">
				<p>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</p>
			</div>
			<div class="weui_cell_ft">${penapply.name}</div>
		</div>
		<!-- 性别  -->
		<div class="weui_cell">
			<div class="weui_cell_bd weui_cell_primary">
				<p>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</p>
			</div>
			<c:choose>
				<c:when test="${penapply.sex==1}">
					<div class="weui_cell_ft">男</div>
				</c:when>
				<c:otherwise>
					<div class="weui_cell_ft">女</div>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 年龄  -->
		<div class="weui_cell">
			<div class="weui_cell_bd weui_cell_primary">
				<p>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</p>
			</div>
			<div class="weui_cell_ft">${penapply.age}</div>
		</div>
		<!-- 联系方式  -->
		<div class="weui_cell">
			<div class="weui_cell_bd weui_cell_primary">
				<p>联系方式</p>
			</div>
			<div class="weui_cell_ft">${penapply.telephone}</div>
		</div>
		<!-- 社区  -->
		<div class="weui_cell"
			style="border-bottom: 1px solid #eeeff0;">
			<div class="weui_cell_bd weui_cell_primary">
				<p>家庭住址</p>
			</div>
			<div class="weui_cell_ft">${penapply.address}</div>
		</div>
		<c:if test="${penapply.pensionAct.id == null || penapply.pensionAct.id == ''}">
			<div class="jx_1"></div>
			<!-- 报修内容(标题区) -->
			<div class="weui_cell weui_cells_form">
				<div class="weui_cell_hd">
					<label class="weui_label">申请描述</label>
				</div>
			</div>
			<!-- 报修内容(内容区) -->
			<div class="weui_cell weui_cells_form"
				style="border-bottom: 1px solid #eeeff0; font-size: 13px;">
				<!-- 报修文字内容(name="content") -->
				<div class="weui_cell_bd weui_cell_primary">
					<textarea class="weui_textarea" name="content" maxlength="200"
						onblur="checkClear(this,1,'请填写申请描述')" id="text_content"
						placeholder="暂未填写服务需求" rows="4" readonly="readonly">${penapply.content}</textarea>
				</div>
			</div>
		</c:if>
		<!-- 按钮 -->
		<div class="container" id="container">
			<div class="button">
				<div class="bd spacing">
					<a href="javascript:;" onclick="gotobj()"
						class="weui_btn weui_btn_primary">重新编辑</a>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
/*跳转到编辑页面*/
function gotobj(){
	window.location.href = "${ctx}/wxpage/updatepen?id=${penapply.id}";
}
</script>
</html>