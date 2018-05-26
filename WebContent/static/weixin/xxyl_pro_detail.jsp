<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sellerid = request.getParameter("sellerid");
	String proid = request.getParameter("proid");
%>
<c:set var="sellerid" value="<%=sellerid%>" />
<c:set var="proid" value="<%=proid%>" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="css/main.css" media="all" />
<!-- <script type="text/javascript" src="http://stc.weimob.com/src/jQuery.js?2014-05-21"></script> -->
<!-- <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script> -->
<script type="text/javascript" src="js/scroller.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/menu.js"></script> 
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<title></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<!-- <link rel="shortcut icon" href="http://stc.weimob.com/img/favicon.ico" /> -->
</head>
<script type="text/javascript">
$(document).ready(function(){
	var proid = $("#proid").val();
	$.get('${ctx}/api/oneproduct?proid='+proid,function(map){
		if(map["data"] != null && map["data"] != '') {
			var temp = map["data"];
			var str = '';
			str += "<div class=\"dialog_wrap\">";
			str += "	<div class=\"dialog_tt\">"+temp.name+"</div>";
			str += "	<div class=\"\" id=\"menuDetail\">";
			str += "		<img src=\""+temp.url+"\" style=\"width:100%;height:60%\">";
			str += "	</div>";
			/* str += "	<div class=\"\" id=\"menuDetail\" style=\"margin:10% 0;float:left\">";
			str += "		<span>价格：¥<span class=\"price\" style=\"color:red;\">"+temp.price+"</span></span>";
			str += "	</div>";
			str += "	<div class=\"\" id=\"menuDetail\" style=\"margin:10% 5%;float:left\">";
			str += "		<span>月售：<span class=\"sale_num\">"+temp.sales+"</span>份<span class=\"sales\"><strong class=\"sale_10\"></strong></span></span>";
			str += "	</div>"; */
			str += "</div>";
			
			$("#fillin").append(str);
		}
	});
});
</script>
<script type="text/javascript">
function toMendian() {
	var sellerid = $("#sellerid").val();
	window.location.href = "${ctx}/static/weixin/xxyl_seller_info.jsp?sellerid="+sellerid;
}

function toMenu() {
	var sellerid = $("#sellerid").val();
	window.location.href = "${ctx}/static/weixin/xxyl_pro_list.jsp?sellerid="+sellerid;
}

var num = 0;
function tip() {
	if(num == 0) {
		alert("预约成功！预约有效期限为6小时！");
		num += 1;
	}else {
		alert("你已经预约成功，请不要重复预约，进店请提供本人的微信号，关注本店微信号可享受9折优惠！");
	}
	
}
</script>
<body onselectstart="return true;" ondragstart="return false;">
	<div class="container">
	<header class="nav menu">
		<div>
			<a href="javascript:;" class="on" onclick="toMenu()">项目列表</a>
			<a href="javascript:;" onclick="toMendian()">商家详情</a>
		</div>
	</header>
	<form name="cart_form" action="#" method="post">
		<input type="hidden" id="sellerid" value="${sellerid}">
		<input type="hidden" id="proid" value="${proid}">
		<div id="fillin">
			<!-- <div class="dialog_wrap">
				<div class="dialog_tt">鲫鱼炖豆腐</div>
				<div class="" id="menuDetail">
					<img src="" style="">
				</div>
				<div class="" id="menuDetail">
					<span>价格：¥<span class="price">28</span></span>
				</div>
				<div class="" id="menuDetail">
					<span>月售：<span class="sale_num">9</span>份<span class="sales"><strong class="sale_10"></strong></span></span>
				</div>
			</div> -->
		</div>
		<footer class="shopping_cart">
			<div class="fixed">
				<div>
					<a id="settlement" href="javascript:;" onclick="tip();" class="comm_btn">我要预约</a>
				</div>
			</div>
		</footer>
	</form>
		
</div></body>
</html>