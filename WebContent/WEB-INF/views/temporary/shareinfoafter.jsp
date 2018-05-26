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
<title>关注+分享,好运无法阻挡</title>
<style type="text/css">
body {
	margin: 0;
	/* text-align: center; */
}

.qrcode {
	width: 200px;
}

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

.loadcover1 {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
	display:none;
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
<body style="margin: 0px;">
    <div class="loadcover1"></div>
	<div class="loadcover"></div>
	<div class="loadimg">
		<div class="ball-clip-rotate"></div>
	</div>
	<div style="width: 100%; height: auto;">
		<img src="${ctx}/static/11act/images/qietu.jpg" style="width: 100%;">
	</div>
	<div style="width: 100%; height: 50px; text-align: center;">
		<img src="${ctx}/static/11act/images/qietu1.jpg"
			style="width: 120px; height: 40px; margin-top: 8px;"> <a
			href="${ctx}/wxurl/redirect?url=/wxact/shareresult">
			<div
				style="width: 85px; height: 40px; background-color: #ee4733; -webkit-border-radius: 20px 0 0 20px; margin-top: -45px; position: absolute; right: 0px;">

				<p style="line-height: 10px; color: #ffffff">中奖名单</p>

			</div>
		</a>
	</div>
	<div style="width: 100%;height: auto;">
	    <img src="${ctx}/static/11act/images/butu.jpg" style="width:100%;">
	</div>
	
	 <!--  提示框 -->
	<div style="width: 100%;height:100px;position: absolute;z-index: 1000;top:40%;margin-top: -50px;display: none;"id="tishi">
		    <div style="width:90%;margin-top: opx;margin-left: auto;margin-right: auto;margin-bottom: 0px;background: url('${ctx}/static/11act/images/tc1.png');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;">
		            <div style="width: 100%;height: auto;text-align: center;padding-top:20px;">
		                <font style="font-size: 20px;color: red;"><b>分享成功</b></font>
		                  <br>
		                  <font style=""id="fo1">
		                 
		                 </font>
		            </div>
		            
		            <div style="width:100%;height: auto;margin-top: 20px;">
		                <div style="width: 40%;height:40px;-webkit-border-radius: 20px 20px 20px 20px;background-color: red;margin-left: auto;margin-right: auto;text-align: center;"onclick="colse()">
		                   <font style="color: #ffffff;font-size: 20px;line-height: 40px;">
		                                                      确定
		                   </font>
		                </div>
		            </div>
		            
		            <div style="width: 100%;height: auto;margin-top: 10px;">
		            <div style="width: 90%;height:25px;margin-left: auto;margin-right:auto; ">
		         <!--      注：券码可以在获奖名单中查看。  -->
		              </div>  
		            </div>
		    </div>
		</div>
	
	<!-- <div style="width: 100%;height: auto;text-align: center;">
	   <font style="font-size: 18px;">
	  ( 关注公众号可见活动规则)
	   </font>
	</div> -->

	<%-- <div style="width: 100%; height: auto;">
		<table style="width: 100%; height: auto; text-align: center;">
			<tr>
				<td style="width: 50%"><img src="${ctx}/static/images/fg2.png"
					style="height: auto; width: 95%"></td>
				<td style="width: 50%"><img src="${ctx}/static/images/tja.jpg"
					style="height: auto; width: 95%"></td>
			</tr>
			<tr>
				<td style="width: 50%"><img src="${ctx}/static/images/fg4.png"
					style="height: auto; width: 95%"></td>
				<td style="width: 50%"><img src="${ctx}/static/images/fg5.png"
					style="height: auto; width: 95%"></td>
			</tr>
		</table>
	</div> --%>

	<%-- <div style="width: 100%; text-align: center;">
		<span> 长按二维码关注公众号 </span> <br> <span> 参与优惠活动 </span>
	</div>

	<!-- 分享二维码 -->
	<div style="width: 100%; text-align: center;">
		<img class="qrcode" src="${ctx}/static/11act/gzfx/gzfxqrcode.jpg">
	</div>

    <div style="width:95%; height: auto; margin-bottom: 5px;padding: 8px;">
		<p style="color: #555555;font-size: 20px;">活动奖品：</p>
		<table style="color: #555555;width: 100% ">
		   <tr>
		     <td>
		     一等奖
		     </td>
		     <td style="padding-left: 30px;">
		       10名
		     </td>
		      <td>
		      300元话费
		     </td>
		   </tr>
		   <tr>
		     <td>
		     二等奖
		     </td>
		     <td style="padding-left: 30px;">
		     20名
		     </td>
		     <td>
		      200元话费
		     </td>
		   </tr>
		   <tr>
		     <td>
		    三等奖
		     </td>
		     <td style="padding-left: 30px;">
		       50名
		     </td>
		     <td>
		     100元话费
		     </td>
		   </tr>
		   <tr>
		     <td style="vertical-align: top;">
		     分享红包
		     </td>
		     <td>
		      每天限前3000名
		     </td>
		     <td>
		     1元红包
		     </td>
		   </tr>
		</table>
	</div>
	<div
		style="width: 95%; height: auto; margin-bottom: 5px; padding: 8px;">
		<p style="color: #555555;font-size: 20px;">关注+分享活动规择：</p>

		<table style="color: #555555">
		   <tr>
		     <td>
		     a)
		     </td>
		     <td>
		          每天前3000名分享的用户可获得红包.
		     </td>
		   </tr>
		   <tr>
		     <td>
		     b)
		     </td>
		     <td>
		         同一个微信ID只可获得一次红包.
		     </td>
		   </tr>
		   <tr>
		     <td>
		     c)
		     </td>
		     <td>
		        每天分享可参与每天抽奖.
		     </td>
		   </tr>
		   <tr>
		     <td style="vertical-align: top;">
		     d)
		     </td>
		     <td>
		         随机抽取幸运粉丝，获奖名单于次日在本微信公众平台公布.
		     </td>
		   </tr>
		   <tr>
		     <td>
		     e)
		     </td>
		     <td>
		        在法律范围内，最终解释权归主办方
		     </td>
		   </tr>
		</table>
	</div> --%>
	<div style="width: 100%;height: auto;">
	   <img src="${ctx}/static/11act/images/qietu3.jpg"style="width: 100%">
	</div>
	<%-- <div style="width: 100%;height: auto;">
	   <img src="${ctx}/static/11act/images/gz3.jpg"style="width: 100%">
	</div> --%>
	<!-- <div style="width: 100%; height: 20px;"></div> -->

</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	var opendid = '${openid}';
	
	function colse(){
		 $("#tishi").css("display", "none");
		 $(".loadcover1").css("display", "none");
	}

	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	$(document)
			.ready(
					function() {

						wx.config({
							debug : false,
							appId : '${config.appId}',
							timestamp : '${config.timestamp}',
							nonceStr : '${config.nonceStr}',
							signature : '${config.signature}',
							jsApiList : [ 'hideOptionMenu', 'showMenuItems',
									'onMenuShareTimeline' ]
						});
						wx.error(function(res) {
							//alert("加载错误:" + JSON.stringify(res));
						});
						wx
								.ready(function() {
									$(".loadcover").css("display","none");
									$(".loadimg").css("display","none");
									wx.hideOptionMenu();
									wx
											.showMenuItems({
												menuList : [ 'menuItem:share:timeline' ],
												success : function(res) {
												},
												fail : function(res) {
												}
											});
									if (opendid != "") {

										wx
												.onMenuShareTimeline({
													title : '关注+分享，好运无法阻挡', // 分享标题
													link : '${url}', // 分享链接
													imgUrl : 'http://ts.do-wi.cn/nsh/static/11act/gzfx/gzfxlogo.jpg', // 分享图标
													success : function() {
														// 用户确认分享后执行的回调函数
														$
																.post(
																		"${ctx}/wxact/shared/${openid}",
																		function(
																				d) {
																			//alert("您已成功分享,获得一次抽奖机会,抽奖编号为"
																			//		+ d);
																			var str = "";
																			if(d.over==null){
																				if (d.luck != null) {
																					if (d.redbag != null) {
																						str = "恭喜您获得红包一只，并可自动参与当日系统抽奖，您的券码是"+d.luck;
																					}else
																					{
																						if(d.isAllcount!=null)
																						{
																							str="您来晚了，明天早点来有红包啊！您的券码是"+d.luck+"，可自动参与当日系统抽奖。";
																						}
																						else if(d.ismycount!=null)
																						{
																							str="您已经领过红包，您的券码是"+d.luck+"，可自动参与当日系统抽奖。";
																						}
																					}
																				}else
																				{
																				str="您已参与当日系统抽奖。";
																				}
																			}
																			else{
																				str="活动已结束";
																			}
																			
																			/* alert(str); */
																			 $("#fo1").text(str);
																			 $("#tishi").css("display","");
																			 $(".loadcover1").css("display","block");
																			 $("body").scrollTop(0);
																		});
													},
													cancel : function() {
														// 用户取消分享后执行的回调函数
													}
												});
									}
								});
					});
</script>
</html>