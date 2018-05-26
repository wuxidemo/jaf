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
<title>我的优惠</title>
<style type="text/css">
body {
	height: 100%;
	margin: 0;
	position: absolute;
	width: 100%;
	font-family: "微软雅黑";
}

.head {
	width: 100%;
	height: 50px;
}

.tabdiv {
	line-height: 50px;
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;
	border-bottom: 1px solid #c9caca;
	color: #727171;
}

.tabdiv:FIRST-CHILD {
	border-right: solid 1px #c9caca;
	width: 49%;
}

.tabact {
	height: 47px;
	border-bottom: 4px solid #f8ba1e;
	color: black;
}

.myucard {
	width: 100%;
	text-align: center;
	padding-bottom: 30px;
}

.myocard {
	width: 100%;
	text-align: center;
	display: none;
	padding-bottom: 30px;
}

.hide {
	display: none;
}

.cardborder {
	margin: auto;
	border: 1px solid #c9caca;
	height: 100px;
	width: 90%;
	margin-top: 20px;
	border-radius: 5px;
}

.top {
	width: 100%;
	height: 70px;
}

.bottom {
	width: 100%;
	height: 30px;
	color: white;
	line-height: 30px;
	text-align: left;
	line-height: 30px;
}

.bottom p {
	margin: 0 0 0 20px;
}

.greydiv {
	background-color: #b5b5b6;
}

.greendiv {
	background-color: #f8ba1e;
}

.left {
	float: left;
	width: 29%;
	text-align: center;
	border-right: 1px solid #c9caca;
	height: 60px;
	margin-top: 6px;
}

.right {
	float: left;
	width: 70%;
	height: 60px;
	margin-top: 6px;
	position: relative;
}

.logodiv {
	width: 55px;
	height: 55px;
	border-radius: 50%;
	border: 3px solid #c9caca;
	overflow: hidden;
	margin: auto;
}

.logodiv img {
	width: 55px;
	height: 55px;
}

.right p {
	margin: 0 0 0 10%;
	text-align: left;
}

.cname {
	font-size: 22px;
	height: 35px;
	line-height: 35px;
}

.uname {
	color: #f8ba1e;
}

.oname {
	color: #595757;
}

.sname {
	color: #727171;
	font-size: 15px;
	height: 20px;
	line-height: 20px;
}

.fail p {
	
}

.right img {
	position: absolute;
	top: 0px;
	width: 91px;
	right: 2%;
}

.nocard {
	margin: auto;
	width: 120px;
	height: 100px;
	margin-top: 50px;
}
.nocard img{
	width: 120px;
}

.nocard p {
	color: #727171;
	margin-top: -28px;
	
}

.cardloading {
	width: 100%;
	margin-top: 10%;
	text-align: center;
}
</style>
</head>

<body>
	<div class="head">
		<div class="tabdiv tabact now">当前</div>
		<div class="tabdiv history">历史</div>
	</div>
	<div class="myucard">
		<c:if test="${datasize!=0}">
			<div class="cardloading">数据加载中...</div>
		</c:if>
		<div id="cards" style="display: none">
			<c:forEach items="${data}" var="card">
				<div onclick="showcard('${card[7]}','${card[6]}')"
					class="cardborder">
					<div class="top">
						<div class="left">
							<div class="logodiv">
								<c:if test="${fn:indexOf(card[2],'http://') >=0 }">
									<img alt=""
										<c:if test="${card[1]==1}">src="${card[2]}"</c:if>
										<c:if test="${card[1]!=1}">src="${ctx}/static/images/headimg.jpg"</c:if>>
								</c:if>
								<c:if test="${fn:indexOf(card[2],'http://') <0 }">
									<img alt=""
										<c:if test="${card[1]==1}">src="${ctx}/${card[2]}"</c:if>
										<c:if test="${card[1]!=1}">src="${ctx}/static/images/headimg.jpg"</c:if>>
								</c:if>
							</div>
						</div>
						<div class="right">							
							<p class="sname">${card[3]}</p>
							<p class="cname uname">${card[0]}</p>
						</div>
					</div>
					<div class="bottom greendiv">
						<p>有效日期：${fn:substring(card[4], 0, 10)}到${fn:substring(card[5], 0, 10)}</p>
					</div>
				</div>
			</c:forEach>
		</div>
		<c:if test="${datasize==0}">
			<div class="nocard">
				<img alt="" src="${ctx}/static/wxfile/images/nodata.png">
				<p>暂无记录</p>
			</div>

		</c:if>
	</div>
	<div class="myocard">
		<c:forEach items="${useddata}" var="card">
			<div class="cardborder">
				<div class="top">
					<div class="left">
						<div class="logodiv">
							<img alt=""
								<c:if test="${card[1]==1}">src="${ctx}/${card[2]}"</c:if>
								<c:if test="${card[1]!=1}">src="${ctx}/static/images/headimg.jpg"</c:if>>
						</div>
					</div>
					<div class="right fail">
						<p class="sname">${card[3]}</p>
						<p class="cname uname">${card[0]}</p>						

						<img alt=""
							<c:if test="${card[8]==2}">src="${ctx}/static/wxfile/images/used.png"</c:if>
							<c:if test="${card[8]==4}">src="${ctx}/static/wxfile/images/over.png"</c:if>
							<c:if test="${card[8]==3}">src="${ctx}/static/wxfile/images/deleted.png"</c:if>>
					</div>
				</div>
				<div class="bottom greydiv">
					<p>
						<c:if test="${card[8]==2}">使用日期：${fn:substring(card[9], 0, 16)}</c:if>
						<c:if test="${card[8]==4}">过期日期：${fn:substring(card[10], 0, 10)}</c:if>
						<c:if test="${card[8]==3}">过期日期：${fn:substring(card[10], 0, 10)}</c:if>
					</p>
				</div>
			</div>
		</c:forEach>
		<c:if test="${useddatasize==0}">
			<div class="nocard">
				<img alt="" src="${ctx}/static/wxfile/images/nodata.png">
				<p>暂无记录</p>
			</div>
		</c:if>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false, // 
		appId : '${appId}',
		timestamp : '${timestamp}',
		nonceStr : '${nonceStr}',
		signature : '${signature}',
		jsApiList : [ 'openCard' ]
	});
	wx.ready(function() {
		$(".cardloading").css("display","none");
		$("#cards").css("display","block");
		//	alert("ready");
	});
	wx.error(function(res) {
		//alert("加载错误:" + res.msg);
	});
	function showcard(cardid, code) {
		wx.openCard({
			cardList : [ {
				cardId : cardid,
				code : code
			} ]
		});
	}
	$(document).ready(function() {
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
</script>
</html>