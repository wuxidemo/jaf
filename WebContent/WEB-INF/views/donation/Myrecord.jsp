<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta name="format-detection" content="telephone=no" />
<title>我的记录</title>
<link type="text/css" href="${ctx}/static/wxfile/yicang/css/Myrecord.css" rel="stylesheet" />
<style type="text/css">
	.inerLt{
		width: 21px;
		padding-bottom: 21px;
		height: 0;	
		margin-left: auto;
		margin-right: auto;
		background: url("${ctx}/static/wxfile/yicang/image/juan.png") no-repeat;
		background-size: cover;
		background-position: 50%;
	}
	.inerLt1{
		width: 21px;
		padding-bottom: 21px;
		height: 0;
		margin-left: auto;
		margin-right: auto;
		background: url("${ctx}/static/wxfile/yicang/image/zeng.png") no-repeat;
		background-size: cover;
		background-position: 50%;
	}
	div.flicking_con {
	    position: absolute;
	    bottom: 10px;
	    z-index: 9;
	    width: 100%;
	    height: 21px;
	    text-align: center;
	}
	div.flicking_con a {
    	display: inline-block;
    	width: 21px;
    	height: 21px;
    	margin: 0;
    	padding: 0;
    	background: url('${ctx}/static/wxfile/main1601/image/lbdqie4_05.png') center no-repeat;
    	text-indent: -1000px;
	}
	div.flicking_con a.on {
	    background-position: 0 -21px;
	    background: url('${ctx}/static/wxfile/main1601/image/lbdqie4_03.png') center no-repeat;
	}
	.main_image li img {
    	position: absolute;
    	display: block;
    	width: 100%;
	}
	.youtu div{
		width: 60px;	
	    padding-bottom: 60px;
	    height: 0;
	    margin-left: auto;
	    margin-right: auto;
	}
</style>
</head>
<body>
    <div class="head">
		<div class="tabdiv tabact now">捐献记录</div>
		<div class="tabdiv history">赠予记录</div>
	</div>
	<div class="clear"></div>
	<div id="liebiao">	
<!-- 	   <div class="Iner"> -->
<!-- 			<div class="Inertop"> -->
<%-- 			    <div class="InertopLt"><img src="${ctx}/static/wxfile/yicang/image/juan.png"/></div> --%>
<!-- 			    <div class="InertopRt">王富帅捐赠320元，花生油X1，棉被x2,大米X2.</div> -->
<!-- 			</div> -->
<!-- 			<div class="Inerbotm"> -->
<!-- 			    <div class="Inerbotm1">捐献时间：2016-12-3</div> -->
<!-- 			</div> -->
<!-- 	   </div> -->
       
        <div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>	
    </div>
    <div id="jzgd" onclick="getmore()">点击加载更多</div>
	<div class="ywgd">已无更多</div>
	 <div class="moreloading" id="ddd2" sss="a">
		<div></div>
		<div></div>
		<div></div>
	</div>
</body>
<script src="${ctx}/static/Clamp/clamp.js"></script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
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
		title : '我的记录', // 分享标题
		link : '${baseurl}/wxurl/redirect?url=wxcommunity/myrecords?comid=${comid}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标

	});

	wx.onMenuShareAppMessage({
		title : '我的记录', // 分享标题
		desc : '查看我的捐献记录和赠予记录', // 分享描述
		link : '${baseurl}/wxurl/redirect?url=wxcommunity/myrecords?comid=${comid}', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标
	});
});


$(document).ready(function(){
	getnow();
});
$(".now").bind("click", function() {
		if (!$(this).hasClass("tabact")) {
			$(this).addClass("tabact");
			$(".history").removeClass("tabact");
			$(".ywgd").hide();
		}
	start=0;
	isall=0;
	iscol=0;
	j=0;
	$("#liebiao").empty();
	getnow();
});
$(".history").bind("click", function() {
		if (!$(this).hasClass("tabact")) {
			$(this).addClass("tabact");
			$(".now").removeClass("tabact");
			$(".ywgd").hide();
		}
	start=0;
	isall=0;
	j=0;
	$("#liebiao").empty();
	gethistory();
});
function getmore() {
	if (isall == 0) {
		showmoreload();
		if(iscol==0){
			getnow();
		}else{
		    gethistory();
		}
		
	}
}

//点击显示更多，收起全部
function add(i){
		var showtext = $("#label"+i).text();
  	   if(showtext == '显示全部') {
  		  $("#label"+i).text('收起全部');
  	   }else{
  		  $("#label"+i).text('显示全部');
  	   }
 	     $("[id^='"+i+"%%']").each(function(){
 	    	 var thisid = $(this).attr('id');
 	    	   var valuej = thisid.substring(thisid.lastIndexOf("%")+1);
 	    	   if(valuej >= 2) {
 	    		  if($(this).css("display") == 'none') {
 	    			  $("#card2_left"+i).css("white-space","normal");
 	    			  $("#card2_left"+i).css("text-overflow","clip");
 	    			  $("#right"+i).css("white-space","normal");
 	    			  $("#right"+i).css("text-overflow","clip");
 	    			  $(this).show();
 	    		  }else{
 	    			  $("#card2_left"+i).css("white-space","nowrap");
	    			  $("#card2_left"+i).css("text-overflow","ellipsis");
	    			  $("#right"+i).css("white-space","nowrap");
	    			  $("#right"+i).css("text-overflow","ellipsis"); 
 	    		      $(this).hide(); 
 	    		  }
 	    	   }
 	       });
 			 			
	}

var start = 0;
var size = 10;
var isall = 0;
var iscol=0;
var jx = new Array();
var j=0;
function getnow(){
	$.post("${ctx}/wxcommunity/idonate",{'start' : start,'size' : size},function(d) {
		hideload();
		hidemoreload();
		if (d.result == '1') {
		if(d.data.length==0){
			  if (start==0){
 		           $("#liebiao").html(
 		        		'<div class="nodatadiv"><div>哎呀，还没捐献过</div><div class="loadp p2size" onclick="">赶紧去捐献</div></div>'   
 		           )
 		           $("#jzgd").hide();
 		          isall = 1;
			  }else{
				//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
			  }
			  return;
			}else{
				if(d.data.length<size){
					//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
				}
				else{
					
				}
			}	
		var length = d.data.length;
		for(var i = 0;i<length;i++){
			var imgurl;
			if(d.data[i][10] == null || d.data[i][10] == '') {
				imgurl = 'http://lyfts2-10017813.image.myqcloud.com/636bd7e1-6ebf-4c60-b116-2ec7ef1eeb32';
			}else{
				imgurl = d.data[i][10]+"?imageView2/2/w/300|imageMogr2/auto-orient";
			}
			var sj = formattime(d.data[i][4]);
			
			var items = d.data[i][11];//捐赠的物品列表
			var list = '';
			var xianshianniu = '';
			if(items.length > 0) {
				for(var j=0;j < items.length;j++){
					var arr = items[j].split('##');
					if(arr[1] == "0"){
						if(j >= 2) {
							list += '<div class="right2" id="'+i+'%%'+j+'" style="display:none;"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div></div>';
						}else{
							list += '<div class="right2"  id="'+i+'%%'+j+'"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div></div>';
						}
					}else{
						if(j >= 2) {
							list += '<div class="right2" id="'+i+'%%'+j+'" style="display:none;"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div><div class="card2_right">'+arr[1]+'件</div></div>';
						}else{
							list += '<div class="right2" id="'+i+'%%'+j+'"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div><div class="card2_right">'+arr[1]+'件</div></div>';
						}
						
					}
				}
			}
			
			if(items.length > 2){
				xianshianniu = '<div style="width:100%;overflow: hidden;"><div class="shijian_right" id="label'+i+'" onclick="add('+i+')">显示全部</div></div>';
			}
			
			if(d.data[i][0] == "1"){ 
				var gerenmoney = '';//个人捐赠的金钱
				var qiyemoney = '';//企业捐赠的金钱
				if(d.data[i][2] == "1") {
					gerenmoney = '<div class="right22" id="012"><div class="card3_left">善款</div><div class="card3_right">'+d.data[i][9]/100+'&nbsp;元</div></div>';
				}else if(d.data[i][2] == "2"){
					
				}else if(d.data[i][2] == "3" && d.data[i][7] =="1") {
					qiyemoney = '<div class="right22" id="012"><div class="card3_left">善款</div><div class="card3_right">'+d.data[i][5]/100+'&nbsp;元</div></div>';
				}else if(d.data[i][2] == "3" && d.data[i][7] =="2") {
					
				}
				$("#liebiao").append('<div class="topkong"></div>'
												+'<div class="rowdiv">'
												+'<div class="left">'
													+'<div class="inerLt"></div>'
												+'</div>'
												+'<div class="card_middle">'
													+'<div class="right" id="right'+i+'">'
														+(d.data[i][2] < 3  ? d.data[i][1] : d.data[i][6])
													+'</div>'
													+(d.data[i][2] == "1" ? gerenmoney : (d.data[i][2] == "3" && d.data[i][7] =="1" ? qiyemoney : ''))
													+list
													+ xianshianniu
													+'<div class="right3">'
														+'<div class="zengyushijian">'+"捐献时间&nbsp;:&nbsp;"+sj+'</div>'
													+'</div>'
												+'</div>'
												+'<div class="card_right">'
													+'<div class="youtu">'
														+'<div style="background: url(\''+imgurl+'\') no-repeat; background-size: cover;  background-position: 50%;"></div>'
													+'</div>'
												+'</div>'
											+'</div>'
										+'<div class="topkong11"></div>'
			);
			}
		}		
		start += size;
	}else{
			if (start == 0) {
				$("#liebiao")
						.html(
								'<div class="nodatadiv"><div>哎呀，还没捐献过</div><div class="loadp p2size" onclick="shouye()">赶紧去捐献</div></div>')
				$("#jzgd").hide();
				$(".ywgd").hide();
				isall = 1;
			} else {
				$("#jzgd").hide();
				$(".ywgd").css("display", "block");
				isall = 1;
			}
	                 }
		
	})
	
}

function shouye(){
	window.open("${ctx}/wxcommunity/donation?comid=${comid}");
}
function gethistory(){
	iscol=1;
	$.post("${ctx}/wxcommunity/donatetome",{'start' : start,'size' : size},function(d) {
		hideload();
		hidemoreload();
		if (d.result == '1') {
		if(d.data.length==0){
			  if (start==0){
 		           $("#liebiao").html(
 		        		'<div class="nodatadiv"><div>您还没有接受过赠予</div></div>'   
 		           )
 		           $("#jzgd").hide();
 		          isall = 1;
			  }else{
				//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
			  }
			  return;
			}else{
				if(d.data.length<size){
					//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
				}
				else{
					
				}
			}	
		
		var length = d.data.length;
		for(var i = 0;i<length;i++){
			var imgurl;
			if(d.data[i][10] == null || d.data[i][10] == '') {
				imgurl = 'http://lyfts2-10017813.image.myqcloud.com/636bd7e1-6ebf-4c60-b116-2ec7ef1eeb32';
			}else{
				imgurl = d.data[i][10]+"?imageView2/2/w/300|imageMogr2/auto-orient";
			}
			var sj = formattime(d.data[i][4]);
			
			var items = d.data[i][11];//捐赠的物品列表
			var list = '';
			var xianshianniu = '';
			if(items.length > 0) {
				for(var j=0;j < items.length;j++){
					var arr = items[j].split('##');
					if(arr[1] == "0"){
						if(j >= 2) {
							list += '<div class="right2" id="'+i+'%%'+j+'" style="display:none;"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div></div>';
						}else{
							list += '<div class="right2"  id="'+i+'%%'+j+'"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div></div>';
						}
					}else{
						if(j >= 2) {
							list += '<div class="right2" id="'+i+'%%'+j+'" style="display:none;"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div><div class="card2_right">'+arr[1]+'件</div></div>';
						}else{
							list += '<div class="right2" id="'+i+'%%'+j+'"><div class="card2_left" id="card2_left'+i+'">'+arr[0]+'</div><div class="card2_right">'+arr[1]+'件</div></div>';
						}
						
					}
				}
			}
			
			if(items.length > 2){
				xianshianniu = '<div style="width:100%;overflow: hidden;"><div class="shijian_right" id="label'+i+'" onclick="add('+i+')">显示全部</div></div>';
			}
			
			if(d.data[i][0] == "2"){ 
				var gerenmoney = '';//个人捐赠的金钱
				var qiyemoney = '';//企业捐赠的金钱
				if(d.data[i][2] == "1") {
					gerenmoney = '<div class="right22" id="012"><div class="card3_left">善款</div><div class="card3_right">'+d.data[i][9]/100+'&nbsp;元</div></div>';
				}else if(d.data[i][2] == "2"){
					
				}else if(d.data[i][2] == "3" && d.data[i][7] =="1") {
					qiyemoney = '<div class="right22" id="012"><div class="card3_left">善款</div><div class="card3_right">'+d.data[i][5]/100+'&nbsp;元</div></div>';
				}else if(d.data[i][2] == "3" && d.data[i][7] =="2") {
					
				}
				$("#liebiao").append('<div class="topkong"></div>'
												+'<div class="rowdiv">'
												+'<div class="left">'
													+'<div class="inerLt1"></div>'
												+'</div>'
												+'<div class="card_middle">'
													+'<div class="right">'+"赠予"+d.data[i][1]+'</div>'
													+list
													+xianshianniu
													+'<div class="right3">'
														+'<div class="zengyushijian">'+"赠予时间&nbsp;:&nbsp;"+sj+'</div>'
													+'</div>'
												+'</div>'
												+'<div class="card_right">'
													+'<div class="youtu">'
														+'<div style="background: url(\''+imgurl+'\') no-repeat; background-size: cover;  background-position: 50%;"></div>'
													+'</div>'
												+'</div>'
											+'</div>'
										+'<div class="topkong11"></div>'
			);
			}
		}		
		start += size;
	}else if (d.result == '0') {
			if (start == 0) {
				$("#liebiao")
						.html(
								'<div class="nodatadiv">	<div>您还没有接受过赠予</div></div>')
				$("#jzgd").hide();
				$(".ywgd").hide();
				isall = 1;
			} else {
				$("#jzgd").hide();
				$(".ywgd").css("display", "block");
				isall = 1;
			}
	                 }
		
	})
}
function formattime(timestr) {
	var date = new Date(timestr);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var dd = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();
	
	if(month < 10) {
		month = "0"+month;
	}
	if(dd < 10) {
		dd = "0" + dd;
	}
		if(hour < 10) {
			hour = "0" + hour;
		}
		if(minute < 10) {
			minute = "0" + minute;
		}
		if(second < 10) {
			second = "0" + second;
		} 
	
	return year+"-"+month+"-"+dd;
}
//黄色点点加载更多
function showload() {
	$("#ddd1").css("display", "block");
}

function hideload() {
	$("#ddd1").css("display", "none");
}

function showmoreload() {
	$("#ddd2").css("display", "block");
	$("#jzgd").css("display", "none");
}
function hidemoreload() {
	$("#ddd2").css("display", "none");
	$("#jzgd").css("display", "block");
}
</script>
</html>