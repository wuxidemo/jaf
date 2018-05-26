<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>我的记录</title>
</head>
<style>
html body{
    margin:0px;
    padding:0px;
}
.content{
    width: 200px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-left: -100px;
    margin-top: -100px;
    text-align: center;
    font-weight: 500;
}
.line1{
}
.line2{
    height: 35px;
    line-height: 35px;
    color:#1f00f4;
}
</style>
<body>
<div class="content">
   <div class="line1">你还没有填写个人信息</div>
   <div class="line2" onclick="message()">去填写个人信息</div>
</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
function message(){
	window.open("${ctx}/wxcommunity/gerenxx");
}
</script>
</html>