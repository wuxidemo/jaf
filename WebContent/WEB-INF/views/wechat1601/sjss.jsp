<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>商家搜索</title>
<link type="text/css"
	href="${ctx}/static/wxfile/main1601/css/sjss.css" rel="stylesheet" />
</head>
<body>
<div class="pot">
<img class="fdj"  src="${ctx}/static/wxfile/main1601/image/fdj.png"/>
<input class="full-width has-padding has-border" id="signup-username" type="text" placeholder="请输入商家名、品名或商圈..."/>
</div>
<div clsss="bt">
<div class="btt">搜索结果</div>

<div class="btm">
	<div class="ball-beat" id="ddd1" sss="a">
		<div></div>
		<div></div>
		<div></div>
	</div> 
<!--    <div class="card"> -->
<!--        <div class="lt"><img class="tp" src="/nsh/static/wxfile/main1601/image/byh.jpg"/></div> -->
<!--        <div class="rt"> -->
<!--        <div class="rt1"><div class="rt11">澳莎利西饼</div>  <div class="rt12">人均￥10</div></div> -->
<!--       <div class="rt2"> -->
<!--          <div class="rt21">蛋糕甜点</div>  <div class="rt22">湖滨商业街7.9km</div> -->
<!--       </div> -->
<!-- <hr> -->
<%-- <div class="quan"><div class="qt"><img src="${ctx}/static/wxfile/main1601/image/quan.jpg"/></div> <div class="qwz">满100减20，满200减50,8.8折</div></div> --%>
<!--        </div> -->
<!--    </div>  -->
<!--    <div class="line"></div>        -->
</div>
<div class="moreloading" id="ddd2" sss="a">
	<div></div>
	<div></div>
	<div></div>
</div>
<div id="jzgd" onclick="getmore()">点击加载更多</div>
<div class="ywgd">已无更多</div>

</div>
</body>

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
showload();
var mylatitude = getCookie("dowijsylat");//31.254789;
var mylongitude = getCookie("dowijsylon");121.235647;
var start = 0;
var size = 10;
var isall = 0;
var isinit = 0; //是否已按cookie数据初始化过
var key = getCookie("keyword");


function getmore(kind) {
     if (isall == 0) {
    	 if(kind=undefined){
	       showmoreload();
    	 }
	       getdata(decodeURI(key),mylatitude,mylongitude);
     }
}
  

$(document).ready(function() {
	//encodeURI(encodeURI($("#signup-username").val())))
	$("#signup-username").val(decodeURI(key));
	if(($("#signup-username").val(decodeURI(key))) == ""){
		$(".btt").hide();
		$(".btm").hide();
	}else{
		$(".btt").show();
		$(".btm").show();
		if(mylatitude != "" && mylongitude != ""){
			isinit = 1;
			getdata(decodeURI(key),mylatitude,mylongitude);
		}
	}
});


$(".fdj").bind("click", function() {
	start = 0;
	$("#signup-username").val();
	$(".btm").empty();
	if($("#signup-username").val() == ""){
		$(".btt").hide();
		$(".btm").hide();
	}else{
		$(".btt").show();
		$(".btm").show();
		if(mylatitude != "" && mylongitude != ""){
			isinit = 1;
			getdata(decodeURI(key),mylatitude,mylongitude);
		}
	}
});

wx.config({
	debug : false,
	appId : '${config.appId}',
	timestamp : '${config.timestamp}',
	nonceStr : '${config.nonceStr}',
	signature : '${config.signature}',
	jsApiList : [ 'getLocation' ]
});
wx.error(function(res) {
	//alert("加载错误:" + JSON.stringify(res));
});
wx.ready(function() {

	wx
			.getLocation({
				type : 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
				success : function(res) {
					mylatitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
					mylongitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
					var speed = res.speed; // 速度，以米/每秒计
					var accuracy = res.accuracy; // 位置精度
					setCookie('dowijsylat', mylatitude, 600000);
					setCookie('dowijsylon', mylongitude, 600000);
					loc = 1;
					if (isinit == 0) {
						getdt(key,mylatitude,mylongitude);
					} else {

					}
				},
				cancel : function() {
					loc = -1;
				}
			});
});
function getdata(keyword, latitude, longitude){
	$.post('${ctx}/wxpage/getmerbykeyword',
			{
				"lat" : latitude,
				"lon" : longitude,
				"start" : start,
				"size" : size,
				"keyword" : keyword
			},
			function(data){
						
		hideload();
		hidemoreload();
		var list = data.data;
		if (data.result == 0) {
				if (start == 0) {
                    // 第一次无数据   展示暂无数据提示
                     $(".btm").html(
                    	'<div class="nodatadiv"> <img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
                      $("#jzgd").css("display","none");
                      $("#ywgd").css("display","none");
                      isall = 1;
                 }else {
                     //展示 无更多数据
                     $("#jzgd").css("display","none");
                     $(".ywgd").css("display","block");											
                     isall = 1;
                  }
			}else{
				if (list.length < size) {
					//展示 无更多数据
					$("#jzgd").css("display","none");
					$(".ywgd").css("display", "block");
					isall = 1;
				} else {
					$("#jzgd").css("display","block");
					$("#ywgd").css("display","none");
					isall=0;						
				}

		for (var i = 0; i < list.length; i++) {
			var zhengshu = parseFloat(list[i][3]).toFixed(1);
			var juli = list[i][6]/1000.0+'';
			var index = juli.indexOf(".");
			juli = juli.substring(0,index+2)+"km";
			
			var logourl = list[i][1]+'';
			if(logourl.indexOf('http://') >=0 ) {
				
			}else{
				logourl = '${ctx}/' + logourl;
			}		
			
			
			
			var scorestr = '';
			var scorehui = '';
			var score = list[i][9];
			if(score == 0) {
				scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" />'; 
			}else{
				var scoreint = parseInt(score);
				var scoreremain = parseInt((score-scoreint)*10);
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
			$(".btm")
					.append('<div class="rowdiv">'
										+'<div id="beforecard1"></div>'
										+'<div id="card" onclick="showcard('+list[i][0]+')">'
											+'<div id="left">'
												+'<div>'
													+'<img src="'+logourl+'">'
												+'</div>'
											+'</div>'
											+'<div id="right">'
												+'<div class="pbetweenright_middle">'
													+'<div class="right_top">'
														+'<div class="right_top1">'+(list[i][2] == null ? "" : list[i][2])
														+'</div>'
													+'</div>'
													+'<div class="right_middle1">'
														+'<div class="xingxing">'
															+scorestr+scorehui
															+'<div class="right_m11">'
																+list[i][9]
															+'</div>'
														+'</div>'
														+'<div class="right_m12">'+"人均"+'<span id="changecolor">'+"￥"+(zhengshu == null ? "" : zhengshu)+'</span>'
														+'</div>'
													+'</div>'
													+'<div class="right_middle2">'
														+'<div class="right_m21">'+list[i][4]
														+'</div>'
														+'<div class="right_m22">'
															+'<div class="jul">'
																+'<div class="qianmi">'
																	+juli
																+'</div>'
															+'</div>'
															+'<div class="dingwei">'
																+'<img src="${ctx}/static/wxfile/main1601/image/dingwei.png">'
															+'</div>'
														+'</div>'
													+'</div>'
													+(list[i][7] == null ? "" : '<div class="right_down">')
													+(list[i][7] == null ? "" :'<div class="right_d1">')
														+(list[i][7] == null ? "" : '<img src="${ctx}/static/wxfile/main1601/image/quan.jpg">')
													+'</div>'
													+(list[i][7] == null ? "" :'<div class="right_d2">')+(list[i][7] == null ? "" : list[i][7])
													+'</div>'
												+'</div>'
												+'</div>'
												+'</div>'
											+'</div>'
										+'</div>'
										+'<div id="aftercard2"></div>'
										+'<div id="gekai"></div>'
							+'</div>'
				);
		    }
		}
		start += size;
				
	});
}

function showcard(id)
{
	window.open("${ctx}/wxpage/merdetail?id="+id+"&token=token");
} 
function showload() {
	$(".rundiv").css("display", "block");
}
function hideload() {
	$(".rundiv").css("display", "none");
}
function showmoreload() {
	$(".moreloading").css("display", "block");
	$("#jzgd").css("display", "none");
}
function hidemoreload() {
	$(".moreloading").css("display", "none");
	$("#jzgd").css("display", "block");
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
	document.cookie = key + "=" + val + ";expires=" + date.toGMTString();
}
</script>
</html>