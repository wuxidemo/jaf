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
<title>全部</title>
<link type="text/css" href="${ctx}/static/wxfile/main1601/css/ms.css"
	rel="stylesheet" />
</head>
<body>
	<div id="all"></div>
<!-- 	<div class="kong"></div> -->
	<div id="xmbnwk">正在定位请稍后...</div>
	<div class="pot">
		<!--  <label class="image-replace cd-username" for="signup-username">sousuo</label> -->
		<img class="fdj" src="${ctx}/static/wxfile/main1601/image/fdj.png" />
		<input class="full-width has-padding has-border" id="signup-username"
			type="text" placeholder="请输入商家名称" />
	</div>

	<div class="top">
		<div class="top1" onclick="ms()">
			<img src="${ctx}/static/wxfile/main1601/image/jtgray.png" />
		</div>
		<div class="top2" onclick="qc()">
			全城<img src="${ctx}/static/wxfile/main1601/image/jtgray.png" />
		</div>
	</div>
	<div class="aa"></div>

	<div class="otl">
		<div class="ot1" id="0">全部</div>
	</div>
	<div class="otr">
		<!-- <div class="ot2" id="0">全部</div> -->
	</div>


	<div class="qc">
		<div class="qc1" id="0" style="color: rgb(248, 186, 30); background-color: rgb(225, 227, 225);" >全城</div>
	</div>

	<div class="card">
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
	<div id="jzgd" onclick="getmore()">点击加载更多</div>
	<div class="ywgd">已无更多</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	showload();
	var mylatitude = getCookie("dowijsylat"); //31.254789;
	var mylongitude = getCookie("dowijsylon"); //121.235647;
	var comid = getCookie("groupid");
	var comname = getCookie("groupname");
	var sonID = 0;
	var fatherID = 0;
	var shangquanID = 0;
	var searchMs = 1;
	var searchQc = 0;
	var isinit = 0; //是否已按cookie数据初始化过
	var start = 0;
	var size = 10;
	var isall = 0;
	var loc = 0;

	if (comid == '' && comname == '') {
		fatherID = 0;
		$(".top1")
				.html(
						"全部"
								+ '<img  src="${ctx}/static/wxfile/main1601/image/jtgray.png"/>');
	} else {
		fatherID = comid;
		//getdt(comid,0,0,mylatitude,mylongitude);
		$(".top1")
				.html(
						decodeURI(comname)
								+ '<img  src="${ctx}/static/wxfile/main1601/image/jtgray.png"/>');
		document.title = decodeURI(comname);
	}
	getdata();
	if (mylatitude != "" && mylongitude != "") {
		isinit = 1;

		getdt(sonID, fatherID, shangquanID, mylatitude, mylongitude);

	}

	$(document).ready(function() {

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
							getdt(sonID,fatherID,  shangquanID, mylatitude,
									mylongitude);
						} else {

						}
					},
					cancel : function() {
						loc = -1;
					}
				});
	});

	//左边父分类的列表
	function getdata() {
		/**	获取美食的父ID*/
		$
				.post(
						"/nsh/wxpage/getparentclassify",
						function(data) {
							var list = data.data;
							for (i = 0; i < list.length; i++) {
								var otsss = (list[i].id == fatherID ? "style='  color: rgb(248, 186, 30);  background-color: rgb(225, 227, 225);'"
										: "");
								$(".otl").append(
										'<div class="ot1" id="'+list[i].id+'" '+otsss+' >'
												+ list[i].name + '</div>');
							}

							$(".ot1")
									.click(
											function() {
												if (this.id == 0) {
													$(".ywgd").hide();
													$(".card").empty();
													$(".otr").css("display",
															"none");
													start = 0;
													isall = 0;
													getdt(0, 0, shangquanID,
															mylatitude,
															mylongitude);
													$(".ot1").css(
															"background-color",
															"white");
													$(".ot1").css("color", "");
													$(this).css(
															"background-color",
															"#e1e3e1");
													$(this).css("color",
															"#f8ba1e");
													$("body").css("position",
															"");
													start = 0;
													isall = 0;
													$(".otl").css("display",
															"none");
													setTimeout("setCount3()",
															300)
													$(".top1")
															.html(
																	$(this)
																			.text()
																			+ '<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>');
													isFirst = 0;

												} else {
													$(".ot1").css(
															"background-color",
															"white");
													$(".ot1").css("color", "");
													$(this).css(
															"background-color",
															"#e1e3e1");
													$(this).css("color",
															"#f8ba1e");
													$(".top1")
															.html(
																	$(this)
																			.text()
																			+ '<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>');
													
													fatherID=this.id;
													getsj(this.id);
												}

											});
						});

		/**	获取全城的ID*/
		$
				.post(
						'/nsh/wxpage/getbusinessgroup',
						function(data) {
							var sj = data.data;
							for (i = 0; i < sj.length; i++) {
								$(".qc").append(
										'<div class="qc1" '+(sj[i].id==0?'color: rgb(248, 186, 30); background-color: rgb(225, 227, 225);':'')+' id="'+sj[i].id+'">'
												+ sj[i].name + '</div>');

							}

							$(".qc1")
									.click(
											function() {
												$(".qc1").css(
														"background-color",
														"white");
												$(".qc1").css("color", "");
												$(this).css("background-color",
														"#e1e3e1");
												$(this).css("color", "#f8ba1e");
												$(".card").empty();
												start = 0;
												$(".ywgd").hide();
												isall = 0;
												setTimeout("setCount2()", 300)
												$(".top2")
														.html(
																$(this).text()
																		+ '<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>');
												$("body").css("position", "");
												shangquanID=this.id;
												getdt(sonID,fatherID,  shangquanID, mylatitude,
														mylongitude);
												isFirst = 0;
											})
						});

	}

	/**	获取美食的子ID*/
	//根据父分类列表获取子分类列表
	function getsj(myid) {
		// 	fatherID=id;
		//var faid=myid;
		$
				.post(
						'${ctx}/wxpage/getchildclassifybypid',
						{
							"pid" : myid
						},
						function(data) {
							$(".otr").css("display",
							"block");
							var zj = data.data;
							$(".otr").empty();
							$(".otr")
									.append('<div class="ot2" id="0">全部分类</div>');
							if (data.result == 0) {
								//$(".card")
									//	.html(
									//			'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
							//	$("#jzgd").hide();
								//isall = 1;
							} else {
								//isall = 0;
								for (i = 0; i < zj.length; i++) {
									$(".otr").append(
											'<div class="ot2" id="'+zj[i].id+'">'
													+ zj[i].name + '</div>');
								}
							}
								$(".ot2").click(
										function() {
											$(".ot2").css("background-color",
													"white");
											$(".ot2").css("color", "");

											$(this).css("background-color",
													"#e1e3e1");
											$(this).css("color", "#f8ba1e");
											setTimeout("setCount1()", 300)
											$("body").css("position", "");
											$(".card").empty();
											start = 0;
											$(".ywgd").hide();
											isall = 0;
											sonID=this.id;
											getdt(sonID,fatherID,shangquanID,
													mylatitude, mylongitude);
											isFirst = 0;
										});
							
						});
	}

	var isFirst=0;
	//显示总列表和显示右边子列表
	function getdt(myid, myfaid, mygid, latitude, longitude) {
		sonID = myid;
		fatherID = myfaid;
		shangquanID = mygid;
		if (mylatitude == "" && mylongitude == "") {
			$("#all").show();
			$("#xmbnwk").show();
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 1500);
			return;
		}
		$
				.post(
						'${ctx}/wxpage/getmerbyoption',
						{

							"lat" : latitude,
							"lon" : longitude,
							"start" : start,
							"size" : size,
							"pid" : myfaid,
							"cid" : myid,
							"bid" : mygid
						},
						function(data) {
							hideload();
							hidemoreload();
							var list = data.data;
							if (data.result == 1) {
								if (list.length == 0) {
									if (start == 0) {
										// 第一次无数据   展示暂无数据提示
										$(".card")
												.html(
														'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/images/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
										$("#jzgd").hide();
										isall = 1;
									} else {
										//展示 无更多数据
										$("#jzgd").hide();
										$(".ywgd").css("display", "block");
										isall = 1;
									}
									return;

								} else {
									if (list.length < size) {
										//展示 无更多数据
										$("#jzgd").hide();
										$(".ywgd").css("display", "block");
										isall = 1;
									} else {
										//点击加载更多								
									}
								}

								for (i = 0; i < list.length; i++) {
									var zhengshu;
									var onecost = data.data[i][3];
									if(onecost == null || onecost == '') {
										zhengshu = '';
									}else{
										zhengshu = '人均<span id="changecolor">￥'+parseFloat(data.data[i][3]).toFixed(1)+'</span>';
									}
									var juli = list[i][7] / 1000.0 + '';
									var index = juli.indexOf(".");
									juli = juli.substring(0, index + 2) + "km";
									
									if (list[i][1].indexOf("http://") >= 0) {

									} else {
										list[i][1] = '${ctx}/' + list[i][1];
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
									$(".card").append('<div class="rowdiv">'
																	+'<div id="beforecard1"></div>'
																	+'<div id="card" onclick="showcard('+list[i][0]+')">'
																		+'<div id="left">'
																			+'<div>'
																				+'<img src="'+list[i][1]+'">'
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
																					+'<div class="right_m12">'+ zhengshu
																					+'</div>'
																				+'</div>'
																				+'<div class="right_middle2">'
																					+'<div class="right_m21">'+list[i][5]
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
																				+(list[i][8] == null ? "" : '<div class="right_down">')
																				+(list[i][8] == null ? "" :'<div class="right_d1">')
																					+(list[i][8] == null ? "" : '<img src="${ctx}/static/wxfile/main1601/image/quan.jpg">')
																				+'</div>'
																				+(list[i][8] == null ? "" :'<div class="right_d2">')+(list[i][8] == null ? "" : list[i][8])
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
								start += size;
							 }else {
								if (isFirst == 0) {
									$(".ywgd").hide();
									$("#jzgd").hide();
									$(".card")
											.append(
													'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>');
								} else {
									$("#jzgd").hide();
									$(".ywgd").css("display", "block");
									isall = 1;
								}
							}

						});

	}

	function ms() {
		$(".qc").css("display", "none");
		$(".top2").css("color", "");
		$(".top2 img").attr("src",
				"${ctx}/static/wxfile/main1601/image/jtgray.png");
		$(".top1").css("color", "#f8ba1e");
		$(".top1 img").attr("src",
				"${ctx}/static/wxfile/main1601/image/jtyellow.png");
		$(".aa").css("display", "block");
		$('.kong').show();
		$("body").css("width", "100%");
		$(".otl").css("display", "block");

		$(".aa").click(
				function() {
					$(".top1").css("color", "");
					$(".top1 img").attr("src",
							"${ctx}/static/wxfile/main1601/image/jtgray.png");
					$(".aa").css("display", "none");
					$(".otl").css("display", "none");
					$(".otr").css("display", "none");
					$("body").css("position", "");
				})
	}

	function qc() {
		$(".otl").css("display", "none");
		$(".otr").css("display", "none");
		$(".top1").css("color", "");
		$(".top1 img").attr("src",
				"${ctx}/static/wxfile/main1601/image/jtgray.png");
		$(".top2").css("color", "#f8ba1e");
		$(".top2 img").attr("src",
				"${ctx}/static/wxfile/main1601/image/jtyellow.png");
		$(".aa").css("display", "block");
		$('.kong').show();
		$("body").css("width", "100%");
		$(".qc").css("display", "block");

		$(".aa").click(
				function() {
					$(".top2").css("color", "");
					$(".top2 img").attr("src",
							"${ctx}/static/wxfile/main1601/image/jtgray.png");
					$(".aa").css("display", "none");
					$(".qc").css("display", "none");
					$("body").css("position", "");
				})

	}
	
	$('.kong').click(function(){
		$('.otl').hide();
		$('.otr').hide();
		$('.qc').hide();
		$('.kong').hide();
		$(".aa").css("display", "none");
		$('body').css("position","");
	});
	
	function setCount2() {
		$(".top2").css("color", "#f8ba1e");
		$(".aa").css("display", "none");
		$(".qc").css("display", "none");
	}

	function setCount1() {
		$(".aa").css("display", "none");
		$(".otl").css("display", "none");
		$(".otr").css("display", "none");
		$(".ot2").css("background-color", "white");
		$(".ot2").css("color", "");

	}
	function setCount3() {
		$(".top1").css("color", "#f8ba1e");
		$(".aa").css("display", "none");

	}
	
	function getmore() {
		if (isall == 0) {
			showmoreload();

			if (searchMs == 1) {
				getdt(sonID,fatherID, shangquanID, mylatitude, mylongitude);
				isFirst = 1;
			}
			if (searchQc == 1) {
				getdt(sonID,fatherID, shangquanID, mylatitude, mylongitude);
				isFirst = 1;
			}

		}
	}
	function showcard(id)
	{
		window.open("${ctx}/wxpage/merdetail?id="+id+"&token=token");
	} 
	function showload() {
		$("#ddd1").css("display", "block");
	}

	function hideload() {
		$("#ddd1").css("display", "none");
	}
	
	function showmoreload() {
		$("#ddd2").css("display", "block");
		$("#jzgd").css("display", "none");
	}
	function hidemoreload() {
		$("#ddd2").css("display", "none");
		$("#jzgd").css("display", "block");
	}

	$(".fdj").bind("click", function() {
		setCookie("keyword",encodeURI(encodeURI($("#signup-username").val())));  
		window.location.href = "${ctx}/wxpage/mersearch";
	});
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
		document.cookie = key + "=" + val + ";expires=" + date.toGMTString()+";path=/";
	}
</script>
</html>