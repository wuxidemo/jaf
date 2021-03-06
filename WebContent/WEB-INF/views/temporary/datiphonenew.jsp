<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	
	<title>有奖问答</title>
	
</head>

<style>
body {
	font-family: "微软雅黑";
	margin:0;
	padding:0;
	background-color:#FCE1E6;
}
h1, a{
	font-color:#000;
}

div.content {
	width:100%;
	text-align: center;
}

div.titlediv {
	width:90%;
	margin:0 auto;
	margin-top:20px;
	margin-bottom:20px;
}

img.titleimg {
	width:100%
}

div.thxtip {
	width:90%;
	color:red;
	font-size:20px;
	font-weight: bold;
	margin:50px auto 20px;
	text-align:left;
}

div.inputdiv {

	width:90%;
	margin:10px auto;
	height:50px;
	text-align:left;
}

div.inputwrap {
	width:70%;
	height:50px;
	float:left;
}

div.btnwrap {
	width:30%;
	height:40px;
	float:left;
	color:white;
	line-height:40px;
	font-size:20px;
	text-align: center;
	background-color: red;
	border-top-right-radius:0.6em;
	border-bottom-right-radius:0.6em;
}

input.inputtext {
	height:40px;
	width:100%;
	border:none;
	font-size:20px;
	border-top-left-radius:0.6em;
	border-bottom-left-radius:0.6em;
}

/* input.subtn {
	height:40px;
	width:100%;
	border:none;
	border-radius:2%;
	color:white;
	font-size:20px;
	background-color: #FF0000;
	border-top-right-radius:0.6em;
	border-bottom-right-radius:0.6em;
} */

div.errormsg {
	width:90%;
	margin:10px auto;
	height:30px;
	font-size:16px;
	color:red;
	text-align:left;
	padding-left:10px;
}

div.role {
	width:90%;
	margin:0 auto;
	
	text-align:left;
	color:red;
	font-size:20px;
	font-weight:bold;
	
}

div.detail {
	
	width:90%;
	margin:10px auto 0;
	font-weight:bold;
	font-size:14px;
	text-align: left;
}

table{
	width:100%;
}

table > tr > td {
	height:30px;
	/* vertical-align: top !important; */
}

div.tail {
	width:100%;
	height:30px;
	background-color:#FFA904;
	
	margin-top:62px;
	margin-bottom:0px;
	/* position:fixed;
	left:0;
	right:0;
	bottom:0; */
}

</style>

<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	$(document).ready(function() {wx.config({
			debug : false,
			appId : '${config.appId}',
			timestamp : '${config.timestamp}',
			nonceStr : '${config.nonceStr}',
			signature : '${config.signature}',
			jsApiList : [ 'hideOptionMenu', 'showMenuItems',
					'onMenuShareTimeline' ]
		});
		wx.error(function(res) {
			//alert("加载错误:" + JSON.stringify(res));
		});
		wx.ready(function() {
			wx.hideOptionMenu();
		});
	});
	
</script>

<body>
	<div class="content">
		<div class="titlediv">
			<img alt="" src="${ctx}/static/11act/images/phonetitle.jpg" class="titleimg">
		</div>
		<div class="thxtip">
			小手一抖，10元话费到手，请填写手机号码 (仅限无锡地区号码有效)：
		</div>
		<div class="inputdiv">
			<div class="inputwrap">
				<input type="text" class="inputtext" id="inputtext" maxlength="11" />
			</div>
			<div class="btnwrap" onclick="thank()">
				提交
			</div>
		</div>
		<div class="errormsg">
			
		</div>
		<div class="role">
			领奖规则：
		</div>
		<div class="detail">
			<table>
				<tr>
					<td style="width:5%;vertical-align: top;">1.</td>
					<td style="width:95%;vertical-align: top;">输入正确手机号码，领取奖项，如填写错误，则无法领奖；</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">2.</td>
					<td style="width:95%;vertical-align: top;">手机号码归属地需为无锡，否则无效；</td>
				</tr>
				<tr>
					<td style="width:5%;vertical-align: top;">3.</td>
					<td style="width:95%;vertical-align: top;">10元话费会根据获奖用户所填手机号，在活动结束后7个工作日发放完毕；如填写不正确，则默认放弃奖项。</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="tail">
		
	</div>
	
<script type="text/javascript">

	$(document).ready(function(){
		$(".errormsg").html("");
		
		var checkdoneurl = "${ctx}/wxact/checkdone";
		$.post(checkdoneurl,function(data){
			if(data.result == '0') {
				window.location.href = '${ctx}/wxact/servey';
			}else if(data.result == '1') {
				
			}
		});
		
	});
	
	function thank() {
		var phonenum = $("#inputtext").val();
		
		if(phonenum.trim() == '') {
			$(".errormsg").html("请输入合法的手机号码");
			$("#inputtext").val("");
			$(".errormsg").focus();
			return false;
		}
		
		if(!testphone(phonenum)) {
			$(".errormsg").html("手机号码不合法，请重新输入");
			$("#inputtext").val("");
			$("#inputtext").focus();
			return false;
		}else{
			var checkurl = "${ctx}/wxact/checkphone";
			$.post(checkurl,{"phone":phonenum},function(data){
				if(data.result == '0') {
					$(".errormsg").html(data.msg);
					$("#inputtext").val("");
					$("#inputtext").focus();
					return false;
				}else{
					var suburl = "${ctx}/wxact/subphone";
					$.post(suburl,{"phone": phonenum},function(data){
						if(data.result == '1') {
							window.location.href="${ctx}/wxact/thankyou?phone="+phonenum;
						}else{
							$(".errormsg").html(data.msg);
							$("#inputtext").val("");
							$("#inputtext").focus();
						}
					});
				}
			});
			
		}
	}
	
	function testphone(phone) {
		var reg = new RegExp("^1[34578][0-9]{9}");
		return reg.test(phone);
	}
	
</script>
	
</body>
</html>