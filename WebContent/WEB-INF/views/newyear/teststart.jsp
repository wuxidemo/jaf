<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<title>点评</title>
</head>

<style>

/*******长按二维码关注*******/

html,body {
	margin:0;
	padding:0;
	background-color: #EFEFED;
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

.focusdiv {
	left: 50%;
	position: absolute;
	width: 240px;
	height:270px;
	top: 50%;
	margin-left: -120px;
	margin-top:-135px;
	background-color: white;
	border-radius: 10px;
	display: none;
}

.closei {
	width:32px;
	height:32px;
	position:absolute;
	top:0;
	right:30px;
	border-bottom-right-radius:0.4em;
	border-bottom-left-radius:0.4em;
	background: url("${ctx}/static/images/closefocus.png") no-repeat center;
}

.focustitle {
	width:100%;
	height:20px;
	line-height:20px;
	margin-top:10px;
	font-size:20px;
	text-align: center;
	color:#535353;
	
}

.focusbody {
	width:100%;
	text-align:center;
}

.focusbody img {
	margin-top:20px;
	width:80%;
}

/**************/

.headimgdiv {
	width:100%;
}

.headimgdiv img{
	width:100%;
}

.acttitle {
	width:100%;
	height:30px;
	line-height:30px;
	text-align:center;
	color:red;
	font-size:20px;
	margin:50px auto;
}

.getindiv {
	width:100%;
	text-align:center;
}

.jiangnan {
	width:50%;
	float:left;
	height:30px;
	line-height:30px;
	text-align:center;
	font-size:20px;
}

.taihu {
	width:50%;
	float:left;
	height:30px;
	line-height:30px;
	text-align:center;
	font-size:20px;
}

.startbtn {
	width:100px;
	height:30px;
	border-radius:50px;
	background-color:red;
	color:white;
	text-align:center;
	margin:auto;
}

.actrole {
	width:100%;
	height:30px;
	line-height:30px;
	text-align:center;
	color:red;
	font-size:18px;
	margin-top:200px;
	
}

</style>
<body>
	<div class="backdiv"></div>
	<div class="focusdiv">
		<!-- <i class="closei"></i> -->
		<div class="focusbody">
			<img alt="" src="${ctx}/static/images/focusqr.jpg">
		</div>
		<div class="focustitle">
			长按二维码进入公众号
		</div>
	</div>
	<div class="headimgdiv">
		<img alt="" src="${ctx}/static/wxfile/newyear/image/testmask_01.jpg">
	</div>
	<div class="acttitle">
		参加活动入口
	</div>
	<div class="getindiv">
		<div class="jiangnan">
			<div class="startbtn" onclick="checkfocus()">江南大学</div>
		</div>
		<div class="taihu">
			<div class="startbtn" onclick="checkfocus()">太湖学院</div>
		</div>
	</div>
	
	<div class="actrole">活动规则</div>
	
</body>

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		/*$(".closei").bind("click",function(){
			$(".focusdiv").css("display","none");
			$(".backdiv").css("display","none");
		});*/
		
		$(".actrole").bind("click",function(){
			window.open("${ctx}/newyearact/actrole");
		});
	});
	
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'hideOptionMenu', 'showMenuItems',
				'onMenuShareTimeline','openLocation','onMenuShareAppMessage' ]
	});
	
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		
		wx.onMenuShareTimeline({
		    title: '最美校园', // 分享标题
		    link: '${baseurl}/wxurl/redirect?url=newyearact/teststart', // 分享链接
		    imgUrl: '${baseurl}/static/wxfile/newyear/image/fenxiang.jpg', // 分享图标
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		
		wx.onMenuShareAppMessage({
		    title: '最美校园', // 分享标题
		    desc: '点击参与最美校园活动，为心仪的选手投票', // 分享描述
		    link: '${baseurl}/wxurl/redirect?url=newyearact/teststart', // 分享链接
		    imgUrl: '${baseurl}/static/wxfile/newyear/image/fenxiang.jpg', // 分享图标
		    
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		
	});
	
	function checkfocus() {
		var checkurl = '${ctx}/newyearact/checkfocus';
		$.post(checkurl, {"param":"99000"}, function(data){
			if(data.result == '1') {
				alert("你已经关注过公众号");
				
			}else if(data.result == '0'){
				$(".backdiv").css("display","block");
				$(".focusdiv img").attr("src",data.qrurl);
				$(".focusdiv").css("display","block");
			}
		}); 
	}
	
</script>

</html>