<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>优惠</title>


</head>
<style>
body {
	font-family: Microsoft YaHei;
	padding: 0px;
	margin: 0px;
}
.ro
</style>
<body>
	<div style="width: 100%; height: 200px;"></div>
</body>

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						//	init(31.4421977997, 120.289276123);
						//getarea(31.4421977997, 120.289276123);
						wx.config({
							debug : false,
							appId : '${config.appId}',
							timestamp : '${config.timestamp}',
							nonceStr : '${config.nonceStr}',
							signature : '${config.signature}',
							jsApiList : [ 'hideOptionMenus', 'closeWindow',
									'getLocation' ]
						});
						wx.error(function(res) {
							alert("加载错误:" + JSON.stringify(res));
						});
						wx.ready(function() {
							wx.hideOptionMenu();
							getdatabyjw();
						});

					});
	function getarea(latitude, longitude) {
		$.post("${ctx}/wxact/getarea", {
			"lat" : latitude,
			"lon" : longitude
		}, function(d) {
			alert(JSON.stringify(d));
		});

	}
	function getdatabyjw() {
		wx.getLocation({
			type : 'wgs84',
			success : function(res) {

				var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
				var speed = res.speed; // 速度，以米/每秒计
				var accuracy = res.accuracy; // 位置精度
				//alert(latitude+":"+longitude);
				//init(latitude, longitude);
				getarea(latitude, longitude);
			}
		});
	}

</script>
</html>