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
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>编辑个人信息</title>
<link type="text/css"
	href="${ctx}/static/wxfile/newyear/css/waitereditinformation.css"
	rel="stylesheet" />
</head>
<body>
	<div id="all"></div>
	<div id="xmbnwk">姓名不能为空!</div>
	<div id="tjsb">
		<div id="tjsb_up">提交失败，请重</div>
		<div id="tjsb_down">新打开活动页面</div>
	</div>
	<div id="all_middle">
		<div id="all_middleup">
			<div id="sc">修改成功&nbsp;!</div>
		</div>
  		<div id="all_middlemiddle1">
  			<div id="gxtg">感谢您的投稿</div>
  		</div>
  		<div id="all_middlemiddle2">
  			<div id="guanzhu">后续活动请关注金阿福e服务微信平台&nbsp;!</div>
  		</div>
  		<div id="all_middledown">
				<div id="chakan">
					<button type="button" onclick="view()" id="check">查看</button>
				</div>
				<div id="fanhuishouye">
					<button type="button" onclick="returnhome()" id="return_home">返回首页</button>
				</div>
  		</div>
	</div>
	<div id="whole_head">
		<img src="../static/wxfile/newyear/image/shangchuan_head.png">
	</div>
	<form id="tijiaol">
		<div id="whole_middle">
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;:</div>
					<input id="xm" type="text" maxlength="5" onblur="nam()" name="name" value="${wtr.name}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">手机号码&nbsp;:</div>
					<input id="shouji" type="text" onblur="phone()" maxlength="11" name="telephone" value="${wtr.telephone}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">店铺名称&nbsp;:</div>
					<input id="dpmc" type="text" onblur="shopName()" maxlength="10" name="mername" value="${wtr.mername}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">个人心语&nbsp;:</div>
					<textarea id="grxy" type="textarea" maxlength="20"
					onblur="individual()" name="context">${wtr.context}</textarea>
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">个人工作照&nbsp;:</div>
					<div id="grgzz">
						<img id="tianjia" src="">					
					</div>
					<script>

					</script>
				</div>
			</div>
			<input id="a" name="url" onchange="tupian()" value="${wtr.url}">
			<div id="whole_foot">
				<button type="button" id="tijiao" onclick="djsc()">提交</button>
			</div>
		</div>
	</form>
</body>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'onMenuShareTimeline', 'openLocation',
				'onMenuShareAppMessage', 'chooseImage', 'uploadImage' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		initupload();
	});
	bindshow("#tianjia");
	$("#tianjia").attr("src","${wtr.url}?imageView2/2/w/300|imageMogr2/auto-orient");
	$("#tijiao").css("background-color","#ef2e2f");
});

function nam() {
	$("#xm").val();
	if (($("#xm").val()) == "") {
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "姓名不能为空!";
		$("#tijiao").css("background-color","#b5b5b5");
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}else{
		pd();
	}
}

function phone() {
	$("#shouji").val();
	if (($("#shouji").val()) == "") {
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "手机号码不能为空!";
		$("#tijiao").css("background-color","#b5b5b5");
		pd();
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}if (!(/^1[3|4|5|7|8][0-9]\d{4,8}$/i.test($("#shouji").val()))) {
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "手机号码格式不对!";
		$("#tijiao").css("background-color","#b5b5b5");
		pd();
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}else{
		pd();
	}
}

function shopName() {
	$("#dpmc").val();
	if(($("#dpmc").val()) == ""){
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "店铺名称不能为空!";
		$("#tijiao").css("background-color","#b5b5b5");
		pd();
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}else{
		pd();
	}
}

function individual() {
	$("#grxy").val();
	if(($("#grxy").val()) == ""){
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "个人心语不能为空!";
		$("#tijiao").css("background-color","#b5b5b5");
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}else{
		pd();
	}
}

function pdtp(){
	$("#a").val();
	if (($("#a").val()) == ""){
		$("#all").show();
		$("#xmbnwk").show();
		document.getElementById("xmbnwk").innerHTML = "检查是否上传图片";
		$("#tijiao").css("background-color","#b5b5b5");
		setTimeout(function() {
			$("#all").hide();
			$("#xmbnwk").hide();
		}, 3000);
		return false;
	}else{
		pd();
	}
}	

function tupian(){
	pd();
}

function pd(){
	if(($("#xm").val()) != "" && ($("#shouji").val()) != "" && ($("#dpmc").val()) != "" && ($("#grxy").val()) != "" && ($("#a").val()) != ""){
		$("#tijiao").css("background-color","#ef2e2f"); 
	} 
}
//获取设置上传参数
function djsc(param){
	if(nam() == false){
		return false;
	}
	if(phone() == false){
		return false;
	}
	if(shopName() == false){
		return false;
	}
	if(individual() == false){
		return false;
	}
	if(pdtp() == false){
		return false;
	}
	var options = {
		type : 'post',
		url : '${ctx}/waiter/upsave',
		dataType : 'json',
		success : function(data){
			if (data.result == 1) {
				$("#all").show();
				$("#all_middle").show();
			}
			if(data.result == 0){
				$("#all").show();
				$("#tjsb").show();
				$("#tjsb_up").show();
				$("#tjsb_down").show();
				document.getElementById("tjsb_up").innerHTML = "提交失败,请重";
				document.getElementById("tjsb_down").innerHTML = "新打开活动页面";
				setTimeout(function() {
					$("#all").hide();
					$("#tjsb").hide();
					$("#tjsb_up").hide();
					$("#tjsb_down").hide();
				}, 3000);
			}
			if(data.result == 2){
				$("#all").show();
				$("#tjsb").show();
				$("#tjsb_up").show();
				$("#tjsb_down").show();
				document.getElementById("tjsb_up").innerHTML = "编辑失败,请重";
				document.getElementById("tjsb_down").innerHTML = "新上传图片";
				setTimeout(function() {
					$("#all").hide();
					$("#tjsb").hide();
					$("#tjsb_up").hide();
					$("#tjsb_down").hide();
				}, 3000);
			}
		},
		error : function(data) {
			//alert(data);
		}
	};
	$('#tijiaol').ajaxForm(options);
	$('#tijiaol').submit();
}


function view() {
	window.location.href = "${ctx}/waiter/jump";
}

function returnhome() {
	window.location.href = "${ctx}/wxurl/redirect?url=waiter/";
}

function initupload() {
	$("#tianjia").bind(
			"click",
			function() {
				wx.chooseImage({
					count : 1, // 默认9
					sizeType : [ 'original', 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
					sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
					success : function(res) {
						var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
						wx.uploadImage({
							localId : localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
							isShowProgressTips : 1, // 默认为1，显示进度提示
							success : function(res) {
								var serverId = res.serverId; // 返回图片的服务器端ID
								$.post("${ctx}/waiter/saveimg?sid="
										+ serverId, function(d) {
									if (d == null) {
										$("#all").show();
										$("#xmbnwk").show();
										$("#xmbnwk").html("保存失败");
										setTimeout(function() {
											$("#all").hide();
											$("#xmbnwk").hide();
										}, 3000);
										return false;
									} else {
										var oImg = document
												.getElementById("tianjia");
										/**
										$("#grgzz").height($("#grgzz").width());
										oImg.onload=function(){
											if(oImg.width>oImg.height)
											{
											$("#grgzz img").css("height","100%");
											$("#grgzz img").css("left","50%");
											$("#grgzz img").css("top","0");
											$("#grgzz img").css("margin-left",   "-"+(oImg.width*$("#grgzz").width()/oImg.height/2)+"px");
											$("#grgzz img").css("width","auto");
											$("#grgzz img").css("margin-top", 0);
											}
											else
											{
											$("#grgzz img").css("width","100%");
											$("#grgzz img").css("top","50%");
											$("#grgzz img").css("left","0");
											$("#grgzz img").css("margin-top",   "-"+(oImg.height*$("#grgzz").width()/oImg.width/2)+"px");
											$("#grgzz img").css("height","auto");
											$("#grgzz img").css("margin-left", 0);
											}
										}
										**/
										oImg.src = d
										+ "?imageView2/2/w/300|imageMogr2/auto-orient";
										$("#a").val(d);
										tupian();
									}
								});
							}
						});
					}
				});
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