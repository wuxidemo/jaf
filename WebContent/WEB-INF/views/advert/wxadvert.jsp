<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<!-- saved from url=(0136)http://www.weimob.com/weisite/detail?pid=5236&bid=10726&did=12327&wechatid=ospGBjhDYhG9USredsDnVhSthjec&from=list&wxref=mp.weixin.qq.com -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css"
	type="text/css" rel="stylesheet">
<link href="${ctx}/static/css/index.css" rel="stylesheet"
	type="text/css" />
<title>首页</title>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes">
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent">
<!-- Mobile Devices Support @end -->
<script type="text/javascript">
	var i = -1;
	var time = 0;
	var array = new Array();
	$(function() {
		getList();
		getMerchant();
		//setInterval("getMerchant()", 5700);
		junmper();
		time = setInterval("junmper()", 5700);
		$(".nav ul li").click(function() {
			i = $(this).index();
			$(".nav ul li").eq(i).addClass("bg").siblings().removeClass("bg");
			$(".pic ul li").eq(i).fadeIn();
			$(".pic ul li").eq(i).siblings().css({
				display : "none"
			});
			$(".pic ul li").eq(i).css({
				left : "100%"
			});
			$(".pic ul li").eq(i).animate({
				left : "0px"
			}, 500, function() {
			});

		});
		$(".nav ul li").hover(function() {
			clearInterval(time);
		}, function() {
			time = setInterval("junmper()", 5700);
		});
	});
	function junmper() {
		i++;
		if (i > 2)
			i = 0;
		$(".nav ul li").eq(i).addClass("bg").siblings().removeClass("bg");
		$(".pic ul li").eq(i).fadeIn();
		$(".pic ul li").eq(i).siblings().css({
			display : "none"
		});
		$(".pic ul li").eq(i).css({
			left : "100%"
		});
		$(".pic ul li").eq(i).animate({
			left : "0px"
		}, 500, function() {
		});

	}
	//获取新店推荐列表
	
	var categorystr = '${cvjsonstr}';
	var jsonobj = eval(categorystr);
	
	function getMerchant() {
		var url = '${ctx}/wxpage/getmerchant';
		$
				.post(
						url,
						function(data) {
							var merchant = data.data;
							var length = data.data.length;
							$("#tbody").children().remove();
							if (data.result) {
								var html = '<table>';
								for (var i = 0; i < length; i++) {
									var mername = merchant[i].name;
									var mernamelen = mername.length;
									if(mernamelen > 9) {
										mername = mername.substring(0,9) + "...";
									}
									
									var cvname = "";
									var mercvid = merchant[i].category;
									for(var j=0;j<jsonobj.length;j++) {
										if(jsonobj[j].id == mercvid) {
											cvname = jsonobj[j].value;
											break;
										}
									}
									if(cvname == '') {
										cvname = '其他';
									}
									
									var meraddress = merchant[i].address;
									var meraddresslen = meraddress.length;
									if(meraddresslen > 11) {
										meraddress = meraddress.substring(0,11) + "...";
									}
									
									html += '<tr><td><div style="width: 100%;  margin-top:-2px; margin-bottom:8px; font-weight: normal;border-bottom: 1px solid #cecece;">'
											+ '<div style="margin-top: 8px;margin-bottom: 8px;float:left;width: 35%;"><a href="${ctx}/wxpage/merdetail?id='
											+ merchant[i].id +'&token=noshake'
											+ '"><img  src="${ctx}/'+merchant[i].thumbnailurl+'" onerror="this.src=\'${ctx}/static/images/load1.png\'" width="220px"></div>'
											+ '<div style="float:right;width: 65%;margin-top:8px;margin-bottom:3px;">'
											+ '<div style="width: 100%; text-align:left;padding-top:3px;color:#000;font-size: 16px;">&nbsp&nbsp'
											+ mername
											+ '<div class="itemlabel">'+cvname+'</div></div>'
											+ '<div style="width: 100%; text-align:left;padding-top:10px;color:#787878;font-size: 16px;">&nbsp&nbsp<img style="width:15px;" src="/nsh/static/images/shdh.png">&nbsp'
											+ merchant[i].telephone
											+ '</div>'
											+ '<div style="width: 100%; text-align:left;padding-top:3px;color:#787878;font-size: 16px;">&nbsp&nbsp<img style="width:15px;" src="/nsh/static/images/shdd.png">&nbsp'
											+ meraddress
											+ '</div>'
											+ '</div></div></td></tr>';
								}
								html += '</table>';
								$("#tbody").html(html);
							}

						});
	}
	// 获取热门商户店铺
	function getList() {
		var type = 'nominate';
		var url = "${ctx}/advert/getList";
		$
				.post(
						url,
						{
							"type" : type
						},
						function(data) {
							if (data.result) {
								var advert = data.data;
								var length = advert.length;
								var html = '';
								for (var i = 0; i < length; i++) {
									if (advert[i].position == '1') {
										if (advert[i].title == '') {
											html = '<img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'">';
										} else {
											if (advert[i].content == '') {
												html = '<a href="javascript:;"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'"></a>';
											} else {
												html = '<a href="'+advert[i].content+'&token=noshake"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'" style="width:180px;height:160px;"></a>';
											}
										}
										$("#advert1").html(html);
									}
									if (advert[i].position == '2') {
										if (advert[i].title == '') {
											html = '<img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'">';
										} else {
											if (advert[i].content == '') {
												html = '<a href="javascript:;"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'"></a>';
											} else {
												html = '<a href="'+advert[i].content+'&token=noshake"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'" style="width:240px;height:80px;"></a>';
											}
										}
										$("#advert2").html(html);

									}
									if (advert[i].position == '3') {
										if (advert[i].title == '') {
											html = '<img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'">';
										} else {
											if (advert[i].content == '') {
												html = '<a href="javascript:;"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'"></a>';
											} else {
												html = '<a href="'+advert[i].content+'&token=noshake"><img  src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/load1.png\'" style="width:240px;height:80px;"></a>';
											}
										}
										$("#advert3").html(html);

									}
								}
							}
						});
	}
	function Load(src) {
		window.location.href = src;
	}
</script>
<style type="text/css">
#tablecontent {
	border-spacing: 0;
}

#advert1 {
	border-bottom: 1px solid #cecece;
}

#advert2 {
	border-left: 1px solid #cecece;
	border-bottom: 1px solid #cecece;
}

#advert3 {
	border-left: 1px solid #cecece;
	border-bottom: 1px solid #cecece;
}

img {
	border: 0;
	vertical-align: middle;
}

div.itemlabel {
	height:26x; 
	/* margin-right:5px; */
	border:1px orange solid;
	color:orange;
	display: inline-block;
	vertical-align: middle;
	border-radius:5px;
	position:absolute;
	right:10px;
}
</style>
<body onselectstart="return true;" ondragstart="return false;">
	<div class="weimob-page" style="display: block; overflow: auto;">
		<div id="content" class="weimob-content">
			<div id="header" class="header">
				<div class="pic">
					<ul>
						<c:forEach items="${adverts}" var="ad" varStatus="z">
						<%-- <a href=""> ${ctx}/advert/getDetail/${ad.id}</a> --%>
							<li><img
									class="img" src="${ctx}/${ad.img}">
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div style="background-color: #efefef;height: 35px;">
				<div
					style="float: left; width: 20px; margin-top: 5px; margin-left: 10px;">
					<img src="/nsh/static/images/rmsh.png">
				</div>
				<div style="   margin-left: 35px;margin-top: 7px;  position: absolute;">
					<span
						style=" font-family: fantasy;">热门商户</span>
				</div>
			</div>
			<div id="body" style="position: relative; margin-bottom: 50px;">
				<table id="tablecontent">
					<tr>
						<td id="advert1" rowspan="2">
							<img src="${ctx}/static/images/load2.png" onerror="this.src='${ctx}/static/images/load2.png'">
						</td>
						<td id="advert2">
							<img src="${ctx}/static/images/load1.png" onerror="this.src='${ctx}/static/images/load1.png'">
						</td>
					</tr>
					<tr>
						<td id="advert3">
							<img src="${ctx}/static/images/load1.png" onerror="this.src='${ctx}/static/images/load1.png'">
						</td>
					</tr>
				</table>
				<div style="background-color: #efefef;height: 35px;">
					<div
						style="float: left; width: 20px; margin-top: 6px; margin-left: 10px;">
						<img src="/nsh/static/images/xdtj.png">
					</div>
					<div style=" margin-left: 35px;margin-top: 7px;position: absolute;">
						<span
							style="font-family: fantasy;">新店推荐</span>
					</div>
				</div>
				<table id="tbody"
					style="text-align: center; width: 100%; height: 100px;">
				</table>
			</div>
		</div>
	</div>
	<div class="top_bar" style="background-color: #efefef">
		<nav>
			<ul id="top_menu" class="top_menu" >
				<li><a href="javascript:;"
					onclick="Load('${ctx}/advert/wxindex')"><img
						src="${ctx}/static/index/images/index_1_0.png"><label
						style="color: #2bc5b6; text-shadow: none;">首页</label></a></li>
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxpage/merlist')"><img
						src="${ctx}/static/index/images/index_2_1.png"><label
						style="color: white; text-shadow: none;">商家</label></a></li>
			<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxcard/cardlist')"><img
						src="${ctx}/static/index/images/index_3_1.png"><label
						style="color: white; text-shadow: none;">优惠</label></a></li>
			
				<li style="background-color: #2fdac3"><a href="javascript:;" onclick="Load('${ctx}/wxpage/my')"><img
						src="${ctx}/static/index/images/index_4_1.png"><label
						style="color: white; text-shadow: none;">我的</label></a></li>
			</ul>
		</nav>
	</div>
</body>
</html>