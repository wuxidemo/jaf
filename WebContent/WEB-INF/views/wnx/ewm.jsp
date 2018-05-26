<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>关注</title>
<style>
html body{
margin:0px;
padding:0px;
}
.Dv1{
    width: 300px;
    height: 300px;
    margin-top: 30%;
    margin-left: auto;
    margin-right: auto;
}
.Dv1 img{
    width: 100%;
    height: 100%;
}
.Dv2{
    width: 235px;
    height: 60px;
    text-align: center;
    margin-left: auto;
    margin-right: auto;
    line-height: 30px;
}
</style>
</head>
<body>
<!-- <div class="Dv"> -->
  <div class="Dv1">
    <img src="${ctx}/static/wxfile/wnx/image/yesican000.jpg" />
  </div>
  <div class="Dv2">长按二维码，关注金阿福e服务，享受智慧社区生活</div>
<!-- </div> -->
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
</script>
</html>