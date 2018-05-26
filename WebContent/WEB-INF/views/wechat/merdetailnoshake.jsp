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
<title>${merchant.name}</title>


</head>

<style>
body {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family:Microsoft YaHei;
	width: 100%;
    height: 100%;
}

div.itemlabel {
	height: 16px;
	line-height: 100%;
	border: 1px orange solid;
	color: orange;
	display: inline-block;
	padding-top: 1px;
	padding-bottom: 1px;
	border-radius: 5px;
	position: absolute;
	right: 20px;
}

div.tel {
	width: 18px;
	height: 20px;
	background: url('${ctx}/static/images/shdh.png') no-repeat center;
	background-size: 15px 15px;
	line-height: 100%;
	display: inline-block;
	vertical-align: middle;
	margin-right: 5px;
}

div.address {
	width: 10%;
	height: 100%;
	background: url('${ctx}/static/images/shdd.png') no-repeat center;
	background-size: 15px 15px;
	line-height: 100%;
	display: inline-block;
	margin-right: 5px;
}

.imgspan {
	padding-left: 25px;
	/*color: rgba(0, 0, 0, 0);*/
	color: white;
	font-size: 20px;
	position: relative;
	display: block;
	height: 27px;
	margin-top: -40px;
	background: #000;
	filter: alpha(opacity = 100);
	opacity: 0.65;
	padding-top: 5px;
	padding-bottom: 3px;
	font-weight: normal;
}

/* .contentdiv {
	text-align: justify;
	padding: 0;
	margin: 0;
	width: 100%;
	background-color: white;
}

.contentdiv img {
	width: 100%;
	height: 100%;
} */

.innerdiv {
	width: 90%;
	margin: auto;
}

.innerdiv p {
	
}

/*****************/
.cards {
	width: 100%;
	overflow: hidden;
	text-align: center;
	margin-top: 10px;
}

.row {
	border-top: 1px solid #eeeff0;
    border-bottom: 1px solid #eeeff0;
    background: url("${ctx}/static/wxfile/images/juchi.png") repeat-y scroll right center/4px auto, url("${ctx}/static/wxfile/images/juchi.png") repeat-y scroll left center/4px auto;
    text-align: center;
    width: 95%;
    height: 119px;
    margin-bottom: 5px;
    margin: auto;
    background-size: cover;
    position: relative;
    margin-bottom: 10px;
}

.addyhq {
	position: relative;
    width: 100%;
    height: 70px;
    float: left;
    text-align: center;
}

.addyhq .left {
	width: 8%;
	height: 100%;
	float: left;
}

.addyhq .center {
	width: 100%;
	height: 70px;
    margin: auto;
    position: relative;
}

.addyhq .right {
	
	width: 8%;
	height: 100%;
	float: left;
}

.myyhq {
	background: rgba(0, 0, 0, 0)
		url("${ctx}/static/wxfile/images/yhqchecked.png") no-repeat scroll
		center center;
	display: inline-block;
	height: 25px;
	left: 3;
	position: absolute;
	width: 25px;
	margin-top: 47px;
}

.yhqnr {
	height: 50%;
	text-align: center;
}

.yhqnr p {
	margin-left: 10px;
	display: inline;
}

.row p {
	display: inline;
}

.logodiv {
	width: 60px;
	height: 60px;
	border-radius: 12.5%;
	overflow: hidden;
	margin: 11px auto;
}

.logodiv img {
	width: 60px;
	height: 60px;
}

.cleft {
	float: left;
	height: 100%;
	width: 25%;
}

.cright {
	float: left;
	height: 100%;
	width: 75%;
}

.ccontent {
	
	height: 70px;
	margin-top: 13px;
	width: 100%;
}

.ccontent div {
	color: black;
	font-size: 18px;
}

.title1 {
	width: 100%;
	height: 40px;
	
}

.title2 {
	width: 100%;
	height: 30px;
	line-height: 30px;
}

.addyhq_bottom{
	width: 97%;
    height: 32px;
    position: absolute;
    bottom: 0;
    padding-left: 2.5%;
    background-color: #f6f6f6;
    border-top: 1px dashed #888888;
}
.zuo{
	width: 50%;
    height: 31px;
    float: left;
}

.shizhong{
	width: 20%;
    float: left;
    margin-top: 8px;
}
.shizhong img{
	width: 16px;
    height: 16px;
}
.jitianguoqi{
	width: 70%;
    float: left;
    line-height: 31px;
    font-size: 14px;
    color: #9FA0A0;
    text-align: left;
}
.you{
	width: 45%; 
	height: 31px;
    float: left;
    line-height: 31px;
    font-size: 14px;
    color: #9FA0A0;
}
.namep {
	text-align: left;
    float: left;
    color: #FFB219 !important;
}

.rightp {
	float: right;
}

div:FOCUS {
	border: none;
	background: none;
}

/********************/
/** 160115**/
.merinfo {
	overflow: hidden;
  	margin: auto;
  	border-bottom: 1px solid #eeeff0;
  	padding: 15px 15px;
}

.mername {
	width: 70%;
	margin: auto;
	font-size: 25px;
	color: #f8ba1e;
	height: 30px;
	float: left;
	word-break: keep-all; /* 不换行 */
	white-space: nowrap; /* 不换行 */
	overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
	text-overflow: ellipsis;
}

.renjun {
	width: 30%;
	height: 30px;
	float: left;
	color: #595757;
	text-align: right;
	font-size: 18px;
	line-height: 38px;
}

.info1 {
	position: relative;
	width: 100%;
	float: left;
	margin-top: 10px;
}
.info2{
    position: relative;
	width: 100%;
	float: left;
	margin-top: 3px;
}
/* .info1:FIRST-CHILD { */
/* 	margin-top: 10px !important; */
/* } */

.add {
/* 	margin-left: 25px;  */
 	width: 14%; 
 	color: #595757; 
/* 	text-decoration: none; */
	float:left;
}
.add1{
    color: #595757;
	text-decoration: none;
}
.info1 img {
	top: 2.5px; 
 	position: absolute; 
	width: 15px;
/* 	margin-top: -10px; */
}

.info2 img{
     top: 2.5px; 
 	position: absolute; 
	width: 15px;
/* 	margin-top: -10px; */
}
.fghr {
	width: 100%;
	height: 10px;
	background-color: #eeeff0;
}

.head {
	width: 100%;
	position: relative;
}

.head img {
	display: block;
}

.innerdiv p:FIRST-CHILD {
	margin-top: 0 !important;
}

.title {
}

.kong{
	width: 100%;
	height: 11px;
}
.head_bottom{
	padding: 0px 15px;
  /* width: 100%; */
  /* height: 40px; */
  /* line-height: 40px; */
  	position: absolute;
 	 bottom: 0;
  	background-color: rgba(0,0,0,0.4);
  	left: 0;
  	right: 0;
}
.head_one{
  width: 100%;
  height: 40px;
  line-height: 40px;
}
.shmz{
  float: left;
  color: #FFFFFF;
  word-break: keep-all;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-size: 18px;
}
.xingx{
	  width: 110px;
  height: 41px;
  float: left;
  line-height: 41px;
  margin-left: 5px;
}
.xingx img{
	width: 14px;
  /* height: 14px; */
  float: left;
  margin-left: 2px;
  margin-top: 14px;
}
.right_down img{
	width: 16px;
    height: 14px;
    float: left;
    margin-bottom: 6px;
}
.fenshu{
    /* width: 22%; */
  float: left;
  color: #F7BB1D;
  /* font-size: 16px; */
  line-height: 16px;
  margin-left: 5px;
  margin-top: 14px;
  font-weight: bold;
}
.rj{
	  width: 95px;
  /* overflow: hidden; */
   float: right; 
  color: #FFFFFF;
   text-align: right; 
  /* line-height: 41px; */
  display: table-cell;
}
.daohang{
	width: 100%;
  	position: relative;
}
.daohang img{
	width: 15px;
   	position: absolute;
   	top: 1px;
}
.jutidizhi{
    color: #494949;
    margin-left: 30px;
}

.dianhua{
	width: 15%;
    overflow: hidden;
    float: left;
    text-align: center;
}
.dianhua img{
	width: 20px;
    height: 18px;
    margin-top: 17px;
}
.jutidianhua{
	width: 80%;
    overflow: hidden;
    float: left;
    line-height: 53px;
    font-size: 18px;
    color: #494949;
    word-break: keep-all;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.youhui{
	width: 15%;
    overflow: hidden;
    float: left;
    text-align: center;
}
.youhui img{
	width: 20px;
    height: 20px;
    margin-top: 16px;
}
.youhuiquan{
	width: 80%;
    overflow: hidden;
    float: left;
    line-height: 54px;
    font-size: 18px;
    color: black;
    word-break: keep-all;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.zan{
	width: 35px;
  	float: left;
  	position: relative;
}
.zan img{
	width: 20px;
  	position: absolute;
  	top: 2px;
}
.bendiantese{
	font-size: 18px;
  	color: black;
  	word-break: keep-all;
  	margin-left: 30px;
}
.tsxx{
	color: #494949;
  	padding: 15px;
}
.diandian{
	width: 15%;
    overflow: hidden;
    float: left;
    text-align: center;
}
.diandian img{
	width: 20px;
    height: 20px;
    margin-top: 17px;
}
.pingjia{
	width: 80%;
    overflow: hidden;
    float: left;
    line-height: 53px;
    font-size: 18px;
    color: black;
    word-break: keep-all;
    white-space: nowrap;
    text-overflow: ellipsis;	
}

.contentdiv{
	width: 100%;
    overflow: hidden;
}
.zhanwu{
	width: 100%;
	color: #9FA0A0;
	font-size: 14px;
	text-align: center;
	margin-top: 50px;
	margin-bottom: 50px;	
}
.contentdiv_head{
	height: 60px;
    padding-left: 5%;
    padding-right: 5%;
}

.left{
	display: table-cell;
    overflow: hidden;
}
.touxiang{
	width: 60px;
    overflow: hidden;
    margin: auto;
}
.touxiang img{
	display: block;
    width: 45px;
    height: 45px;
    border-radius: 50%;
}
.right{
	display: table-cell;
    width: 100%;
    overflow: hidden;
    margin-top: 5px;
}
.right_top{
	width: 100%;
	overflow: hidden;
}
.right_down{
	width: 90%;
    overflow: hidden;
    margin-top: 3px;
}
.right_top_left{
	width: 40%;
    float: left;
    text-align: left;
    color: #9FA0A0;
    font-size: 14px;
    overflow: hidden;
    word-break: keep-all;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.right_top_right{
	width: 100px;
    float: right;
    text-align: right;
    color: #9FA0A0;
    font-size: 14px;
}
.contentdiv_middle{
	width: 90%;
    color: #494949;
    font-size: 14px;
    margin: auto;
    overflow: hidden;
    margin-bottom: 20px;
    word-break: break-all;
    word-wrap: break-word;
}
.contentdiv_bottom{
	width: 100%;
	overflow: hidden;
	padding-left: 5%;
}
.tup{
	width: 23%;
    float: left;
    overflow: hidden;
}
.tup img{
	width: 79px;
    height: 80px;
    border: 1px solid #d2d2d2;
}
.gekai{
	width: 100%;
	height: 24px;
}
.chakanqb{
	width: 100%;
	height: 41px;
	text-align: center;
	color: #F7BB1D;
	line-height: 41px;
}
.di{
	width: 100%;
    height: 60px;
    text-align: center;
}
#xiaoyouxi{
	width: 80%;
    height: 40px;
    background-color: #F8BA1E;
    border-radius: 10px;
    line-height: 40px;
    text-align: center;
    margin-top: 20px;
    margin-left: 10%;
    color: #FFFFFF;
    font-size: 18px;
}
#ddd1{text-align: center;width:100%;height:30px;background-color:white;margin-top: 42px;margin-bottom: 30px;display: none;}

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

a:link {
text-decoration: none;
}
a:visited {
text-decoration: none;
}
a:hover {
text-decoration: none;
}
a:active {
text-decoration: none;
}
</style>


<body>
	<!--  -->
	<div class="head"></div>
	<div class="merinfo">
		<div class="daohang">
			<img alt="" src="${ctx}/static/wxfile/images/dizhi.png">
		</div>
		<div class="jutidizhi">${merchant.address}</div>
	</div>
	<a href="tel:${merchant.telephone}">
		<div class="merinfo">
			<div class="daohang">
				<img alt="" style="width: 20px;" src="${ctx}/static/wxfile/images/dianhua.png">
			</div>
			<div class="jutidizhi">${merchant.telephone}</div>
		</div>
	</a>
	<div class="fghr"></div> 
	<div class="title merinfo">
		<div class="zan">
			<img alt="" src="${ctx}/static/wxfile/images/youhui.png">
		</div>
		<div class="bendiantese">优惠券</div>
	</div>
	<div class="cards"></div>
	<div class="fghr" id="ycang1"></div>
	<div class="merinfo"<c:if test="${merchant.specialcourse == null || merchant.specialcourse == ''}">style="display: none;"</c:if>>
		<div class="zan">
			<img alt="" src="${ctx}/static/wxfile/images/tese.png">
		</div>
		<div class="bendiantese">本店特色</div>
	</div>
	
	<div class="tsxx" <c:if test="${merchant.specialcourse == null || merchant.specialcourse == ''}">style="display: none;"</c:if>>${merchant.specialcourse}</div>
	<div class="fghr" id="ycang2"></div>
	<div class="merinfo">
		<div class="zan">
			<img alt="" src="${ctx}/static/wxfile/images/pingjia.png"> 
		</div>
		<div class="bendiantese">评价</div>
	</div>
	<div class="contentdiv">
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
	<div class="chakanqb" onclick="add()">查看全部评价</div>
	<div class="fghr"></div>
	<div class="di">
		<div id="xiaoyouxi" onclick="xiaoyouxi();">快来玩小游戏吧</div>
	</div> 
</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<script type="text/javascript">

	showload();
	var data = $.parseJSON('${exts}');
	var merid = '${merid}';
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		//	alert("本活动仅支持微信");
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
		//listCard();
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});

	$(document).ready(function() {
		bindshow("#zhaopian");
		headxiangq();
		qiansantiao(merid);
		listCard(); 
	});

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

		return year + "-" + month + "-" + dd;
	}
	//点击跳转页面查看全部评价
	function add(kind){
		var merid = '${merid}';
		window.location.href="${ctx}/wxcommunity/jumpallmer?merid="+merid;
	}
	
	
	//点击进入小游戏
	function xiaoyouxi(){
		window.location.href="http://yx8.com/game/tusimianbao2/";
	}
	
	
	
	var merchantname = '${merchant.name}';//商户名
	var avgscore = '${avgscore}';//头部评价分数
	var merchantonecost = '<fmt:formatNumber type="number" value="${merchant.onecost}" />';//消费金额
	
	//获取头部相关详情
	function headxiangq(){
		var logourl = '${merchant.introduceurl}';//头部图片
		if(logourl.indexOf('http://') >=0 ) {
			
		}else{
			logourl = '${ctx}/' + logourl;
		}
		
		
		var scorestr = '';
		var scorehui = '';
		if(avgscore == 0) {
			scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" />'; 
		}else{
			var scoreint = parseInt(avgscore);
			var scoreremain = parseInt((avgscore-scoreint)*10);
			if(scoreremain == 0) {
				for(var j=1;j <= scoreint;j++){
					scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
				}
				var noscore = 5-scoreint;
				for(var k=1;k<=noscore ; k++){
					scorehui += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
				}
			}else{
				for(var j=1;j <= scoreint;j++){
					scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
				}
				scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/0.'+scoreremain+'.png" />'; 
				var noscore = 4-scoreint;
				for(var k=1;k<=noscore ; k++){
					scorehui += '<img src="${ctx}/static/wxfile/main1601/stars/0.png"/>';
				}
			}
		}
		
		
		$(".head").append('<img alt="" src="'+logourl+'?imageView2/2/w/500|imageMogr2/auto-orient" width="100%">'
				+'<div class="head_bottom"><div class="head_one">'
					+'<div style="max-width:'+(document.body.clientWidth -240)+'px" class="shmz">'+merchantname+'</div>' 
					+'<div class="xingx">'
						+scorestr+scorehui
						+'<div class="fenshu">'
							+avgscore
						+'</div>'
					+'</div>'
					+ (merchantonecost==''?'':'<div class="rj">'+"人均&nbsp;￥"+''+parseFloat(merchantonecost)+''+'</div>') 
				+'</div></div>'
		);
	}
	
	//获取优惠券
	function listCard() {
		$
				.post(
						"${ctx}/wxpage/getcardlist",
						{
							"id" : merid
						},
						function(cards) {
							var cardlist = cards.data;
							if (cards.result == '1') {
								$("#ycang1").css("height","10px");
								//$("#ycang2").css("height","10px");
								$(".title").show();
								$(".cards").show();
								for (var i = 0; i < cardlist.length; i++) {
									var starttime = cardlist[i].card.starttime;
									var endtime = cardlist[i].card.endtime;
									var mydate = new Date();
									var tianshu = ((endtime - mydate)/1000)/3600;
									var logourl = cardlist[i].card.logourl;
									var cardname = cardlist[i].card.name;
									if (cardname.length > 12) {
										cardname = cardname.substring(0, 12)
												+ '...';
									}

									var cardmername = cardlist[i].card.merchantname;
									if (cardmername.length > 5) {
										cardmername = cardmername.substring(0,
												5)
												+ '...';
									}
									
									if(logourl != null){
										if(logourl.indexOf("http://") >= 0){
											
										}else{
											logourl = '${ctx}/' + logourl;
										}
									}
									
									$(".cards")
											.append((cardlist[i].card.datetype == 1 ? '<div class="row bottomborder" style="height: 119px;" onclick="getCard(\''+ cardlist[i].cardid+ '\',\''+i+ '\')">' : 
													'<div class="row bottomborder" style="height: 86px;" onclick="getCard(\''+ cardlist[i].cardid+ '\',\''+i+ '\')">')
														+'<div class="addyhq">'
															+'<div class="center">'
																+'<div class="cleft">'
																	+'<div class="logodiv">'
																		+ (cardlist[i].card.isonly == 1 ? '<img alt="" src="'+logourl+'">': '<img alt="" src="${ctx}/static/images/headimg.jpg">')
																	+'</div>'
																+'</div>'
																+'<div class="cright">'
																	+'<div class="ccontent">'
																		+'<div class="title2">'
																			+'<div style="text-align: left;">'+cardmername+'</div>'
																		+'</div>'
																		+'<div class="title1">'
																			+'<div style="color: white; font-size: 17px;" class="namep">'+cardname+'</div>' 
																		+'</div>'
																	+'</div>'
																+'</div>'
															+'</div>'
															+'<div class="kong"></div>'
														+'</div>'
														+(cardlist[i].card.datetype == 1 ? '<div class="addyhq_bottom">' : '')
															+(cardlist[i].card.datetype == 1 ? '<div class="zuo">' : '')
																+(cardlist[i].card.datetype == 1 ? '<div class="shizhong">' : '')
																	+(cardlist[i].card.datetype == 1 ? '<img alt="" src="${ctx}/static/wxfile/images/shizhong.png">' : '')
																+(cardlist[i].card.datetype == 1 ? '</div>' : '')
																+(cardlist[i].card.datetype == 1 ? '<div class="jitianguoqi">还有'+Math.round(tianshu/24)+'天过期</div>' : '')
															+(cardlist[i].card.datetype == 1 ? '</div>' : '')
															+(cardlist[i].card.datetype == 1 ? '<div class="you">有效期至'+formattime(endtime)+'</div>' : '')
														+(cardlist[i].card.datetype == 1 ? '</div>' : '')
													+'</div>'
									  );

								}

							}else{
								$("#ycang1").css("height","0");
								//$("#ycang2").css("height","0");
								$(".title").hide();
								$(".cards").hide();
							}

						});

	}
	
	
	//获取全部评论前三条
	function qiansantiao(merid){
		$
			.post(
				"${ctx}/wxcommunity/partmercomment",
				{
					"merid" : merid
				},function(data){
					hideload(); 
					hidemoreload();
					if(data.result == 0){
						//暂无评价
						$(".chakanqb").hide();
						$(".contentdiv").append('<div class="zhanwu">暂无评价...</div>'
								
						);
					}else if(data.result == 1){
						$(".chakanqb").show();
						for(var i = 0;i < data.data.length;i++){
							var urlstr = '';
							var logourl7 = data.data[i][7];
							if(logourl7 == '' || logourl7 == null){
								urlstr = '<div class="contentdiv_bottom" style="height:0;"></div>';
							}else{
								var urlarr = logourl7.split(',');
								for(var j = 0;j < urlarr.length;j++){
									urlstr += '<div class="tup"><img id="zhaopian" src="'+urlarr[j]+'"></div>';
								}
								
								urlstr = '<div class="contentdiv_bottom">'+urlstr+'</div>';
							
								if(logourl7.indexOf('http://') >=0 ) {
									
								}else{
									logourl7 = '${ctx}/' + logourl7;
								}
							}
							var sj = formattime(data.data[i][5]);
							
							var logourl9 = data.data[i][9]+'';
							if(logourl9 != null){
								if(logourl9.indexOf('http://') >=0 ) {
									
								}else{
									logourl9 = '${ctx}/' + logourl9;
								}
							}
							var scorestr2 = '';
							var scorehui2 = '';
							var score2 = data.data[i][4];
							if(score2 == 0){
								scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
							}else{
								var scoreint2 = parseInt(score2);
								var scoreremain2 = parseInt((score2-scoreint2)*10);
								if(scoreremain2 == 0) {
									for(var j=1;j <= scoreint2;j++){
										scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
									}
									var noscore2 = 5-scoreint2;
									for(var k=1;k<=noscore2 ; k++){
										scorehui2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
									}
								}else{
									for(var j=1;j <= scoreint2;j++){
										scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
									}
									scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.'+scoreremain2+'.png" />'; 
									var noscore2 = 4-scoreint2;
									for(var k=1;k<=noscore2 ; k++){
										scorehui2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png"/>';
									}
								}
							}
							
							$(".contentdiv").append('<div class="gekai"></div>'
														+'<div class="contentdiv_head">'
															+'<div style="width:100%;overflow:hidden;">'
																+'<div class="left">'
																	+'<div class="touxiang">'
																		+'<img alt="" src="'+logourl9+'">'
																	+'</div>'
																+'</div>'
																+'<div class="right">'
																	+'<div class="right_top">'
																		+'<div class="right_top_left">'+data.data[i][8]+'</div>'
																		+'<div class="right_top_right">'+sj+'</div>'
																	+'</div>'
																	+'<div class="right_down">'
																		+scorestr2+scorehui2
																	+'</div>'
																+'</div>'
															+'</div>'
														+'</div>'
														+'<div class="contentdiv_middle">'+data.data[i][2]+'</div>'
														+urlstr
														+'<div class="gekai" style="border-bottom: 1px solid #eeeff0;"></div>'
												);
							
						}
				}else if(data.result == 2){
					$(".chakanqb").show();
					for(var i = 0;i < data.data.length;i++){
						var urlstr = '';
						var logourl7 = data.data[i][7];
						if(logourl7 == '' || logourl7 == null){
							urlstr = '<div class="contentdiv_bottom" style="height:0;"></div>';
						}else{
							var urlarr = logourl7.split(',');
							for(var j = 0;j < urlarr.length;j++){
								urlstr += '<div class="tup"><img id="zhaopian" src="'+urlarr[j]+'"></div>';
							}
							
							urlstr = '<div class="contentdiv_bottom">'+urlstr+'</div>';
						
							if(logourl7.indexOf('http://') >=0 ) {
								
							}else{
								logourl7 = '${ctx}/' + logourl7;
							}
						}
						var sj = formattime(data.data[i][5]);
						
						var logourl9 = data.data[i][9]+'';
						if(logourl9 != null){
							if(logourl9.indexOf('http://') >=0 ) {
								
							}else{
								logourl9 = '${ctx}/' + logourl9;
							}
						}
						var scorestr2 = '';
						var scorehui2 = '';
						var score2 = data.data[i][4];
						if(score2 == 0){
							scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
						}else{
							var scoreint2 = parseInt(score2);
							var scoreremain2 = parseInt((score2-scoreint2)*10);
							if(scoreremain2 == 0) {
								for(var j=1;j <= scoreint2;j++){
									scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
								}
								var noscore2 = 5-scoreint2;
								for(var k=1;k<=noscore2 ; k++){
									scorehui2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
								}
							}else{
								for(var j=1;j <= scoreint2;j++){
									scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
								}
								scorestr2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.'+scoreremain2+'.png" />'; 
								var noscore2 = 4-scoreint2;
								for(var k=1;k<=noscore2 ; k++){
									scorehui2 += '<img src="${ctx}/static/wxfile/main1601/stars/0.png"/>';
								}
							}
						}
						
						$(".contentdiv").append('<div class="gekai"></div>'
													+'<div class="contentdiv_head">'
														+'<div style="width:100%;overflow:hidden;">'
															+'<div class="left">'
																+'<div class="touxiang">'
																	+'<img alt="" src="'+logourl9+'">'
																+'</div>'
															+'</div>'
															+'<div class="right">'
																+'<div class="right_top">'
																	+'<div class="right_top_left">'+data.data[i][8]+'</div>'
																	+'<div class="right_top_right">'+sj+'</div>'
																+'</div>'
																+'<div class="right_down">'
																	+scorestr2+scorehui2
																+'</div>'
															+'</div>'
														+'</div>'
													+'</div>'
													+'<div class="contentdiv_middle">'+data.data[i][2]+'</div>'
													+urlstr
													+'<div class="gekai" style="border-bottom: 1px solid #eeeff0;"></div>'
											);
						
					
					}
				}
			});	
	}


	function getCard(id, index) {
		wx.addCard({
			cardList : [ {
				cardId : id,
				cardExt : JSON.stringify(data[index])
			} ], // 需要添加的卡券列表
			success : function(res) {
				var cardList = res.cardList; // 添加的卡券列表信息
			}
		});
	}
	
	
	
	
	function showload() {
		$("#ddd1").css("display","block");
	}
	
	function hideload() {
		$("#ddd1").css("display","none");
	}
	
	function showmoreload()
	{
		$("#ddd2").css("display","block");
		$(".chakanqb").css("display","none");
	}
	function hidemoreload()
	{
		$("#ddd2").css("display","none");
		$(".chakanqb").css("display","block");
	}
	
	function bindshow(tab) {
		$(tab).css("position", "absolute");
		$($(tab).parent()).css("position", "relative");
		$($(tab).parent()).css("overflow", "hidden");
		$(tab).bind(
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