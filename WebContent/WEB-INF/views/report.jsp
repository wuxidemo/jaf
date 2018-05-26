<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
</head>
<%@ include file="quote.jsp"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=mVg2scwGtbcKdbdHczxfBhHk"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>
<script src="${ctx}/static/echarts-2.0.0/doc/asset/js/esl/esl.js"></script>

<body>
<div class="row-fluid" style="width:584px;margin-left:auto;margin-right:auto;">
	<img style="width:100%;"  src="${ctx}/static/images/hyy.jpg" />
</div>
</body>
</html>