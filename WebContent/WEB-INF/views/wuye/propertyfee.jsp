<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" href="${ctx}/static/weui/weui.min.css" />
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family: Microsoft YaHei;
	background-color: #eeeff0;
	letter-spacing: 1px;
}

.rowdiv {
	padding: 10px 20px;
	background-color: white;
	margin-bottom: 10px;
	border-top: 1px solid #E1E1E1;
	border-bottom: 1px solid #E1E1E1;
	position: relative;
}

.table {
	width: 100%;
	display: table;
	height: 25px;
	line-height: 25px;
}

.table div:FIRST-CHILD {
	width: 85px;
}

.table-cell {
	display: table-cell;
}

.wjf {
	color: #FD605C;
}

.yjf {
	color: #149378;
}

.foot {
	position: fixed;
	height: 70px;
	bottom: 0;
	left: 0;
	width: 100%;
	border-top: 1px solid #E1E1E1;
	background-color: white;
}

.btns {
	width: 90%;
	height: 40px;
	text-align: center;
	margin: auto;
	line-height: 40px;
	margin-top: 15px;
}

.jf {
	width: 48%;
	float: left;
	background-color: #F9BA1F;
	color: white;
	height: 100%;
	border-radius: 5px;
}

.fk {
	width: 100%;
	height: 70px;
}

.xz {
	width: 48%;
	float: right;
	background-color: #5DC8E8;
	color: white;
	height: 100%;
	border-radius: 5px;
}

.xzhk {
	position: absolute;
	border: 1px solid #756F7B;
	width: 20px;
	height: 20px;
	right: 20px;
	top: 15px;
}

.gyz {
	background: url('${ctx}/static/wxfile/wuye/image/gouxuan.png') center
		no-repeat;
	background-size: 15px;
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
 	margin-top:10px; 
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

.weui_cells {
	font-size: 14px !important;
}

.weui_toast_content {
	padding: 0px 5px;
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
<title>物业缴费</title>
</head>
<body>
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
	<div class="fk"></div>

	<div class="foot">
		<div class="btns">
			<div class="jf" onclick="submit()">去缴费</div>
			<div class="xz" onclick="tonew()">新增用户</div>
		</div>
	</div>
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg weui_icon_warn"></i>
			<p class="weui_toast_content" id="toastcontent"></p>
		</div>
	</div>
	<div id="loadingToast" class="weui_loading_toast"
		style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<div class="weui_loading">
				<div class="weui_loading_leaf weui_loading_leaf_0"></div>
				<div class="weui_loading_leaf weui_loading_leaf_1"></div>
				<div class="weui_loading_leaf weui_loading_leaf_2"></div>
				<div class="weui_loading_leaf weui_loading_leaf_3"></div>
				<div class="weui_loading_leaf weui_loading_leaf_4"></div>
				<div class="weui_loading_leaf weui_loading_leaf_5"></div>
				<div class="weui_loading_leaf weui_loading_leaf_6"></div>
				<div class="weui_loading_leaf weui_loading_leaf_7"></div>
				<div class="weui_loading_leaf weui_loading_leaf_8"></div>
				<div class="weui_loading_leaf weui_loading_leaf_9"></div>
				<div class="weui_loading_leaf weui_loading_leaf_10"></div>
				<div class="weui_loading_leaf weui_loading_leaf_11"></div>
			</div>
			<p class="weui_toast_content">数据加载中</p>
		</div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/Clamp/clamp.js" type="text/javascript"></script>
<script type="text/javascript">
	//$("#ddd").css("width",$("#ddd").width()+"px");
	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	} 
	//else if (wechatInfo[1] < "6.0") {
	//	alert("本页面仅支持微信6.0以上版本");
	//}
	showloadstart();
	var obj;
	var objname;
	var size = 10;
	var start = 0;
	var isall = 0;
	var comid = '${comid}';
	var comname = '${comname}';
	var openid = '${openid}';
	$(document).ready(function() {
		getlist();
	});

	function submit() {

		var ids = "";
		$(".gyz").each(function() {
			ids += $(this).attr("feeid") + ",";
		});

		if (ids.endWith(",")) {
			ids = ids.substring(0, ids.length);
		}

		if (ids == "") {
			showalert("请选择需缴费的记录");
			return;
		}

		var data = {};

		data.openid = openid;
		data.ids = ids;
		$("#loadingToast").show();
		$.post("${ctx}/wxcommunity/feegetpay", data, function(d) {
			$("#loadingToast").hide();
			if (d.result == "1") {
				pay(d.appId, d.timeStamp, d.nonceStr, d.package1, d.signType,
						d.paySign);
			} else {
				showalert(d.msg, 1500);
			}
		});
	}

	function pay(appId, timeStamp, nonceStr, package1, signType, paySign) {
		WeixinJSBridge.invoke('getBrandWCPayRequest', {
			"appId" : appId, //公众号名称，由商户传入     
			"timeStamp" : timeStamp + "", //时间戳，自1970年以来的秒数     
			"nonceStr" : nonceStr, //随机串     
			"package" : package1,
			"signType" : signType, //微信签名方式:     
			"paySign" : paySign
		//微信签名 
		}, function(res) {
			if (res.err_msg == "get_brand_wcpay_request:ok") {
				window.open("${ctx}/wxurl/tourl?url=wuye/feeok");
			} else {
				window.open("${ctx}/wxurl/tourl?url=wuye/feefail");
			}
		});

	}

	function tonew() {
		window.open("${ctx}/wxcommunity/bindphone");
	}

	function getmore() {
		if (isall == 0) {
			showmoreload();
			getlist(obj);
		}
	}

	function getlist(commid) {
		$
				.post(
						'${ctx}/wxcommunity/getmyfee',
						{
							'start' : start,
							'size' : size,
							'openid' : openid
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

									// gy
									var html = $('<div class="rowdiv"><div class="table"><div class="table-cell">用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户：</div><div class="table-cell">'
											+ dd.data[k].build
											+ '号楼'
											+ dd.data[k].number
											+ '室</div></div><div class="table"><div class="table-cell">户&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;主：</div><div class="table-cell">'
											+ ((dd.data[k].householder == "" || dd.data[k].householder == null) ? ""
													: ('*' + dd.data[k].householder
															.substring(
																	1,
																	dd.data[k].householder.length)))
											+ '</div></div><div class="table"><div class="table-cell">联系方式：</div><div class="table-cell">'
											+ ((dd.data[k].telephone == ""
													|| dd.data[k].telephone == null || dd.data[k].telephone.length != 11) ? ""
													: (dd.data[k].telephone
															.substring(0, 3)
															+ '****' + dd.data[k].telephone
															.substring(
																	7,
																	dd.data[k].telephone.length)))
											+ '</div></div><div class="table"><div class="table-cell">应缴费用：</div><div class="table-cell">'
											+ dd.data[k].fee
											/ 100
											+ '元</div></div><div class="table"><div class="table-cell">缴费状态：</div><div class="table-cell '
											+ (dd.data[k].state == 0 ? 'wjf'
													: 'yjf')
											+ '">'
											+ (dd.data[k].state == 0 ? '未缴费'
													: '已缴费')
											+ '</div></div></div>');
									html.appendTo($('.list'));
									if (dd.data[k].state == 0) {
										var gxk = $('<div class="xzhk" feeid="'+dd.data[k].id+'" ></div>');
										gxk.bind("touchstart", function() {
											if ($(this).hasClass("gyz")) {
												$(this).removeClass("gyz");
											} else {
												$(this).addClass("gyz");
											}
										});
										gxk.appendTo(html);
									}

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

	function showalert(str, time) {
		$("#toastcontent").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, time == undefined ? 1500 : time);
	}
	String.prototype.endWith = function(s) {
		if (s == null || s == "" || this.length == 0 || s.length > this.length)
			return false;
		if (this.substring(this.length - s.length) == s)
			return true;
		else
			return false;
		return true;
	}
</script>
</html>