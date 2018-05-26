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
	background-color: #FDE2E7;
	margin:0;
	border:0;
}

h1, a{
	font-color:#000;
}

div.content {
	width:100%;
	text-align: center;
	filter:alpha(opacity=80); 
	-moz-opacity:0.8; 
	opacity:0.8;
}

div.item {
	width:100%;
}

div.question {
	width:100%;
	margin-top:10px;
	margin-bottom:10px;
	font-size:18px;
	/* height:60px; */
}

div.questionindex {
	width:8%;
	display:inline-block;
	vertical-align: top !important;
	font-weight: bold;
	
	/* height:100px; */
}

div.questiontitle {
	width:90%;
	display:inline-block;
	text-align:left !important;
	font-weight: bold;
	
	/* height:100px; */
}

div.answer {
	width:90%;
	margin:auto;
	text-align:left !important;
	font-size:20px;
}


div.actbtn {
	width:100%;
	text-align: center;
	margin-top:30px;
}

.subtn {
	width:80%;
	height:40px;
	border:none; 
	font-size: 20px;
	border-radius:2%;
	background-color: #FF0000;
	color:white; 
	margin:30px auto 0; 
	border-radius:0.6em;
	box-shadow:none !important;
	text-shadow:none !important;
}

div.maskall {
	position:fixed;
	left:0px;
	top:0px;
	bottom:0px;
	right:0px;
	display:none;
	background-color: #000;
	filter:alpha(opacity=80); 
	-moz-opacity:0.8; 
	opacity:0.8;
	
	z-index:50;
}

div.tipmask {
	position:fixed;
	left:0px;
	top:0px;
	bottom:0px;
	right:0px;
	z-index:60;
	display:none;
}

div.msgcon {
	width:220px;
	height:180px;
	margin:180px auto;
	background-color: #FFFFFF;
	position:relative;
	z-index:100;
	border-radius:0.6em;
	
	filter:alpha(opacity=100); 
	-moz-opacity:1; 
	opacity:1;
}

div.tipmsg {
	position:relative;
	width:220px;
	height:80px;
	line-height:80px;
	padding-left:20px;
	font-size:18px;
	color:red;
}

div.surebtndiv {
	position:relative;
	width:220px;
	height:100px;
	text-align: center;
}

.errbtn {
	position:relative;
	width:80%;
	height:40px;
	border:none; 
	border-radius:2%;
	background-color: #FF0000;
	color:white; 
	margin-top:48px;
	font-size: 20px;
	box-shadow:none !important;
	text-shadow:none !important;
	border-radius:0.6em;
}


/**************************/

.backred {
	background-color: red;
}

div.option {
	height:30px;
	line-height:30px;
	margin:30px 0;
}


div.little {
	width:30px;
	height:30px;
	display:inline-block;
	border:1px solid red;
	border-radius:50%;
}


div.opcon {
	height:30px;
	line-height:30px;
	font-size:14px;
	display:inline-block;
}

table {
	width:100%;
}

td {
	padding:10px 0 !important;
	font-size:16px;
}


/************************/

div.imgdiv {
	width:100%;
}

img.imgcon {
	width:100%;
}

div.tail {
	width:100%;
	height:30px;
	/* margin-top:92px; */
	background-color:#FFA904;
	
	position:fixed;
	left:0px;
	bottom:0px;
	right:0px;
}

</style>

<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">

	var wechatInfo = navigator.userAgent.match(/MicroMessenger\/([\d\.]+)/i);
	if (!wechatInfo) {
		alert("本活动仅支持微信");
	}
	$(document).ready(function() {
		
		wx.config({
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

	<div class="maskall"></div>
	
	<div class="tipmask">
		<div class="msgcon">
			<div class="tipmsg">
				
			</div>
			<div class="surebtndiv">
				<button class="errbtn" onclick="dispear()">确定</button>
			</div>
		</div>
	</div>
	
	
	
	<div class="content">
	
		<div class="imgdiv">
			<img alt="" src="${ctx}/static/11act/images/1.jpg" class="imgcon">
		</div>
	
		<div class="item" id="item1">
			<div class="question">
				<div class="questionindex">
					1.
				</div>
				<div class="questiontitle">
					无锡城市吉祥物的名字叫什么？
				</div>
			</div>
			<div class="answer">
				
				<table>
					<tr class="option">
						<td style="width:30px;vertical-align: top;"><div class="little" name="q1" value="1">&nbsp;</div></td>
						<td style="text-align: left;">阿福阿喜</td>
					</tr>
					<tr class="option">
						<td style="vertical-align: top;"><div class="little" name="q1" value="2">&nbsp;</div></td>
						<td style="text-align: left;">福宝宝</td>
					</tr>
				</table>
			</div>
			<div class="actbtn">
				<button class="subtn" id="q1btn">下一题</button>
			</div>
		</div>
		
		<div class="item" id="item2" style="display:none;">
			<div class="question">
				<div class="questionindex">
					2.
				</div>
				<div class="questiontitle">
					无锡农村商业银行的金阿福借记卡跨行ATM取现（同城）需要手续费吗？
				</div>
			</div>
			<div class="answer">
			
				<table>
					<tr class="option">
						<td style="width:30px;vertical-align: top;"><div class="little" name="q2" value="1">&nbsp;</div></td>
						<td style="text-align: left;">需要</td>
					</tr>
					<tr class="option">
						<td style="vertical-align: top;"><div class="little" name="q2" value="2">&nbsp;</div></td>
						<td style="text-align: left;">不需要</td>
					</tr>
				</table>
			</div>
			<div class="actbtn">
				<button class="subtn" id="q2btn">下一题</button>
			</div>
		</div>

		<div class="item" id="item3" style="display:none;">
			<div class="question">
				<div class="questionindex">
					3.
				</div>
				<div class="questiontitle">
					
					无锡市民卡具有公交卡、医保卡、银行卡等功能，市民卡合作银行是无锡农村商业银行吗？
				</div>
			</div>
			<div class="answer">
			
				<table>
					<tr class="option">
						<td style="width:30px;vertical-align: top;"><div class="little" name="q3" value="1">&nbsp;</div></td>
						<td style="text-align: left;">是</td>
					</tr>
					<tr class="option">
						<td style="vertical-align: top;"><div class="little" name="q3" value="2">&nbsp;</div></td>
						<td style="text-align: left;">不是</td>
					</tr>
				</table>
			</div>
			<div class="actbtn">
				<button class="subtn" id="q3btn">下一题</button>
			</div>
		</div>
		
		<div class="item" id="item4" style="display:none;">
			<div class="question">
				<div class="questionindex">
					4.
				</div>
				<div class="questiontitle">
					金阿福e服务平台疯狂双11系列活动中拼人气的最大奖项是什么？
				</div>
			</div>
			<div class="answer">
			
				<table>
					<tr class="option">
						<td style="width:30px;vertical-align: top;"><div class="little" name="q4" value="1">&nbsp;</div></td>
						<td style="text-align: left;">iPhone 6</td>
					</tr>
					<tr class="option">
						<td style="vertical-align: top;"><div class="little" name="q4" value="2">&nbsp;</div></td>
						<td style="text-align: left;">iPhone 6s Plus(64G)</td>
					</tr>
				</table>
			</div>
			<div class="actbtn">
				<button class="subtn" id="q4btn">下一题</button>
			</div>
		</div>
		
		<div class="item" id="item5" style="display:none;">
			<div class="question">
				<div class="questionindex">
					5.
				</div>
				<div class="questiontitle">
					疯狂双11系列活动包括哪些子活动
				</div>
			</div>
			<div class="answer">
			
				<table>
					<tr class="option">
						<td style="width:30px;vertical-align: top;"><div class="little" name="q5" value="1">&nbsp;</div></td>
						<td style="text-align: left;">拼人气；全城抽奖；有奖问答</td>
					</tr>
					<tr class="option">
						<td style="vertical-align: top;"><div class="little" name="q5" value="2">&nbsp;</div></td>
						<td style="text-align: left;">拼人气；全城抽奖；抢钱约吗；有奖问答；阿福脱光</td>
					</tr>
				</table>
			</div>
			<div class="actbtn">
				<button class="subtn" id="q5btn">提交答卷</button>
			</div>
		</div>
		
	</div>
	
	<div class="tail">
			
	</div>
	
	
<script type="text/javascript">

	$(document).ready(function(){
		initevent();
	});
	
	function initevent() {
		
		$(".option").each(function(){
			$(this).bind("click",function(){
				var thisop = $(this).find("div.little")
				var opname = thisop.attr("name");
				$("div.little[name='"+opname+"']").removeClass("backred");
				thisop.addClass("backred");
			});
		});
		
		$("#q1btn").bind("click",function(){
			var resultstr = '';
			$("div.little[name='q1']").each(function(){
				if($(this).hasClass("backred")) {
					resultstr += $(this).attr("value");
				}
			});
			
			if(resultstr == '') {
				showmask("你还没选择答案哦");
				return false;
			}else if(resultstr == '2'){
				showmask("答案不正确哦");
				return false;
			}else{
				$("#item1").css("display","none");
				$(".imgcon").attr("src","${ctx}/static/11act/images/2.jpg")
				$("#item2").css("display","");
			}
			
		});
		
		$("#q2btn").bind("click",function(){
			var resultstr = '';
			$("div.little[name='q2']").each(function(){
				if($(this).hasClass("backred")) {
					resultstr += $(this).attr("value");
				}
			});
			
			if(resultstr == '') {
				showmask("你还没选择答案哦");
				return false;
			}else if(resultstr == '1'){
				showmask("答案不正确哦");
				return false;
			}else{
				$("#item2").css("display","none");
				$(".imgcon").attr("src","${ctx}/static/11act/images/3.jpg")
				$("#item3").css("display","");
			}
			
		});
		
		$("#q3btn").bind("click",function(){
			var resultstr = '';
			$("div.little[name='q3']").each(function(){
				if($(this).hasClass("backred")) {
					resultstr += $(this).attr("value");
				}
			});
			
			if(resultstr == '') {
				showmask("你还没选择答案哦");
				return false;
			}else if(resultstr == '2'){
				showmask("答案不正确哦");
				return false;
			}else{
				$("#item3").css("display","none");
				$(".imgcon").attr("src","${ctx}/static/11act/images/4.jpg")
				$("#item4").css("display","");
			}
			
		});
		
		$("#q4btn").bind("click",function(){
			var resultstr = '';
			$("div.little[name='q4']").each(function(){
				if($(this).hasClass("backred")) {
					resultstr += $(this).attr("value");
				}
			});
			
			if(resultstr == '') {
				showmask("你还没选择答案哦");
				return false;
			}else if(resultstr == '1'){
				showmask("答案不正确哦");
				return false;
			}else{
				$("#item4").css("display","none");
				$(".imgcon").attr("src","${ctx}/static/11act/images/5.jpg")
				$("#item5").css("display","");
			}
			
		});
		
		$("#q5btn").bind("click",function(){
			var resultstr = '';
			$("div.little[name='q5']").each(function(){
				if($(this).hasClass("backred")) {
					resultstr += $(this).attr("value");
				}
			});
			
			if(resultstr == '') {
				showmask("你还没选择答案哦");
				return false;
			}else if(resultstr == '1'){
				showmask("答案不正确哦");
				return false;
			}else{
				
				var checkurl = "${ctx}/wxact/saveopenid";
				$.post(checkurl,function(data){
					if(data.result == '0'){
						window.location.href="${ctx}/"+data.url;
						return false; 
					}else{
						if(data.flag) {
							window.location.href="${ctx}/wxact/givephone";
							return false;
						}else{
							showmask("话费已抢完");
							window.location.href="${ctx}/wxact/datifail";
							return false;
						}
					}
				});
				
			}
			
		});
	}
	
	function tijiao() {
		window.location.href="${ctx}/wxpage/inputphone";
	}
	
	function showmask(msg) {
		$(".tipmsg").html(msg);
		$(".maskall").show();
		$(".tipmask").show();
	}
	
	function dispear() {
		$(".maskall").hide();
		$(".tipmask").hide();
	}
	
</script>		
</body>
</html>