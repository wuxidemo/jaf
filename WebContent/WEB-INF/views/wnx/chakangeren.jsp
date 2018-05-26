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
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<link rel="stylesheet" href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<title>个人信息</title>
<style type="text/css">
	body {
		margin: 0;
		width: 100%;
		height: 100%;
		background-color: white;
		font-family: "Microsoft YaHei" ! important;
	}

	#tou {
		width: 100%;
		background-color: #EEEEEE;
		overflow: hidden;
	}

	#head1 {
		width: 100%;
		text-align: center;
		margin: auto;
	}
	
	#head1 div {
		width: 25%;
	    padding-bottom: 25%;
	    height: 0;
	    border-radius: 50%;
	    margin-left: auto;
	    margin-right: auto;
	    margin-top: 30px;
	    background: url("${headimgurl}?imageView2/2/w/100|imageMogr2/auto-orient") no-repeat;
	    background-size: cover;
	    background-position: 50%;
	}

	#head2 {
		width: 100%;
		height: 35px;
	    color: #595757;
	    float: left;
	    text-align: center;
	    line-height: 35px;
	    font-size: 15px;
	    font-family: "Microsoft YaHei" ! important;
	}
	#middle_1,#middle_2{
		width: 100%;
		color: #595757;
		font-size: 15px;
		border-bottom: 1px solid #DCDDDD;
		overflow: hidden;
	}
	#middle_3{
		width: 100%;
		color: #595757;
		font-size: 15px;
		overflow: hidden;
		padding-left: 26px;
	}
	#middle_4{
		width: 100%;
		color: #595757;
		font-size: 15px;
		overflow: hidden;
	}
	#middle_5{
		width: 100%;
		color: #595757;
		font-size: 15px;
		overflow: hidden;
		margin-top: 70px;
		border-top: 1px solid #DCDDDD;
	}
	#middle_5_left{
		width: 100%;
	    line-height: 42px;
	    text-align: left;
	    padding-left: 30px;
	    overflow: hidden;
	}
	#middle_5_right{
		width: 100%;
	    line-height: 42px;
	    overflow: hidden;
	    text-align: left;
	    padding-left: 30px;
	    border-top: 1px solid #DCDDDD;
	}
	#middle_1_left{
		width: 50%;
		height: 42px;
		float: left;
		line-height: 42px;
	}
	#middle_1_right{
		width: 50%;
		height: 42px;
		float: right;
		line-height: 42px;
	}
	#name{
		width: 50%;
		height: 42px;
		float: left;
		text-align: center;
		}
	#age{
		width: 50%;
		height: 42px;
		float: left;
		text-align: center;
	}
	#fuwushijian{
		width: 80%;
		height: 42px;
		float: left;
		text-align: left;
		text-indent: 26px;
		line-height: 42px;
	}
	#phone{
		width: 19%;
		height: 42px;
		float: left;
		text-align: center;
		border-left: 1px solid #DCDDDD;
	}
	#boda{
		width: 24px;
		height: 24px;
		margin-top: 9px;
	}
	#caineng{
		width: 20%;
	    float: left;
	    text-align: left;
	    line-height: 42px;
	    overflow: hidden;
	}
	#cnlb{
		width: 68%;
	    float: left;
	    line-height: 42px;
	    overflow: hidden;
	}
	.likecourse{
		float: left;
	    width: 70%;
	    text-align: left;
	    font-size: 13px;
	    vertical-align: middle;
	}
	
	.onecourse {
	    width: 90%;
	    display: inline-block;
	    height: 30px;
	    border: 1px solid #EEEEEE;
	    line-height: 30px;
	    text-align: center;
	    border-radius: 30px;
	    -webkit-tap-highlight-color: rgba(0,0,0,0);
	    background-color: #EEEEEE;
	    font-size: 12px;
	    cursor: pointer;
	}
	
	#edtt{
		width: 90%;
	    padding: 10px 26px 0 26px;
	    overflow: hidden;
	}
	#bottom{
		width: 100%;
	    overflow: hidden;
	    margin-top: 10px;
	    margin-bottom: 20px;
	}
	#daishenhe{
		width: 100%;
	    overflow: hidden;
	    text-align: center;
	    margin-top: 20px;
	    display: none;	
	}
	#daishenhe img{
		width: 106px;
		height: 26px;
	}
	#bottom_left{
		width: 50%;
	    float: left;
	    overflow: hidden;
	}
	#bianji{
		width: 85%;
	    display: block;
	    margin-left: 23px;
	    margin-right: auto;
	    font-size: 18px;
	    text-align: center;
	    color: #FFF;
	    background-color: #F8BA1E;
	    line-height: 2.33333333;
	    border-radius: 5px;
	    overflow: hidden;
	}
	#bottom_right{
		width: 50%;
	    float: left;
	    overflow: hidden;
	}
	#xiaxian{
		width: 85%;
	    display: block;
	    margin-left: 2px;
	    margin-right: auto;
	    font-size: 18px;
	    text-align: center;
	    color: #F8BA1E;
	    background-color: white;
	    border: 1px solid #F8BA1E;
	    line-height: 2.33333333;
	    border-radius: 5px;
	    overflow: hidden;
	}
	.weui_cell:before{
	    width: 100%;
	    height: 1px;
	    color: #D9D9D9;
	    -webkit-transform-origin: 0 0;
	    -ms-transform-origin: 0 0;
	    transform-origin: 0 0;
	    transform: scaleY(.5);
	    left: 0;
	}
	.weui_label{
		width: 5em!important;
	}
</style>
</head>
<body>
	<div id="tou">
		<div id="head1">
			<div></div>
		</div>
		<div id="head2">${name}</div>
	</div>
	<div class="weui_cells">
		<div id="middle_1">
			<div id="middle_1_left">
				<div style="width: 50%;height:42px;float:left;"></div>
				<div id="name">性别&nbsp;:&nbsp;
					<c:if test="${sex == 1}">男</c:if>
					<c:if test="${sex == 2}">女</c:if>
				</div>
			</div>
			<div id="middle_1_right">
				<div id="age">年龄&nbsp;:&nbsp;${age}</div>
				<div style="width: 50%;height:42px;float:left;"></div>
			</div>
		</div>
		<div id="middle_2">
			<div id="fuwushijian">服务时间&nbsp;:&nbsp;${servetime}</div>
			<a id="phone" href="tel:${phone}">
				<img id="boda" src="${ctx}/static/wxfile/wnx/image/phone.png">
			</a>
		</div>
		<div id="middle_3">
			<div id="caineng">才能类型&nbsp;:&nbsp;</div>
			<div class="likecourse">
					<table style="width:100%;">
						 <c:forTokens items="${ability}" delims="," var="name" varStatus="cou">
						 	<c:if test="${cou.count%4 == 1 }"><tr style="height:50px;"></c:if>
						 		<td style="width:25%;">
						 			<div class="onecourse">
										${name}
									</div>
						 		</td>
						 	<c:if test="${cou.count%4 == 0 }"></tr></c:if>
						 	<c:set var = "course_count" value = "${cou.count}" /> 
						</c:forTokens>
						
						<c:if test = "${course_count%4==1}"> 
							 <td style="width:25%;"></td> 
							 <td style="width:25%;"></td>
							 <td style="width:25%;"></td>  
						 	</tr > 
						 </c:if > 
						 <c:if test = "${course_count%4==2}"> 
						 	<td style="width:25%;"></td>
						 	<td style="width:25%;"></td>  
						 	</tr> 
						 </c:if>
						 <c:if test = "${course_count%4==3}"> 
						 	<td style="width:25%;"></td> 
						 	</tr> 
						 </c:if>
					</table>
				</div>
		</div>
		<div class="weui_cell" style="padding: 10px 30px 10px 27px !important;">
			<div class="weui_cell_hd">
				<label class="weui_label">才能描述</label>
			</div>
		</div>
		<div id="middle_4" style="border-top: 1px solid #DCDDDD;">
			<div id="edtt">${abilitydescrib}</div>
		</div>
		<div id="middle_5">
			<div id="middle_5_left">意向报酬&nbsp;:&nbsp;
					<c:if test="${paytype == 1}">有偿</c:if>
					<c:if test="${paytype == 0}">无偿</c:if>
			</div>
			<div id="middle_5_right">参考价&nbsp;:&nbsp;
					<c:if test="${paytype == 1}">${pay}</c:if>
					<c:if test="${paytype == 0}">免费</c:if>
			</div>
		</div>
	</div>
	<div id="bottom">
		<div id="bottom_left">
			<a id="bianji" onclick="eddit()">编辑个人信息</a>
		</div>
		<div id="bottom_right">
			<a id="xiaxian" onclick="offline()">
				<c:if test="${isshow == 0 ||isshow == ''}">上线能手服务</c:if>
				<c:if test="${isshow == 1}">下线能手服务</c:if>
			</a>
		</div>
	</div>
	<div id="daishenhe">
		<img src="${ctx}/static/wxfile/wnx/image/shz.png">
	</div>
	<!--微信提示 -->
	<div class="weui_mask"></div>
	<div class="weui_dialog">
		<div class="weui_dialog_hd"><strong class="weui_dialog_title">审核不通过</strong></div>
		<div class="weui_dialog_bd" id="weui_dialog_bd" style="padding-left: 30px;padding-right: 30px;">${failreason}</div>
		<div class="weui_dialog_ft">
			<a href="javascript:;" class="weui_btn_dialog primary">确定</a>
		</div>
	</div>
	<!--上下线微信提示 -->
	<div class="weui_toast" style="display: none;">
	    <i class="weui_icon_toast"></i>
	    <p class="weui_toast_content">已完成</p>
	</div>
</body>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/wxfile/wnx/js/example.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wnx/js/zepto.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var checkstate = '${checkstate}';
		if(checkstate == 0){
			$("#bottom").hide();
			$("#daishenhe").show();
		}else if(checkstate == 1){
			$("#bottom").show();
			$("#daishenhe").hide();
		}else if(checkstate == 2){
			$("#bottom").hide();
			$("#daishenhe").hide();
			$(".weui_mask").show();
			$(".weui_dialog").show();
		}
		wx.config({
			debug : false,
			appId : '${config.appId}',
			timestamp : '${config.timestamp}',
			nonceStr : '${config.nonceStr}',
			signature : '${config.signature}',
			jsApiList : [ 'onMenuShareTimeline', 'openLocation',
					'onMenuShareAppMessage', 'chooseImage', 'uploadImage' ]
		});
		wx.error(function(res) {
			//alert("加载错误:" + JSON.stringify(res));
		});
		wx.ready(function() {
			wx.onMenuShareTimeline({
				title : '个人信息', // 分享标题
				link : '${baseurl}/wxurl/redirect?url=wxcommunity/myinfo', // 分享链接
				imgUrl : '${baseurl}/static/wxfile/wnx/image/chakanxinxi.png' // 分享图标
			});
			wx.onMenuShareAppMessage({
				title : '个人信息', // 分享标题
				desc : '秀出你的技能', // 分享描述
				link : '${baseurl}/wxurl/redirect?url=wxcommunity/myinfo', // 分享链接
				imgUrl : '${baseurl}/static/wxfile/wnx/image/chakanxinxi.png' // 分享图标
			});
		});
	});
	
	
	$(".weui_dialog_ft").bind("click",function(){
		var openid = '${openid}';
		window.location.href = "${ctx}/wxcommunity/editmyinfo?comid=${comid}";
	});
	
	var openid = '${openid}';
	function eddit(){
		window.location.href = "${ctx}/wxcommunity/editmyinfo?comid=${comid}";	
	}
	
	function offline(){
		shangxiaxian();
	}
	
	function yincang(){
		$(".weui_toast").hide();
	}
	
	//上下线
	function shangxiaxian(){
		$.post("${ctx}/wxcommunity/isshow?openid="+openid,function (data){
						if(data.isshow == 1){
							$(".weui_toast").show();
							$(".weui_toast_content").html("上线成功");
							$("#xiaxian").html("下线能手服务");
							setTimeout("yincang()",2000);
						}else if(data.isshow == 0){
							$(".weui_toast").show();
							$(".weui_toast_content").html("下线成功");
							$("#xiaxian").html("上线能手服务");
							setTimeout("yincang()",2000);
						}
			   });
	}
</script>
</html>