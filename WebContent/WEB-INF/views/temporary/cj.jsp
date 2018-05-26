<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>现场摇红包</title>
<style type="text/css">
body {
	margin: 0;
}

img {
	width: 100%;
}

</style>
</head>
<body>
	<img id="img" src="${ctx}/static/wxfile/images/show.jpg">
	<img id="img1" style="display:none" src="${ctx}/static/wxfile/images/cjqrdoe.jpg" />
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var result = '${result}';
						if (result == "1") {
							$("#img")
							.bind(
									"click",
									function(d) {
										//  document.getElementById("myimg").onclick = null;
									$("#img")
															.css("display",
																	"none");
																	$("#img1")
															.css("display",
																	"block");
										$.post(
												"${ctx}/tmpactivity/docj",
												function(d) {
													
													
													if (d.result == "1") {
														alert("领取红包成功！");
													} else {
														alert(d.msg);
													}
												});
									});
						} else {
							alert("${msg}");
								$("#img").css("display","none");
							$("#img1").css("display","block");
						}

						
					});
</script>
</html>