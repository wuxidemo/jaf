<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="format-detection" content="telephone=no" />

<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>最美服务员</title>
<link type="text/css"
	href="${ctx}/static/wxfile/newyear/css/fwyxq.css" rel="stylesheet" />
</head>
<body>

<div class="aa"></div>

<div class="bb">
  <!--<div class="bb1">您今天的投票机会已用完,<br>请明天再来！<br>请关注金阿福的其他活动。</div>
    <div class="bb1">您已为他投过票！</div>
     <div class="bb2">请把票投给其他人吧~</div>
     --> 
</div>

<div class="cc">
<!-- 
<div class="cc1">您今天的投票机会已用完，</div>
<div class="cc2">请明天再来！</div>
<div class="cc3">请关注金阿福的更多活动！</div>
 -->
</div>

<div class="dd"></div>

<div class="ewm">
    <!-- <div class="ewm1">长按二维码进入公众号</div> -->
</div>

<div class="ee">
<!--<div class="ee1">正在定位中，请稍后！</div>  -->
</div>


<div class="gg">
<!-- <div class="gg1">请允许定位！</div> -->
</div>


<div class="out">
<div class="top">

<div class="lt">
<section class="imgzoom_pack">
    <div class="imgzoom_x">X</div>
    <div class="imgzoom_img">
        <img src=""/>
    </div>
</section>

<div class="wbtp"><img class="wy" class="tp" orsrc="${waiter.url}" src=""></div> 


</div>
<div class="rt">
<div class="rt1"><a class="rt11">${waiter.senumber}</a><a class="rt12">${waiter.name}</a></div>
<!-- 
<div class="rt2">
<a class="rt21">店铺名称:</a>
<a class="rt22">${waiter.mername}</a>
</div>
 -->
<div class="rt2">店铺名称：</div>

<div class="rt22">${waiter.mername}</div>




<div class="rt3"><a class="rt31">个人心语：</a></div>
<div class="rt4"><a class="rt41">${waiter.context}</a></div>
</div>
<div style="clear:both"></div>
<div class="wb">
<c:if test="${iscount==0}"><img class="df" src="${ctx}/static/wxfile/newyear/image/dianzani.png" onclick="addInformation()" />${allcount}</c:if>
<c:if test="${iscount!=0}"><img class="df" src="${ctx}/static/wxfile/newyear/image/dianzanp.png" onclick="addInformation()" />${allcount}</c:if>
</div>
</div>
</div>
<div class="hx"></div>
<div class="sm">扫描二维码进行投票</div>
<div class="ymewm"><img class="ewmtp" src=""></div>
</body>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<script src="${ctx}/static/scale/js/scale.js"></script>

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
	<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

wx.config({
	debug : false,
	appId : '${config.appId}',
	timestamp : '${config.timestamp}',
	nonceStr : '${config.nonceStr}',
	signature : '${config.signature}',
	jsApiList : [ 'onMenuShareTimeline', 'openLocation',
			'onMenuShareAppMessage' ,'getLocation']
});
wx.error(function(res) {
	//alert("加载错误:" + JSON.stringify(res));
});
wx.ready(function() {
	wx.onMenuShareTimeline({
		title : '吃在湖滨街，看最美服务员', // 分享标题
		link : '${baseurl}/wxurl/redirect?url=waiter/detail?id=${waiter.id}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/newyear/image/waitelogo.jpg' // 分享图标

	});

	wx.onMenuShareAppMessage({
		title : '吃在湖滨街，看最美服务员', // 分享标题
		desc : '我是${waiter.senumber}号${waiter.name}，正在参加“最美服务员”活动，快为我投上一票吧！更有现金红包等着你！', // 分享描述
		link : '${baseurl}/wxurl/redirect?url=waiter/detail?id=${waiter.id}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/newyear/image/waitelogo.jpg' // 分享图标
	});
	wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        qjlatitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        qjlongitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        loc=1;
	    },
	    cancel:function(){
	    	loc=-1;
	    } 
	});
	
});

var loc=0;
var qjlongitude;
var qjlatitude;


$(document).ready(function() {
	bindshow('.wy')
	$(".wy").attr("src","${waiter.url}?imageView2/2/w/300|imageMogr2/auto-orient");
	
	ImagesZoom.init({
		"elem" : ".wbtp"
	});
	var waiterid = '${waiter.id}';
	$.post("${ctx}/waiter/getfwyurl",{"id":waiterid},function(data) {
		if(data.result == '1') {
			$(".ewmtp").attr("src",data.fwyurl);    //attr() 方法设置或返回被选元素的属性值
		}
	});
	
});


function setCount() {
	$(".aa").hide();
	$(".bb").hide();
	$(".cc").hide();
	$(".dd").hide();
	$(".ee").hide();
}
function addInformation(){
	//$(".divimg").bind("click",function() {
		//$(".aa").show();
	if(loc==0){
			 $(".aa").show();
			 $(".ee").show();
			 $(".ee").html(
						'<div class="ee1">'+ '正在定位中，请稍后！'+ '</div>');
			 setTimeout("setCount()",1500)
			 
}else if(loc==1){		
		  
		$.post("${ctx}/waiter/checkfocus",{param : "543000${waiter.id}"},function(data) {
			if (data.result ==1) {

				           $.post("${ctx}/waiter/Thup",{"waiterid":'${waiter.id}',"lat":qjlatitude,"lon":qjlongitude},function(dt){
					           var cs = dt.daysum;
					           // $(".aa").hide();
									    if(dt.result ==1) {
							
										                    if (cs < 3) {
										                  //  $(".aa").show();
											              //  $(".cc").show();
											              //  $(".cc").html(	
										                  //  '<div class="cc1">'+'投票成功！'+'</div>'
								                          //   +'<div class="cc2">'
										                  //   + '您今天还可以再投'
											              //   + (3 - cs)
											              //   + '票哦！'
											              //   + '</div>');
											                loadPage();
											               setTimeout("setCount()",1500)

										                               } else {
										                            	   $(".aa").show();
																            $(".cc").show();
																            $(".cc").html(
																			'<div class="cc1">'+ '您今天的投票机会已用完，'+ '</div>'
																			+'<div class="cc2">'+ '请明天再来！'+ '</div>'
																			+'<div class="cc3">'+'请关注金阿福的其他活动！'+'</div>');
											                                  loadPage();
										                                    setTimeout("setCount()",1500)
										                                      }
								        }else if (dt.result == 2) {
								        	                            $(".aa").show();
											                            $(".bb").css("display","table");
											                            $(".bb").html(
														                '<div class="bb1">'+ dt.msg+ '</div>');
											                    
											                            
																	setTimeout("setCount()",1500)
							            }else {
																$(".aa").show();
															    $(".dd").show();
															     $(".dd").html(
																			'<p class="dd2">'+ '投票失败，请重新打开活动页面！'+ '</p>');
															     setTimeout("setCount()",1500)
												}

				                                                                               });
			 }else if(data.result ==-1){
			             $(".aa").show();
						 $(".dd").show();
						 $(".dd").html(
					'<p class="dd2">'+ '投票失败，请重新打开活动页面！'+ '</p>');
						 setTimeout("setCount()",1500)        	
		     } else {
				         $(".aa").show();
				         $(".ewm").show();
				         $(".ewm").html(
						 '<div class="ewm1">'+'长按二维码进入公众号'+'</div>'
					    +'<div class="ewm2">'+ '<img class="ewm3" src="'+data.qrurl+'">'+ '</div>');		
			                    }					
		});
		
		
}else if(loc==-1){
	// $(".aa").show();
	 //$(".gg").show();
	 //$(".gg").html(
		//		'<div class="gg1">'+ '请允许定位!'+ '</div>');
	 loc=0;
	 wx.getLocation({ 
		 type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
		    success: function (res) {
		        qjlatitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		        qjlongitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		        var speed = res.speed; // 速度，以米/每秒计
		        var accuracy = res.accuracy; // 位置精度
		        loc=1;
		    },
		    cancel:function(){
		    	loc=-1;
		    } 
	 });
	
}
//});
}
function loadPage(){
	window.location.reload();
}


function bindshow(wy) {
	$(wy).css("position", "absolute");
	$($(wy).parent()).css("position", "relative");
	$($(wy).parent()).css("overflow", "hidden");
	$(wy).bind(
			"load",
			function() {
				if ($(this).attr("asrc") == null) {
					var $this = $(this);
					var oImg = new Image();
					oImg.onload = function() {
						if (oImg.width > oImg.height) {
							$this.css("height", "100%");
							$this.css("left", "50%");
							$this.css("top", "0");
							$this.css("margin-left", "-"
									+ (oImg.width * $this.parent().width()
											/ oImg.height / 2) + "px");
							$this.css("width", "auto");
							$this.css("margin-top", 0);
						} else {
							$this.css("width", "100%");
							$this.css("top", "50%");
							$this.css("left", "0");
							$this.css("margin-top", "-"
									+ (oImg.height * $this.parent().width() 
											/ oImg.width / 2) + "px");
							$this.css("height", "auto");
							$this.css("margin-left", 0);
						}
					}
					oImg.src = $(this).attr("src");

				}

			});
}

</script>
</html>