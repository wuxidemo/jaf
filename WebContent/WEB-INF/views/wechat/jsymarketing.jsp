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
	<title>直销模式</title>
	
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
	
</head>

<body>
	<div data-role="page" style="margin:0;padding:0;background-color:#fff;color:#575759">
		<div style="width: 100%;">
			<img alt="" src="${ctx}/static/jsy/marketing.jpg" width="100%"">
		</div>
		<div style="width: 100%;margin-top:0">
			<hr style="border:none;height: 1px;background-color: #87c150">
		</div>
		
		<div data-role="content">
		  	<table>
		  		<tr>
		  			<td style="vertical-align: top;width:30%;">推荐规则：</td>
		  			<td style="vertical-align: top;width:70%;">推荐人每推荐一个商户，且商户正式签约 一个月后（按年付费）推荐人可领取推广 </td>
		  		</tr>
		  		<tr>
		  			<td style="vertical-align: top;padding-top:10px;">商户规则：</td>
		  			<td style="vertical-align: top;padding-top:10px;">费用：免费试用1-3个月<br/>
		  				&emsp;&emsp;&emsp;摇一摇设备100元/个<br/>
		  			服务费：300元/月   700元/季   2500元/年 <br/>
		  			商户ABC注册后按2500元/年付费，商户A获取推广费每个商户1000元，且按实际付费每年收取。</td>
		  		</tr>
		  	</table>
		 </div>
		 
		 
		 <div style="text-align: center;height:30px;">
		 	<img alt="" src="${ctx}/static/jsy/telephone.png" style="vertical-align: middle;"><span>&nbsp;热线电话：<a href="tel:4000510222">4000510222</a></span>
		 </div>
		 <div style="text-align: center;height:30px;">
		 	<img alt="" src="${ctx}/static/jsy/home.png" style="vertical-align: middle;"><span>&nbsp;公司地址：江苏省无锡市滨湖区锦溪路100号</span>
		 </div>
	</div>
</body>
</html>