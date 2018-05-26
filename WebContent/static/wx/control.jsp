<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<!-- saved from url=(0136)http://www.weimob.com/weisite/detail?pid=5236&bid=10726&did=12327&wechatid=ospGBjhDYhG9USredsDnVhSthjec&from=list&wxref=mp.weixin.qq.com -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>遙控器</title>

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
<style>
body {
	margin: 0;
	background-image: url("${ctx}/static/wx/files/default/back.jpg");
	background-repeat: repeat;
	text-align: center;
}

button {
	width: 20%;
	height: 100px
}

.top {
	width: 100%;
	height: 20%;
	text-align: center;
	margin-top: 10px;
}

.center {
	width: 100%;
	height: 500px;
	height: 60%;
}

.foot1 {
	bottom: 30;
	width: 100%;
	height: 100px;
	position: absolute; 
	
}
.foot {
	width: 100%;
	height: 50px;
	position: absolute; 
	bottom: 0;
}

/**div {
	border: 1px solid #e3e3e3;
	border-radius: 4px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05) inset;
}*/
.center img {
	/**width: auto;
	height: 120px;
	*/
	
}

#sortable {
	display: inline-block;
	list-style-type: none;
	margin: 10px;
	padding: 0;
}

#sortable li {
	border: medium none;
	cursor: pointer;
	float: left;
	margin: 0;
	padding: 0;
	background-size: cover;
}

#loading-mask {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	z-index: 20000;
	background-color: rgba(0, 0, 0, 0.8);;
}

.loading {
	position: absolute;
	top: 20%;
	z-index: 20001;
	height: auto;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

.cdiv {
	margin-top: 10px;
	float: top;
	width: 100%;
	height: auto;
	float: top;
}

.cbtn {
border-radius: 8px;
	width: 40%;
	height: 50px;
	border: 1px solid rgba(0, 0, 0, 0.4);
	letter-spacing: 0.4em;
	 font-size: 30px;
	 color: white;
}
</style>
<link rel="stylesheet" type="text/css" href="${ctx}/static/phoneselect/css/styles.css" />
<body onselectstart="return true;" ondragstart="return false;">
	<div id="content"
		style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 100%; height: auto">
		<div class="top">
			<ul id="sortable" style="width: 280px;" class="sortable">
				<li key="cmd_mute"
					style="background-image: url('${ctx}/static/wx/files/default/novol.png'); width: 55px; height: 55px"></li>
				<li style="width: 10px; height: 10px"></li>
				<li key="cmd_vol_down"
					style="background-image: url('${ctx}/static/wx/files/default/vol_left.png');width:75px;height:55px;"></li>
				<li key="cmd_vol_up"
					style="background-image: url('${ctx}/static/wx/files/default/vol_right.png'); width: 75px; height: 55px"></li>
				<li style="width: 10px; height: 10px"></li>
				<li key="cmd_home"
					style="background-image: url('${ctx}/static/wx/files/default/home.png');width:55px;height:55px"></li>

			</ul>
		</div>
		<div class="center" style="margin-top: 4%">
			<ul id="sortable" style="width: 252px;" class="sortable">
				<li style="background-image: url(''); width: 61px; height: 61px"></li>
				<li key="cmd_up"
					style="background-image: url('${ctx}/static/wx/files/default/up.png');width:130px;height:61px"></li>
				<li style="background-image: url(''); width: 61px; height: 61px"></li>
				<li key="cmd_left"
					style="background-image: url('${ctx}/static/wx/files/default/left.png');width:61px;height:130px"></li>
				<li key="cmd_ok"
					style="background-image: url('${ctx}/static/wx/files/default/ok.png');width:130px;height:130px"></li>
				<li key="cmd_right"
					style="background-image: url('${ctx}/static/wx/files/default/right.png');width:61px;height:130px"></li>
				<li style="background-image: url(''); width: 61px; height: 61px"></li>
				<li key="cmd_down"
					style="background-image: url('${ctx}/static/wx/files/default/down.png');width:130px;height:61px"></li>
				<li style="background-image: url(''); width: 61px; height: 61px"></li>

			</ul>



		</div>
		<div class="foot1" style="text-align: center;">

			<ul id="sortable" style="width: 280px;" class="sortable">
				<li key="cmd_menu"
					style="background-image: url('${ctx}/static/wx/files/default/menu.png'); width: 100px; height: 46px;"></li>
				<li style="width: 80px; height: 10px"></li>
				<li key="cmd_back"
					style="background-image: url('${ctx}/static/wx/files/default/return.png');width: 100px; height: 46px;"></li>

			</ul>
			
		</div>
		<div class="foot" style="text-align: center;background-image: url('${ctx}/static/wx/files/footback.jpg');background-repeat: repeat;">
		<div style="margin-top:15px">
		<span id="mytitle" style="height:100%">未连接</span>
		</div>

		
		</div>
	</div>
	<div id='loading-mask' style="display:none">
		<div id="loading" class="loading" style="display:none">
			<div class="cdiv">
				<span id="mytip" style="color: white; font-size: 30px">请输入智家宝IP地址</span>
			</div>
			<div class="cdiv">
				<input id="myip" onfocus="ipfocuson()" style="width: 80%; font-size: 40px;border-radius: 8px;"  placeholder="192.168.1.1">
			</div>
			<div class="cdiv">
				<input type="button" style="background-color:#4d90fe;" class="cbtn" value="确认" onclick="checkone()">
				<input type="button" style="background-color:#d84a38;" class="cbtn" value="取消" onclick="hideFail()">
			</div>
			<div class="cdiv">
				<span id="mycon" style="color: white; font-size: 30px;display: none">连接中...</span>
			</div>
		</div>
	</div>
	<div id="choise" class="loading" style="top: 10%;display: none">
				<div class="cdiv">
				<select id="myselect" name="fancySelect" class="makeMeFancy">
        	<!-- Notice the HTML5 data attributes -->
         </select>
			</div>
		</div>

</body>
	<script src="${ctx}/static/phoneselect/jquery-1.4.3.min.js"></script>
<script src="${ctx}/static/phoneselect/js/script.js"></script>
<script>
	var mydeviceip = "";
	//预加载点击效果图片 
	new Image().src = '${ctx}/static/wx/files/click/power.png';
	new Image().src = '${ctx}/static/wx/files/click/novol.png';
	new Image().src = '${ctx}/static/wx/files/click/vol_left.png';
	new Image().src = '${ctx}/static/wx/files/click/vol_right.png';
	new Image().src = '${ctx}/static/wx/files/click/home.png';
	new Image().src = '${ctx}/static/wx/files/click/up.png';
	new Image().src = '${ctx}/static/wx/files/click/left.png';
	new Image().src = '${ctx}/static/wx/files/click/ok.png';
	new Image().src = '${ctx}/static/wx/files/click/right.png';
	new Image().src = '${ctx}/static/wx/files/click/down.png';
	new Image().src = '${ctx}/static/wx/files/click/menu.png';
	new Image().src = '${ctx}/static/wx/files/click/return.png';
var time=10000;
var step=1000;
	$(document).ready(
			function() {
				//绑定触摸事件
				$("li").bind(
						"touchstart",
						function() {
							var url = $(this).css("background-image").replace(
									"default", "click");
							$(this).css("background-image", url);
							go($(this).attr("key"));
						});
				//$("li").bind("mousedown", function() {
				//go($(this).attr("key"));
				//});
				//绑定触摸离开事件
				$("li").bind(
						"touchend",
						function() {
							var url = $(this).css("background-image").replace(
									"click", "default");
								$(this).css("background-image", url);
						});

				$.post("${ctx}/api/mydevices", function(data) {
					if (data && data.result == "1") {
						settitle("设备连接中...");
						checkOK(data.ips);
					} else {
						showFail();
					}
				});
				
				//$('select.makeMeFancy').bind("change",function (){
				//	alert($(this).val());
				//});
			});
	//无设备 填写IP界面
	function showFail() {
		$("#loading-mask").css("display", "");
		$("#loading").css("display", "");
	}
	function hideFail() {
		$("#loading-mask").css("display", "none");
		$("#loading").css("display", "none");
	}
	function showChoise() {
		$("#loading-mask").css("display", "");
		$("#choise").css("display","");
	}
	function hideChoise() {
		$("#loading-mask").css("display", "none");
		$("#choise").css("display","none");
	}
	var alldata = [];
	var allips;
	//检查获取到的设备是否能链接
	function checkOK(ips) {
		alldata = [];
		allips=ips;
		for (var i = 0; i < ips.length; i++) {

			$.ajax({
				url : "http://" + ips[i].lanip + ":7968/remotekey?key="
						+ i,
				type : 'POST',
				success : function(d) {

					alldata.push(ips[d]);
				}
			});
		}
		time=5000;
		checkData();
		//setTimeout("checkData()", 10000);
		//return ok;
	}
	function ipfocuson()
	{
		$("#mytip").html("请输入智家宝IP地址");
		$("#mytip").css("color", "white");
		$("#myip").select();
	}
	function checkone()
	{
		var ip=$("#myip").val();
		if(!isIP(ip))
			{
			$("#mytip").html("请输入正确的IP地址!");
			$("#mytip").css("color", "red");
			return;
			}
		$("#mycon").css("display","");
		$("#mycon").html("连接中...");
		$.ajax({
			url : "http://" + ip + ":7968/remotekey?key="
					+ "1",
			type : 'POST',
			timeout:2000,
			success : function(d) {
						//alert(document.title);
				//document.title = "我的智家宝";
				settitle("我的智家宝");
				mydeviceip = ip;
				hideFail();
			},
			error:function()
			{
				$("#mycon").html("连接失败...");
			}
		});
	}
	function isIP(ip)   
	{   
	    var re =  /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/   
	    return re.test(ip);   
	}  
	function checkData() {
		
		if(alldata.length!=allips.length)
		{
		
		if(time!=0)
		{
			setTimeout("checkData()",step);
			time-=step;
			return;
		}
		}
		
		if (alldata.length == 0) {
			settitle("设备连接失败...");
			showFail();
		} else if (alldata.length == 1) {
		
		settitle(alldata[0].name + "的智家宝");
			//document.title = alldata[0].name + "的智家宝";
			mydeviceip = alldata[0].lanip;
			//hidezzc();
		} else {
			for(var i=0;i<alldata.length;i++)
				{
				$("#myselect").append("<option value=\""+alldata[i].lanip+"\" data-icon=\"${ctx}/static/images/box.png\" data-html-text=\""+alldata
[i].name+"的智家宝&lt;i&gt;"+alldata[i].lanip+"&lt;/i&gt;\">"+alldata[i].name+"的智家宝</option>")
				}
			initselect();
			settitle("选择设备");
			showChoise();
		}
	}
	String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
		if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
			return this.replace(
					new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
					replaceWith);
		} else {
			return this.replace(reallyDo, replaceWith);
		}
	}
	function go(cmd) {
		if (mydeviceip != "") {
			$.ajax({
				url : "http://" + mydeviceip + ":7968/remotekey?code=" + cmd,
				type : 'POST',

				success : function(data) {
				},
				error : function(data) {
				}
			});
		}
	}
	function _loadScript(url) {

		var script = document.createElement('script');
		script.async = true;
		script.src = url;
		$(script).on('load error', function(e, errorType) {
			$(script).off().remove();
		});
		document.head.appendChild(script);
	}
	function onchoiseend(name,ip)
	{
		mydeviceip=ip;
		//alert(document.title);
		settitle(name);
		//document.title = name;
		hideChoise();
		bindclick();
		//alert("asdads");
	}
function bindclick()
{
$("#mytitle").bind("touchend",function(){
						showChoise();
				});
				$("#mytitle").bind("click",function(){
						showChoise();
				});
}

	function settitle(str)
	{
		$("#mytitle").html(str);
		//document.title = str;
//	var $body = $('body');
	
// hack在微信等webview中无法修改document.title的情况
//	var $iframe = $('<iframe src="${ctx}/static/wx/files/click/power.png"></iframe>').on('load', function() {
//	setTimeout(function() {
//	$iframe.off('load').remove()
	//	}, 0)
	//	}).appendTo($body)
	}
</script>
</html>