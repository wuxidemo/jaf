<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family: Microsoft YaHei;
}

.contentdiv {
	text-align: justify;
	padding: 0 20px;
	margin: 0;
	background-color: white;
}

.innerdiv {
	width: 100%;
	margin: auto;
}

.innerdiv img {
	width: 100%;
}

.head {
	padding: 0px 20px;
	margin-top: 15px;
}

.title {
	margin-bottom: 10px;
	width: 100%;
	font-size: 18px;
	color: #F7BB20;
}

.timelogo {
	width: 23px;
	display: table-cell;
	position: relative;
	top: 12px;
}

.readlogo {
	background: url('${ctx}/static/wxfile/main1601/image/readcount1.png')
		center no-repeat;
	width: 18px;
	height: 100%;
	display: table-cell;
	background-size: 75%;
	height: 100%;
	display: table-cell;
}

.time {
	display: table-cell;
}

.readcount {
	display: table-cell;
	text-align: right;
}

.detail {
	width: 100%;
	height: 20px;
	line-height: 40px;
	display: table;
	color: #9FA1A0;
	border-top: 1px solid #D6D6D6;
}

.readcountimg {
	margin-right: 4px;
	width: 17px;
}

.timeimg {
	width: 14px;
	position: absolute;
}

.btndiv {
	width: 100%;
	text-align: center;
	margin-bottom: 30px;
}

.btn {
	width: 80%;
	height: 40px;
	background-color: #F7BB20;
	color: white;
	font-size: 18px;
	margin: auto;
	line-height: 40px;
	margin-top: 30px;
	border-radius: 6px;
}

.container {
	background-color: white;
	position: fixed;
	top: 0;
	width: 100%;
	bottom: 0;
}

.huise {
	background-color: #D8D8D8 !important;
}
</style>
<title>抢购详情</title>
</head>
<body>
	<div class="head">
		<div class="title">${sq.title}</div>
		<div class="detail"></div>
	</div>
	<div class="contentdiv">
		<div class="innerdiv">${sq.content}</div>
	</div>
	<div class="btndiv">
		<c:if test="${state==1}">
			<div class="btn huise">敬请期待</div>
		</c:if>
		<c:if test="${state==2}">
			<c:if test="${payed==0}">
				<div class="btn" onclick="getpayparam()">${sq.buttontext}</div>
			</c:if>
			<c:if test="${payed==1}">
				<c:if test="${hascard==1}">
					<div class="btn huise">已抢购</div>
				</c:if>
				<c:if test="${hascard==0}">
					<div class="btn" onclick="showcard()">领取卡券</div>
				</c:if>
			</c:if>
		</c:if>
		<c:if test="${state==3}">
			<div class="btn huise">已售完</div>
		</c:if>
		<c:if test="${state==4||state==5}">
			<div class="btn huise">已结束</div>
		</c:if>



	</div>

	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent"></p>
		</div>
	</div>


	<div class="container" id="container" style="display: none;">
		<div class="msg">
			<div class="weui_msg">
				<div class="weui_icon_area">
					<i class="weui_icon_warn weui_icon_msg"></i>
				</div>
				<div class="weui_text_area">
					<h2 class="weui_msg_title">支付失败</h2>
					<p class="weui_msg_desc"></p>
				</div>
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a href="javascript:window.location.reload();"
							class="weui_btn weui_btn_primary">确定</a>
					</p>
				</div>
				<div class="weui_extra_area"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var qgid = '${sq.id}';
	var openid = '${openid}';
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	//else if (wechatInfo[1] < "6.0") {
	//alert("本活动仅支持微信6.0以上版本");
	//}
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'addCard','onMenuShareTimeline','onMenuShareAppMessage' ]
	});

	wx.ready(function() {
		wx.onMenuShareTimeline({
			title : '${sq.title}', // 分享标题
			link : '${baseurl}/wxurl/redirect?url=wxcommunity/qgdetail?id=${sq.id}', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/main1601/image/qgshare.png' // 分享图标

		});

		wx.onMenuShareAppMessage({
			title : '${sq.title}', // 分享标题
			desc : '${sq.subtitle}', // 分享描述
			link : '${baseurl}/wxurl/redirect?url=wxcommunity/qgdetail?id=${sq.id}', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/main1601/image/qgshare.png' // 分享图标
		});

	});

	function getpayparam() {
		$.post("${ctx}/wxcommunity/gobuy?id=" + qgid + "&openid=" + openid,
				function(d) {
					if (d.result == "1") {
						pay(d.appId, d.timeStamp, d.nonceStr, d.package1,
								d.signType, d.paySign);
					} else if(d.result == "2") {
						showcard();
					} else {
						showalert(d.msg, 1500);
					}
				});
	}
	function pay(appId, timeStamp, nonceStr, package1, signType, paySign) {
		WeixinJSBridge.invoke('getBrandWCPayRequest', {
			"appId" : appId, //公众号名称，由商户传入     
			"timeStamp" : timeStamp + "", //时间戳，自1970年以来的秒数     
			"nonceStr" : nonceStr, //随机串     
			"package" : package1,
			"signType" : signType, //微信签名方式:     
			"paySign" : paySign
		//微信签名 
		}, function(res) {
			if (res.err_msg == "get_brand_wcpay_request:ok") {
				showcard();
			} else {
				$("#container").show();
			}
		});
	}
	function showcard() {
		wx.addCard({
			cardList : [ {
				cardId : '${cardid}',
				cardExt : '${card_ext}'
			} ], // 需要添加的卡券列表
			success : function(res) {
				if (res.errMsg == "addCard:ok") {
					updatecardstate();
				}
			}
		});
	}
	function updatecardstate() {
		$.post("${ctx}/wxcommunity/updateqgcard?id=" + qgid + "&openid="
				+ openid, function(d) {
			if (d.result == "1") {
				window.location.reload();
			} else {
				showalert("请重新领取卡券", 1500);
			}

		});
	}
	function showalert(str, time) {
		$("#toastcontent").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, time == undefined ? 1500 : time);
	}
</script>
</html>