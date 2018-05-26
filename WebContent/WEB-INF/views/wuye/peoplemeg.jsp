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
<!-- 2016-4-20 #袁伟 版本[1.0] -->
<title>个人信息</title>
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
.weui_cell_ft_1:after {
    content: " ";
    display: inline-block;
    -webkit-transform: rotate(45deg);
    transform: rotate(45deg);
    height: 6px;
    width: 6px;
    border-width: 2px 2px 0 0;
    border-color: #C8C8CD;
    border-style: solid;
    position: relative;
    top: -2px;
    top: -1px;
    margin-left: .3em;
}
.weui_cells{
	background-color:#eeeff0;
}
.weui_cell{
	background-color: #fff;
}
.weui_btn_primary{
	background-color: #F8BA1E;
	font-size: 15px;
	margin-top: 40px;
}
.weui_btn_primary:ACTIVE{
	background-color: #e3a706;
}
</style>
</head>
<body>
	<div class="weui_cells">
		<!-- 头像  -->
		<div class="weui_cell">
			<div class="weui_cell_hd">
				<label class="weui_label">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像</label>
			</div>
			<div class="weui_cell_bd weui_cell_primary head_img" id="tianjiadiv">
				<img id="tianjia" src="${userinfo.headimgurl}?imageView2/2/w/50|imageMogr2/auto-orient" alt="头像图">
					<!-- 测试头像 -->
<%-- 				<img id="tianjia" src="${ctx}/static/wxfile/wuye/image/2.png"> --%>
			</div>
		</div>
		<!-- 姓名  -->
		<div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <p>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</p>
            </div>
            <div class="weui_cell_ft">${userinfo.name}</div>
        </div>
        <!-- 性别  -->
        <div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <p>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</p>
            </div>
            <c:choose>
            	<c:when test="${userinfo.sex==1}">
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
            <div class="weui_cell_ft">${userinfo.age}</div>
        </div>
        <!-- 联系方式  -->
        <div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <p>联系方式</p>
            </div>
            <div class="weui_cell_ft">${userinfo.phone}</div>
        </div>
        <!-- 社区  -->
        <div class="weui_cell" style="border-bottom: 1px solid #eeeff0; margin-bottom: 11px;">
            <div class="weui_cell_bd weui_cell_primary">
                <p>社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</p>
            </div>
            <div class="weui_cell_ft">${userinfo.community.name}</div>
        </div>
		<c:if test="${volunteer!=null}">
			<!-- 我能行信息显示(通过判断显示) -->
			<a class="weui_cell" href="javascript:;" onclick="gotownx()"
				style="border-bottom: 1px solid #DCDDDD; border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_bd weui_cell_primary">
					<p>我能行个人信息</p>
				</div>
				<div class="weui_cell_ft_1"></div>
			</a>
		</c:if>
	</div>
	<div class="container" id="container">
		<div class="button">
			<div class="bd spacing">
				<a href="javascript:;" onclick="gotobj()" class="weui_btn weui_btn_primary">编&nbsp;&nbsp;&nbsp;辑</a>
			</div>
		</div>
	</div>
	<!-- 隐藏域 -->
	<input type="hidden" value="${openid}" id="openid">
</body>
<script type="text/javascript">
/*跳转到我能行信息*/
function gotownx(){
	window.location.href = "/nsh/wxcommunity/myinfo";	
}
/*跳转到编辑页面*/
function gotobj(){
	window.location.href = "/nsh/wxpage/tochuserinfo";
}
</script>
</html>