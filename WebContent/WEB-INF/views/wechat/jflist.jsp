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
<title>积分兑换</title>
<style type="text/css">
body {
	height: 100%;
	margin: 0;
	position: absolute;
	width: 100%;
	font-family: "Arial Negreta", "Arial";
}

.head {
	height: 30px;
	line-height: 50px;
	text-align: right;
	width: 100%;
}

.head a {
	margin-right: 10%;
}

.myucard {
	width: 100%;
	text-align: center;
}

.myocard {
	width: 100%;
	text-align: center;
	display: none;
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
	background-color: #2cc4b7;
}

.left {
	float: left;
	width: 20%;
	text-align: center;
	border-right: 1px solid #c9caca;
	height: 60px;
	margin-top: 6px;
}

.center {
	float: left;
	width: 42%;
	height: 60px;
	margin-top: 6px;
	position: relative;
}

.logodiv {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	overflow: hidden;
	margin: 5px auto auto;
}

.logodiv img {
	width: 50px;
	height: 50px;
}

.center p {
	margin: 0 0 0 5%;
	text-align: left;
}

.cname {
	font-size: 20px;
	height: 35px;
	line-height: 35px;
}

.uname {
	color: #2cc4b7;
}

.oname {
	color: #595757;
}

.sname {
	color: #727171;
	font-size: 12px;
	height: 20px;
	line-height: 20px;
}

.fail p {
	
}

.center img {
	position: absolute;
	top: -5px;
	width: 69px;
	right: 2%;
}

.nocard {
	margin: 10% auto auto;
	width: 140px;
	height: 186px;
}

.nocard p {
	color: #727171;
}

.right {
	width: 34%;
	height: 60px;
	margin-top: 6px;
	float: left;
	
}

.right p {
	color: #2cc4b7;
	display: inline;
	line-height: 60px;
}

.bp {
	
}

.backdiv {
	background: #333 none repeat scroll 0 0;
	bottom: 0;
	left: 0;
	opacity: 0.8;
	position: fixed;
	right: 0;
	top: 0;
	display: none;
}

.choisediv {
	left: 50%;
	margin-left: -175px;
	position: absolute;
	width: 350px;
	top: 20%;
	background-color: white;
	border-radius: 15px;
	display: none;
}

.ctop {
	height: 20px;
	width: 100%;
	text-align: center;
	position: relative;
}

.ctop p {
	font-size: 17px;
}

.ctop i {
	background: url('${ctx}/static/wxfile/images/close.png') no-repeat
		center;
	height: 30px;
	background-color: #2cc4b7;
	position: absolute;
	width: 30px;
	top: -17px;
	right: 20px;
}

.ccenter {
	
	overflow: auto;
	width: 100%;
	min-height: 30px;
}

.cbottom {
	width: 100%;
	height: 50px;
	border-top: solid 1px #e8e8e8;
}

.cbottom div {
	float: left;
	font-size: 20px;
	height: 100%;
	line-height: 50px;
	text-align: center;
	width: 49%;
	color: #2cc4b7;
	z-index:99;
}

.cbottom div:FIRST-CHILD {
	border-right: solid 1px #e8e8e8;
}

.crow {
	width: 100%;
	height: 50px;
	position: relative;
	line-height: 50px;
	 z-index: 0;
}

.crow i {
	height: 25px;
	margin-left: 20px;
	margin-top: 12px;
	position: absolute;
	width: 25px;
}

.check i {
	background: url('${ctx}/static/wxfile/images/yhqcheck.png');
}

.checked i {
	background: url('${ctx}/static/wxfile/images/yhqchecked.png');
}

.crow p {
	font-size: 17px;
	margin: 0 0 0 55px;
}

.showtip {
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 0.3125em;
	bottom: -30px;
	color: white;
	width: 200px;
	height: 30px;
	left: 50%;
	position: fixed;
	text-align: center;
	z-index: 999;
	line-height: 30px;
	margin-left: -100px;
}

.errortip {
	color: red;
	width: 100%;
	height: 30px;
	line-height: 30px;
	text-align: center;
	display: none;
}

.nocards {
	width: 100%;
	height: 100px;
	line-height: 100px;
	position: relative;
}

.nocards p {
	color: #898989;
	margin: 0 0 0 137px;
	font-size: 20px;
}

.nocards i {
	background: url('${ctx}/static/wxfile/images/bankcard.png');
	width: 79px;
	height: 60px;
	position: absolute;
	margin: 18px 0 0 39px;
}


</style>
</head>

<body>
	<div class="head">
		<a href="javascript:window.location.href='${ctx}/tmpactivity/jfrole'">积分兑换规则</a>
	</div>
	<div class="myucard">
		<c:forEach items="${data}" var="card">
			<div onclick="showcard('${card.cardid}')" class="cardborder">
				<div class="top">
					<div class="left">
						<div class="logodiv">
							<img alt=""
								<c:if test="${card.isonly==1}">src="${ctx}/${card.logourl}"</c:if>
								<c:if test="${card.isonly!=1}">src="${ctx}/static/images/headimg.jpg"</c:if> />
						</div>
					</div>
					<div class="center">
						<p class="cname uname">${card.name}</p>
						<p class="sname">${card.merchantname}</p>
					</div>
					<div class="right">
						<p>${card.count}积分</p>
						<p>
							<strong class="bp">></strong>
						</p>
					</div>
				</div>
				<div class="bottom greendiv">
					<c:if test="${card.datetype==2}">
						<p>
							有效日期:
							<c:if test="${card.delaytime==0 or card.delaytime==null}">当</c:if><c:if test="${card.delaytime!=0}">${card.delaytime}</c:if>天生效,有效天数:${card.usetime}
						</p>
					</c:if>
					<c:if test="${card.datetype==1}">
						<p>有效日期:${fn:substring(card.starttime, 0, 10)}到${fn:substring(card.endtime, 0, 10)}</p>
					</c:if>

				</div>
			</div>
		</c:forEach>
		<c:if test="${datasize==0}">
			<div class="nocard">
				<img alt="" src="${ctx}/static/wxfile/images/nocard.png">
				<p>还没积分兑换券...</p>
			</div>

		</c:if>
	</div>
	<div class="backdiv"></div>
	<div class="choisediv">
		<div class="ctop">
			<p>选择银行卡</p>
			<i class="closei"></i>
		</div>
		<div class="ccenter">
			
		</div>
		<div class="errortip">该银行卡积分不够,请选择其他银行卡兑换</div>
		<div class="cbottom">
			<div  id="okbtn" >兑 换</div>
			<div onclick="hide()">取 消</div>
		</div>
	</div>
	<div id="showtip" class="showtip"></div>
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
		jsApiList : [ 'addCard' ]
	});
	wx.ready(function() {

		//	alert("ready");
	});
	wx.error(function(res) {
		//alert("加载错误:" + res.msg);
	});
	function showcard(cardid) {
		mycardid = cardid;
		$.post("${ctx}/wxcard/bankcard", {
			"cardid" : cardid
		}, function(d) {
			$(".ccenter").html("");
			$(".errortip").css("display", "none");
			num = -1;
			if (d.result == "1") {
				var html = "";
				if (d.cards.length > 0) {
					for (var i = 0; i < d.cards.length; i++) {
						html += '<div num='
								+ i
								+ ' can="'
								+ d.cards[i].can
								+ '" class="crow '
								+ ((i == 0 && d.cards[i].can == 1) ? 'checked'
										: 'check') + '"><i></i><p>'
								+ d.cards[i].cardnum + ' (积分:'
								+ d.cards[i].points + ')</p></div>';
					}
					if (d.cards[0].can == 1) {
						num = 0;
					}
					$("#okbtn").attr("onclick","show()");
					$("#okbtn").html("兑  换");
				} else {
					html = '<div class="nocards"><i></i><p>还没有绑定的银行卡</p></div>';
					$("#okbtn").bind("click",function(){
						window.location.href="${ctx}/wxurl/redirect?url=wxpage/bindbankcard";
					});
					$("#okbtn").html("绑定银行卡");
				}
				exts = d.exts;
				$(".ccenter").html(html);
				$(".backdiv").css("display", "block");
				$(".choisediv").css("display", "block");
				$(".crow").bind("click", function() {
					
					if ($(this).attr("can") == "0") {
						$(".errortip").css("display", "block");
						return;
					} else {
						$(".errortip").css("display", "none");
					}
					num = $(this).attr("num");
					$(".crow").each(function() {
						if ($(this).attr("num") == num) {
							if ($(this).hasClass("check")) {
								$(this).removeClass("check");
							}
							if (!$(this).hasClass("checked")) {
								$(this).addClass("checked");
							}
						} else {
							if ($(this).hasClass("checked")) {
								$(this).removeClass("checked");
							}
							if (!$(this).hasClass("check")) {
								$(this).addClass("check");
							}
						}
					});
				});
			} else {
				alerttip(d.msg, 3000);
			}
		});

	}
	var exts = [];
	function getcard() {
		wx.openCard({
			cardList : [ {
				cardId : cardid,
				code : code
			} ]
		});
	}
	$(document).ready(function() {
		$(".closei").bind("click", function() {
			hide();
		});
	});
	function hide() {
		$(".backdiv").css("display", "none");
		$(".choisediv").css("display", "none");
	}
	function setnum(i) {
		num = i;
	}
	var num;
	var mycardid;
	function show() {
		if (exts[num] != null) {
			wx.addCard({
				cardList : [ {
					cardId : mycardid,
					cardExt : exts[num]
				} ], // 需要添加的卡券列表
				success : function(res) {
					//var cardList = res.cardList; // 添加的卡券列表信息
					hide();
				}
			});
		}
return false;
	}
	function hidetip() {
		$("#showtip").css("bottom", "-30px");
	}
	function alerttip(str, ms) {
		$("#showtip").html(str);
		$("#showtip").animate({
			bottom : "30px"
		}, 500);
		setTimeout("hidetip()", ms);
	}
</script>
</html>