<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<title>金融网格管理</title>
<style type="text/css">
body {
	margin: 0;
	background-color: #eeeff0;
	font-family: Microsoft YaHei;
	font-size: 14px;
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

.rowdiv {
	width: 100%;
	padding: 10px 0px;
	display: table;
	background-color: white;
	margin-bottom: 10px;
}

.left {
	display: table-cell;
	width: 90px;
	height: 60px;
	text-align: center;
	position: relative;
}

.left img {
	position: absolute;
	width: 60px;
	height: 60px;
	left: 15px;
}

.right {
	line-height: 30px;
	display: table-cell;
}

.top {
	width: 100%;
	border-bottom: 1px dashed #e1e3e1;
	word-break: break-all;
}

.bottom {
	width: 100%;
	display: table;
	padding-top: 3px;
}

.fzr {
	border-right: 1px solid #e1e3e1;
	display: table-cell;
}

.tel {
	width: 60px;
	display: table-cell;
	background: url('${ctx}/static/wxfile/wuye/image/managephone.png')
		center no-repeat;
	background-size: 20px;
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

	//showloadstart();
	var obj;
	var objname;
	var size = 10;
	var start = 0;
	var isall = 0;
	//	var cookieCode = '${comid}';
	//	var cookieName = '${comname}';

	$(document).ready(function() {
		getlist();

	});

	function getmore() {
		if (isall == 0) {
			showmoreload();
			console.log("getmore start:" + start)
			getlist();
		}
	}

	function getlist() {
		$
				.post(
						'${ctx}/wxcommunity/seachwangge',
						{
							'start' : start,
							'size' : size
							
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
									}
								}
								for (var k = 0; k < length; k++) {
									

									var html = $('<div class="rowdiv"><div class="left"><img src="'+dd.data[k].logourl+'?imageView2/2/w/300"></div><div class="right"><div class="top">'+dd.data[k].area+
									'</div><div class="bottom"><div class="fzr">负责人:'+dd.data[k].name+'</div><a class="tel" href="tel:'+dd.data[k].telephone+'"></a></div></div></div>');
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