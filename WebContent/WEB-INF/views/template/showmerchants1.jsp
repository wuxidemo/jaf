<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta charset="utf-8">
	<meta name="apple-touch-fullscreen" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta name="description" content="">
	<title>微信活动首页</title>
	<link rel="stylesheet" type="text/css"
		href="${ctx}/static/mt/media/css/style1.css">
	
	<meta name="viewport"
		content="width=500, user-scalable=no, target-densitydpi=device-dpi, minimal-ui">
</head>
<body>
	<section id="wrap">
		<section class="page page1 z-current" style="-webkit-transform: none;">
			<!--  顶部图片 -->
			<div
				style="width: 500px; height: 130px; text-align: center; border-bottom: 1px dashed #000;">
				<img src="${ctx}/${art.yurl}" style="height: 120px" />
			</div>
			<!--    中部商家信息 -->
			<div
				style="width: 500px; height: 140px; border-bottom: 1px dashed #000; border-bottom: 1px dashed #000;">
				<div style="padding-left: 15px; padding-top: 10px;">

					<table style="width: 100%">
						<tr>
							<td>
								<h3>
									<b>${mer.name}</b>
								</h3>
							</td>
						</tr>
						<tr>
							<td>电话:&nbsp;&nbsp;<span>${mer.telephone}</span>
							</td>
						</tr>
						<tr>
							<td>地址:&nbsp;&nbsp;<span>${mer.telephone}</span>
							</td>
						</tr>

					</table>
				</div>
			</div>
			<!-- 下部信息    -->
			<div
				style="width: 500px; height: 290px; border-bottom: 1px dashed #000;overflow: auto;">
				<div style="padding-left: 20px; padding-top: 10px; padding-right: 10px">
					<span> &nbsp; &nbsp;&nbsp;&nbsp;</span>
                      <span>${art.content}</span>
				</div>
			</div>

			<!--     底部优惠券 -->
			<div style="width: 100%; height: auto;">
				<div
					style="padding-left: 20px; padding-top: 10px; padding-right: 10px">
					<h2>优惠券</h2>
				</div>
			</div>
		</section>
	</section>



</body>
</html>