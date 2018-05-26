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
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<meta name="apple-touch-fullscreen" content="yes">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta name="description" content="">
	<title>${merchant.name}活动页</title>
	
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
	
	
</head>

<style>

.contentdiv img{
	width:100%;
	height:100%;
}

.innerdiv p {
	line-height: 20px;
}

.imgspan {
	padding-left:25px; 
	color:rgba(0,0,0,0);
	font-size:20px;
	position:relative; 
	display:block;
	height:27px; 
	margin-top:-42px;
	background:#000; 
	filter: alpha(opacity=100); 
	opacity:0.65;
	padding-top:5px;
	padding-bottom:5px;
	font-weight: normal;
}

div.itemlabel {
	height:16px;
	line-height:100%;
	/* margin-right:5px; */
	border:1px orange solid;
	color:orange;
	display: inline-block;
	padding-top:1px;
	padding-bottom:1px;
	border-radius:5px;
	position:absolute;
	right:20px;
}

div.tel {
	width:18px;
	height:20px;
	background: url('${ctx}/static/images/shdh.png') no-repeat center;
	background-size:15px 15px;
	line-height:100%;
	display: inline-block;
	vertical-align: middle;
	margin-right:5px;
}

div.address {
	width:18px;
	height:20px;
	background: url('${ctx}/static/images/shdd.png') no-repeat center;
	background-size:15px 15px;
	line-height:100%;
	display: inline-block;
	vertical-align: middle;
	margin-right:5px;
}

/***************************/

.cards {
	width: 100%;
	text-align: center;
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
	
div:FOCUS {
	border: none;
	background: none;
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
/***************************/

</style>

<body>
	<div data-role="page" style="margin:0;padding:0;" id="pagebody">
		<div style="width: 100%;height: 200px;">
			<img alt="" src="${ctx}/${merchant.detailurl}" width="100%" height="200px;" onclick="showdetail('${merchant.id}')">
			<span class="imgspan" style="">${merchant.name}</span>
		</div>
		<div style="margin-left:20px; height:60px;">
			<div style="margin:10px 0; color:#595757;"><div class="tel"></div>${merchant.telephone}<div class="itemlabel"><c:forEach items="${labellist}" var="label"><c:if test="${label.id == merchant.category}">${label.value}</c:if></c:forEach></div></div>
			<div style="margin:10px 0; color:#595757;"><div class="address"></div>${merchant.address}</div>
		</div>
		<div>
			<hr  style="border:none;height: 1px;background-color: #cecece;"/>
		</div>
		
		<div class="cards"></div>
		
		<div style="text-align:justify; padding:0;margin:0;width: 100%;background-color: white;" class="contentdiv">
			<div style="line-height: 60px; padding:20px;" class="innerdiv">
				${article.content}
			</div>
		</div>
		
	</div>
	<div id="showtip" class="showtip"></div>
</body>

<script type="text/javascript" src="http://zb.weixin.qq.com/nearbycgi/addcontact/BeaconAddContactJsBridge.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	BeaconAddContactJsBridge.ready(function(){
	//判断是否关注
		BeaconAddContactJsBridge.invoke('checkAddContactStatus',{} ,function(apiResult){
			if(apiResult.err_code == 0){
				var status = apiResult.data;
				if(status == 1){
					isfocus=true;

				}else{
				  //BeaconAddContactJsBridge.invoke('jumpAddContact');
				  isfocus=false;
				}
			}else{
				alert(apiResult.err_msg)
			}
		});
	});
	var isfocus=null;
	var data=$.parseJSON('${exts}');
	var merid = '${merchant.id}';
	
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i) ;
	if( !wechatInfo ) {
	    alert("本活动仅支持微信") ;
	} else if ( wechatInfo[1] < "6.0" ) {
	    alert("本活动仅支持微信6.0以上版本") ;
	}
	
	wx.config({
		debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId : '${appId}', // 必填，公众号的唯一标识
		timestamp : '${timestamp}', // 必填，生成签名的时间戳
		nonceStr : '${nonceStr}', // 必填，生成签名的随机串
		signature : '${signature}',// 必填，签名，见附录1
		jsApiList : [ 'addCard' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	
	wx.ready(function() {
		listCard();
	});
	
	//var readyFunc = function onBridgeReady() {
		
	//}
	
	function formattime(timestr) {
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
	}
	
	function listCard() {
		$
				.post(
						"${ctx}/wxpage/getcardlist",
						{
							"id" : merid
						},
						function(cards) {
							var cardlist = cards.data;
							if (cards.result == '1') {
								$(".cards")
										.before(
												'<div style="margin-left: 20px;">'
														+ '<span style="font-size: 20px;">优惠券</span>'
														+ '</div>');

								for (var i = 0; i < cardlist.length; i++) {
									
									var cardname = cardlist[i].card.name;
									if(cardname.length > 5) {
										cardname = cardname.substring(0,5) + '...';
									}
									
									var cardmername = cardlist[i].card.merchantname;
									if(cardmername.length > 5) {
										cardmername = cardmername.substring(0,5) + '...';
									}

									$(".cards")
											.append(
													'<div class="row bottomborder" onclick="getCard(\''
															+ cardlist[i].cardid
															+ '\',\''
															+ i
															+ '\')">'
															+ '<div class="addyhq">'
															+ '<div class="left"></div>'
															+ '<div class="center">'
															+ '<div class="cleft">'
															+ '<div class="logodiv">'
															+ (cardlist[i].card.isonly == 1 ? '<img alt="" src="${ctx}/'+cardlist[i].card.logourl+'">'
																	: '<img alt="" src="${ctx}/static/images/headimg.jpg">')
															+ '</div>'
															+ '</div>'
															+ '<div class="cright">'
															+ '<div class="ccontent">'
															+ '<div class="title1">'
															+ '<p style="color: #2bc4b6; font-size: 20px;" class="namep">'
															+ cardname
															+ '</p>'
															+ '<p style="margin: 13px 10px 0 0; height: 20px; line-height: 20px" class="rightp">有效日期</p>'
															+ '</div>'
															+ '<div class="title2">'
															+ '<p style="float: left">'
															+ cardmername
															+ '</p>'
															+ '<p style="margin: 0 10px 0 0; font-size: 10px;" class="rightp">'
															+ (cardlist[i].card.datetype == 1 ? formattime(cardlist[i].card.starttime)
																	+ '-'
																	+ formattime(cardlist[i].card.endtime)
																	: (cardlist[i].card.delaytime == 0 ? '当天生效，有效天数：'
																			+ cardlist[i].card.usetime
																			: cardlist[i].card.delaytime
																					+ '天生效，有效天数：'
																					+ cardlist[i].card.usetime))
															+ '</p>'
															+ '</div>'
															+ '</div>'
															+ '</div>'
															+ '</div>'
															+ '<div class="right"></div>'
															+ '</div>'
															+ '</div>');

								}

								$(".cards")
										.after(
												'<div><hr style="border: none; height: 1px; background-color: #cecece;margin-bottom:0px;" /></div>');

							}

						});

	}
	
	function getCard(id,index) {
		if(isfocus==null)
		{return ;}
	if(isfocus==false)
		{
		alerttip("关注公众号,马上领取!",5000);
		setTimeout("tofocus()",5000);
		return;
		}
		wx.addCard({
		    cardList: [{
		        cardId: id,
		        cardExt: JSON.stringify(data[index])
		    }], // 需要添加的卡券列表
		    success: function (res) {
		        var cardList = res.cardList; // 添加的卡券列表信息
		    }
		});
	}
	
	

	function showdetail(merchantid) {
		window.location.href="${ctx}/wxpage/merdetail?id="+ merchantid;
	}
	function hidetip() {
		$("#showtip").css("bottom", "-30px");
	}
	function alerttip(str, ms) {
		$("#showtip").html(str);
		$("#showtip").animate({
			bottom : "50%"
		}, 500);
		setTimeout("hidetip()", ms);
	}
	function tofocus(){
		BeaconAddContactJsBridge.invoke('jumpAddContact');
	}
	
</script>

</html>