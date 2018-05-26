<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<title>社区金融</title>
<style type="text/css">
body {
	margin: 0;
	background-color: #eeeff0;
	font-family: Microsoft YaHei;
	font-size: 14px;
}

.mybody {
	margin: 0;
	font-family: Microsoft YaHei;
	font-size: 14px;
	background-color: #F5F4F9;
}

#card {
	overflow: hidden;
	width: 100%;
	margin: auto;
	background-color: white;
}
/**地址**/
.top {
	width: 100%;
	height: 35px;
	overflow: hidden;
	text-align: center;
	line-height: 35px;
	text-align: center;
	background-color: #eeeeee;
	color: #7a7070;
}

.top img {
	width: 17px;
}

.divimg img {
	width: 100%;
}

.address_list {
	position: absolute;
	overflow: auto;
	float: left;
	width: 100%;
	height: 145px;
	color: #7a7070;
	background-color: white;
	text-align: center;
	z-index: 999;
	display: none;
	color: #7a7070;
}

.address_list p {
	margin-top: 0;
	margin-bottom: 0;
	line-height: 35px;
}
/***/
#left {
	min-width: 76px;
	margin: auto;
	width: 30%;
	text-align: center;
	padding-top: 10px;
	padding-bottom: 10px;
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
	float: left;
	text-align: left;
	overflow: hidden;
	font-size: 19px;
	font-weight: bold;
	color: #f8ba1e;
	line-height: 80px;
}

.btmy {
	clear: both;
	width: 100%;
	height: 10px;
	background-color: #f8ba1e;
}

.btmg {
	clear: both;
	width: 100%;
	height: 10px;
	background-color: #e1e3e1;
}

.kong {
	width: 100%;
	height: 100%;
	background-color: #e1e3e1;
	position: absolute;
	opacity: 0.01;
	z-index: 3;
	display: none;
}
/***分页***/
#ddd1 {
	text-align: center;
	width: 100%;
	height: 30px;
	background-color: white;
	margin-top: 42px;
	display: none;
}

#ddd2 {
	text-align: center;
	width: 100%;
	height: 30px;
	background-color: white;
	margin-top: 15px;
	display: none;
}

#ddd_kong {
	position: fixed;
	width: 150px;
	height: 150px;
	top: 50%;
	margin-top: -75px;
	margin-left: -75px;
	left: 50%;
	text-align: center;
}

.ball-beat div {
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

.ball-beat>div:nth-child(2n-1) {
	-webkit-animation-delay: 0.35s !important;
	animation-delay: 0.35s !important;
}

.moreloading>div:nth-child(2n-1) {
	-webkit-animation-delay: 0.35s !important;
	animation-delay: 0.35s !important;
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
	/* 	margin-top:10px; */
	margin-bottom: 10px;
}

.nodatadiv {
	position: fixed;
	width: 150px;
	height: 150px;
	top: 50%;
	margin-top: -75px;
	margin-left: -75px;
	left: 50%;
	text-align: center;
}

.nodatadiv img {
	width: 120px;
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
/****/
/*******160415改版******/
.jrdiv {
	margin-bottom: 10px;
	padding: 15px;
	background-color: white;
}

.jrcontent {
	width: 100%;
	display: block;
	position: relative;
}

.contentimg {
	width: 100%;
	height: auto;
}

.countdiv {
	z-index: 22;
	position: absolute;
	top: 10px;
	right: 10px;
	color: white;
	background-color: rgba(3, 3, 3, 0.5);;
	overflow: hidden;
	padding: 3px 7px;
	border-radius: 10px;
}

.titlediv {
	bottom: 0;
	position: absolute;
	color: white;
	background-color: rgba(3, 3, 3, 0.5);;
	z-index: 22;
	width: 100%;
	height: 35px;
	display: table;
	line-height: 35px;
}

.content {
	display: table-cell;
	font-size: 18px;
	padding-left: 10px;
	height: 35px;
}

.time {
	display: table-cell;
	width: 90px;
	text-align: center;
	height: 35px;
}

.readcountimg {
	margin-right: 5px;
	width: 17px;
}

.timediv {
	background: url('${ctx}/static/wxfile/main1601/image/time.png') center
		no-repeat;
	width: 18px;
	display: table-cell;
	background-size: 75%;
	height: 35px;
	display: table-cell;
}
/****/
.goto {
	padding: 10px 20px;
    overflow: hidden;
    position: relative;
    background-color: #FFFFFF;
    margin-bottom: 10px;
}

.left {
	float: left;
    overflow: hidden;
    border-radius: 50%;
}
.left img{
	width: 55px;
}
.middle{
	float: left;
    width: 55%;
    margin-top: 3px;
    margin-left: 18px;
}
.shequkehu{
	font-size: 18px;
    color: #373737;
    border-bottom: 1px dashed #D1D2D3;
    margin-bottom: 2px;
    padding-bottom: 4px;
}
.dianci{
	color: 5dc8e8;
}
a:VISITED{
	text-decoration: none;
}
a:LINK{
	text-decoration: none;
}
.right {
	float: right;
    position: absolute;
    top: 50%;
    right: 20px;
    margin-top: -7px;
}
.right img{
	width: 10px;
}
</style>
</head>
<body>
	<!-- <div class="top"> -->
	<%-- 	全部社区<img src="${ctx}/static/wxfile/main1601/image/arrowg.png"> --%>
	<!-- </div> -->
	<!-- 	<div class="address_tip"></div> -->
	<!-- 	<div class="address_list"> -->
	<!-- 		<p id="0">全部社区</p> -->
	<!-- 	</div> -->
	<!-- 	<div class="kong"></div> -->
	<div class="goto" onclick="go()">
		<div style="width: 100%" >
			<div class="left">
				<img alt="" src="${ctx}/static/wxfile/main1601/image/jinrongtx.png">
			</div>
			<div class="middle">
				<div class="shequkehu">社区客户经理</div>
				<div class="dianci">点此联系</div>
			</div>
			<div class="right">
				<img alt="" src="${ctx}/static/wxfile/main1601/image/arrow.png">
			</div>
		</div>
	</div>
	<div class="list">
		<div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>

		<div class="ball-beat" id="ddd_kong" sss="a" style="display: none">
			<div></div>
			<div></div>
			<div></div>
		</div>
		<!-- 	<div id="card"> -->
		<%-- 		<div id="left"><img alt="" src="${ctx}/static/wxfile/main1601/image/byh.jpg"></div> --%>
		<!-- 		<div id="right">用农商行卡，优惠享不停</div> -->
		<!-- 		<div class="btmy"></div> -->
		<!-- 		<div class="btmg"></div> -->
		<!-- 	</div> -->



	</div>
	<div class="moreloading" id="ddd2" sss="a">
		<div></div>
		<div></div>
		<div></div>
	</div>
	<div id="jzgd" onclick="getmore()">点击加载更多</div>
	<div class="ywgd">已无更多</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/Clamp/clamp.js" type="text/javascript"></script>
<script type="text/javascript">
	//$("#ddd").css("width",$("#ddd").width()+"px");

	showloadstart();
	var obj;
	var objname;
	var size = 10;
	var start = 0;
	var isall = 0;
	var cookieCode = '${comid}';
	var cookieName = '${comname}';

	$(document).ready(function() {
		//console.log("cookie:"+cookieCode+cookieName);
		getlist();
		//var ddd1 = document.getElementById("ddd");
		//$clamp(ddd1, {
		//	clamp : 1,
		//	useNativeClamp : false
		//	});
	});
function go(){
	window.open("${ctx}/wxurl/tourl?url=wuye/managearea");
}
	function getmore() {
		if (isall == 0) {
			showmoreload();
			console.log("getmore start:" + start)
			getlist(obj);
		}
	}

	function getlist(commid) {
		$
				.post(
						'${ctx}/wxpage/getfinanceinfo',
						{
							'start' : start,
							'size' : size,
							'commid' : 1
						},
						function(dd) {
							console.log("commid:" + commid + " start:" + start);
							hideload();
							hidemoreload();
							if (dd.result == "1") {
								var length = dd.data.length;
								console.log("list length:" + length);
								if (length == 0) {
									if (start == 0) {
										// 第一次无数据   展示暂无数据提示
										$(".list")
												.html(
														'<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
										$("#jzgd").hide();
										isall = 1;
									} else {
										//展示 已无更多数据
										console.log("start!=0已无更多");
										$("#jzgd").hide();
										$(".ywgd").css("display", "block");
										isall = 1;
									}
									return;

								} else {
									if (length < size) {
										//展示 已无更多数据
										console.log("length<size已无更多"
												+ "length:" + length);
										$("#jzgd").hide();
										$(".ywgd").css("display", "block");
										isall = 1;
									} else {
										//点击加载更多								
									}
								}
								for (var k = 0; k < length; k++) {
									if (dd.data[k][2].indexOf("http://") >= 0) {
										dd.data[k][2] = dd.data[k][2]
												+ '?imageView2/2/w/500';
									} else {
										dd.data[k][2] = '${ctx}/'
												+ dd.data[k][2];
									}

									var html = $('<div class="jrdiv" onclick="showcard('
											+ dd.data[k][0]
											+ ')"><div class="jrcontent">	<img class="contentimg"	src="'
											+ dd.data[k][2]
											+ '"><div class="countdiv"><img class="readcountimg" src="${ctx}/static/wxfile/main1601/image/readcount.png">'
											+ (dd.data[k][3] == null ? 0
													: dd.data[k][3])
											+ '</div><div class="countbackdiv"></div><div class="titlediv"><div class="content" >'
											+ dd.data[k][1]
											+ '</div><div class="timediv"></div><div class="time" >'
											+ gettimestr(new Date(dd.data[k][4]))
											+ '</div></div></div></div>');
									html.appendTo($('.list'));

								}
								$(".content").each(function() {
									$clamp(this, {
										clamp : 1,
										useNativeClamp : false
									});
								});

								start += size;
								console.log("jiaguode start:" + start);
							} else if (dd.result == "0") {

								if (start == 0) {
									$(".list")
											.html(
													'<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
									$("#jzgd").hide();
									$(".ywgd").hide();
									isall = 1;
								} else {
									//展示 已无更多数据
									console.log("start!=0已无更多");
									$("#jzgd").hide();
									$(".ywgd").css("display", "block");
									isall = 1;
								}

							}
						});
	}
	$('.top').click(function() {
		$('.address_list').show();
		$('.kong').show();
		$('body').css("position", "fixed");
		$('body').css("width", "100%");
	});
	$('.kong').click(function() {
		$('.address_list').hide();
		$('.kong').hide();
		$('body').css("position", "");
	});

	function showcard(id) {
		window.open("/nsh/wxpage/jrdetail?id=" + id);
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
		date.setTime(date.getTime() + expiresDays);
		document.cookie = key + "=" + val + ";expires=" + date.toGMTString();
	}

	//加载
	function showloadstart() {
		$("#ddd_kong").show();
	}
	function showload() {
		$("#ddd1").css("display", "block");
	}

	function hideload() {
		$("#ddd1").css("display", "none");
		$("#ddd_kong").hide();
	}

	function showmoreload() {
		$("#ddd2").css("display", "block");
		$("#jzgd").css("display", "none");
	}
	function hidemoreload() {
		$("#ddd2").css("display", "none");
		$("#jzgd").css("display", "block");
	}
	function gettimestr(date) {
		var year = date.getFullYear();
		var month = (parseInt(date.getMonth()) + 1);
		if (month < 10) {
			month = "0" + month;
		}
		var day = date.getDate();
		if (day < 10) {
			day = "0" + day;
		}
		var hours = date.getHours();
		if (hours < 10) {
			hours = "0" + hours;
		}
		var mi = date.getMinutes();
		if (mi < 10) {
			mi = "0" + mi;
		}
		return year + "-" + month + "-" + day;
	}
</script>
</html>