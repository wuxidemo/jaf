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
<meta name="format-detection" content="telephone=no" />
<title>义仓(${commname })</title>
<link rel="stylesheet" href="${ctx}/static/wxfile/yicang/css/ychomepage.css"/>
<link rel="stylesheet" href="${ctx}/static/wxfile/yicang/css/style.css"/>
<link rel="stylesheet" href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
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
	    right: 9px;
	    bottom: 2px;
	    z-index: 999;
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
	<div class="aa" onclick="hid()"></div>
	<div class="kong1"></div>
	<!--<div class="address_list">
		<div class="Head-------"><img src="${ctx}/static/wxfile/wnx/image/ltjt.png">全部社区</div>
		<p id="0" class="head" onclick="hd()">全部社区</p>
	</div>
	<div class="top" onclick="show()">全部社区<img src="${ctx}/static/wxfile/yicang/image/arrowg.png" style="display: none;"></div>-->
	<!--  轮播跟换 -->
	<div class="main_visual" style="background-color: white;width: 100%;">
		<div class="flicking_con"></div>
		<div class="main_image" style="height: 117px;"></div>
	</div>
	<div class="top2">
		<div class="aixin">
			<img alt="" src="${ctx}/static/wxfile/yicang/image/yicangaixin.png">
		</div>
		<div class="ycgs">义仓公示</div>
		<div class="gsxq">
			<div class="button" onclick="gongshixq()">公示详情</div>
		</div>
	</div>
	<div id="liebiao"></div>
	<div style="width: 100%;height: 45px;"></div>
	<div class="list">
			 <div class="ball-beat" id="ddd1" sss="a">
				<div></div>
				<div></div>
				<div></div>
			</div>
	</div>
	<div id="bottom">
		<a id="woyaojuan" onclick="donate()">我要捐献</a>
		<a id="wodejilu" onclick="record()">我的记录</a>
	</div>
	<!--微信提示 -->
	<div class="weui_mask" style="z-index: 30 !important;"></div>
	<div class="weui_dialog" style="z-index: 50 !important;">
		<div class="weui_dialog_hd"><strong class="weui_dialog_title"></strong></div>
		<div class="weui_dialog_bd" id="weui_dialog_bd" style="padding-left: 30px;padding-right: 30px;">姓名不能为空!</div>
		<div class="weui_dialog_ft">
			<a href="javascript:;" class="weui_btn_dialog primary">确定</a>
		</div>
	</div>
</body>
<script src="${ctx}/static/Clamp/clamp.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/yicang/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/yicang/js/jquery.event.drag-1.5.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/yicang/js/jquery.touchSlider.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	showload();
	var obj;
	var objname;
	var cookieCode =getCookie("comID");
	var cookieName = decodeURI(getCookie("comName"));
	var size=20;
	var start=0;
	
	
	
	function hid(){
		$('.aa').css("display","none");   
		$('.address_list').removeClass("rightout").removeClass("rightin").addClass("rightout")
		 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		    $(this).css("transform","translate3d(100%, 0, 0)"); 
		    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
			$(this).css("opacity","0"); 
		    $(this).removeClass("rightout");
		    });
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
			title : '关爱他人,奉献爱心.', // 分享标题
			link : '${baseurl}/wxurl/redirect?url=wxcommunity/donation',// 分享链接
			imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标
		});
		wx.onMenuShareAppMessage({
			title : '关爱他人,奉献爱心.', // 分享标题
			desc : '关爱他人,奉献爱心.', // 分享描述
			link : '${baseurl}/wxurl/redirect?url=wxcommunity/donation',// 分享链接
			imgUrl : '${baseurl}/static/wxfile/yicang/image/share.png' // 分享图标
		});
	});
	
	$(document).ready(function() {
		//$('.Head').html(cookieName+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
		if(cookieCode == "" || cookieName == ""){
			getlist(0);
		}else{
			getlist(cookieCode);
		}
		getlunbotu(cookieCode);
	});
	
	
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
	
	//收起全部
	/* function reduce(i){		 
	 	var paragraph=document.getElementById("0"+i);
		$clamp(paragraph, {clamp: 2, useNativeClamp: false, animate: false,truncationChar:' ',truncationHTML:'...<span class="setcolor" id="'+i+'" style="background-color:#efefef;color:#727171;border-radius:5px;padding-left:5px;padding-right:5px;font-size:14px;float:right;" onclick="add('+i+')">显示全部</span>'});
	} */
	
	
	var timer = "";
	//轮播图初始化
	function initmainimg(){
		var img = new Image(); //创建一个Image对象，实现图片的预下载
		img.src = $($(".main_image ul li img")[0]).attr("src");
		if (img.complete) { // 如果图片已经存在于浏览器缓存，直接调用回调函数
			seth();
		}
		img.onload = function() { //图片下载完毕时异步调用callback函数。
				seth();
		};
		
		var page = getCookie("page");
		setCookie("page","",0);
		$dragBln = false;
		
		$(".main_image").touchSlider({ 
			flexible : false,
			speed : 200, 
			page: page=""?1:page,   
			btn_prev : $("#btn_prev"),
			btn_next : $("#btn_next"),
			paging : $(".flicking_con a"),
			counter : function (e){
				$(".flicking_con a").removeClass("on").eq(e.current-1).addClass("on");
			}
		}); 
		
		$(".main_image").bind("mousedown", function() {
			$dragBln = false;
		});
		
		$(".main_image").bind("dragstart", function() {
			$dragBln = true;
		});
		
		$(".main_image a").click(function(){
			if($dragBln) {
				return false;
			}
		});
		
		
		if(timer == "")
		{
			timer = setInterval(function(){
				
			$("#btn_next").click();
		}, 4000);
		
		}
			
		$(".main_visual").hover(function(){
			clearInterval(timer);
		},function(){
			timer = setInterval(function(){
				$("#btn_next").click();
			},4000);
		});
		
		$(".main_image").bind("touchstart",function(){
			clearInterval(timer);
		}).bind("touchend", function(){
			timer = setInterval(function(){
				$("#btn_next").click();
			}, 4000);
		});
	}
	
	
	
	
	function seth() {
		$(".main_image").css("height", $($(".main_image ul li img")[0]).height());
	}
	
	//毫秒转换为时间
	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		
		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		
		return year+"-"+month+"-"+dd;
	}

	
	//头部点击切换事件
	/*function show(){
		$('.aa').css("display","block");
		$('.address_list').removeClass("rightin").removeClass("rightout").addClass("rightin")
		.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			$(this).css("transform","translate3d(0%, 0, 0)"); 
			$(this).css("-webkit-transform","translate3d(0%, 0, 0)"); 
			$(this).css("opacity","1"); 
		    $(this).removeClass("rightin");
		    });
	}
	$(".Head").click(function() { 
		  $('.aa').css("display","none"); 
		  hd();	
	});
	
	function hd(){
		$('.address_list').removeClass("rightout").removeClass("rightin").addClass("rightout")
		 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		    $(this).css("transform","translate3d(100%, 0, 0)"); 
		    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
			$(this).css("opacity","0"); 
		    $(this).removeClass("rightout");
		    });
	}*/
	
	//获取社区列表接口
	/*function getdata(){
		$.get("${ctx}/wxcommunity/getcommunities",function(data){
			hideload();
			if(data.result=='1'){
				var len = data.data.length;
				for(var i =0;i < len ;i++){
					$(".address_list").append('<p onclick="hd()" class="head" id="'+data.data[i].id+'">'+data.data[i].name+'</p>');
				}
				if(cookieCode == "" || cookieName == ""){
					console.log("cookie is null!");
					getlist(0);
					obj=0;
					objname="";
				}else{
					obj=cookieCode;
					objname=cookieName;
					getlist(obj);
				}
				console.log("cookieCode"+obj);
				$("#"+obj).css("color","#f8ba1e");
				$("#"+obj).css("background-color","#e1e3e1");
				console.log("####:"+$("#"+obj).text());
				$('.top').html($("#"+obj).text()+'<img src="${ctx}/static/wxfile/main1601/image/arrowg.png">');
				
				$(".address_list p").click(function(){
					console.log(this.id);
					$(".address_list p").css("color","#7a7070");
					$(".address_list p").css("background-color","white");
					
					$(this).css("color","#f8ba1e");
					$(this).css("background-color","#e1e3e1");
					$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
					$('.top').html($(this).text()+'<img src="${ctx}/static/wxfile/main1601/image/arrowg.png">');
					start=0;
 					$('#liebiao').empty();
 					$('.nodatadiv').hide();
 					obj=this.id;
					objname=$(this).text();
					setCookie("comID",obj,9999999999);
					setCookie("comName",encodeURI(encodeURI(objname)),9999999999);
					console.log("obj:"+obj);
					console.log("objname"+objname);
					getlist(this.id);
					getlunbotu(this.id);
					$('.aa').css("display","none");  
	                hd();
	                
				});
			}else if(data.result=='0'){
				$("#liebiao").html(
				 '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp">暂无数据</div></div>');
			}
		});
	}*/
	
	
	//根据社区id获取该社区下的轮播图列表接口
	function getlunbotu(comid){
		$.post("${ctx}/wxcommunity/getcarousel",
				{
					"comid" : comid
				},
				function (dd){
					$(".main_visual").empty();
					if(dd.result == '1'){
						var suffix = "?imageView2/2/w/500|imageMogr2/auto-orient";
						if(dd.data.length == 1){
							$(".main_visual").html('<div class="flicking_con">'
														+'<a href="#" class="" style="display:none"></a>'
													+'</div>'
													+'<div class="main_image" style="height: 117px;">'
														+'<img class="" src="'+dd.data[0].picurl+suffix+'" onclick="go('+dd.data[0].id+','+dd.data[0].type+',\''+dd.data[0].url+'\')">'
													+'</div>'
							);
							
						}else{
							var flicking = $('<div class="flicking_con"></div>');
							var mainimg = $('<div class="main_image" style="height: 117px;"></div>');
							var ulcontent = $('<ul></ul>');
							for(var i = 0;i < dd.data.length;i++){
								flicking.append('<a href="#" class=""></a>');
								ulcontent.append('<li><img class="" src="'+dd.data[i].picurl+suffix+'" onclick="go('+dd.data[i].id+','+dd.data[i].type+',\''+dd.data[i].url+'\','+(i+1)+')"></li>');
							}
							
							mainimg.html(ulcontent);
							mainimg.append('<a href="javascript:;" id="btn_prev"></a> <a href="javascript:;" id="btn_next"></a>');
							$(".main_visual").append(flicking);
							$(".main_visual").append(mainimg);
						}
					}else if(dd.result == '0'){ 
					}
					initmainimg();
				});
	}
	
	
	
	//首页获取捐赠记录列表接口
	var jx = new Array();
	function getlist(comid){
		$.post("${ctx}/wxcommunity/gethomerecords",
			{
				"comid" : comid
			},
			function (d){
				hideload();
				if(d.result == '1'){
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
						}else if(d.data[i][0] == "2"){
							$("#liebiao").append('<div class="topkong"></div>'
														+'<div class="rowdiv">'
															+'<div class="left">'
																+'<div class="inerLt1"></div>'
															+'</div>'
															+'<div class="card_middle">'
																+'<div class="right">'+"赠予"+d.data[i][1]+'</div>'
																+list
																+ xianshianniu
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
						/*var paragraph=document.getElementById("0"+i);
				    	$clamp(paragraph, {clamp: 2, useNativeClamp: false, animate: false,truncationChar:' ',truncationHTML:'...<span class="setcolor" id="'+i+'" style="background-color:#efefef;color:#727171;border-radius:5px;padding-left:5px;padding-right:5px;font-size:14px;float:right;" onclick="add('+i+')">显示全部</span>'});*/
					}
				}else if(d.result == '0'){
					$("#liebiao").html(
					 '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp">暂无数据</div></div>');
				}
		});
	}
	
	$('.kong1').click(function(){
		$('.address_list').hide();
		$(".aa").css("display", "none");
		$('.kong1').hide();
		$('body').css("position","");
	});
	
	
	
	$(".weui_dialog_ft").bind("click",function(){
		$(".weui_mask").hide();
		$(".weui_dialog").hide();
	});
	
	//公示详情点击事件
	function gongshixq(){
		var cookieCode =getCookie("comID");
		if(cookieCode == "" || cookieCode == "0"){
			$(".weui_mask").show();
			$(".weui_dialog").show();
			document.getElementById("weui_dialog_bd").innerHTML = "您还没有选择社区!";
		}else{ 
			window.location.href  = "${ctx}/wxcommunity/detailrecords?comid="+cookieCode;
		}
	}
	
	function showload() {
		$("#ddd1")
		.css("display","block");
	}
	
	function hideload() {
		$("#ddd1").css("display","none");
	}
	
	//我要捐献
	function donate(){
		var cookieCode =getCookie("comID");
		if(cookieCode == "" || cookieCode == "0"){
			$(".weui_mask").show();
			$(".weui_dialog").show();
			document.getElementById("weui_dialog_bd").innerHTML = "您还没有选择社区!";
		}else{
			window.location.href = "${ctx}/wxcommunity/corporatedonation?comid="+cookieCode;
		}
	}
	
	//我的记录
	function record(){
		window.location.href = "${ctx}/wxcommunity/myrecords?comid=${comid}";
	}
	
	
	
	//获取cookie的值
	function getCookie(name) {
		var cookieArray = document.cookie.split("; "); //得到分割的cookie名值对    
		var cookie = new Object();
		for (var i = 0; i < cookieArray.length; i++) {
			var arr = cookieArray[i].split("="); //将名和值分开    
			if (arr[0] == name)
				return unescape(arr[1]); //如果是指定的cookie，则返回它的值    
		}
		return "";
	}
	//设置cookie方法
	function setCookie(key, val, time) {
		var date = new Date();
		var expiresDays = time;
		date.setTime(date.getTime() + expiresDays );
		document.cookie = key + "=" + val + ";expires=" + date.toGMTString()+";path=/";
	}
	
	function go(id, type ,url,count)
	{
		setCookie("page",count,999999);
		if(type==2)
			{
			window.location.href=url;
			}
		else
			{
			window.open("${ctx}/wxcommunity/advertdetail?id="+id);
			}
	}
</script>
</html>