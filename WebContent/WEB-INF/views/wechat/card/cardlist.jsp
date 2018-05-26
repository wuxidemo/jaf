<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<link href="${ctx}/static/css/index.css" rel="stylesheet"
	type="text/css" />
<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css"
	type="text/css" rel="stylesheet">
<style type="text/css">
body {
	margin: 0;
}

.head {
	width: 100%;
}

.head img {
	max-height: 200px;
	width: 100%;
}

.cards {
	width: 100%;
	text-align: center;
	padding-bottom: 60px;
}

.row {
	text-align: center;
	height: 100px;
	width: 95%;
	margin: 5px auto;
}

.addyhq {
	position: relative;
	width: 100%;
	float: left;
	height: 100%;
}

.addyhq .left {
	background: url('${ctx}/static/wxfile/images/yhqleft.png') right center
		no-repeat;
	width: 8%;
	height: 100%;
	float: left;
}

.addyhq .center {
	float: left;
	width: 84%;
	height: 100%;
	background: url('${ctx}/static/wxfile/images/yhqcenter.png') center
		repeat-x;
	position: relative;
}

.addyhq .right {
	background: url('${ctx}/static/wxfile/images/yhqright.png') left center
		no-repeat;
	width: 8%;
	height: 100%;
	float: left;
}

.myyhq {
	background: rgba(0, 0, 0, 0)
		url("${ctx}/static/wxfile/images/yhqchecked.png") no-repeat scroll
		center center;
	display: inline-block;
	height: 25px;
	left: 3;
	position: absolute;
	width: 25px;
	margin-top: 47px;
}

.yhqnr {
	height: 50%;
	text-align: center;
}

.yhqnr p {
	margin-left: 10px;
	display: inline;
}

.row p {
	display: inline;
}

.logodiv {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	overflow: hidden;
	margin: 21px auto;
}

.logodiv img {
	width: 60px;
	height: 60px;
}

.cleft {
	float: left;
	height: 100%;
	width: 25%;
}

.cright {
	float: left;
	height: 100%;
	width: 75%;
}

.ccontent {
	border-left: 1px solid #e6e6e6;
	height: 70px;
	margin-top: 16px;
	width: 100%;
}

.ccontent p {
	margin: 0 0 0 10px;
	color: #adadad;
	font-size: 14px;
}

.title1 {
	width: 100%;
	height: 40px;
	line-height: 40px;
}

.title2 {
	width: 100%;
	height: 30px;
	line-height: 30px;
}

.namep {
	text-align: left;
	float: left;
	margin-left: 10px;
}

.rightp {
	float: right;
}

.top_bar {
	bottom: 0;
	font-family: Helvetica, Tahoma, Arial, Microsoft YaHei, sans-serif;
	left: 0;
	margin: auto;
	position: fixed;
	right: 0;
	z-index: 900;
}

.cardloading {
	width: 100%;
	text-align: center;
}

.cardloading p {
	margin-top: 20px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>优惠券</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	function Load(src) {
		window.location.href = src;
	}

	/* function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		
		if(month < 10) {
			month = "0"+month;
		}
		if(dd < 10) {
			dd = "0" + dd;
		}
		
		return year+"-"+month+"-"+dd ;
	} */

	var data = $.parseJSON('${exts}');
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		//alert("本活动仅支持微信");
	} else if (wechatInfo[1] < "6.0") {
		alert("本活动仅支持微信6.0以上版本");
	}

	wx.config({
		debug : false,
		appId : '${appId}', // 必填，公众号的唯一标识
		timestamp : '${timestamp}', // 必填，生成签名的时间戳
		nonceStr : '${nonceStr}', // 必填，生成签名的随机串
		signature : '${signature}',// 必填，签名，见附录1
		jsApiList : [ 'addCard' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});

	wx.ready(function() {
		/* listCard(); */
		$(".cardloading").css("display","none");
		$(".cards").css("display", "");
	});
	wx.error(function(res) {
		alert("加载错误:" + JSON.stringify(res));
			});
	$(document).ready(function() {

	});
	var readyFunc = function onBridgeReady() {

	}

	/* function listCard() {
		$.post("${ctx}/wxcard/getcardlist",function(cards){
			var cardlist = cards.data;
			if(cards.result == '1') {
				
				for(var i=0; i<cardlist.length;i++) {
					
					var cardname = cardlist[i].card.name;
					if(cardname.length > 5) {
						cardname = cardname.substring(0,5) + '...';
					}
					
					$(".cards").append('<div class="row bottomborder" onclick="addcrad(\''+cardlist[i].cardid+'\',\''+i+'\')">' +
					   				   		'<div class="addyhq">' +
					   				   			'<div class="left"></div>' +
						   			   			'<div class="center">' + 
								   					'<div class="cleft">' + 
								   			   				'<div class="logodiv">' + 
								   			   				(cardlist[i].card.isonly == 1 ? '<img alt="" src="${ctx}/'+cardlist[i].card.logourl+'">' : '<img alt="" src="${ctx}/static/images/headimg.jpg">') +
								   							'</div>' + 
								   					'</div>' + 
							   			    		'<div class="cright">' + 
							   			   		 		'<div class="ccontent">' + 
							   			   			 		'<div class="title1">' + 
							   			   				 		'<p style="color: #2bc4b6; font-size: 20px;" class="namep">'+cardname+'</p>' + 
							   			   				 		'<p style="margin: 13px 10px 0 0; height: 20px; line-height: 20px" class="rightp">有效日期</p>' + 
							   			   			 		'</div>' + 
							   			   			 		'<div class="title2">' + 
							   			   				 		'<p style="float: left">'+cardlist[i].card.merchantname+'</p>' + 
							   			 				 		'<p style="margin: 0 10px 0 0; font-size: 10px;" class="rightp">' + 
							   			 				 			(cardlist[i].card.datetype == 1 ? formattime(cardlist[i].card.starttime)+'-'+formattime(cardlist[i].card.endtime) : 
							   			 					 		(cardlist[i].card.delaytime == 0 ? '当天生效，有效天数：'+ cardlist[i].card.usetime : cardlist[i].card.delaytime+'天生效，有效天数：'+ cardlist[i].card.usetime)) +
							   							 		'</p>' + 
							   						 		'</div>' + 
							   					 		'</div>' + 
							   			    		'</div>' + 
						   			   			'</div>' + 
						   			   			'<div class="right"></div>' +
						   			   		'</div>' +
						   			   '</div>'
						);
					
				}
				
			}
			
		});
		
	} */

	function addcrad(id, index) {
		wx.addCard({
			cardList : [ {
				cardId : id,
				cardExt : JSON.stringify(data[index])
			} ], // 需要添加的卡券列表
			success : function(res) {
				var cardList = res.cardList; // 添加的卡券列表信息
			}
		});
	}

	if (typeof WeixinJSBridge === "undefined") {
		document.addEventListener('WeixinJSBridgeReady', readyFunc, false);
	} else {
		readyFunc();
	}
</script>

<body>
	<div class="head">
		<c:if test="${ad!=null}">
			<img src="${ctx}/${ad.img}">
		</c:if>
		<c:if test="${ad==null}">
			<img src="${ctx}/static/wxfile/images/yhad.jpg">
		</c:if>
	</div>

	<!-- <div class="cards"></div> -->
	<div class="cardloading">
		<p>数据加载中...</p>
	</div>
	<div class="cards" style="display: none">
		<c:forEach items="${data}" var="card" varStatus="st">
			<div class="row  bottomborder"
				onclick="addcrad('${card.cardid}','${st.index}')" style="">
				<div class="addyhq">
					<div class="left"></div>
					<div class="center">
						<div class="cleft">
							<div class="logodiv">
								<c:if test="${card.card.isonly==1}">
									<img alt="" src="${ctx}/

${card.card.logourl}">
								</c:if>
								<c:if test="${card.card.isonly!=1}">
									<img alt="" src="${ctx}/static/images/headimg.jpg">
								</c:if>


							</div>
						</div>
						<div class="cright">
							<div class="ccontent">
								<div class="title1">
									<!--<p style="color: #2bc4b6; font-size: 20px;" 

class="namep">${card.card.name}</p>-->
									<p style="color: #2bc4b6; font-size: 20px;" class="namep">
										<c:if test="${fn:length(card.card.name) > 12}">${fn:substring(card.card.name,0,12)}...</c:if>
										<c:if test="${fn:length(card.card.name) <= 12}">${card.card.name}</c:if>
									</p>
								<!-- 	<p
										style="margin: 13px 10px 0 0; height: 20px; line-height: 20px"
										class="rightp">有效日期</p> -->
								</div>
								<div class="title2">
									<!--<p style="float: left">${card.card.merchantname}

</p>-->
									<p style="float: left">
										<c:if test="${fn:length(card.card.merchantname) > 5}">${fn:substring(card.card.merchantname,0,5)}...</c:if>
										<c:if test="${fn:length(card.card.merchantname) <= 5}">${card.card.merchantname}</c:if>
									</p>
									<p style="margin: 0 10px 0 0; font-size: 10px;" class="rightp">
										<c:if test="${card.card.datetype==1}">
									${fn:substring(card.card.starttime, 0, 10)}-

${fn:substring(card.card.endtime, 0, 10)}
									</c:if>
										<c:if test="${card.card.datetype==2}">
											<c:if test="${card.card.delaytime==0}">当</c:if><c:if test="${card.card.delaytime!=0}">${card.card.delaytime}</c:if>天生效,有效天

数:${card.card.usetime}
									</c:if>
									</p>
								</div>

							</div>
						</div>


					</div>
					<div class="right"></div>
				</div>
			</div>
		</c:forEach>

	</div>

	<div class="top_bar" style="background-color: #efefef">
		<nav>
			<ul id="top_menu" class="top_menu">
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/advert/wxindex')"><img
						src="${ctx}/static/index/images/index_1_1.png"><label
						style="color: white; text-shadow: none;">首页</label></a></li>
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxpage/merlist')"><img
						src="${ctx}/static/index/images/index_2_1.png"><label
						style="color: white; text-shadow: none;">商家</label></a></li>

				<li><a href="javascript:;"
					onclick="Load('${ctx}/wxcard/cardlist')"><img
						src="${ctx}/static/index/images/index_3_0.png"><label
						style="color: #2bc5b6; text-shadow: none;">优惠</label></a></li>

				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxpage/my')"><img
						src="${ctx}/static/index/images/index_4_1.png"><label
						style="color: white; text-shadow: none;">我的</label></a></li>
			</ul>
		</nav>
	</div>
</body>

</html>