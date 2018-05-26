<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<meta name="apple-touch-fullscreen" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta name="description" content="">
	<title>加入我们</title>
	
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
	
	<script type="text/javascript">
		function joinus() {
			window.location.href="${ctx}/wxpage/jsyjoinus";
		}
	</script>
	
	
</head>

<body>
	<div data-role="page" style="margin:0;padding:0;background-color: white;">
		<div style="width: 100%; margin-bottom:0;">
			<img alt="" src="${ctx}/static/images/titleback.png">
		</div>
		<div style="margin-left:20px;margin-right:20px;">
			<p>&emsp;&emsp;基于微信的智慧商业数据服务平台简称金数源，该产品面向的用户是服务业（如餐饮和服装等行业）的经营管理者，解决其核心需求“如何收集线下消费者体验的反馈信息和客户行为相关数据，通过数据分析挖掘和再造，为商户的精细化运营和顾客的私人化定制提供大数据支持。”</p>
			<p>&emsp;&emsp;金数源不同与传统的餐饮管理软件和大众点评之类的公共平台，主要是通过自助化的服务采集顾客的行为数据，形成商户自己的大数据，并通过大数据的运用和微信连接一起的能力做到精准化的传播和营销。</p>
		</div>
		<div data-role="content">
		  	<button style="background-color: #2bc4b6;-webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, 0);
 				-moz-box-shadow: 0 1px 3px rgba(0, 0, 0, 0);" onclick="joinus()">加入我们</button>
		 </div>
		 <div style="text-align: center;height:30px;">
		 	<img alt="" src="${ctx}/static/jsy/telephone.png" style="vertical-align: middle;"><span>&nbsp;热线电话：400510222</span>
		 </div>
		 <div style="text-align: center;height:30px;">
		 	<img alt="" src="${ctx}/static/jsy/home.png" style="vertical-align: middle;"><span>&nbsp;公司地址：江苏省无锡市滨湖区锦溪路100号</span>
		 </div>
		 
		 <div style="width: 100%;">
			<img alt="" src="${ctx }/static/images/zanwuPic2.jpg" width="100%" height="200px;">
		 </div>

	</div>
</body>
</html>