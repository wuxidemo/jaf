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
<meta name="apple-mobile-web-app-capable" content="no" />
<title>商圈</title>
<link type="text/css"
	href="${ctx}/static/wxfile/main1601/css/homepage.css"
	rel="stylesheet" />
<link type="text/css"
	href="${ctx}/static/wxfile/main1601/css/style.css"
	rel="stylesheet" />
</head>
<body>
	
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
	<div id="head2">
		<div id="meishi" onclick="ms()">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/ms.jpg">
			<div id="ms">美食</div>
		</div>
		<div id="shenghuofuwu" onclick="shfw()">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/shfw.jpg">
			<div id="shfw">生活服务</div>
		</div>
		<div id="xiuxianyule" onclick="xxyl()">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/xxyl.jpg">
			<div id="xxyl">休闲娱乐</div>
		</div>
		<div id="qita" onclick="toqita()">
			<img alt="" src="${ctx}/static/wxfile/main1601/image/qt.jpg">
			<div id="qt">全部</div>
		</div>
	</div>
	<div id="kongdiv"></div>
	<div id="middle1">
		<div id="remenshanghu">
			<div id="aixin">
				<img alt="" src="${ctx}/static/wxfile/main1601/image/huo.png">
			</div>
			<div id="rmsh">热门商户</div>
		</div>
		<div id="wxm">
			<div id="wasaitu">
				<div id="ws">
					<img alt="" src="">
				</div>
				<div id="wasai">哇噻</div>
			</div>
			<div id="xiehoutu">
				<div id="xh">
					<img alt="" src="">
				</div>
				<div id="xiehou">邂逅</div>
			</div>
			<div id="mitaocantingtu">
				<div id="mtct">
					<img alt="" src="">
				</div>
				<div id="mitaocanting">蜜桃餐厅</div>
			</div>
		</div>
	</div>
	<div id="kongdiv"></div>
	<div id="middle2">
		<div id="fujinshangjia">
			<div id="fujin">
				<img alt="" src="${ctx}/static/wxfile/main1601/image/shangjia.png">
			</div>
			<div id="fjsj">附近商家</div>
		</div>
		 <div id="liebiao">
		 	<div class="ball-beat" id="ddd1" sss="a">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<%-- <div class="rowdiv">
				<div id="beforecard1"></div>
				<div id="card">
					<div id="left">
						<div>
							<img alt="" src="${ctx}/static/wxfile/main1601/image/byh.jpg">
						</div>
					</div>
					<div id="right">
						<div class="pbetweenright_middle">
							<div class="right_top">
								<div class="right_top1">棒约翰披萨</div>
								<div class="right_top2">人均￥80</div>
							</div>
							<div class="right_middle">
								<div class="right_m1">西餐</div>
								<div class="right_m2">湖滨商业街7.9km</div>
							</div>
						</div>
						<div class="right_down">
							<div class="right_d1">
								<img alt="" src="${ctx}/static/wxfile/main1601/image/quan.jpg">
							</div>
							<div class="right_d2">满100减20,满200减50</div>
						</div>
					</div>
				</div>
				<div id="aftercard2"></div>
			</div>  --%>
		</div>
	</div>
	<div class="moreloading" id="ddd2" sss="a">
				<div></div>
				<div></div>
				<div></div>
			</div>
	<div id="jzgd" onclick="add()">点击加载更多</div>	
	<div id="last"></div>
	<%@ include file="foot.jsp"%>
</body>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/main1601/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/main1601/js/jquery.event.drag-1.5.min.js"></script>
<script type="text/javascript" 
	src="${ctx}/static/wxfile/main1601/js/jquery.touchSlider.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
showload();
var mylatitude = getCookie("dowijsylat");//31.254789;
var mylongitude = getCookie("dowijsylon");//121.235647;
var isinit = 0; //是否已按cookie数据初始化过
var start = 0;//初始数据 
var Allstart = 0;//每次添加时的初始数据 
var size = 10;//每页多少数据
var allsize = 0;//当前数据数量
var isall = 0;
	
	if(mylatitude == "" && mylongitude == ""){
		
	}if(mylatitude != "" && mylongitude != ""){
		isinit=1;
		getData(Allstart,size,mylatitude,mylongitude);
	}
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [  'getLocation' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		getdatabyjw();
	});
	
	
	$(document).ready(function(){
		gethot();
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
		
		timer = setInterval(function(){
			$("#btn_next").click();
		}, 4000);
		
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
	
	
	
	//加载更多这一功能
	function add(kind) {
	if(isall==0)
		{
		if(kind=undefined)
		{
		showmoreload();
		}
		getData(Allstart,size,mylatitude,mylongitude); 
		}
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
	
	//获取经纬度
	function getdatabyjw() {
		wx.getLocation({
			type : 'wgs84',
			success : function(res) {
	//console.log("4:"+new Date().getTime());
				var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
				var speed = res.speed; // 速度，以米/每秒计
				var accuracy = res.accuracy; // 位置精度
				//alert(latitude+":"+longitude);
				mylatitude = latitude;
				mylongitude = longitude;
				setCookie('dowijsylat',mylatitude,600000);
				setCookie('dowijsylon',mylongitude,600000);
				if(isinit == 0){
					getData(Allstart,size,mylatitude,mylongitude);
				}else{
					
				}
				
			}, 
			fail : function(f) {
				//alert("授权失败");
			},
			cancel : function(c) {
				//alert("取消操作");
			}
		});
	}
	
	//获取热门商户
	function gethot() {
		$.post("${ctx}/wxpage/gethotmerchant",
				function (data){
					if(data.result == 1){
						$("#wasaitu").bind("click",function(){
							window.open(data.data[0].jumpurl);
						});
						if(data.data[0].imgurl.indexOf("http://") >= 0){
							$("#ws img").attr("src",data.data[0].imgurl);
						}else{
							$("#ws img").attr("src","${ctx}/"+data.data[0].imgurl);
						}
						$("#wasai").html(data.data[0].name);
						
						$("#xiehoutu").bind("click",function(){
							window.open(data.data[1].jumpurl);
						});
						if(data.data[1].imgurl.indexOf("http://") >= 0){
							$("#xh img").attr("src",data.data[1].imgurl);
						}else{
							$("#xh img").attr("src","${ctx}/"+data.data[1].imgurl);
						}
						$("#xiehou").html(data.data[1].name);
						
						$("#mitaocantingtu").bind("click",function(){
							window.open(data.data[2].jumpurl);
						});
						if(data.data[2].imgurl.indexOf("http://") >= 0){
							$("#mtct img").attr("src",data.data[2].imgurl);
						}else{
							$("#mtct img").attr("src","${ctx}/"+data.data[2].imgurl);
						}
						$("#mitaocanting").html(data.data[2].name);

					}			
			}
		);
	}
	
	//获取附近商家相关数据
	function getData(start,size,latitude,longitude){
		$.post("${ctx}/wxpage/getnearbymerchant",
				{
					"start":start,
					"size":size,
					"lat":latitude,
					"lon":longitude
				},
				function(data,status){
					hideload(); 
					hidemoreload();
					if(data.result == 0){
						if(start == 0){
							$("#liebiao").html('<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
							$("#jzgd").css("display","none");
							isall=1;
						}else{
							document.getElementById("jzgd").innerHTML = "已无更多";
							$("#jzgd").css("background-color","#efefed");
							isall=1;
						}
					}else{
						if(data.data.length < size){
							document.getElementById("jzgd").innerHTML = "已无更多";
							$("#jzgd").css("background-color","#efefed");
							isall=1;
						}else{
							$("#jzgd").css("display","block");
							isall=0;
						}
						Allstart = start+data.data.length;
						
					for(var i = 0;i < data.data.length;i++){
						var zhengshu;
						var onecost = data.data[i][3];
						if(onecost == null || onecost == '') {
							zhengshu = '';
						}else{
							zhengshu = '人均<span id="changecolor">￥'+parseFloat(data.data[i][3])+'</span>';
						}
						var juli = data.data[i][6]/1000.0+'';
						var index = juli.indexOf(".");
						juli = juli.substring(0,index+2)+"km";
						
						var logourl = data.data[i][1]+'';
						if(logourl != null){
							if(logourl.indexOf('http://') >=0 ) {
								
							}else{
								logourl = '${ctx}/' + logourl;
							}
						}
						
						var scorestr = '';
						var scorehui = '';
						var score = data.data[i][8];
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

						
						$("#liebiao").append('<div class="rowdiv">'
														+'<div id="beforecard1"></div>'
														+'<div id="card" onclick="showcard('+data.data[i][0]+')">'
															+'<div id="left">'
																+'<div>'
																	+'<img src="'+logourl+'">'
																+'</div>'
															+'</div>'
															+'<div id="right">'
																+'<div class="pbetweenright_middle">'
																	+'<div class="right_top">'
																		+'<div class="right_top1">'+(data.data[i][2] == null ? "" : data.data[i][2])
																		+'</div>'
																	+'</div>'
																	+'<div class="right_middle1">'
																		+'<div class="xingxing">'
																			+scorestr+scorehui
																			+'<div class="right_m11">'
																				+data.data[i][8]
																			+'</div>'
																		+'</div>'
																		+'<div class="right_m12">'+ zhengshu
																		+'</div>'
																	+'</div>'
																	+'<div class="right_middle2">'
																		+'<div class="right_m21">'+data.data[i][4]
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
																	+(data.data[i][7] == null ? "" : '<div class="right_down">')
																	+(data.data[i][7] == null ? "" :'<div class="right_d1">')
																		+(data.data[i][7] == null ? "" : '<img src="${ctx}/static/wxfile/main1601/image/quan.jpg">')
																	+'</div>'
																	+(data.data[i][7] == null ? "" :'<div class="right_d2">')+(data.data[i][7] == null ? "" : data.data[i][7] )
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
			});
	}
	
	function ms() {
		setCookie("groupid",1);
		setCookie("groupname",encodeURI(encodeURI('美食')));
		window.location.href="${ctx}/wxpage/mergroup";
	}
	function shfw() {
		setCookie("groupid",2);
		setCookie("groupname",encodeURI(encodeURI('生活服务')));
		window.location.href="${ctx}/wxpage/mergroup";
	}
	function xxyl() {
		setCookie("groupid",5);
		setCookie("groupname",encodeURI(encodeURI('休闲娱乐')));
		window.location.href="${ctx}/wxpage/mergroup";
	}
	function toqita()
	{
		setCookie("groupid","");
		setCookie("groupname","");
		window.location.href="${ctx}/wxpage/mergroup";
	}
	
	function showcard(id)
	{
		window.open("${ctx}/wxpage/merdetail?id="+id+"&token=token");
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
		$("#jzgd").css("display","none");
	}
	function hidemoreload()
	{
		$("#ddd2").css("display","none");
		$("#jzgd").css("display","block");
	}
	function go(id, type ,url,count)
	{
		setCookie("page",count,999999);
		if(type==1)
			{
			window.location.assign(url);
			}
		else
			{
			window.open("${ctx}/advert/getDetail/"+id);
			}
	}
</script>
</html>