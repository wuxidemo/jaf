<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta name="format-detection" content="telephone=no" />
<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<title>优惠</title>
<style type="text/css">
body {
	font-family: Microsoft YaHei;
	margin: 0;
}

.quan {
	margin: auto;
	padding-top: 35px;
	width: 94%;
	overflow: hidden;
}

.qleft {
	width: 2%;
	height : 150px;
	float: left;
	height: 150px;
}

.qleft img {
	height: 100%;
}

.qbody {
	font-weight:bold; 
	width: 93%;
	height: 150px;
	float: left;
	background-color: #f8ba1e;
	text-align: center;
}

.qbody p {
	margin-bottom: 0px;
}

.qbody>:nth-child(1) {
	font-size: 22px;
	color: #7a7070;
}

.qbody>:nth-child(2) {
	font-size: 30px;
	color: white;
	margin-top: 9px;
}

.qbody>:nth-child(3) {
	font-size: 15px;
	color: #7a7070;
	margin-top: 5px;
}

.qright {
	width: 5%;
	height: 150px;
	float: left;
}

.qright img {
	height: 100%;
}

.notice {
overflow:hidden;
	clear: both;
	padding-top: 35px;
	width: 90%;
	margin: auto;
	font-size: 15px;
}

.n_tip{
	clear:both;
	float:left;
	width: 80px;;
	margin-top: 3px;
}
.n_con{
	width:70%;
	float:left;
	margin-top: 3px;
}

.btn {
	clear:both;
	width: 100%;
	padding-top: 30px;
}

.btn div {
	width: 70%;
	margin: auto;
	background-color: #f8ba1e;
	text-align: center;
	line-height: 50px;
	color: white;
	font-size: 22px;
	border-radius: 10px;
}
.lqok{
	position: absolute;
	width:74%;
	height: 150px;
	z-index: 999;
    text-align: center;
    margin: -58% auto auto 13%;
    border: 2px solid #f8ba1e;
    border-radius: 10px;
    background-color: white;
    display: none;
}
.lqok>:nth-child(1){
	margin-bottom: 0;
	padding-top: 0;
	font-size: 30px;
	color: #f8ba1e;
}
.kong{
	width: 100%;
	height: 100%;
	background-color: #e1e3e1;
	position: absolute;
 	opacity:0.01; 
 	z-index: 9; 
 	display: none;
}
</style>
</head>
<body>
<div class="kong"></div>
	<div class="quan">
		<div class="qleft">
			<img src="${ctx}/static/wxfile/main1601/image/quanleft.png">
		</div>
		<div class="qbody">
			<p>棒约翰披萨</p>
			<p>满100元减10元</p>
			<p>有效日期：2015.6.19-2016.5.18</p>
		</div>
		<div class="qright">
			<img src="${ctx}/static/wxfile/main1601/image/quanright.png">
		</div>
	</div>
	<div class="notice">
		<div class="n_tip">使用须知：</div><div class="n_con">本优惠券只适合在棒约翰皮萨湖滨万达店使用<br>不可叠加使用，不兑换，不找零</div>
		<div class="n_tip">电话：</div><div class="n_con">0510-33333333</div>
		<div class="n_tip">地址：</div><div class="n_con">滨湖区和螺口梁溪道32号</div>
	</div>
	<div class="btn">
		<div>领取</div>
	</div>
	<div class="lqok">
		<p>领取成功</p>
		<p>温馨提示：请至微信卡包中查看。</p>
	</div>
	
</body>
<script type="text/javascript">
	$('.btn').click(function(){
		$('.kong').show();
		$('.lqok').show();
		setTimeout(function(){
			$('.kong').hide();
			$('.lqok').hide();
		},1000);
	});
	$('.kong').click(function(){		
		$('.lqok').hide();
		$('.kong').hide();
	});
</script>
</html>