<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style type="text/css">
</style>
<title>缴费失败</title>
</head>
<body>
	<div class="container" id="container">
		<div class="msg">
			<div class="weui_msg">
				<div class="weui_icon_area">
					<i class="weui_icon_warn weui_icon_msg"></i>
				</div>
				<div class="weui_text_area">
					<h2 class="weui_msg_title">缴费失败</h2>
					<p class="weui_msg_desc"></p>
				</div>
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a href="${ctx}/wxcommunity/showwyjf"
							class="weui_btn weui_btn_primary">确定</a>
					</p>
				</div>
				<div class="weui_extra_area">
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>