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
<title>我是商家</title>
<style type="text/css">
body {
	margin: 0;
}

.middle {
	position: fixed;
	width: 100%;
	height: 230px;
	top: 50%;
	margin-top: -115px;
	text-align: center;
}

.head {
	width: 100%;
	height: 50px;
	margin-top: 50px;
	text-align: right;
}

.head a {
	padding: 0 13px;
	text-decoration: none;
	color: #0000ee;
}

.leftborder {
	border-left: 1px solid #c8c8c8;
	margin-right: 30px;
}

.greendiv {
	background-color: #2cc4b7;
}

.bluediv {
	background-color: #5eadd4;
}

.btndiv {
	border-radius: 3px;
	margin: 0px auto 30px auto;
	width: 85%;
	height: 100px;
	color: white;
	text-align: left;
	position: relative;
	line-height: 100px;
}

.btndiv p {
	margin: 0;
	margin-left: 40%;
	font-size: 25px;
}

.btndiv i {
	width: 43px;
	height: 43px;
	position: absolute;
	top: 50%;
	margin-top: -21px;
	margin-left: 20%;
}

.greendiv i {
	background: url('${ctx}/static/wxfile/images/unit.png') center no-repeat;
}

.bluediv i {
	background: url('${ctx}/static/wxfile/images/saoyisao.png') center
		no-repeat;
}

.backdiv {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: white;
	display: none;
}

.tipdiv {
	position: absolute;
	width: 200px;
	height: 200px;
	top: 50%;
	left: 50%;
	margin-top: -100px;
	margin-left: -100px;
}

.tip {
	height: 150px;
	width: 100%;
	text-align: center;
	font-size: 23px;
}

.tipbtndiv {
	text-align: center;
	width: 100%;
	height: 50px;
}

.tipbtndiv button {
	background-color: #2bc4b6;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	margin-top: 10px;
	width: 90%;
	border-radius: 5px;
}
</style>
</head>
<body>
	<div class="head">
		<a id="close" href="#">退出</a><a href="${ctx}/wxpage/changepass"
			class="leftborder">修改密码</a>
	</div>
	<div class="middle">
		<div class="greendiv btndiv">
			<i></i>
			<p>收款</p>
		</div>
		<div class="btndiv bluediv">
			<i></i>
			<p>核销卡券</p>
		</div>
	</div>
	<form action="${ctx}/wxcard/usegift" method="post" id="inputform"
		style="display: none">
		<input name="code" id="code">
	</form>
	<div class="backdiv">
		<div class="tipdiv">
			<div class="tip"></div>
			<div class="tipbtndiv">
				<button id="ok">确定</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		wx.config({
			debug : false,
			appId : '${appId}',
			timestamp : '${timestamp}',
			nonceStr : '${nonceStr}',
			signature : '${signature}',
			jsApiList : [ 'scanQRCode', 'closeWindow' ]
		});
		wx.error(function(res) {
			alert("加载错误:" + JSON.stringify(res));
		});
		$(".greendiv").click(function() {
			window.location.href = "${ctx}/wxorder/showorder";
		});
		$("#close").bind("click", function() {
			$.post("${ctx}/wxorder/loginout", function() {

			});
			wx.closeWindow();
		});
		$(".bluediv").click(function() {
			wx.scanQRCode({
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
				scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
				success : function(res) {
					$.post("${ctx}/wxcard/usecard",{"code":res.resultStr},function(d){
						$(".backdiv").css("display","block");
						$(".tip").html(d.msg);
					});

					//$("#code").val(res.resultStr);
					//$("#inputform").submit();
				}
			});
		});
		$("#ok").bind("click",function(){
			$(".backdiv").css("display","none");
		});
	});
</script>
</html>