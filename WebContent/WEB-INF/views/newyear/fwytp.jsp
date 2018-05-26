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
	href="${ctx}/static/wxfile/newyear/css/fwytp.css" rel="stylesheet" />
</head>
<body>
<div class="aa"></div>

<div class="bb">
  <!-- 
    <div class="bb1">您今天的投票机会已用完,<br>请明天再来！<br>请关注金阿福的其他活动。</div>
       <div class="bb2"></div>
  --> 
</div>

<div class="cc">
 <!--
<div class="cc1">您今天的投票机会已用完，</div>
<div class="cc2">请明天再来！</div>
<div class="cc3">请关注金阿福的更多活动！</div>
 -->
</div>

<div class="dd">
<!--<p class="dd2">投票失败，请重新打开活动页面！</p>  -->
</div>

<div class="ewm">
		<!-- <div class="ewm1">长按二维码进入公众号</div>  --> 
</div>

<div class="ee">
<!--<div class="ee1">正在定位中，请稍后！</div>  -->
</div>

<div class="gg">
<!-- <div class="gg1">请允许定位！</div> -->
</div>



<div class="dbtp"><img src="${ctx}/static/wxfile/newyear/image/top.png"></div>
<div class="ot">
		<div class="lt"></div>
			
		<div class="rt"></div>
	   <div class="kong"></div>
</div>
</body>
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
		link : '${baseurl}/wxurl/redirect?url=waiter/vote', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/newyear/image/waitelogo.jpg' // 分享图标

	});

	wx.onMenuShareAppMessage({
		title : '吃在湖滨街，看最美服务员！', // 分享标题
		desc : '快为你心中的最美服务员投上一票吧！更有现金红包等着你，手快有，手慢无哦~', // 分享描述
		link : '${baseurl}/wxurl/redirect?url=waiter/vote', // 分享链接
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




function setCount() {
	$(".aa").hide();
	$(".bb").hide();
	$(".cc").hide();
	$(".dd").hide();
	$(".ee").hide();
	$(".ee1").hide();
	
}
$(document).ready(function() {
	getdata();
	
});

function getdata() {
  $(".lt").html("");
  $(".rt").html("");
	$.post("${ctx}/waiter/gettplist",function(data) {
		var dates=data.data;
		for (var i = 0;i <dates.length; i++) {
			if(i % 2 == 0){
				       $(".lt").append(
				        '<div class="lt1">'
				   		       +'<div class="bh">'+dates[i][1]+'&nbsp;&nbsp;&nbsp;'+dates[i][2]+'</div>'
				   		       +'<div class="dtp">'+'<img class="wy" onclick="to('+ dates[i][0]+ ')" asrc="'+ dates[i][3]+ '?imageView2/2/w/150|imageMogr2/auto-orient" src="a.gif">'+'</div>'
				   		       +'<div class="dz">'
				                   +'<div class="xm">'+dates[i][4]+'</div>'
				                   +'<div class="kk '+ (dates[i][6] == 0 ? "xtp": "xtp")+ '" myid="'+ dates[i][0]+ '">'
				   		                  +'<img class="nn" src="'+ (dates[i][6] == 0 ? " ${ctx}/static/wxfile/newyear/image/dianzani.png"
					                        :"${ctx}/static/wxfile/newyear/image/dianzanp.png")+'">'
					                      +'&nbsp;' +dates[i][5]
				   		           +'<div>'
		                       +'</div>'
		                       +'<div>');
			              }else{
			           $(".rt").append(	  
			        	 '<div class="rt1">'
				   		       +'<div class="bh">'+dates[i][1]+'&nbsp;&nbsp;&nbsp;'+dates[i][2]+'</div>'
				   		       +'<div class="dtp">'+'<img class="wy ys" onclick="to('+ dates[i][0]+ ')" asrc="'+ dates[i][3]+ '?imageView2/2/w/150" src="a.gif">'+'</div>'
				   		    +'<div class="dz">'
			                   +'<div class="xm">'+dates[i][4]+'</div>'
			                   +'<div class="kk '+ (dates[i][6] == 0 ? "xtp": "xtp")+ '" myid="'+ dates[i][0]+ '">'
			   		                 +'<img class="nn" src="'+ (dates[i][6] == 0 ? " ${ctx}/static/wxfile/newyear/image/dianzani.png"
				                        :"${ctx}/static/wxfile/newyear/image/dianzanp.png")+'">'
				                     +'&nbsp;' +dates[i][5]
			   		           +'<div>'
				   		    +'</div>'
				   		 +'<div>');
			                   }
		                                      }
	          
		       init('img')
		        bindshow('.wy'); 
		       addEvent(window, 'scroll', lazyLoad);
		       addshow();
		                                                              });
	
                   }
                   
                   
                   
                
                  
function addshow() {
	$(".xtp").bind("click",function() {
		
		if(loc==0){
			 $(".aa").show();
			 $(".ee").show();
			 $(".ee").html(
						'<div class="ee1">'+ '正在定位中，请稍候！'+ '</div>');
			 setTimeout("setCount()",1500)
			 
		}else if(loc==1){
	
			var zt = $(this).attr("myid");
			$.post("${ctx}/waiter/checkfocus",{param : "44000"},function(data) {
				
					if (data.result ==1) {
				
                                  $.post("${ctx}/waiter/Thup",{"waiterid":zt,"lat":qjlatitude,"lon":qjlongitude},function(dt) {
									      
                                	  
											var cs = dt.daysum;
											if (dt.result == 1) {
														          if (cs < 3) {
															      
																			getdata();
                                                                            setTimeout("setCount()",1500)

																	          } else {
																	            $(".aa").show();
																	            $(".cc").show();
																	            $(".cc").html(
																				'<div class="cc1">'+ '您今天的投票机会已用完，'+ '</div>'
																				+'<div class="cc2">'+ '请明天再来！'+ '</div>'
																				+'<div class="cc3">'+'请关注金阿福的其他活动！'+'</div>');
																	        getdata();
																			setTimeout("setCount()",1500)

																		            }

											} else if (dt.result == 2) {
																	$(".aa").show();
																	$(".bb").css("display","table");
																	$(".bb").html(
																				'<div class="bb1">'+ dt.msg+ '</div>');
																		setTimeout("setCount()",1500)
											} else {
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
							
						
						}else {	
		
							$(".aa").show();
							$(".ewm").show();
							$(".ewm").html(
								'<div class="ewm1">'+ '长按二维码进入公众号'+ '</div>'
								+ '<div class="ewm2">'+ '<img class="ewm3" src="'+data.qrurl+'">'+ '</div>');

							
								}

										})
			
			
			
			
			
		} else if(loc==-1){
			// $(".aa").show();
			// $(".gg").show();
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
		
		
					});

}
                   
//common
function tagName(tagName) {
	return document.getElementsByTagName(tagName); //getElementsByTagName() 方法可返回带有指定标签名的对象的集合
}

function addEvent(obj, type, func) {
	if (obj.addEventListener) {
		obj.addEventListener(type, func, false);
	} else if (obj.attachEvent) {
		obj.attachEvent('on' + type, func);
	}
}

//����ĳЩ����
var v = {
	eleGroup : null,
	eleTop : null,
	eleHeight : null,
	screenHeight : null,
	visibleHeight : null,
	scrollHeight : null,
	scrolloverHeight : null,
	limitHeight : null
}

//�����ݽ��г�ʼ��
function init(element) {
	v.eleGroup = tagName(element)
	screenHeight = document.documentElement.clientHeight; //Chrome浏览器   document.documentElement.clientHeight  浏览器可视部分高度
	scrolloverHeight = document.body.scrollTop; //Chrome浏览器  document.body.scrollTop  浏览器滚动部分高度
	for (var i = 0, j = v.eleGroup.length; i < j; i++) {
		if (v.eleGroup[i].offsetTop <= screenHeight
				&& v.eleGroup[i].getAttribute('asrc')) { //getAttribute(attributename) 方法返回指定属性名的属性值                                                                                                                                      (attributename  必需。需要获得属性值的属性名称)
			v.eleGroup[i].setAttribute('src', v.eleGroup[i]
					.getAttribute('asrc')); // setAttribute(attributename,attributevalue)方法添加指定的属性，并                                                                                                                   为其赋指定的值     (attributename必需,您希望添加的属性的名称                                                                                                                                      attributevalue必需,您希望添加的属性值。)
			v.eleGroup[i].removeAttribute('asrc')
		}
	}

}

function lazyLoad() {
	if (document.body.scrollTop == 0) { //document.body.scrollTop 浏览器滚动部分高度
		limitHeight = document.documentElement.scrollTop
				+ document.documentElement.clientHeight;
	} else {
		limitHeight = document.body.scrollTop
				+ document.documentElement.clientHeight;
	}
	for (var i = 0, j = v.eleGroup.length; i < j; i++) {
		if (v.eleGroup[i].offsetTop <= limitHeight
				&& v.eleGroup[i].getAttribute('asrc')) {
			v.eleGroup[i].src = v.eleGroup[i].getAttribute('asrc');
			v.eleGroup[i].removeAttribute('asrc')
		}
	}
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

function to(id) {
	window.location.href = "${ctx}/waiter/detail?id=" + id;
}
</script>
</html>