<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>最美校园</title>
<link type="text/css"
	href="${ctx}/static/wxfile/newyear/css/toupiao.css" rel="stylesheet" />
</head>
<body>
	<div class="aa"></div>
	<div class="bb">
		<div class="bb1">加载中......</div>
	</div>
	<div class="cc">
	 <!-- 
	  <div class="cc1">投票成功！</div>
      <div class="cc2">您今天还可以再投(3 - cs)票哦！</div>
       --> 
	</div>
	
	<div class="dd">
	  <!--<p class="dd2">您今天的投票机会已用完，请明天再来！</p> 
	   <p class="dd2">投票失败，请重新打开活动页面！</p> 
	  <p class="dd3">大家快发货不存在</p>-->
	 </div>
	 
	<div class="ewm">
		<!-- <div class="ewm1">长按二维码进入公众号</div>  --> 
	</div>

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
				'onMenuShareAppMessage' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		wx.onMenuShareTimeline({
			title : '最美校园投票啦', // 分享标题
			link : '${baseurl}/wxurl/redirect?url=newyearact/vote?col=${col}', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标

		});

		wx.onMenuShareAppMessage({
			title : '最美校园投票啦', // 分享标题
			desc : '快来欣赏我们的校园，喜欢的点个赞啦。', // 分享描述
			link : '${baseurl}/wxurl/redirect?url=newyearact/vote?col=${col}', // 分享链接
			imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标
		});
	});

	function setCount() {
		$(".aa").hide();
		$(".cc").hide();
		$(".dd").hide();
	}

	$(document).ready(function() {
		getdata();
	});

	function getdata() {
		$(".lt").html("");
		$(".rt").html("");

		$.post("${ctx}/newyearact/find",{collegestate : '${col}'},function(data) {
					for (var i = 0; i < data.length; i++) {
						
						if (i % 2 == 0) {
							              $(".lt").append(
								              '<div class="ys1">'
								                 + '<div class="zpmc">'+ data[i][10]+ ' '+ data[i][6] + '</div>'
								                 + '<img onclick="to('+ data[i][0]+ ')" asrc="'+ data[i][8]+ '?imageView2/2/w/150" src="a.gif" />'
							                + '</div>'

															
							                + '<div class="dz">'
                                                 + '<a class="xm '+ (data[i][14] == 0 ? "": "islike")+ '">'+ data[i][2] + '</a>'
									             + '<a class="tp '+ (data[i][14] == 0 ? "xtp": "xtp")+ '" myid="'+ data[i][0]+ '"> '
												        + '<img src="'+ (data[i][14] == 0 ? " ${ctx}/static/wxfile/newyear/image/toupiaoi.png"
																	                        :"${ctx}/static/wxfile/newyear/image/toupiaop.png")+'">'
									             + '</a>'
									             + '<a class="sz '+ (data[i][14] == 0 ? "": "like")+ '">'+ data[i][15] + '</a>'
							               + '</div>');
								      } else {
								       	$(".rt").append(
													'<div class="ys2">'
															+' <div class="zpmc">'+data[i][10]+' '+ data[i][6]+'</div>'
															+' <img onclick="to('+data[i][0]+')" asrc="'+data[i][8]+ '?imageView2/2/w/150" src="a.gif" />'
												  + '</div> '
												  + '<div class="dz">'
															  +'<a class="xm '+ (data[i][14] == 0 ? "": "islike")+ '">'+ data[i][2]+ '</a>'
															  +'<a class="tp '+ (data[i][14] == 0 ? "xtp": "xtp")+ '" myid="'+ data[i][0]+ '">'
															        + '<img  src="'+ (data[i][14] == 0 ? "${ctx}/static/wxfile/newyear/image/toupiaoi.png "
																	                                    :"${ctx}/static/wxfile/newyear/image/toupiaop.png")+'">'
															  +'</a> '
															  +'<a class="sz '+ (data[i][14] == 0 ? "": "like")+ '">'+ data[i][15]+ '</a>'
												 + ' </div>  '

											);

								}

							}
							init('img')
							addEvent(window, 'scroll', lazyLoad);
							addshow();
						});

	}

	function addshow() {
		$(".xtp").bind("click",function() {
				$(".aa").show();
				<!--$(".bb").show();-->
				var zt = $(this).attr("myid");
				$.post("${ctx}/newyearact/checkfocus",{param : "88000"},function(data) {
					
						if (data.result ==1) {
							
                                      $.post("${ctx}/newyearact/Thup",{productid : zt,collegestate:'${col}'},function(dt) {
										  
												var cs = dt.daysum;
											    $(".aa").hide();
												<!-- $(".bb").hide();-->
												if (dt.result == 1) {
															          if (cs < 3) {
																      // $(".aa").show();
																	   //$(".cc").show();
																	   //$(".cc").html(
																		//			'<div class="cc1">'+ '投票成功！'+ '</div>'
																			//	  + '<div class="cc2">'+ '您今天还可以再投'+ (3 - cs)+ '票哦！'+ '</div>');
																				getdata();

																				//setTimeout("setCount()",1500)

																		   } else {
																		$(".aa").show();
																		$(".dd").show();
																		$(".dd").html(
																					'<p class="dd2">'+ '您今天的投票机会已用完，请明天再来！'+ '</p>');
																		        getdata();
																				setTimeout("setCount()",1500)

																			   }

												} else if (dt.result == 2) {
																		$(".aa").show();
																		$(".dd").show();
																		$(".dd").html(
																					'<div class="dd3">'+ dt.msg+ '</div>');
																			setTimeout("setCount()",1500)
												} else {
																		$(".aa").show();
																	    $(".dd").show();
																	     $(".dd").html(
																					'<p class="dd2">'+ '投票失败，请重新打开活动页面！'+ '</p>');
															
														}

																	});

							}else if(data.result ==-1){
								$(".aa").show();
							    $(".dd").show();
							     $(".dd").html(
											'<p class="dd2">'+ '投票失败，请重新打开活动页面！'+ '</p>');
							
							}else {
								$(".bb").hide();
								$(".aa").show();
								$(".ewm").show();
								$(".ewm").html(
										'<div class="ewm1">'+ '长按二维码进入公众号'+ '</div>'
									+ '<div class="ewm2">'+ '<img class="ewm3" src="'+data.qrurl+'">'+ '</div>');

									}

											})
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
	function to(id) {
		window.location.href = "${ctx}/newyearact/detail?id=" + id;
	}
</script>
</html>


