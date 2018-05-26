<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>全城抽奖</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
	background: url('${ctx}/static/11act/images/contentback.png') repeat-y;
	filter:
		"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
}

.headdiv {
	width: 100%;
}

.headdiv img {
	width: 100%;
	position: relative;
}

.detailrolediv {
	top: 15px;
	border-radius: 50px;
	right: 10;
	position: absolute;
	width: 100px;
	height: 25px;
	line-height: 25px;
	text-align: center;
	background-color: #f8f0c7;
	color: #f65670;
	z-index: 9;
}

.myjp {
	top: 15px;
	border-radius: 50px;
	left: 10;
	position: absolute;
	width: 100px;
	height: 25px;
	line-height: 25px;
	text-align: center;
	background-color: #f8f0c7;
	color: #f65670;
	z-index: 9;
}

.content {
	width: 100%;
	text-align: center;
}

.rolediv {
	width: 80%;
	margin: auto;
	color: #ed304e;
	font-size: 20px;
	text-align: left;
	height: 60px;
	line-height: 70px;
}

.roledetail {
	width: 80%;
	margin: auto;
	text-align: left;
	text-indent: 2em;
}

.buttondiv {
	width: 80%;
	margin: auto;
}

button {
	box-shadow: none;
	width: 47%;
	height: 40px;
	border: none;
	color: white;
	font-size: 15px;
	border-radius: 50px;
	margin-top: 30px;
}

.coverdiv {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	opacity: 0.8;
	background-color: #333;
	z-index: 99;
	display: none;
}

.derolediv {
	margin-bottom: 20px;
	position: absolute;
	top: 20px;
	left: 20px;
	right: 20px;
	background-color: #FEF2A0;
	z-index: 100;
	display: none;
}

.titlename {
	margin: auto;
	height: 30px;
	width: 90%;
	text-align: left;
	line-height: 30px;
	font-size: 20px;
	color: red;
}

.deroletitle {
	text-align: center;
	margin-top: 20px;
	width: 100%;
	height: 30px;
	margin-bottom: 10px;
}

.titlespan {
	float: left;
	width: 2%;
	height: 30px;
	background-color: red;
}

.decontent {
	text-align: left;
	margin: auto;
	width: 90%;
	text-indent: 2em;
	margin-bottom: 20px;
}

.jps {
	display: -webkit-box;
	text-indent: 0;
}

.jps section {
	width: 30%;
}

.roles {
	display: -webkit-box;
	text-indent: 0;
}

.roles section:FIRST-CHILD {
	width: 15px;
}

.roles section:nth-child(2) {
	width: 95%;
}

#close {
	position: absolute;
	width: 25px;
	height: 25px;
	top: 10px;
	right: 10px;
}

.bottomdiv {
	position: fixed;
	left: 0;
	right: 0;
	height: 5px;
	bottom: 0;
	background-color: #fdcb2c;
}

.overdiv {
	top: 80px;
	position: absolute;
	left: 5%;
}

.overdiv img {
	width: 160px;
}




.loadcover {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
	display:none;
}

.loadimg {
	position: absolute;
	z-index: 1000;
	width: 25px;
	height: 25px;
	top: 50%;
	left: 50%;
	margin-top: -12px;
  margin-left: -12px;
}

    
.ball-clip-rotate {
	background-color: #fff;
	width: 15px;
	height: 15px;
	border-radius: 100%;
	margin: 2px;
	-webkit-animation-fill-mode: both;
	animation-fill-mode: both;
	border: 2px solid #fff;
	border-bottom-color: transparent;
	height: 25px;
	width: 25px;
	background: transparent !important;
	display: inline-block;
	-webkit-animation: rotate 0.75s 0s linear infinite;
	animation: rotate 0.75s 0s linear infinite;
}
  .loadcover1 {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
}
  
  
  
@-webkit-keyframes rotate {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg); }

  50% {
    -webkit-transform: rotate(180deg);
            transform: rotate(180deg); }

  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg); } }

@keyframes rotate {
  0% {
    -webkit-transform: rotate(0deg);
            transform: rotate(0deg); }

  50% {
    -webkit-transform: rotate(180deg);
            transform: rotate(180deg); }

  100% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg); } }
            
/************************************************/

.loadcover3 {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 99;
	display:none;
	
}

.inputphone {
    position:fixed;
	margin:auto;
	width:200px;
	height:300px;
	background-color:white;
	opacity: 0;
	z-index:120;
}

.lotip {
	width:100%;
	height:50px;
	
}

.inputdiv {
	width:100%;
	height:80px;
}

.phonein {
	height:40px;
	width:90%;
	border:none;
	font-size:20px;
	border-radius:0.6em;
}

.phoneerr {
	width:100%;
	height:40px;
	color:red;
	line-height:40px;
}

.phonebtnwrap {
	width:100%;
	heith:50px;
	
}

.phonebtn {
	width:80%;
	height:40px;
	font-size:20px;
	background-color:red;
	border-radius:0.6em;
	margin:auto;
}


/******************************、

</style>
</head>
<body>
<div class="loadcover1"></div>
	<div class="loadimg">
		<div class="ball-clip-rotate"></div>
	</div>
	<div class="loadcover"></div>
	
	<div class="loadcover3">
		
	</div>
	
	<!-- 
	<div class="inputphone">
		<div class="lotip">检测到你的位置不在无锡，<br/>本次活动只面向无锡用户<br/>请输入手机号码继续</div>
		<div class="inputdiv">
			手机号码：<input type="text" placeholder="请输入一个无锡号码" maxlength="11" id="phonein" class="phonein"/>
			<div class="phoneerr"></div>
		</div>
		<div class="phonebtnwrap">
			<div class="phonebtn" onclick="valphone()"></div>
		</div>
	</div> -->
	
	
	<div style="width: 100%;height:150px;position: absolute;z-index: 1000;top:40%;margin-top: -50px;display: none;"id="phonetip">
		    <div style="width:90%;margin-top: opx;margin-left: auto;margin-right: auto;margin-bottom: 0px;background: url('${ctx}/static/11act/images/tc1.png');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;">
		            <div style="width: 100%;height: auto;text-align: center;padding-top:20px;">
		                <font style="font-size: 20px;color: red;"><b>输入手机号码</b></font>
		                  <br>
		                  
		                  <div style="width:100%;height:30px;font-size:20px;margin-top:30px;">
		                  	<input type="text" placeholder="请输入手机号码" maxlength="11" id="phonein" class="phonein"/>
		                  </div>
		                  
		                  <div style="height:50px;width:100%;line-height:50px;" class="phoneerr">
		                 
		                 </div>
		                 
		            </div>
		            
		            <div style="width:100%;height: auto;margin-top: 20px;">
		                <div style="width:90%;height:40px;-webkit-border-radius: 20px 20px 20px 20px;background-color: red;margin-left: auto;margin-right: auto;text-align: center;"onclick="colse()">
		                   <div style="color: #ffffff;font-size: 20px;line-height: 40px;text-align:center;"onclick="valphone()">
		                                                      确定
		                   </div>
		                </div>
		            </div>
		            
		            <div style="width: 100%;height: auto;margin-top: 10px;">
		            <div style="width: 90%;height:25px;margin-left: auto;margin-right:auto; ">
		         <!--      注：券码可以在获奖名单中查看。  -->
		              </div>  
		            </div>
		    </div>
		</div>
	

	<div class="backdiv">
		<div class="headdiv">
			<div class="detailrolediv" onclick="hjmd()">中奖名单</div>
			<div class="myjp" onclick="hjmd1()">我的抵用券</div>
			<img alt="" src="${ctx}/static/11act/images/headimg.png">
			<c:if test="${actstate=='0'}">
			<div class="overdiv">
				<img src="${ctx}/static/11act/images/over.png">
			</div>
		</c:if>
		</div>
		<div class="content">
			<div class="rolediv">活动介绍</div>
			<div class="roledetail">
				2015年11月1日至2015年11月11日期间，凭无锡农村商业银行交易小票，拍照后在金阿福e服务公众号活动页面上传，即有机会获得惊喜。
				<br>
				
				
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>本次活动仅限无锡地区用户</b>
				</div>
			<div class="buttondiv">
				<button style="background-color: #ed304e;" class="upbtn">上传</button>
				<button style="background-color: #f65670;"  onclick="display()">活动规则</button><!-- onclick="hjmd()" -->
			</div>
			<div class="fildiv"></div>
			<!-- 
			<c:if test="${iswin==true}">您已中奖机会留给别人吧</c:if>
			<c:if test="${iswin==false}">
				<c:if test="${is3==true}">今天上传次数已满</c:if>
				<c:if test="${is3==false}">
					<button onclick="upload()">上传(${count}次)</button>
				</c:if>

			</c:if>
 -->
		</div>
	</div>
	
	   <!--  提示框 -->
	<div style="width: 100%;height:100px;position: absolute;z-index: 1000;top:40%;margin-top: -50px;display: none"id="tishi">
		    <div style="width:90%;margin-top: opx;margin-left: auto;margin-right: auto;margin-bottom: 0px;background: url('${ctx}/static/11act/images/tc1.png');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;">
		            <div style="width: 100%;height: auto;text-align: center;padding-top:20px;">
		                <font style="font-size: 20px;color: red;"><b>上传成功</b></font>
		                  <br>
		                   您的抽奖编号是：<font style="color: red;"id="fo1">
		                   
		                 </font>
		                 <br>
		                 <font>
		                 系统将通过抽奖编号进行抽奖
		                 </font>
		            </div>
		            
		            <div style="width:100%;height: auto;margin-top: 20px;">
		                <div style="width: 40%;height:40px;-webkit-border-radius: 20px 20px 20px 20px;background-color: red;margin-left: auto;margin-right: auto;text-align: center;"onclick="colse()">
		                   <font style="color: #ffffff;font-size: 20px;line-height: 40px;">
		                                                      确定
		                   </font>
		                </div>
		            </div>
		            
		            <div style="width: 100%;height: auto;margin-top: 10px;">
		            <div style="width: 90%;height:25px;margin-left: auto;margin-right:auto; ">
		              注：抽奖编号可以在获奖名单中查看。 
		              </div>  
		            </div>
		    </div>
		</div>
		
		
	<div class="coverdiv"></div>
	<div class="derolediv">
		<img id="close" src="${ctx}/static/11act/images/detailclose.png">
		<div class="deroletitle">
			<div class="titlespan"></div>
			<div class="titlename">活动规则:</div>
		</div>
		<div class="decontent">

			2015年11月1日至2015年11月11日期间，凭无锡农村商业银行交易小票，拍照后在金阿福e服务公众号活动页面上传，即有机会获得惊喜。</div>

		<div class="deroletitle">
			<div class="titlespan"></div>
			<div class="titlename">奖品详情:</div>
		</div>
		<div class="decontent">
			<section class="jps">
				<section>一等奖</section>
				<section>10名</section>
				<section>300元</section>
			</section>
			<section class="jps">
				<section>二等奖</section>
				<section>20名</section>
				<section>200元</section>
			</section>
			<section class="jps">
				<section>三等奖</section>
				<section>50名</section>
				<section>100元</section>
			</section>
			<section class="jps">
				<section>幸运奖</section>
				<section>100名</section>
				<section>10元话费</section>
			</section>
			<section class="jps">
				<section>脱光奖</section>
				<section style="width: 60%;">总金额1111元话费，当天所有上传抽奖编号尾号为11的用户进行均分（取整）。</section>
			</section>
		</div>

		<div class="deroletitle">
			<div class="titlespan"></div>
			<div class="titlename">活动规则:</div>
		</div>
		<div class="decontent"> 
			<section class="roles">
				<section>1.</section>
				<section>每个用户每天最多可上传三张当日不同小票，重复上传无效；交易金额需大于10元，非无锡农村商业银行交易小票上传无效；</section>
			</section>
			<section class="roles">
				<section>2.</section>
				<section>交易小票包括：刷卡消费、柜面存款、购买理财基金业务，各种电子渠道（支付宝快捷支付、网银、手机银行、自助终端、ATM机）的账务交易成功截图；</section>
			</section>

			<section class="roles">
				<section>3.</section>
				<section>交易短信截图无效；ATM取款小票无效；转账票价无效；</section>
			</section>
			<section class="roles">
				<section>4.</section>
				<section>上传小票照片模糊不能分辨主要信息或上传失败视为无效；</section>
			</section>
			<section class="roles">
				<section>5.</section>
				<section>随机抽取幸运粉丝，获奖名单于次日在本微信公众平台公布；</section>
			</section>
			<section class="roles">
				<section>6.</section>
				<section>同一个微信ID每天都有一次获奖机会；</section>
			</section>

			<section class="roles">
				<section>7.</section>
				<section>本次活动只针对无锡地区用户，在法律范围内，最终解释权归主办方。</section>
			</section>

		</div>
	</div>
	<div class="bottomdiv"></div>
	<div class="loadcover"></div>
	<div class="loadimg">
		<div class="ball-clip-rotate"></div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		/* $(".detailrolediv").bind("click", function() {
			$(".coverdiv").css("display", "block");
			$(".derolediv").css("display", "block");
		}); */
		$("#close").bind("click", function() {
			$(".coverdiv").css("display", "none");
			$(".derolediv").css("display", "none");
		});

	
	});
	    function display(){
	    	$(".coverdiv").css("display", "block");
			$(".derolediv").css("display", "block");
	    }
	
	function colse(){
		 $("#tishi").css("display", "none");
		 $(".loadcover").css("display", "none");
	}
	
	function hjmd() {
		window.open("${ctx}/wxurl/redirect?url=wxact/luckresult");
	}
	function hjmd1() {
		window.open("${ctx}/wxurl/redirect?url=wxact/myqccjcard");
	}
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'hideOptionMenu', 'chooseImage', 'uploadImage', 'closeWindow' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		wx.hideOptionMenu();
		getdatabyjw();
	});

	function upload() {
		if('${actstate}'=='0')
			{
			alert("活动已结束");
			}
		else{
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

						$.post("${ctx}/wxact/saverecord?mid=" + serverId,
								function(d) {
									if (d.result == "1") {
										/* alert("上传成功，您的券码是" + d.luckid
												+ ",凭此券可以参加系统抽奖一次");
										location.reload(); */
										$("#fo1").text(d.luckid);
										 $("#tishi").css("display","");
										 $(".loadcover").css("display","block");
										 
									} else if (d.result == "-1") {
										alert("登陆过期");
										location.reload();
									} else {
										alert(d.msg);
									}

								});
					}
				});
			}
		});
		}
	}
	
	function getarea(latitude, longitude) {
		$.post("${ctx}/wxact/getarea", {
			"lat" : latitude,
			"lon" : longitude
		}, function(d) {
			$(".loadcover1").css("display","none");
			$(".loadimg").css("display","none");
			if(d.result == '1') {
				$(".upbtn").attr("onclick","upload()");
			}else if(d.result == '2'){
				$(".loadcover3").css("display","block");
				$("#phonetip").css("display","block");
			}else{
				
			}
			/* alert(JSON.stringify(d)); */
			/* $(".loadcover").css("display","none");
			$(".loadimg").css("display","none"); */
		});

	}
	function getdatabyjw() {
		wx.getLocation({
			type : 'wgs84',
			success : function(res) {

				var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
				var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
				var speed = res.speed; // 速度，以米/每秒计
				var accuracy = res.accuracy; // 位置精度
				//alert(latitude+":"+longitude);
				//init(latitude, longitude);
				getarea(latitude, longitude);
			},
			cancel: function (res) {
			    alert('用户拒绝授权获取地理位置');
				wx.closeWindow();
			}

		});
	}
	
	function valphone() {
		var phonenum = $("#phonein").val();
		
		if(phonenum.trim() == '') {
			$(".phoneerr").html("请输入合法的手机号码");
			$("#phonein").val("");
			$("#phonein").focus();
			return false;
		}
		
		if(!testphone(phonenum)) {
			$(".phoneerr").html("手机号码不合法，请重新输入");
			$("#phonein").val("");
			$("#phonein").focus();
			return false;
		}else{
			var checkurl = "${ctx}/wxact/phlocation";
			$.post(checkurl,{"phone":phonenum},function(data){
				if(data.result == '0') {
					$(".phoneerr").html("网络错误");
					$("#phonein").val("");
					$("#phonein").focus();
					return false;
				}else if(data.result == '2') {
					$(".phoneerr").html("该手机号码非无锡号码");
					$("#phonein").val("");
					$("#phonein").focus();
				} else{
					$(".loadcover3").css("display","none");
					$("#phonetip").css("display","none");
					$(".upbtn").attr("onclick","upload()");
				}
			});
			
		}
	}
	
	function testphone(phone) {
		var reg = new RegExp("^1[34578][0-9]{9}");
		return reg.test(phone);
	}
	
</script>
</html>