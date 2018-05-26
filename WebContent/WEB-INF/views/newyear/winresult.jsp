<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html >
<html>
<head>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="${ctx}/static/dd/themes/scale.css"
	type="text/css" />

<title>获奖</title>
<style type="text/css">
body {
	margin: 0;
	font-family: SimHei;
	color: #ff591f;
	font-size: 15px;
}

.head {
	width: 100%;
}

.head img {
	width: 100%;
	margin-top: -10px;
}

.backdiv {
	width: 90%;
	margin: auto;
	background-color: #fcf1dd;
	margin-top: 20px;
}

.winrow {
	width: 90%;
	margin: auto;
	border: solid 2px #ff591f;
	margin-top: 20px;
	background-color: white;
	border-radius: 5px;
	position: relative;
}

.row1 {
	width: 90%;
	height: 35px;
	line-height: 35px;
	margin: auto;
	position: relative;
	margin-top: 5px;
}

.left {
	width: 33%;
	float: left;
	text-align: center;
	height: 100%;
	text-align: left;
	font-weight: 900;
}

.right {
	width: 33%;
	float: left;
	height: 100%;
	text-align: right;
}

.center {
	width: 33%;
	float: left;
	height: 100%;
	text-align: center;
	font-weight: 900;
}

.left img {
	width: 80%;
}

.row2 {
	width: 90%;
	text-align: center;
	margin: auto;
	overflow: hidden;
}

.row3 {
	margin: auto;
	width: 90%;
	height: 25px;
	line-height: 25px;
	text-align: left;
	color: #555555;
	margin-bottom: 10px;
}

.first {
	position: absolute;
	width: 35px;
	top: -18px;
	z-index: 99;
	left: -16px;
}

.second {
	position: absolute;
	width: 35px;
	top: -14px;
	z-index: 99;
	left: -13px;
}

.third {
	position: absolute;
	width: 35px;
	top: -14px;
	z-index: 99;
	left: -13px;
}

.kong {
	width: 100%;
	height: 20px;
}

.nrdiv {
	width: 100%;
}

.zan {
	position: absolute;
	width: 22px;
	right: 40px;
	top: 4px;
}

.qtdiv {
	width: 90%;
	margin: auto;
	overflow: hidden;
}

.qtleft {
	width: 50%;
	float: left;
}

.qtright {
	width: 50%;
	float: left;
}

.qttitle {
	color: #555555;
	height: 25px;
	width: 100%;
}

.qtimg {
	width: 100%;
	padding-bottom: 100%;
	width: 100%;
	height: 0;
}

.qtimg img {
	width: 100%;
}

.qtcontent {
	width: 90%;
	margin-top: 20px;
	border-bottom: 1px solid #d3d3d3;
}

.qtright .qtcontent {
	float: right;
}

.cots {
	background-color: white;
	height: 33px;
	border-left: 1px solid #d3d3d3;
	border-right: 1px solid #d3d3d3;
	line-height: 35px;
}

.cleft {
	position: relative;
	height: 100%;
	width: 45%;
	float: left;
}

.cleft img {
	position: absolute;
	left: 6px;
	width: 20px;
	top: 5px;
}

.cleft div {
	position: absolute;
	left: 35px;
	top: -1px;
}

.cright {
	position: relative;
	height: 100%;
	
	color: #555555;
	text-align: right;
	width: 50%;
	float: left;
}

.cover {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: white;
	z-index: 999;
	display: none;
}

.show {
	width: 100%;
	z-index: 10000;
	background-color: white;
	display: none;
}

.show img {
	width: 100%;
}

.imgzoom_pack {
	width: 100%;
	height: 100%;
	position: fixed;
	left: 0;
	top: 0;
	background: rgba(0, 0, 0, .7);
	display: none;
	z-index: 9999;
}

.imgzoom_pack .imgzoom_x {
	color: #fff;
	height: 30px;
	width: 30px;
	line-height: 30px;
	background: #000;
	text-align: center;
	position: absolute;
	right: 5px;
	top: 5px;
	z-index: 1000;
	cursor: pointer;
}

.imgzoom_pack .imgzoom_img {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	overflow: hidden;
}

.imgzoom_pack .imgzoom_img img {
	width: 100%;
	position: absolute;
	top: 50%;
}

.imgdiv {
	padding-bottom: 50%;
	width: 50%;
	height: 0;
	float: left;
}

.textdiv {
	text-align: left;
	width: 45%;
	float: right;
	color: #555555;
}

.up {
	font-size: 18px;
	width: 100%;
}

.down {
	padding-bottom: 90%;
	width: 100%;
	height: 0;
	line-height: 20px;
	display: -webkit-box;
}
</style>
</head>
<body>
	<section class="imgzoom_pack">
		<div class="imgzoom_x">X</div>
		<div class="imgzoom_img">
			<img src="" />
		</div>
	</section>
	<div class="backdiv">
		<div class="head">
			<img src="${ctx}/static/wxfile/newyear/image/winhead.png">
		</div>
		<div id="wins">
			<div class="winrow w1">
				<img class="first" alt=""
					src="${ctx}/static/wxfile/newyear/image/first.png">
			</div>
			<div class="winrow w2">
				<img class="second" alt=""
					src="${ctx}/static/wxfile/newyear/image/second.png">
			</div>
			<div class="winrow w3">
				<img class="third" alt=""
					src="${ctx}/static/wxfile/newyear/image/third.png">
			</div>

		</div>
		<div class="kong"></div>
		<div class="qtdiv">
			<div class="qtleft"></div>
			<div class="qtright"></div>
		</div>
		<div class="kong"></div>
	</div>
	<div class="kong"></div>
	<!-- 
	<div class="cover">
		<div class="show">
			<img alt=""
				src="http://luyftest-10013419.image.myqcloud.com/c21e7e04-0a34-43f3-90b6-0b054331ae84">
		</div>
	</div>
 -->
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/lazyload/lazyload.js"></script>
<script src="${ctx}/static/scale/js/scale.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getdata();
		/**	$(".lzload").bind("click", function() {
				$(".show img").attr("src", $(this).attr("src"));
				$(".cover").show(); 

				new RTP.PinchZoom($(".show"), {});
				$(".show").show();
			});
		 **/
	});
	function getdata() {
		$
				.post(
						"${ctx}/newyearact/getwinlist",
						{
							collegestate : '${col}'
						},
						function(d) {
							if (d.result == "1") {
								var size = d.data.length > 6 ? 6
										: d.data.length;
								for (var i = 0; i < size; i++) {
									var mc;
									var zwmc;
									var wz = d.data[i][7];
									if (wz.length > 30) {
										wz = wz.substr(0, 26) + "...";
									}
									if (i == 0) {
										mc = "first";
										zwmc = "一等奖";
										$(".w1")
												.append(
														'<div class="row1"> <div class="left">'
																+ zwmc
																+ '</div><div class="center">'
																+ d.data[i][1]
																+ '</div><div class="right">	<img class="zan" src="${ctx}/static/wxfile/newyear/image/toupiaop.png"> '
																+ d.data[i][11]
																+ ' </div>	</div><div class="row2"><div class="imgdiv">	<img alt="" class="lzload" orsrc="'
																+ d.data[i][6]
																+ '" asrc="'
																+ d.data[i][6]
																+ '?imageView2/2/w/300"	src="${ctx}/static/wxfile/newyear/image/imgback.png"></div><div class="textdiv"><div class="up">作品介绍</div><div class="down" >'
																+ wz
																+ '</div></div></div><div class="row3">'
																+ d.data[i][5]
																+ '</div>');
									} else if (i == 1 || i == 2) {
										mc = "second";
										zwmc = "二等奖";
										$(".w2")
												.append(
														'<div class="row1"> <div class="left">'
																+ zwmc
																+ '</div><div class="center">'
																+ d.data[i][1]
																+ '</div><div class="right">	<img class="zan" src="${ctx}/static/wxfile/newyear/image/toupiaop.png"> '
																+ d.data[i][11]
																+ ' </div>	</div><div class="row2"><div class="imgdiv">	<img alt="" class="lzload" orsrc="'
																+ d.data[i][6]
																+ '" asrc="'
																+ d.data[i][6]
																+ '?imageView2/2/w/300"	src="${ctx}/static/wxfile/newyear/image/imgback.png"></div><div class="textdiv"><div class="up">作品介绍</div><div class="down" >'
																+ wz
																+ '</div></div></div><div class="row3">'
																+ d.data[i][5]
																+ '</div>');
									} else if (i == 3 || i == 4 || i == 5) {
										mc = "third";
										zwmc = "三等奖";
										$(".w3")
												.append(
														'<div class="row1"> <div class="left">'
																+ zwmc
																+ '</div><div class="center">'
																+ d.data[i][1]
																+ '</div><div class="right">	<img class="zan" src="${ctx}/static/wxfile/newyear/image/toupiaop.png"> '
																+ d.data[i][11]
																+ ' </div>	</div><div class="row2"><div class="imgdiv">	<img alt="" class="lzload" orsrc="'
																+ d.data[i][6]
																+ '" asrc="'
																+ d.data[i][6]
																+ '?imageView2/2/w/300"	src="${ctx}/static/wxfile/newyear/image/imgback.png"></div><div class="textdiv"><div class="up">作品介绍</div><div class="down" >'
																+ wz
																+ '</div></div></div><div class="row3">'
																+ d.data[i][5]
																+ '</div>');
									}

								}

								if (d.data.length > 6) {
									for (var i = 6; i < d.data.length; i++) {
										var html = '<div class="qtcontent"><div class="qttitle">'
												+ (i+1)
												+ d.data[i][5]
												+ '</div><div class="qtimg"><img class="lzload" orsrc="'
												+ d.data[i][6]
												+ '"	asrc="'
												+ d.data[i][6]
												+ '?imageView2/2/w/150"	src="${ctx}/static/wxfile/newyear/image/imgback.png"></div><div class="cots"><div class="cleft"><img alt="" src="${ctx}/static/wxfile/newyear/image/toupiaop.png"><div>'
												+ d.data[i][11]
												+ '</div></div><div class="cright">'
												+ d.data[i][1]
												+ '</div></div></div>';
										if (i % 2 == 0) {
											$(".qtleft").append(html);
										} else {
											$(".qtright").append(html);
										}
									}
								}
								lazyinit(".lzload");
								bindshow(".lzload", $(".row2").width());
								ImagesZoom.init({
									"elem" : ".row2"
								});
								ImagesZoom.init({
									"elem" : ".qtimg"
								});

							}

						});
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