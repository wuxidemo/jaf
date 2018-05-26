<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>详情页面</title>
	
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/static/wxfile/newyear/css/styles.css">

  </head>
  <body>
    <div class="aa"></div>
    <div class="bb">
		<!-- <div class="bb1">加载中......</div> -->
	</div>
	<div class="cc">
	 <!--
	 
	  <div class="cc1">投票成功！</div>
      <div class="cc2">您今天还可以再投(3 - cs)票哦！</div>
	   -->
	</div>
	 <div class="dd">
	 <!--<p class="cc3">您今天的投票次数已经使用完了！</p> 
	 <p class="dd2">投票失败，请重新打开活动页面！</p> -->
	 </div>
	 <div class="ewm">
	</div>
	
	
	
    <div class="div_main">
    <div class="top">
	<div class="div_id"><span>${p.senumber}</span><a class="bt">号作品</a></div>
    <div class="div_title"><span>${p.title}</span></div>
    </div>
    <div style="clear:both"></div>
    <div class="div_img"><img src="${p.url}?imageView2/2/w/300" width="100%"/></div>
<div class="zj">
    <div class="div_name">${p.name}</div>
    <div class="div_xueyuan">${p.college}</div>
    <div class="div_like">
    <c:if test="${iscount==0}"><img class="divimg" src="${ctx}/static/wxfile/newyear/image/toupiaoi.png" onclick="addInformation()" /><div class="sl">${allcount}</div></c:if>  
    <c:if test="${iscount!=0}"><img class="" src="${ctx}/static/wxfile/newyear/image/toupiaop.png" onclick="addInformation()" /><div class="xys sl" >${allcount}</div></c:if>
    </div>
</div>
    <div class="div_content"><span >作品介绍：</span><a class="js">${p.context}</a></div>
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
		title : '我的校园', // 分享标题
		link : '${baseurl}/wxurl/redirect?url=newyearact/detail?id=${p.id}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标

	});

	wx.onMenuShareAppMessage({
		title : '我的校园', // 分享标题
		desc : '我独爱这校园一角。', // 分享描述
		link : '${baseurl}/wxurl/redirect?url=newyearact/detail?id=${p.id}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/newyear/image/sharelog.jpg' // 分享图标
	});
});
function setCount() {
	$(".aa").hide();
	$(".cc").hide();
	$(".dd").hide();
}
function addInformation(){
	//$(".divimg").bind("click",function() {
		$(".aa").show();
		<!--$(".bb").show();-->
		$.post("${ctx}/newyearact/checkfocus",{param : "77000${p.id}"},function(data) {
			if (data.result ==1) {

				           $.post("${ctx}/newyearact/Thup",{productid :'${p.id}',collegestate:'${p.collegestate}'},function(dt) {
					           var cs = dt.daysum;
					            $(".aa").hide();
							  <!--  $(".bb").hide();-->
									    if(dt.result ==1) {
							
										                    if (cs < 3) {
										                	//$(".aa").show();
											            //    $(".cc").show();
											              //  $(".cc").html(	
										                  //  '<div class="cc1">'+'投票成功！'+'</div>'
								                         //   +'<div class="cc2">'
										                 //  	+ '您今天还可以再投'
											             //   + (3 - cs)
											             //   + '票哦！'
											             //   + '</div>');
											                loadPage();
											               setTimeout("setCount()",1500)

										                               } else {
											                                  $(".aa").show();
											                                  $(".dd").show();
											                                  $(".dd").html(
												                              '<p class="cc3">'
											                                 + '您今天的投票机会已用完，请明天再来！'
											                                 + '</p>');
											                                  loadPage();
										                                    setTimeout("setCount()",1500)
										                                      }
								        }else if (dt.result == 2) {
																$(".aa").show();
																$(".dd").show();
																$(".dd").html(
																			'<div class="dd3">'+ dt.msg+ '</div>');
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
			                    	
		     } else {
				         <!--$(".bb").hide();-->
				         $(".aa").show();
				         $(".ewm").show();
				         $(".ewm").html(
						 '<div class="ewm1">'+'长按二维码进入公众号'+'</div>'
					    +'<div class="ewm2">'+ '<img class="ewm3" src="'+data.qrurl+'">'+ '</div>');		
			                    }					
		});
//});
}
function loadPage(){
	window.location.reload();
}
</script>
</html>
