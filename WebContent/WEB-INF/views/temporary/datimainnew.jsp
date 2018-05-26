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
<title>有奖问答</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
	filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
}

/*******************************/

div.content {
	width:96%;
	margin:0 2%;
	text-align:center;
	padding-bottom:20px;
	margin-bottom:100px;
}

div.bigtitle {
	width:100%;
	height:50px;
	text-align:center;
	margin:20px 0;
}

div.bigtitle img{
	height:50px;
	margin:auto auto;
}

div.showimgdiv {
	width:100%;
	padding:20px 0;
	background-color: #FFA902;
}

div.showimgdiv img {
	width:100%;
}

.startdiv {
	width: 80%;
	margin: auto;
}

button {
	box-shadow: none;
	width: 90%;
	height: 40px;
	border: none;
	color: white;
	font-size: 20px;
	border-radius:0.6em;
	margin-top: 30px;
}

div.notetip {
	width: 80%;
	margin: auto;
}

div.introdiv {
	width: 90%;
	margin: 15px auto;
	color: #ed304e;
	font-size: 20px;
	text-align: left;
	height: 30px;
	line-height: 30px;
}

div.detailintro {
	width: 90%;
	margin: auto;
	font-size: 14px;
	height: 20px;
	line-height: 20px;
	position:relative;
	font-weight:bold;
	text-shadow: none;
	text-align:left;
}

div.deindex {
	width:8%;
	display:inline;
	text-align:left;
	float:left;
}

div.decon {
	width:90%;
	display:inline;
	float:left;
	text-align:left;
}

div.tail {
	width:100%;
	height:30px;
	background-color:#FFA904;
}

/**************************/

.loadcover {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
}

.loadimg {
	position: absolute;
	z-index: 1000;
	width: 25px;
	height: 25px;
	top: 50%;
	left: 50%;
	margin-top: -12px;
  	margin-left: -12px;
}

    
.ball-clip-rotate {
	background-color: #fff;
	width: 15px;
	height: 15px;
	border-radius: 100%;
	margin: 2px;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
	border: 2px solid #fff;
	border-bottom-color: transparent;
	height: 25px;
	width: 25px;
	background: transparent !important;
	display: inline-block;
	-webkit-animation: rotate 0.75s 0s linear infinite;
	animation: rotate 0.75s 0s linear infinite;
}

@-webkit-keyframes rotate {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg); }

  50% {
    -webkit-transform: rotate(180deg);
            transform: rotate(180deg); }

  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg); } }

@keyframes rotate {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg); }

  50% {
    -webkit-transform: rotate(180deg);
            transform: rotate(180deg); }

  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg); } }
            


</style>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	$(document).ready(function() {

		wx.config({
			debug : false,
			appId : '${config.appId}',
			timestamp : '${config.timestamp}',
			nonceStr : '${config.nonceStr}',
			signature : '${config.signature}',
			jsApiList : [ 'hideOptionMenu', 'showMenuItems',
					'onMenuShareTimeline', 'closeWindow' ]
		});
		
	});
	
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		wx.hideOptionMenu();
		getdatabyjw();
	});
	
	
	function getarea(latitude, longitude) {
		$.post("${ctx}/wxact/getarea", {
			"lat" : latitude,
			"lon" : longitude
		}, function(d) {
			$(".loadcover").css("display","none");
			$(".loadimg").css("display","none");
			if(d.result == '1') {
				$(".btnclass").attr("onclick","gostart()");
			}else if(d.result == '2'){
				$(".btnclass").css("background-color","#cccccc");
			}else{
				
			}
		});

	}
	function getdatabyjw() {
		wx.getLocation({
			type : 'wgs84',
			success : function(res) {

				var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
				var speed = res.speed; // 速度，以米/每秒计
				var accuracy = res.accuracy; // 位置精度
				//alert(latitude+":"+longitude);
				//init(latitude, longitude);
				getarea(latitude, longitude);
			},
			cancel: function (res) {
			    alert('用户拒绝授权获取地理位置');
			    wx.closeWindow();
			}

		});
	}
	
</script>
<body>

	<div class="loadcover"></div>
	<div class="loadimg">
		<div class="ball-clip-rotate"></div>
	</div>
	
	<div class="content">
		<div class="bigtitle">
			<img alt="" src="${ctx}/static/11act/images/questionhead.jpg" class="titleimg">
		</div>
		<div class="showimgdiv">
			<img alt="" src="${ctx}/static/11act/images/question.jpg" class="showimg">
		</div>
		<div class="startdiv">
			<button style="background-color: #ed304e;" class="btnclass">答题得话费</button>
		</div>
		
		<div class="startdiv" style="margin-top:20px;">
			<div style="font-size:16px; color:red;">此活动仅限无锡地区用户</div>
		</div>
		
		<div class="notetip">
			<div class="introdiv" style="margin-top:20px;">活动介绍:</div>
			<div class="detailintro" style="margin-bottom:20px;">
				小调查，测测你对无锡农村商业银行和金阿福e服务的了解，正确回答问题即有机会赢取话费。
			</div>
			
			<div class="introdiv" style="margin-top:50px;">活动规则:</div>
			<div class="detailintro">
				<div class="deindex">
					1.
				</div>
				<div class="decon">
					活动期间，前10000名完成答卷的粉丝即可获得10元话费；
				</div>
			</div>
			<div class="detailintro">
				<div class="deindex">
					2.
				</div>
				<div class="decon">
					同一个微信ID活动期间只有一次获奖机会；
				</div>
			</div>
			<div class="detailintro">
				<div class="deindex">
					3.
				</div>
				<div class="decon">
					活动日期：2015.11.1-11.11；
				</div>
			</div>
			<div class="detailintro">
				<div class="deindex">
					4.
				</div>
				<div class="decon">
					本活动仅限无锡地区用户，填写手机号码归属地需为无锡。
				</div>
			</div>
			<div class="detailintro">
				<div class="deindex">
					5.
				</div>
				<div class="decon">
					在法律范围内，最终解释权归主办方。
				</div>
			</div>
		</div>
		
	</div>
	<div class="tail">
			
	</div>
</body>



<script type="text/javascript">
	function gostart(){
		window.location.href = "${ctx}/wxact/startanswer";
	}
	
</script>
</html>