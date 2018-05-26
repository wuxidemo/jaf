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
<title>全部评价</title>
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
.merinfo {
	width: 100%;
    overflow: hidden;
    margin: auto;
    border-bottom: 1px solid #eeeff0;
}
.zongtipingjia{
	width: 24%;
    float: left;
    overflow: hidden;
    line-height: 50px;
    color: #373737;
    text-align: center;
    font-size: 18px;
    margin-left: 2%;
}
.xingx{
	width: 74%;
    height: 50px;
    float: left;
    line-height: 50px;
}
.xingx img {
    width: 15px;
    height: 13px;
    float: left;
    margin-left: 2px;
    margin-top: 19px;
}
.fenshu {
    width: 22%;
    float: left;
    color: #F7BB1D;
    line-height: 16px;
    margin-left: 5px;
    margin-top: 19px;
    font-weight: bold;
}
.contentdiv{
	width: 100%;
    overflow: hidden;
}
.zhanwu{
	width: 100%;
    height: 150px;
    color: #9FA0A0;
    font-size: 18px;
    text-align: center;
    padding-top: 215px;	
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
.right_down img{
	width: 16px;
    height: 14px;
    float: left;
    margin-bottom: 6px;
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
</style>
<body>
	<div class="merinfo"></div>
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
	<div class="chakanqb" onclick="add()">点击加载更多</div>
</body>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<script type="text/javascript">
		var start = 0;//初始数据 
		var Allstart = 0;//每次添加时的初始数据 
		var size = 10;//每页多少数据
		var allsize = 0;//当前数据数量
		var isall = 0;
		var merid = '${merid}';
		var avgscore ='${avgscore}';
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
			
		});
		wx.error(function(res) {
			//alert("加载错误:" + JSON.stringify(res));
		});
		
		$(document).ready(function() {
			headxiangq();
			pinglun(merid,Allstart,size);
		});
		
		
		
		
		//获取头部评价分数
		function headxiangq(){
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
			
			$(".merinfo").append('<div class="zongtipingjia">'+'总体评价&nbsp;:'+'</div>'
								 +'<div class="xingx">'
								 	+scorestr+scorehui
								 	+'<div class="fenshu">'
								 		+avgscore
								 	+'</div>'
								 +'</div>'
			);
		}
		
		//点击加载更多
		function add(kind){
			if(isall==0){
				if(kind=undefined){
					showmoreload();
				}
				pinglun(merid,Allstart,size);
			}
		}
		
		
		
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
		
		
		
		//获取全部评论
		function pinglun(merid,start,size){
			$
				.post(
					"${ctx}/wxcommunity/allmercomment",
					{
						"merid" : merid,
						"start" : start,
						"size" : size
						
					},function(data){
						hideload(); 
						hidemoreload();
						if(data.result == 0){
							if(start == 0){
								//暂无评价
								$(".chakanqb").hide();
								$(".contentdiv").append('<div class="zhanwu">暂无评价...</div>'
										
								);
								isall=1;
							}else{
								$(".chakanqb").html("已无更多");
								$(".chakanqb").css("background-color","#eeeff0");
								isall=1;
							}
						}else{
							if(data.data.length < size){
								$(".chakanqb").html("已无更多");
								$(".chakanqb").css("background-color","#eeeff0");
								isall=1;
							}else{
								$(".chakanqb").html("加载更多");
								$(".chakanqb").css("background-color","#white");
								$(".chakanqb").css("display","block");
								isall=0;
							}
							Allstart = start+data.data.length;
							for(var i = 0;i < data.data.length;i++){
								var urlstr = '';
								var logourl7 = data.data[i][7];
								if(logourl7 == '' || logourl7 == null){
									urlstr = '<div class="contentdiv_bottom" style="height:0;"></div>';
								}else{
									var urlarr = logourl7.split(',');
									for(var j = 0;j < urlarr.length;j++){
										//console.log(j+"-----------"+urlarr[j]);
										urlstr += '<div class="tup"><img id="zhaopian" src="'+urlarr[j]+'"></div>';
									}
									
									urlstr = '<div class="contentdiv_bottom">'+urlstr+'</div>';
								}
								
								var sj = formattime(data.data[i][5]);
								
								var logourl9 = data.data[i][9]+'';
								if(logourl9.indexOf('http://') >=0 ) {
									
								}else{
									logourl9 = '${ctx}/' + logourl9;
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
		
		
</script>
</html>