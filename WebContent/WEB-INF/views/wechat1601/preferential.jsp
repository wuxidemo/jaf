<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<title>优惠</title>
<style type="text/css">
body {
	margin: 0;
	font-family: Microsoft YaHei;
/* 	background-color: #e1e3e1; */
	padding-bottom: 51px;
}

.aa {
	width: 100%;
    position: fixed;
    left: 0;
    right: 0;
    top: 268px;
    bottom: 0px;
    background-color: #333;
    opacity: 0.6;
    z-index: 100;
    display: none;
}

.head{
	width: 100%;
}
.head img{
	width:100%;
}
.menu{
overflow:hidden;
	width:100%;
	height: 35px;
}
.menu div{
	color:#7a7070;
	width:49.6%;
	height:35px;
	line-height:35px;
	float:left;
	text-align: center;
	background-color: white;
}
.menu>:nth-child(1){
	margin-right: 0.8%;
}
.city,.sort{
	height: 35px;
	overflow: hidden;
	text-align: center;
}
.city img,.sort img{
	width: 17px;
}
.menu div span{
	pointer-events:none;
}
.menups{
	color: #f8ba1e;
}

.list1 {
	position:absolute;
	overflow:auto;
	float:left;
	width: 100%;
	height:150px;
	color:#7a7070;
	background-color: white;
	text-align: center;
	z-index: 999;
	display: none;
}

.list1 p {
	margin-top: 0;
	margin-bottom:0;
    line-height: 35px;
}

.list2 {
	position:absolute;
	float:left;
	width: 100%;
	color:#7a7070;
	background-color: white;
	text-align: center;
	z-index: 999;
	display: none;
}

.list2 p {
	margin-top: 0;
	margin-bottom:0;
    line-height: 35px;
}
.quanlist{
	
}
.unittop{
	width: 100%;
	height: 5px;
	background-color: #e1e3e1;
}
.unit{
	width:100%;
	height: 90px;
	overflow:hidden;
	background-color: #f8ba1e;
	
}
.u_img{
    width: 30%;
    min-width: 60px;
    text-align: center;
    clear: both;
    float: left;
    overflow: hidden;
    margin-top: 15px;
	
}
.u_img img{
	width: 60px;    
    height: 60px;
    border-radius: 50px;
}
.u_p{
	float: left;
	margin-top:20px;
}
.u_p>:nth-child(1){
margin-top: 0;
margin-bottom:6px;
font-size: 15px;
}
.u_p>:nth-child(2){
font-size: 20px;
color: white;
}
.kong{
	width: 100%;
	height: 100%;
	background-color: #e1e3e1;
	position: absolute;
  	opacity:0;
 	z-index: 3; 
 	display: none;
}
/***分页***/
#ddd1{text-align: center;width:100%;height:30px;background-color:white;margin-top: 42px;display: none;}

#ddd2{text-align: center;width:100%;height:30px;background-color:white;margin-top: 15px;display: none;}
	.ball-beat div{ 		
		background-color: #f8ba1e;
		width: 15px;
  		height: 15px;
	  	border-radius: 100%;
 	  	margin: 2px; 
	  	-webkit-animation-fill-mode: both;
	  	animation-fill-mode: both;
	  	display: inline-block;
	  	-webkit-animation: ball-beat 0.7s 0s infinite linear;
	 	animation: ball-beat 0.7s 0s infinite linear
	 }
	 
	 .moreloading div {
	 	background-color: #f8ba1e;
		width: 15px;
  		height: 15px;
	  	border-radius: 100%;
 	  	margin: 2px; 
	  	-webkit-animation-fill-mode: both;
	  	animation-fill-mode: both;
	  	display: inline-block;
	  	-webkit-animation: ball-beat 0.7s 0s infinite linear;
	 	animation: ball-beat 0.7s 0s infinite linear
	 }
  
	  @-webkit-keyframes ball-beat {
	  50% {
	    opacity: 0.2;
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75); }

      100% {
      opacity: 1;
      -webkit-transform: scale(1);
            transform: scale(1); } }
            
      @-webkit-keyframes moreloading {
	  50% {
	    opacity: 0.2;
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75); }

      100% {
      opacity: 1;
      -webkit-transform: scale(1);
            transform: scale(1); } }

  @keyframes ball-beat {
  50% {
    opacity: 0.2;
    -webkit-transform: scale(0.75);
            transform: scale(0.75); }

  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }
            
  @keyframes moreloading {
  50% {
    opacity: 0.2;
    -webkit-transform: scale(0.75);
            transform: scale(0.75); }

  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }
			
  .ball-beat > div:nth-child(2n-1) {
	  -webkit-animation-delay: 0.35s !important;
	  animation-delay: 0.35s !important; 
}
  .moreloading > div:nth-child(2n-1) {
	  -webkit-animation-delay: 0.35s !important;
	  animation-delay: 0.35s !important; 
}

.loadp {
	width: 100%;
	text-align: center;
}
.p2size {
	font-size: 18px;
	margin-top: -25px;
}
.moreloading {
	margin-bottom: 10px;
	margin-top: 10px;
	width: 100%;
	text-align: center;
	display: none;
}

#jzgd {
	height: 35px;
	width: 100%;
	background-color: white;
	text-align: center;
	color: #eb621d;
	line-height: 35px;
	display: none;
	font-size: 15px;
}
.ywgd{
	display: none;
	height: 35px;
	width: 100%;
	background-color:#efefed;
	text-align: center;
	color: #eb621d;
	line-height: 35px;
	display: none;
	font-size: 15px;
/* 	margin-top:10px; */
}
.nodatadiv {
	margin: auto;
	width: 120px;
	height: 100px;
	margin-top: 58px;
}
.nodatadiv img {
	width: 120px;
}

/****/
</style>
</head>
<body>
<div class="aa"></div>
<div class="kong"></div>
<!-- <div class="head"> -->
<%-- 		<c:if test="${ad!=null}"> --%>
<%-- 			<img src="${ctx}/${ad.img}"> --%>
<%-- 		</c:if> --%>
<%-- 		<c:if test="${ad==null}"> --%>
<%-- 			<img src="${ctx}/static/wxfile/main1601/image/yhad.png"> --%>
<%-- 		</c:if> --%>
<!-- 	</div> -->

<div class="head"><img src="${ctx}/static/wxfile/main1601/image/yhad.png"></div>
	<div style="background-color: #e1e3e1">
		<div class="menu">
			<div class="city">
				全城 <img src="${ctx}/static/wxfile/main1601/image/arrowg.png">
			</div>
			<div class="sort">
				折扣最大 <img src="${ctx}/static/wxfile/main1601/image/arrowg.png">
			</div>
		</div> 
	</div>
	
	<div class="list1">
		<p id="0">全城</p>
	</div>
	<div class="list2">
		<p id="1">领用最多</p>
		<p id="2">折扣最大</p>
		<p id="3">最新上架</p>
	</div>
	<div class="unittop"></div>	
	<div class="quanlist">
	 <div class="ball-beat" id="ddd1" sss="a">
				<div></div>
				<div></div>
				<div></div>
			</div>
<!-- 		<div class="unit"> -->
<!-- 			<div class="u_img"> -->
<%-- 				<img src="${ctx}/static/wxfile/main1601/image/byh.jpg"> --%>
<!-- 			</div> -->
<!-- 			<div class="u_p"> -->
<!-- 				<div>波尔曼时尚酒店</div> -->
<!-- 				<div>9折优惠券</div> -->
<!-- 			</div> -->			
<!-- 		</div> -->
<!-- <div class="unittop"></div> -->
</div>

<div class="moreloading" id="ddd2" sss="a">
				<div></div>
				<div></div>
				<div></div>
			</div>
	<div id="jzgd" onclick="getmore()">点击加载更多</div>
    <div class="ywgd">已无更多</div>
    
<%@ include file="foot.jsp"%>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	showload();
	
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		//alert("本活动仅支持微信");
	} else if (wechatInfo[1] < "6.0") {
		alert("本活动仅支持微信6.0以上版本");
	}
	
	wx.config({
		debug : false,
		appId : '${appId}', // 必填，公众号的唯一标识
		timestamp : '${timestamp}', // 必填，生成签名的时间戳
		nonceStr : '${nonceStr}', // 必填，生成签名的随机串
		signature : '${signature}',// 必填，签名，见附录1
		jsApiList : [ 'addCard' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	
	wx.ready(function() {
		hideload();
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	
	var readyFunc = function onBridgeReady() {
	
	}
	
	function showcard(id, k) {
		wx.addCard({
			cardList : [ {
				cardId : id,
				cardExt : lists[k]
			} ], // 需要添加的卡券列表
			success : function(res) {
				var cardList = res.cardList; // 添加的卡券列表信息
			}
		});
	}
	
/*****************以上的js是易刚所加************************/


	$(document).ready(function() {
		getdata();
		
	});
	//分页
	start = 0;
	size = 10;
	isall = 0;
	var obj;//选中的商圈
	var type=2;//排序类型
	function getmore() {
		if (isall == 0) {
			showmoreload();
			console.log("getmore start:"+start)
			getsort(obj,type);
		}
	}
	
	function getdata(){
		$.get('${ctx}/wxpage/getbusinessgroup',function(d){
		if(d.result=='1'){
			var len=d.data.length;
			for(var i=0;i<len;i++){
				$(".list1").append('<p id="'+d.data[i].id+'">'+d.data[i].name+'</p>');				
			}
	
			$("#0").css("color","#f8ba1e");
			$("#0").css("background-color","#e1e3e1");
			$(".list2 p:nth-child(2)").css("color","#f8ba1e");
			$(".list2 p:nth-child(2)").css("background-color","#e1e3e1");
			//getlist(0);
			obj=0;
			console.log("init:"+obj+type);
			getsort(obj,type);
			
			$(".list1 p").click(function(){
				console.log(this.id);
				$(".list1 p").css("color","#7a7070");
				$(".list1 p").css("background-color","white");					
				$(this).css("color","#f8ba1e");
				$(this).css("background-color","#e1e3e1");				
				start=0;
				isall=0;
				$('.quanlist').empty();
				$('.ywgd').hide();
				
				obj=this.id;
				$('.city').html($(this).text()+"<img src='${ctx}/static/wxfile/main1601/image/arrowy.png'>");
				console.log("obj:"+obj);
				//getlist(this.id);	
				getsort(obj,type);
				setTimeout(function(){
					$('.list1').hide();
					$('.kong').hide();
					$('body').css("position","");
					$(".aa").css("display", "none");
					},200);
			});			
		}
		else if(d.result=='0'){
			$('.list1').html('<p>暂无数据</p>');
		}
	});	
		
	}
	var lists=[];
	function getsort(sqid,type){
		$.post('${ctx}/wxpage/getcardbyoption',{"start":start,"size":size,"id":sqid,"type":type},function(data){
			console.log("sqid:"+sqid+" start:"+start);
				hideload();
				hidemoreload();
			if(data.result=="1"){
				var length=data.data.length;
				console.log("quan length:"+length);
				if (length == 0) {
	                   if (start == 0) {
	                    // 第一次无数据   展示暂无数据提示
	                     $(".quanlist").html(
	                    '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png">'
	                    +'<div class="loadp p2size">暂无数据</div></div>')
                          $("#jzgd").hide();
	                      isall = 1;
	                             } else {
		                        //展示 已无更多数据
                                $("#jzgd").hide();
                                $(".ywgd").show();											
		                        isall = 1;
	                          }
	                          return;

 	    		} else {
	                   if (length < size) {
		               //展示 已无更多数据
	                   $("#jzgd").hide();			               
                       $(".ywgd").show();
		               isall = 1;
	                            } else {
		                         //点击加载更多								
	                               }
                   }
				for(var k=0;k<length;k++){
					lists[k]=data.data[k][5];
					console.log(data.data[k][4]);
					if(data.data[k][2] != null){
						if(data.data[k][2].indexOf("http://") < 0){
							data.data[k][2] = '${ctx}/' + data.data[k][2];	
						}
					}
					
					$('.quanlist').append('<div class="unit" onclick="showcard(\''
							+data.data[k][4]+'\','+k
							+')"><div class="u_img"><img src="'
							+data.data[k][2]
							+'"></div><div class="u_p"><div>'
							+data.data[k][1]
							+'</div><div>'
							+data.data[k][3]
							+'</div></div></div><div class="unittop"></div>');
				}
				start +=size;
			}else if(data.result=="0"){
				if(start==0){
				$(".quanlist").html(
	                     '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png">'
	                     +'<div class="loadp p2size">暂无数据</div></div>')
	                       $("#jzgd").hide();
	 					  $(".ywgd").hide();
	                       isall = 1;					
	 					console.log("商圈"+sqid+"暂无数据");
				}
				else
					{
					 $("#jzgd").hide();			               
                     $(".ywgd").show();
		               isall = 1;
					}
			}
		});
	}
	
	$(".list2 p").click(function(){
		$(".list2 p").css("color","#7a7070");
		$(".list2 p").css("background-color","white");
		$('.quanlist').empty();
		$('.ywgd').hide();
		
		isall=0;
		start=0;
		type=this.id;
		getsort(obj,type);
		$(this).css("color","#f8ba1e");
		$(this).css("background-color","#e1e3e1");
		console.log("type:"+type)
		$('.sort').html($(this).text()+"<img src='${ctx}/static/wxfile/main1601/image/arrowy.png'>");
		setTimeout(function(){
			$('.list2').hide();
			$('.kong').hide();
			$(".aa").css("display", "none");
			$('body').css("position","");
			},500);
	});
	
	$(".city").click(function() {
		$(".list2").hide();
		$(".sort").css("color","#7a7070");
		$(".sort img").attr("src","${ctx}/static/wxfile/main1601/image/arrowg.png");
		$(this).css("color","#f8ba1e");
		$(this).children("img").attr("src","${ctx}/static/wxfile/main1601/image/arrowy.png");
		$('.kong').show();
		$(".list1").show();
		$(".aa").css("display", "block");
		$('body').css("position","fixed");
		$('body').css("width","100%");		
	});
	$(".sort").click(function() {		
		$(".list1").hide();
		$(".city").css("color","#7a7070");
		$(".city img").attr("src","${ctx}/static/wxfile/main1601/image/arrowg.png");
		$(this).css("color","#f8ba1e");
		$(this).children("img").attr("src","${ctx}/static/wxfile/main1601/image/arrowy.png");
		$('.kong').show();
		$(".list2").show();
		$(".aa").css("display", "block");
		$('body').css("position","fixed");
		$('body').css("width","100%");	
	});
	
	$('.kong').click(function(){
		$('.list1').hide();
		$('.list2').hide();
		$('.kong').hide();
		$(".aa").css("display", "none");
		$('body').css("position","");
	});
	$('.aa').click(function(){
		$('.list1').hide();
		$('.list2').hide();
		$('.kong').hide();
		$(".aa").css("display", "none");
		$('body').css("position","");
	})
	/* function showcard(id)
	{
		window.open("/nsh/wxpage/merdetail?id="+id+"&token=token");
	}  */
	
	function showload() {
		$("#ddd1").css("display","block");
	}
	
	function hideload() {
		$("#ddd1").css("display","none");
	}
	
	function showmoreload()
	{
		$("#ddd2").css("display","block");
		$("#jzgd").css("display","none");
	}
	function hidemoreload()
	{
		$("#ddd2").css("display","none");
		$("#jzgd").css("display","block");
	}
	
</script>
</html>