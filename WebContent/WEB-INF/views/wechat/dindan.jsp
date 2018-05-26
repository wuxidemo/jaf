<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<title>我的订单</title>


<style type="text/css">
body {
	margin: 0;
	padding: 0;
	font-family: Microsoft YaHei;
	font-size: 14px;
	background-color: #F5F4F9;
}

.head {
	width: 100%;
	height: 40px;
	background-color: white;
}

.tabdiv {
	line-height: 40px;
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;
	border-bottom: 1px solid #EEEEEE;
	color: #727171;
	font-size: 18px;
}

.tabdiv:FIRST-CHILD {
	border-right: solid 1px #EEEEEE;
	width: 49%;
}

.tabact {
	height: 37px;
	border-bottom: 4px solid #f8ba1e;
	color: #f8ba1e;
}

.rowdiv {
	width: 100%;
	margin-top: 10px;
	background-color: white;
	color: #9F9F9F;
	border-top: 1px solid #EEEEEE;
}

.top {
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #EEEEEE;
	padding: 0px 15px;
}

.bottom {
	height: 40px;
	line-height: 40px;
	border-top: 1px solid #EEEEEE;
	padding: 0px 15px;
}

.dd {
	float: left;
	width: 80%;
	white-space: nowrap;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
}

.zt {
	float: left;
	width: 20%;
	text-align: right;
}

.middle {
	padding: 15px;
}

.content {
	width: 100%;
	display: table;
}

.logodiv {
	display: table-cell;
	width: 80px;
	position: relative;
}

.logodiv img {
	width: 80px;
	position: absolute;
	height: 67px;
}

.wzdiv {
	display: table-cell;
	height: 62px;
	padding-left: 20px;
}

.mername {
	font-size: 18px;
	color: black;
	margin-top: -1px;
}

.dealtime {
	margin-top: 2px;
	white-space: nowrap;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
}

.moneys {
	display: table;
	width: 100%;
	margin-top: 2px;
}

.money {
	display: table-cell;
}

.dpj {
	color: #f8ba1e;
}

.pjbtn {
	margin-top: 7px;
	float: right;
	text-align: center;
	width: 60px;
	height: 25px;
	line-height: 25px;
	color: #FE8642;
	border: 1px solid #FE8642;
	border-radius: 5px;
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
	margin-top: 15px;
	display: none;
}

#ddd11 {
	text-align: center;
	width: 100%;
	height: 30px;
	background-color: white;
	margin-top: 42px;
	display: none;
}

#ddd21 {
	text-align: center;
	width: 100%;
	height: 30px;
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

#ddd_kong1 {
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
	margin-top: 10px;
}

#jzgd1 {
	height: 35px;
	width: 100%;
	background-color: white;
	text-align: center;
	color: #eb621d;
	line-height: 35px;
	display: none;
	margin-top: 10px;
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
}

.ywgd1 {
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
</style>
</head>
<body style="margin: 0; padding: 0;" class="bodyi">
	<div class="head">
		<div class="tabdiv tabact now" onclick="showall()">全部</div>
		<div class="tabdiv history" onclick="showwait()">待评价</div>
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

	<div class="list1">
		<div class="ball-beat" id="ddd11" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>

		<div class="ball-beat" id="ddd_kong1" sss="a" style="display: none">
			<div></div>
			<div></div>
			<div></div>
		</div>


	</div>

	<div id="more" style="display: none">
		<div class="moreloading" id="ddd2" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>
		<div id="jzgd" onclick="getmore()">点击加载更多</div>
		<div class="ywgd">已无更多</div>
	</div>
	<div id="more1" style="display: none">
		<div class="moreloading" id="ddd21" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>
		<div id="jzgd1" onclick="getmore1()">点击加载更多</div>
		<div class="ywgd1">已无更多</div>
	</div>


	<div id="content" style="height: auto; overflow: hidden;"></div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>


<script>
	showloadstart();
	jQuery(document).ready(function() {
		showall();
		getlist();
		getlist1();
	});
	var openid = "${openid}";
	var size = 10;
	var start = 0;
	var isall = 0;

	var start1 = 0;
	var isall1 = 0;

	function showall() {
		$(".list").show();
		$(".list1").hide();
		$("#more").show();
		$("#more1").hide();
		start = 0;
		//hidemoreload1();
		$(".history").removeClass('tabact');
		$(".now").addClass('tabact');
	}

	function showwait() {
		start1 = 0;
		$(".now").removeClass('tabact');
		$(".history").addClass('tabact');
		$("#more1").show();
		$("#more").hide();
		$(".list1").show();
		$(".list").hide();
	//	hidemoreload();
	}

	function getmore() {
		if (isall == 0) {
			showmoreload();
			$("#jzgd").css("display", "none");
			getlist();
		}
	}

	function getlist() {
		$
				.post(
						'${ctx}/wxorder/getmypayorderlist',
						{
							'start' : start,
							'size' : size,
							'openid' : openid
						},
						function(dd) {

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
										$("#jzgd").show();
									}
								}
								for (var k = 0; k < length; k++) {
									if (dd.data[k][12].indexOf("http://") >= 0) {
										dd.data[k][12] = dd.data[k][12]
												+ '?imageView2/2/w/100';
									} else {
										dd.data[k][12] = '${ctx}/'
												+ dd.data[k][12];
									}

									var html = $('<div class="rowdiv"><div class="top"><div class="dd">订单号：'
											+ dd.data[k][4]
											+ '</div><div class="zt '
											+ (dd.data[k][13] == null ? 'dpj'
													: '')
											+ '">'
											+ (dd.data[k][13] == null ? '待评价'
													: '已评价')
											+ '</div></div><div class="middle"><div class="content"><div class="logodiv"><img src="'+dd.data[k][12]+'"></div><div class="wzdiv"><div class="mername">'
											+ dd.data[k][11]
											+ '</div><div class="dealtime">交易时间：'
											+ gettimestr(new Date(dd.data[k][1]))
											+ '</div><div class="moneys">交易金额：'
											+ (parseInt(dd.data[k][2]) / 100)
											+ '</div></div></div></div>'
											+ (dd.data[k][13] == null ? '<div class="bottom"><a onclick="gotopj('+dd.data[k][3]+','+dd.data[k][0]+',\''+openid+'\')" class="pjbtn">评价</a></div>'
													: '') + '</div>');
									html.appendTo($('.list'));

								}

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

	function getmore1() {
		if (isall1 == 0) {
			showmoreload1();
			$("#jzgd1").css("display", "none");
			getlist1();
		}
	}

	function getlist1() {
		$
				.post(
						'${ctx}/wxorder/getmypayorderlist',
						{
							'start' : start1,
							'size' : size,
							'openid' : openid,
							'judge' : 1
						},
						function(dd) {

							hideload1();
							hidemoreload1();
							if (dd.result == "1") {
								var length = dd.data.length;
								console.log("list length:" + length);
								if (length == 0) {
									if (start1 == 0) {
										// 第一次无数据   展示暂无数据提示
										$(".list1")
												.html(
														'<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
										$("#jzgd1").hide();
										isall1 = 1;
									} else {
										//展示 已无更多数据
										console.log("start!=0已无更多");
										$("#jzgd1").hide();
										$(".ywgd1").css("display", "block");
										isall1 = 1;
									}
									return;

								} else {
									if (length < size) {
										//展示 已无更多数据
										console.log("length<size已无更多"
												+ "length:" + length);
										$("#jzgd1").hide();
										$(".ywgd1").css("display", "block");
										isall1 = 1;
									} else {
										//点击加载更多		
										$("#jzgd1").show();
									}
								}
								for (var k = 0; k < length; k++) {
									if (dd.data[k][12].indexOf("http://") >= 0) {
										dd.data[k][12] = dd.data[k][12]
												+ '?imageView2/2/w/100';
									} else {
										dd.data[k][12] = '${ctx}/'
												+ dd.data[k][12];
									}

									var html = $('<div class="rowdiv"><div class="top"><div class="dd">订单号：'
											+ dd.data[k][4]
											+ '</div><div class="zt '
											+ (dd.data[k][13] == null ? 'dpj'
													: '')
											+ '">'
											+ (dd.data[k][13] == null ? '待评价'
													: '已评价')
											+ '</div></div><div class="middle"><div class="content"><div class="logodiv"><img src="'+dd.data[k][12]+'"></div><div class="wzdiv"><div class="mername">'
											+ dd.data[k][11]
											+ '</div><div class="dealtime">交易时间：'
											+ gettimestr(new Date(dd.data[k][1]))
											+ '</div><div class="moneys">交易金额：'
											+ (parseInt(dd.data[k][2]) / 100)
											+ '</div></div></div></div>'
											+ (dd.data[k][13] == null ? '<div class="bottom"><a class="pjbtn" onclick="gotopj('+dd.data[k][3]+','+dd.data[k][0]+',\''+openid+'\')">评价</a></div>'
													: '') + '</div>');
									html.appendTo($('.list1'));

								}

								start1 += size;
								console.log("jiaguode start:" + start);
							} else if (dd.result == "0") {

								if (start1 == 0) {
									$(".list1")
											.html(
													'<div class="nodatadiv"><img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
									$("#jzgd1").hide();
									$(".ywgd1").hide();
									isall1 = 1;
								} else {
									//展示 已无更多数据
									console.log("start!=0已无更多");
									$("#jzgd1").hide();
									$(".ywgd1").css("display", "block");
									isall1 = 1;
								}

							}
						});
	}
	function gotopj(merid,oderid,openid) {
		window.open('${ctx}/wxcommunity/mercommentparam?merid='+merid+'&orderid='+oderid+'&openid='+openid);
	}

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
		$("#jzgd").css("display", "block");
	}
	function hidemoreload() {
		$("#ddd2").css("display", "none");
		$("#jzgd").css("display", "none");
	}

	function showloadstart1() {
		$("#ddd_kong1").show();
	}
	function showload1() {
		$("#ddd11").css("display", "block");
	}

	function hideload1() {
		$("#ddd11").css("display", "none");
		$("#ddd_kong1").hide();
	}

	function showmoreload1() {
		$("#ddd21").css("display", "none");
		$("#jzgd1").css("display", "none");
	}
	function hidemoreload1() {
		$("#ddd21").css("display", "none");
		$("#jzgd1").css("display", "none");
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
		return year + "-" + month + "-" + day + " " + hours + ":" + mi;
	}
</script>
</html>