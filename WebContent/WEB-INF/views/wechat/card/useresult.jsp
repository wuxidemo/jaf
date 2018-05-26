<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title><c:if test="${data.result==1}">扫描成功</c:if> <c:if
		test="${data.result==0}">扫描失败</c:if></title>
<style type="text/css">
body {
	height: 100%;
	margin: 0;
	position: absolute;
	width: 100%;
}

div {
	
}

.top {
	position: relative;
	width: 100%;
	height: 60%;
}

.ok {
	background: url('${ctx}/static/wxfile/images/ok.png') no-repeat center;
}

.fail {
	background: url('${ctx}/static/wxfile/images/fail.png') no-repeat center;
}

.top img {
	width: 100%;
}

.bottom {
	width: 100%;
	text-align: center;
}

.result {
	height: 155px;
	left: 50%;
	margin-left: -140px;
	margin-top: -77px;
	position: absolute;
	text-align: center;
	top: 50%;
	width: 280px;
}

.sm {
	color: white;
	margin-top: 32px;
}

.cardname {
	color: #fff67f;
}

.btns {
	width: 280px;
	height: 100px;
	margin: auto;
}

.btndiv {
	float: left;
	width: 50%;
	margin-top: 10%;
	text-align: center;
}

.btn {
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

.greenbtn {
	background-color: #2bc4b6;
}

.greybtn {
	background-color: #b5b5b5;
}

.failp {
	margin-top: 50px;
	color: black;
}
</style>
</head>

<body>

	<div
		class="top <c:if test="${data.result==1}">ok</c:if>
<c:if test="${data.result==0}">fail</c:if> ">
		<div class="result">
			<c:if test="${data.result==1}">
				<p class="sm">扫描成功</p>
				<p class="cardname">${data.data.name}</p>
			</c:if>

			<c:if test="${data.result==0}">
				<p class="cardname failp">${data.msg}</p>
			</c:if>

		</div>
	</div>

	<div class="bottom">
		<div class="btns">
			<div class="btndiv">
				<button class="btn greenbtn" onclick="usecard()">继续扫描</button>
			</div>
			<div class="btndiv">
				<button class="btn greybtn" onclick="back()">返回</button>
			</div>
		</div>
	</div>
	<form action="${ctx}/wxcard/usegift" method="post" id="inputform"
		style="display: none">
		<input name="code" id="code">
	</form>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	
	function showcard(cardid, code) {
		wx.openCard({
			cardList : [ {
				cardId : cardid,
				code : code
			} ]
		});
	}
	$(document).ready(function() {
		wx.config({
			debug : false, // 
			appId : '${appId}',
			timestamp : '${timestamp}',
			nonceStr : '${nonceStr}',
			signature : '${signature}',
			jsApiList : [ 'scanQRCode' ]
		});
		wx.ready(function() {

			//	alert("ready");
		});
		wx.error(function(res) {
			alert("加载错误:" + JSON.stringify(res));
		});
		$(".now").bind("click", function() {
			if (!$(this).hasClass("tabact")) {
				$(this).addClass("tabact");
				$(".history").removeClass("tabact");
				$(".myucard").css("display", "block");
				$(".myocard").css("display", "none");
			}
		});
		$(".history").bind("click", function() {
			if (!$(this).hasClass("tabact")) {
				$(this).addClass("tabact");
				$(".now").removeClass("tabact");
				$(".myucard").css("display", "none");
				$(".myocard").css("display", "block");
			}
		});
	});
	function back() {
		window.location.href = "${ctx}/wxorder/choise";
	}
	function usecard() {
		wx.scanQRCode({
			needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
			success : function(res) {
				$("#code").val(res.resultStr);
				$("#inputform").submit();
			}
		});
	}
</script>
</html>