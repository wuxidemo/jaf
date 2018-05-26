<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
	<title>社区</title>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/yicang/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/main1601/js/jquery.event.drag-1.5.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/main1601/js/jquery.touchSlider.js"></script>
<link type="text/css" href="${ctx}/static/wxfile/main1601/css/style.css" rel="stylesheet" />
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style type="text/css">
body {
	margin: 0;
	font-family: Microsoft YaHei;
	font-size: 14px;
	padding-bottom: 51px;
	color: #7a7070;
}

.aa {
    width: 100%;
	height: 100%;
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background-color: #333;
	opacity: 0.2;
	z-index: 3;
	display: none;
}

.top {
	width: 100%;
    height: 35px;
    overflow: hidden;
    line-height: 35px;
    text-align: center;
    color: #373737;
    position: relative;
    background-color: #FBBD0C;
}

.top img {
	width: 16px;
    position: absolute;
    top: 50%;
    margin-top: -6px;
}

.main_image li {
	float: left;
	width: 100%;
	position: absolute;
}

.main_image li img {
	position: absolute;
	display: block;
	width: 100%;
}

div.flicking_con {
	position: absolute;
    right: 9px;
    bottom: 2px;
    z-index: 98;
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

.divimg img {
	width: 100%;
}

.tip {
	height: 12px;
    background-color: #eeeff0;
    width: 100%;
}

#youh,#qiangg{
	width: 100%;
    overflow: hidden;
    margin: auto;
    border-bottom: 1px solid #d2d2d2;
}

.youhui{
	width: 10%;
    overflow: hidden;
    float: left;
    margin-top: 8px;
    text-align: center;
}
.qianggou{
	width: 10%;
    overflow: hidden;
    float: left;
    margin-top: 8px;
    text-align: center;
}

.youhui img{
	width: 20px;
    height: 21px;
}
.qianggou img{
	width: 20px;
    height: 22px;
}
.youhuihuodong,.qianggouhuodong{
	width: 80%;
    overflow: hidden;
    float: left;
    line-height: 39px;
    font-size: 18px;
    color: #373737;
    word-break: keep-all;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.middle{
	margin-bottom: 10px;
    display: -moz-box;
    display: -webkit-box;
    display: box;
    padding: 0 8px;
    margin-top: 10px;
}
.tupianzuo{
	text-align: center;
    border-right: 1px solid #d2d2d2;
    -moz-box-flex: 1;
    -webkit-box-flex: 1;
    box-flex: 1;
    padding-right: 2px;
}
.tupianzhong{
	text-align: center;
    border-right: 1px solid #d2d2d2;
    -moz-box-flex: 1;
    -webkit-box-flex: 1;
    box-flex: 1;
    padding: 0 2px;
}
.tupianyou{
	text-align: center;
    -moz-box-flex: 1;
    -webkit-box-flex: 1;
    box-flex: 1;
    padding-left: 2px;
}
.tupianzuo img,.tupianzhong img,.tupianyou img{
	width: 100%;
	display: block;
}
.kong{
	width: 100%;
	height: 14px;
	background-color: white;
}

.left{
	width: 33%;
	float: left;
	overflow: hidden;
	margin-left: auto;
	margin-right: auto;
}

.liebiao{
	width: 100%;
    overflow: hidden;
    text-align: center;
    margin-bottom: 20px;
    margin-top: 10px;
}
.zhengge{
	width: 95%;
    margin: auto;
    margin-bottom: 10px;
}
.jutihuod{
	width: 100%;
    height: 112px;
    position: relative;
}
.jutihuod_ig{
	width: 100%;
    height: 112px;
    border: 1px solid #d2d2d2;
}
.zuoshangjiao{
	width: 20%;
    height: 30px;
    position: absolute;
    background-color: rgba(39, 178, 59, 0.8);
    top: 15px;
    color: white;
    border-radius: 0 15px 15px 0;
    line-height: 30px;
    text-align: center;
    font-size: 14px;
}
.jutihuod_bottom{
	width: 100%;
    height: 25px;
    position: absolute;
    bottom: 0;
    background-color: rgba(255,255,255,0.5);
}
.zong{
    height: 25px;
    float: right;
}
.shizhong{
	width: 100%;
    float: left;
    height: 25px;
}
.shizhong img{
	width: 18px;
    height: 18px;
    float: left;
    margin-top: 4px;
}
.djs{
    height: 25px;
    float: right;
    line-height: 25px;
    font-size: 14px;
    color: #221815;
    text-align: right;
}
.daoji{
	float: left;
    line-height: 25px;
    color: #221815;
    font-size: 14px;
    margin-left: 10px;
}
.right{
	width: 33%;
	float: left; 
	overflow: hidden;
	margin-left: auto;
	margin-right: auto;
}
.link {
	overflow: hidden;
	height: 161px;
}

.unit {
	width: 25%;
	height: 75px;
	min-width: 45px; 
	overflow : hidden;
	float: left;
	text-align: center;
	margin-top: 5px;
	overflow: hidden;
}

.unit img {
	width: 45px;
}

.unit p {
	width: 100%;
	margin-top: 0px;
	font-size: 14px;
}

.kong {
	width: 100%;
	height: 100%;
	background-color: #e1e3e1;
	position: absolute;
	opacity: 0;
	z-index: 3;
	display: none;
}
/*******/
#card {
	overflow: hidden;
	width: 100%;
	padding-bottom: 9px; 
	margin : auto;
	background-color: white;
	border-bottom: 1px solid #e1e3e1;
	margin: auto;
}

#left {
	min-width: 76px;
	margin: auto;
	width: 30%;
	text-align: center;
	padding-top: 9px;
	float: left;
	overflow: hidden;
}

#left img {
	margin: auto;
	display: block;
	width: 76px;
	height: 62px;
}

#right {
	width: 70%;
	padding-top: 14px;
	float: left;
	text-align: left;
	overflow: hidden;
}

.pbetweenright_middle {
	width: 100%;
	height: 53px;
	margin: 0;
}

.right_top {
	width: 100%;
	color: #040404;
	font-size: 16px;
	font-family: "Microsoft YaHei" ! important;
}

.right_middle {
	width: 100%;
	margin-top: 5px;
	color: #7a7070;
	font-size: 12px;
	font-family: "Microsoft YaHei" ! important;
}

.right_down {
	height: 28px;
	margin-top: 5px;
	overflow: hidden;
	margin-bottom: 0px;
	width: 100%;
	border-top: 1px solid #e1e3e1;
	line-height: 28px;
}

.right_d1 {
	width: 12%;
	float: left;
	margin-top: 5px;
}

.right_d1 img {
	width: 24px;
	height: 24px;
}

.right_d2 {
	width: 87%;
	display: block;
	overflow: hidden;
	float: left;
	margin-left: 1%;
	color: #7a7070;
	font-size: 12px;
	word-break: keep-all;
	white-space: nowrap;
	text-overflow: ellipsis;
	font-family: "Microsoft YaHei" ! important;
	margin-top: 3px;
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

.rundiv {
	margin: auto;
	width: 80px;
	height: 100px;
	margin-top: 60px;
	display: none;
}

.loadp {
	width: 100%;
	text-align: center;
}

.p2size {
	font-size: 18px;
	margin-top: -32px;
}

.moreloading {
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

.ywgd {
	display: none;
	height: 35px;
	width: 100%;
	background-color: #efefed;
	text-align: center;
	color: #eb621d;
	line-height: 35px;
	display: none;
	font-size: 15px;
}

.nodatadiv {
	margin: auto;
	width: 120px;
	height: 100px;
	margin-top: 10px;
}

.nodatadiv img {
	width: 120px;
}

.color {
	background-color: transparent;
}


/****/
/* 右边隐藏的选择框 css代码*/
.address_list{
	overflow: auto;
	position: fixed;
	top: 0;
	bottom:51px;
	right: 0;
	width: 90%; 
	 opacity: 0;
	background-color: white;
	z-index: 99;
	-webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
    
}
.rightin{
	animation-name: bounceInRight;     
    animation-duration:0.5s;            
    animation-delay:0;                 
    animation-fill-mode:forwards ;                                                                           
    -webkit-animation-name:bounceInRight;
    -webkit-animation-duration: 0.5s;
     -webkit-animation-delay:0;
    -webkit-animation-fill-mode:forwards ;
}

.rightout{
	animation-name: bounceOutRight;
	animation-duration:0.5s;
    animation-delay:0;
    animation-fill-mode:forwards ;
    -webkit-animation-name:bounceOutRight;
    -webkit-animation-duration: 0.5s;
    -webkit-animation-delay:0;
    -webkit-animation-fill-mode:forwards ;
}

.address_list .Head{
	color:black;
	width: 100%;
	height: 50px;
	border-top: 1px solid #e1e1e1;
	border-bottom: 1px solid #e1e1e1;
	line-height: 50px;
	text-align: center;
	background-color: #f7f7f7;
}

.Head img{
	height: 15px;
    position: absolute;
    left: 5%;
    top: 17.5px;
}
.address_list .head {
	width: 100%;
	height: 50px;
	border-bottom: 1px solid #e1e1e1;
	line-height: 50px;
	text-align: center;
	margin: 0px;
}
@-webkit-keyframes bounceInRight {
  from, 20%, 75%, 90%, to {
    -webkit-animation-timing-function: cubic-bezier(0.415, 0.610, 0.355, 1.000);
    animation-timing-function: cubic-bezier(0.415, 0.610, 0.355, 1.000);
  }


100%{ 
-webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
opacity: 1;
}
 
}

@keyframes bounceInRight {
  from, 20%, 75%, 90%, to {
    -webkit-animation-timing-function: cubic-bezier(0.415, 0.610, 0.355, 1.000);
    animation-timing-function: cubic-bezier(0.415, 0.610, 0.355, 1.000);
  }


100%{
-webkit-transform: translate3d(0%, 0, 0);
    transform: translate3d(0%, 0, 0);
opacity: 1;
}
 
}

@-webkit-keyframes bounceOutRight {

  to {
    opacity: 0;
    -webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
  }
}

@keyframes bounceOutRight {

  to {
    opacity: 0;
    -webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
  }
}

.weui_toast_content {
  margin: 10px 0 15px !important;
}
.weui_icon_msg:before {
  font-size: 60px !important;
}
</style>
</head>
<body>
	<div class="aa" onclick="hid()"></div>
	<div class="kong"></div>
	<div class="top" onclick="show()">
		选择社区<img src="${ctx}/static/wxfile/main1601/image/arrowg.png">
	</div>
	<div class="address_tip"></div>
	<div class="address_list">
	  <div class="Head"><img src="${ctx}/static/wxfile/wnx/image/ltjt.png">选择社区</div>
		
<!-- 		<p>美湖社区</p> -->
	</div>

	<!--  轮播跟换 -->
	<div class="main_visual">
		<div class="flicking_con">
			<c:forEach items="${adverts}" var="ad" varStatus="vs">

				<a href="#"
					<c:if test="${fn:length(adverts)==1}">style="display:none"</c:if>></a>
				<%-- <a href="#" style="background:url('${ctx}/static/images/btn_main_img.png') 0 0 no-repeat; ">2</a> --%>
			</c:forEach>
		</div>
		<div class="main_image">
			<c:if test="${fn:length(adverts)==1}">
				<c:forEach items="${adverts}" var="ad" varStatus="vs">
					<c:if test="${fn:indexOf(ad.img,'http://') >=0 }">
						<img class="" src="${ad.img}" onclick="go(${ad.id},${ad.type2},'${ad.url}',${vs.count})">
					</c:if>
					<c:if test="${fn:indexOf(ad.img,'http://') <0 }">
						<img class="" src="${ctx}/${ad.img}" onclick="go(${ad.id},${ad.type2},'${ad.url}',${vs.count})">
					</c:if>
				</c:forEach>
				
			</c:if>

			<c:if test="${fn:length(adverts)!=1}">
				<ul>
					<c:forEach items="${adverts}" var="ad" varStatus="vs">
						<c:if test="${fn:indexOf(ad.img,'http://') >=0 }">
							<li><img class="" src="${ad.img}" onclick="go(${ad.id},${ad.type2},'${ad.url}',${vs.count})"></li>
						</c:if>
						<c:if test="${fn:indexOf(ad.img,'http://') <0 }">
							<li><img class="" src="${ctx}/${ad.img}" onclick="go(${ad.id},${ad.type2},'${ad.url}',${vs.count})"></li>
						</c:if>
					</c:forEach>
					<%--  <li><span class="img_3" style="background:url('${ctx}/static/images/1.jpg') center top no-repeat;-moz-background-size:100% 100%;  background-size:100% 100%;"></span></li>
		    <li><span class="img_4" style="background:url('${ctx}/static/images/2.jpg') center top no-repeat;-moz-background-size:100% 100%;  background-size:100% 100%;"></span></li> --%>
				</ul>
			</c:if>
			<a href="javascript:;" id="btn_prev"></a> <a href="javascript:;"
				id="btn_next"></a>
		</div>
	</div>
	<div class="link">
		<div class="unit" onclick="gotosh()">
			<img src="${ctx}/static/wxfile/main1601/image/shanghu.png">
			<p>商户</p>
		</div>
		<div class="unit" onclick="gotojr()">
			<img src="${ctx}/static/wxfile/main1601/image/jinrong.png">
			<p>金融</p>
		</div>
		<div class="unit" onclick="gotojf()">
			<img src="${ctx}/static/wxfile/main1601/image/jiaofei.png">
			<p>生活缴费</p>
		</div>
		<div class="unit" onclick="gotozyz()">
			<img src="${ctx}/static/wxfile/main1601/image/yanglao.png">
			<p>养老</p>
		</div>
	   <div class="unit" onclick="gotoican()">
			<img src="${ctx}/static/wxfile/main1601/image/ican.png">
			<p>我能行</p>
		</div>
		<div class="unit" onclick="gotoyc()">
			<img src="${ctx}/static/wxfile/main1601/image/yicang.png">
			<p>义仓</p>
		</div>
		<div class="unit" onclick="gotowy()">
			<img src="${ctx}/static/wxfile/main1601/image/wuye.png">
			<p>物业</p>
		</div>
		<div class="unit" onclick="gotosqdt()">
			<img src="${ctx}/static/wxfile/main1601/image/menjin.png">
			<p>门禁</p>
		</div>
	</div>
	<div class="tip"></div>
	<div id="youh">
		<div class="youhui">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/youhui.png">
		</div>
		<div class="youhuihuodong">优惠活动</div>
	</div>
	<div class="middle">
		<div class="tupianzuo">
			<img alt="" src="${ctx}">
		</div>
		<div class="tupianzhong">
			<img alt="" src="${ctx}">
		</div>
		<div class="tupianyou">
			<img alt="" src="${ctx}">
		</div>
	</div>
	<div class="tip" id="tip1"></div>
	<div id="qiangg">
		<div class="qianggou">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/qianggou.png">
		</div>
		<div class="qianggouhuodong">抢购活动</div>
	</div>
	<div class="liebiao"></div>
	<!--<div class="middle1">
		<div class="kong"></div>
		<div class="left">
			<div class="tupian">
				<img alt="" src="">
			</div>
			<div class="riliaoguan">
				<div class="rlg"></div>
				<div class="rlg_left"></div>
				<div class="rlg_right"></div>
			</div>
		</div>
		<div class="middle">
			<div class="tupian">
				<img alt="" src="">
			</div>
			<div class="jiutiaolamian">
				<div class="jtlm"></div>
				<div class="jtlm_left"></div>
				<div class="jtlm_right"></div>
			</div>
		</div>
		<div class="right">
			<div class="tupian">
				<img alt="" src="">
			</div>
			<div class="chegnshiyinghua">
				<div class="csyh"></div>
				<div class="csyh_left"></div>
				<div class="csyh_right"></div>
			</div>
		</div>
		<div class="kong"></div>
	</div>-->
	<div class="list">
		<div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>

	<div class="moreloading" id="ddd2" sss="a">
				<div></div>
				<div></div>
				<div></div>
	</div>
	<!--<div id="jzgd" onclick="getmore()">点击加载更多</div>-->
	<!--<div class="ywgd">已无更多</div>-->
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent">请选择商品</p>
		</div>
	</div>
	<!--<div id="last" style="width: 100%;height: 50px;"></div>-->
	<%@ include file="foot.jsp"%>
	
</body>

<script type="text/javascript">
	showload();
	var obj;
	var objname;
	var cookieCode = getCookie("comID");
	var cookieName = decodeURI(getCookie("comName"));
	var size=10;
	var start=0;
	var isall=0;
	function show() {
		 $('.aa').css("display","block");
		$('.address_list').removeClass("rightin").removeClass("rightout").addClass("rightin")
		.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			$(this).css("transform","translate3d(0%, 0, 0)"); 
			$(this).css("-webkit-transform","translate3d(0%, 0, 0)"); 
			$(this).css("opacity","1"); 
		    $(this).removeClass("rightin");
		    });
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hd();	
		  });
	} 
	function hd(){
		$('.address_list').removeClass("rightout").removeClass("rightin").addClass("rightout")
		 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		    $(this).css("transform","translate3d(100%, 0, 0)"); 
		    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
			$(this).css("opacity","0"); 
		    $(this).removeClass("rightout");
		    });
	}
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

	function getmore() {
		if (isall == 0) {
			showmoreload();
			console.log("getmore start:"+start)
			//getlist(obj);
		}
	}
	
	$(document).ready(function() {
		
		//$('.Head').html(cookieName+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
		youhuihuodong();
		qianggouhuodong();
		getdata();
		
		var timer = "";
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
	});
	
	function seth() {
		$(".main_image").css("height", $($(".main_image ul li img")[0]).height());
	}
	
	function getdata(){
		$.get('${ctx}/wxpage/getcommunities',function(d){
			if(d.result=='1'){
				var len=d.data.length;
				for(var i=0;i<len;i++){
					$(".address_list").append('<p onclick="hd()" class="head" id="'+d.data[i].id+'">'+d.data[i].name+'</p>');				
				}	
				if(cookieCode=="" || cookieName==""){
					console.log("cookie is null!");
					//getlist(0);
					obj=0;
					objname="";
					
				}else{					
					obj=cookieCode;
					objname=cookieName;
					//getlist(obj);
					$('.top').html($("#"+obj).text()+'<img src="${ctx}/static/wxfile/main1601/image/arrowg.png">');
					
				}
				console.log("cookieCode"+obj);
				$("#"+obj).css("color","#f8ba1e");
				$("#"+obj).css("background-color","#e1e3e1");
				console.log("####:"+$("#"+obj).text());
					
				$(".address_list p").click(function(){
					console.log(this.id);
					$(".address_list p").css("color","#7a7070");
					$(".address_list p").css("background-color","white");	
					
					$(this).css("color","#f8ba1e");
					$(this).css("background-color","#e1e3e1");
					$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
					$('.top').html($(this).text()+'<img src="${ctx}/static/wxfile/main1601/image/arrowg.png">');
 					start=0;
 					isall=0;
 					$('.list').empty();
 					$('.nodatadiv').hide();
					$('.ywgd').hide();
					obj=this.id;
					objname=$(this).text();
					setCookie("comID",obj,999999999);
					setCookie("comName",encodeURI(encodeURI(objname)),999999999);										
					console.log("obj:"+obj);
					console.log("objname"+objname);
					//getlist(this.id);	
// 					setTimeout(function(){
// 						$('.address_list').hide();
// 						$('.kong').hide();
// 						$('body').css("position","");
// 						},500);
                   $('.aa').css("display","none");  
                   hd();
                
				});
				
			}else if(d.result=='0'){
				$(".list").html(
                '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
                  $("#jzgd").hide();
				  $(".ywgd").hide();
                 
			}
			if(obj==0)
				{
				show();
				}
		});
	}
	/*function getlist(commid){
		$.post('${ctx}/wxpage/getmerbycommunity',{'lat':31.696965,'lon':120.365478,'start':start,'size':size,'commid':commid},function(dd){
				console.log("commid:"+commid+" start:"+start);
				hideload();
				hidemoreload();				
				if(dd.result=="1"){
					var length=dd.data.length;
					console.log("list length:"+length);
					if (length == 0) {
		                   if (start == 0) {
		                    //第一次无数据   展示暂无数据提示
		                     $(".list").html(
		                    '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/zhanwusj.png"><div class="loadp p2size">暂无数据</div></div>');
	                          $("#jzgd").hide();
		                      isall = 1;
		                             } else {
			                        //展示 已无更多数据
			                        console.log("start!=0已无更多");
	                                $("#jzgd").hide();
	                                $(".ywgd").css("display","block");											
			                        isall = 1;
		                          }
		                          return;

     	    		} else {
		                   if (length < size) {
			               //展示 已无更多数据
			               console.log("length<size已无更多"+"length:"+length);
		                   $("#jzgd").hide();			               
	                       $(".ywgd").css("display","block");
			               isall = 1;
		                            } else {
			                         //点击加载更多								
		                               }
	                   }
					for(var k=0;k<length;k++){
						if(dd.data[k][7]!=null){
							if(dd.data[k][1].indexOf("http://") >= 0){
								
							}else{
								dd.data[k][1] = '${ctx}/' + dd.data[k][1];
							}
						var html='<div id="card" onclick="showcard('
						+dd.data[k][0]
						+')"><div id="left"><img alt="" src="'
						+dd.data[k][1]
						+'"></div><div id="right"><div class="pbetweenright_middle"><div class="right_top">'
						+dd.data[k][2]
						+'</div><div class="right_middle">'
						+dd.data[k][4]
						+'</div></div><div class="right_down"><div class="right_d1"><img alt="" src="${ctx}/static/wxfile/main1601/image/quan.jpg"></div><div class="right_d2">'
						+dd.data[k][7]
						+'</div></div></div></div>';
						}else{
							if(dd.data[k][1].indexOf("http://") >= 0){
								
							}else{
								dd.data[k][1] = '${ctx}/' + dd.data[k][1];
							}
							var html='<div id="card" onclick="showcard('
							+dd.data[k][0]
							+')"><div id="left"><img alt="" src="'
							+dd.data[k][1]
							+'"></div><div id="right"><div class="pbetweenright_middle"><div class="right_top">'
							+dd.data[k][2]
							+'</div><div class="right_middle">'
							+dd.data[k][4]
							+'</div></div></div></div>';
						}
						$('.list').append(html);	
						}
						start +=size;
					console.log("jiaguode start:"+start);
				}else if(dd.result=="0"){
					if(start==0){
						$(".list").html(
	                    '<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/zhanwusj.png"><div class="loadp p2size">暂无数据</div></div>')
	                      $("#jzgd").hide();
						  $(".ywgd").hide();
	                      isall = 1;					
						console.log("社区"+commid+"暂无数据");
					}else{
						 $("#jzgd").hide();			               
	                     $(".ywgd").show();
			             isall = 1;
					}
					
				}	
		});
	}*/
// 	$('.top').click(function(){
// 		$('.address_list').show();	
// 		$('.kong').show();
// 		$('body').css("position","fixed");
// 		$('body').css("width","100%");
// 		$(".aa").css("display", "block");
// 		$(".address_list").click(
// 				function() {
// 					$(".aa").css("display", "none");
// 					$("body").css("position", "");
// 				}) 
// 	});	
	
	
	
	//优惠活动接口
	function youhuihuodong(){
		$.post("${ctx}/wxcommunity/getacts",
				{
			
				},function(data){
					if(data.result == '1'){
						for(var i=0; i<data.data.length;i++){
							var id = data.data[i].id;
							var img = data.data[i].img;
							var type2 = data.data[i].type2;
							var url = data.data[i].url;
							if(i==0) {
								$(".tupianzuo").attr("onclick","gohd('"+id+"','"+type2+"','"+url+"')");
								$(".tupianzuo img").attr("src",img);
							}else if(i == 1) {
								$(".tupianzhong").attr("onclick","gohd('"+id+"','"+type2+"','"+url+"')");
								$(".tupianzhong img").attr("src",img);
							}else if(i == 2) {
								$(".tupianyou").attr("onclick","gohd('"+id+"','"+type2+"','"+url+"')");
								$(".tupianyou img").attr("src",img);
							}
							
							
							/* if(data.data[i].type2 == 0){
								$(".tupianzuo img").attr("src",data.data[0].img);
								$(".tupianzhong img").attr("src",data.data[1].img);
								$(".tupianyou img").attr("src",data.data[2].img);
							}else if(data.data[i].type2 == 1){
								$(".tupianzuo").bind("click",function(){
									window.open(data.data[0].url+data.data[0].id);
								});
								$(".tupianzhong").bind("click",function(){
									window.open(data.data[1].url+data.data[1].id);
								});
								$(".tupianyou").bind("click",function(){
									window.open(data.data[2].url+data.data[2].id);
								});
							} */
						}
					}else{
						//显示现有活动
					}
	
		})
	}
	//获取抢购活动的接口
	function qianggouhuodong(){
		$.post("${ctx}/wxcommunity/getquickbuyacts",
				{
			
				},function(data){
					hideload(); 
					hidemoreload();
					var jx = [];
					$(".liebiao").html("");
					if(data.result == 1){
						 for(var i = 0;i<data.data.length;i++){
							var qgid = data.data[i].id;//抢购活动id
							var imgurl = data.data[i].imgurl;//抢购活动图片链接
							var state = data.data[i].state;//抢购活动状态
							var starttime =  new Date(data.data[i].starttime);
							var endtime = new Date(data.data[i].endtime);
							var mydate = new Date();
							var now = mydate.getTime();
							$(".liebiao").append('<div class="zhengge">'
														+'<div class="jutihuod" onclick="gotohuo('+qgid+')">'
															+'<img alt="" class="jutihuod_ig" src="'+imgurl+'">'
															+(state == 1 ? '<div class="zuoshangjiao">未开始</div>':(state == 2 ? '<div class="zuoshangjiao">进行中</div>':
																(state == 3 ? '<div class="zuoshangjiao" style="background-color:rgba(150, 148, 148, 0.8)">已售完</div>':(state == 4 ? '<div class="zuoshangjiao" style="background-color:rgba(150, 148, 148, 0.8)">已下线</div>':
																(state == 5 ? '<div class="zuoshangjiao" style="background-color:rgba(150, 148, 148, 0.8)">已结束</div>': '')))))
																+(state == 5 ? '': (state == 3 ? '' : '<div class="jutihuod_bottom">'))
																+(state == 5 ? '': (state == 3 ? '' : '<div style="height: 25px;float: left;"></div>'))
																+(state == 5 ? '': (state == 3 ? '' : (state == 2 ? '<div class="zong">' :'<div class="zong">')))
																	+(state == 5 ? '': (state == 3 ? '' : '<div class="shizhong">'))
																		+(state == 5 ? '': (state == 3 ? '' : '<img alt="" src="${ctx}/static/wxfile/main1601/image/huiseshizhong.png">'))
																		+(state == 5 ? '': (state == 3 ? '' : (state == 2 ? '<div class="daoji">倒计时&nbsp;:&nbsp;</div><div  class="djs" id="daojishi'+i+'">99&nbsp;:&nbsp;99&nbsp;:&nbsp;99</div>':'<div class="daoji">预售倒计时&nbsp;:&nbsp;</div><div  class="djs" id="daojishi'+i+'">99&nbsp;:&nbsp;99&nbsp;:&nbsp;99</div>')))
																	+'</div>'
																+'</div>'
															+'</div>'
														+'</div>'
													+'</div>'
							);
							if(state == 1){
								var sntime = data.data[i].starttime - now ;
								jx.push(sntime);
							}else if(state == 2){
								var entime = data.data[i].endtime - now;
								jx.push(entime);
							}else{
								jx.push(-999);
							}
						}
						formatSeconds(jx);
					}else{
						$("#tip1").hide();
						$("#qiangg").hide();
						$(".liebiao").hide();
					}
		})
	}
	
	/* function djs(target,index) {
		var targetdate = new Date(parseInt(target));
		var now = new Date();
		var oft = Math.round((targetdate.getTime() - now.getTime()) / 1000);
		var ofd = parseInt(oft / 3600 / 24);
		var ofh = parseInt((oft % (3600 * 24)) / 3600);
		var ofm = parseInt((oft % 3600) / 60);
		var ofs = oft % 60;
		
		if (ofs < 0) {
			$("#djs"+index).html('倒计时结束');
		}
		
		$("#djs"+index).html('还有' + ofd + '天' + ofh + '小时' + ofm + '分钟' + ofs + '秒');
		
		setTimeout("djs('"+target+"', '"+now+"', '"+index+"')",1000);
	} */
	
	/* function daoJiShi(id){
		var oft=Math.round((endtime-now)/1000);
		var ofh=parseInt((oft%(3600*24))/3600);
		var ofm=parseInt((oft%3600)/60);
		var ofs=oft%60;
		document.getElementById('daojishi').innerHTML = '预售倒计时&nbsp;:&nbsp;'+ofh+'&nbsp;:&nbsp;'+ofm+'&nbsp;:&nbsp;'+ofs;
		 if(ofs<0){
			 document.getElementById('daojishi').innerHTML='';
			 return;
		 } 
		 
		 var oft = Math.round((endtime - now) / 1000);
		 var ofd = parseInt(oft / 3600 / 24);
		 var ofh = parseInt((oft % (3600 * 24)) / 3600);
		 var ofm = parseInt((oft % 3600) / 60);
		 var ofs = oft % 60;
		 document.getElementById('daojishi').innerHTML = '还有 ' + ofd + ' 天 ' + ofh + ' 小时 ' + ofm + ' 分钟 ' + ofs + ' 秒';
		 if (ofs < 0) {
			 document.getElementById('daojishi').innerHTML = '倒计时结束！';
			 return;
		 }
		 
		 setInterval('daoJiShi()',1000);
		 $.get('${ctx}/wxcommunity/getoneqg?id'+id,function(data){
			 var endtime = new Date(data.endtime);
			 var starttime =  new Date(data.starttime);
			 var now = new Date();
			 var oft = Math.round((endtime - now) / 1000);
			 var ofd = parseInt(oft / 3600 / 24);
			 var ofh = parseInt((oft % (3600 * 24)) / 3600);
			 var ofm = parseInt((oft % 3600) / 60);
			 var ofs = oft % 60;
			 //document.getElementById('daojishi').innerHTML = '预售倒计时&nbsp;:&nbsp;'+ofh+'&nbsp;:&nbsp;'+ofm+'&nbsp;:&nbsp;'+ofs;
			 if (ofs < 0) {
				 //document.getElementById('daojishi').innerHTML = '倒计时结束！';
				 return '倒计时结束' ;
			 }
			 return '预售倒计时&nbsp;:&nbsp;'+ofh+'&nbsp;:&nbsp;'+ofm+'&nbsp;:&nbsp;'+ofs;
			 setInterval('daoJiShi(id)',1000);
		 });
	} */
	
	
	
	function formatSeconds(jubujx) {
		for(var i =0;i<jubujx.length;i++){
			if(jubujx[i] == -999){
				continue;
			}
			var theTime = jubujx[i]/1000;// 秒 
			
	
			if(theTime<=0){
				$("#daojishi"+i).html("倒计时结束！");
				qianggouhuodong();
				return;
			}
			else{ 
				jubujx[i] -= 1000;
				var tian = 0;
				var xiaoshi = 0;
				var fen = 0;
				//天
				if (theTime >= 24 * 3600) {
					tian = parseInt(theTime / (24 * 3600));
					theTime = parseInt(theTime % (24 * 3600));
				}
				//小时
				if (theTime >= 3600) {
					xiaoshi = parseInt(theTime / 3600);
					theTime = parseInt(theTime % 3600);
				}
				//分
				if (theTime >= 60) {
					fen = parseInt(theTime / 60);
					theTime = parseInt(theTime % 60);
				}		
				//秒
				miao = parseInt(theTime);
					
				$("#daojishi"+i).html(tian+"天"+xiaoshi+"小时"+fen+"分"+miao+"秒");
				} 
			}
			setTimeout(function(){formatSeconds(jubujx)}, 1000);
	}
	
	
	
	$('.kong').click(function(){
		$('.address_list').hide();
		$(".aa").css("display", "none");
		$('.kong').hide();
		$('body').css("position","");
	});
	
	function gotosh(){
		if(checkcom()){
			var comname=encodeURI(encodeURI(objname));
			window.location.href="${ctx}/wxpage/commer?comid="+obj+"&comname="+comname;
		}		
	}
	function gotojr(){
		if(checkcom()){
			window.location.href="${ctx}/wxurl/tourl?url=wechat1601/finance";
		}
// 		if(obj==0 || obj==null){
//			window.location.href="${ctx}/wxurl/tourl?url=wechat1601/finance";
// 		}else{
// 			var comname=encodeURI(encodeURI(objname));
// 			window.location.href="${ctx}/wxurl/tourl?url=wechat1601/finance?comid="+obj+"&comname="+comname;
			
// 		}
	}
	function gotojf(){
		if(checkcom()){
			window.location.href="${ctx}/wxcommunity/lifefee?comid="+obj;
		}
	}
	function gotozyz(){
		window.location.href="${ctx}/wxcommunity/showpension";
	}
	function gotoyc(){
		if(checkcom()){
		window.location.href="${ctx}/wxcommunity/donation?comid="+obj;
		}
	}
	function gotoican(){
		/* window.location.href="${ctx}/wxurl/tourl?url=wnx/serve"; *///"${ctx}/wxurl/redirect?url=wxcommunity/myinfo";
		if(checkcom()){
			var comname=encodeURI(encodeURI(objname));
		window.location.href="${ctx}/wxcommunity/?comid="+obj;
		}
	}
	function gotowy(){
		if(checkcom()){
		window.location.href="${ctx}/wxcommunity/repair?commid="+obj;
		}
	}
	function gotosqdt(){
		window.location.href="${ctx}/wxcommunity/openac";
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
	function checkcom()
	{
		if(obj==0 || obj==null){
			showalert("请选择社区",1500);
			return false;
		}else
			{
			return true;
			}
	}
	//设置cookie方法
	function setCookie(key, val, time) {
		var date = new Date();
		var expiresDays = time;
		date.setTime(date.getTime() + expiresDays );
		document.cookie = key + "=" + val + ";expires=" + date.toGMTString()+";path=/";
	}
	function showcard(id)
		{
			window.open("/nsh/wxpage/merdetail?id="+id+"&token=token");
		} 
	
	/*分页**/
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

	
	function go(id, type ,url,count){
		setCookie("page",count,999999);
		if(type==1){
			window.location.assign(url);
		}else{
			window.open("${ctx}/advert/getDetail/"+id);
		}
	}
	
	function gohd(id, type ,url,count){
		setCookie("page",count,999999);
		if(type==1){
			window.location.assign(url);
		}else{
			window.open("${ctx}/wxcommunity/comactdetail?id="+id);
		}
	}
	
	function showalert(str, time) {
		$("#toastcontent").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, time);
	}
	
	//优惠活动跳转
	
	//抢购活动跳转
	function gotohuo(qgid){
		window.open("${ctx}/wxcommunity/qgdetail?id="+qgid);
	}
	
</script>
</html>