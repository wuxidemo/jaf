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
<title>人气值活动</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
}

.titlediv {
	width: 100%;
	text-align: center;
}

.titlediv img {
	width: 50%;
	margin-top: 10px;
}

.topdiv {
	width: 100%;
	height: 42px;
}

.descdiv {
	width: 100%;
	text-align: center;
	position: relative;
}

.descdiv img {
	width: 90%;
}

.myinfo {
	margin-top: 10px;
	width: 100%;
	height: 30px;
	text-align: center;
}

.myinfodiv {
	width: 200px;
	margin: auto;
	width: 80%;
	color: #ca3a2a;
}

.myrqz {
	display: inline;
}

.mylogo {
	height: 20px;
	position: absolute;
	width: 20px;
	display: inline;
}

.mylogo img {
	margin-top: -1px;
	margin-left: -35px;
	position: absolute;
	width: 20px;
	height: 20px;
	margin-left: -35px;
	position: absolute;
	width: 20px;
}

.mypm {
	display: inline;
}

.rqztitle {
	width: 100%;
	text-align: center;
}

.phbtitle {
	margin: auto;
	width: 115px;
	height: 23px;
	color: white;
	background-color: #d70d0d;
	border-radius: 14px;
	line-height: 23px;
	text-align: center;
}

.pmdiv {
	margin-top: 5px;
	width: 100%;
	text-align: center;
	margin-bottom: 25px;
}

.first {
	background: url('${ctx}/static/11act/images/first.png') no-repeat center;
}

.second {
	background: url('${ctx}/static/11act/images/second.png') no-repeat
		center;
}

.phb {
	width: 90%;
	margin: auto;
}

.row {
	background-color: #f8ebd3;
	display: -webkit-box;
	margin-top: 3px;
}

.col1 {
	height: 40px;
	width: 30%;
	line-height: 40px;
}

.col3 {
	width: 15%;
	text-align: left;
}

.col3 img {
	margin-top: 5px;
	width: 30px;
	border-radius: 50%;
}

.col2 {
	width: 35%;
	height: 40px;
	line-height: 40px;
	text-align: left;
}

.col4 {
	width: 20%;
	height: 40px;
	line-height: 40px;
	text-align: left;
}

.red {
	color: #ca3a2a;
}

.text-overflow {
	overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
	text-overflow: ellipsis;
	/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
}

.backdetail {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	background: url('${ctx}/static/11act/images/detailback.jpg') center;
	z-index: 99;
	display: none;
}

.detail {
	position: absolute;
	top: 20px;
	left: 20px;
	bottom: 20px;
	right: 20px;
	text-align: center;
	border-radius: 10px;
}

.tmdiv {
	background-color: white;
	opacity: 0.5;
}

.bottomdiv {
	width: 100%;
}

.bottomdiv img {
	width: 100%;
}

.detailhead {
	width: 100%;
	height: 50px;
}

.detailhead img {
	position: absolute;
	width: 25px;
	height: 25px;
	top: 10px;
	right: 10px;
}

.rowtitle {
	width: 80%;
	height: 20px;
	margin: auto;
	color: #ca3a2a;
	text-align: left;
}

.rowcontent {
	text-indent: 2em;
	width: 80%;
	text-align: left;
	margin: 5 auto;
}

.jp section {
	font-size: 15px;
	text-indent: 0;
}

.jprow {
	display: -webkit-box;
}

.jprow section:FIRST-CHILD {
	text-indent: 1em;
	width: 120px;
}

.rolerow {
	text-indent: 0;
	width: 80%;
	text-align: left;
	margin: 5 auto;
}

.jprole {
	display: -webkit-box;
}

.col1 img {
	width: 31px;
}

.rolediv {
	line-height: 22px;
	margin-top: 10px;
	left: 5%;
	position: absolute;
	border-radius: 5px;
	width: 70px;
	height: 23px;
	background-color: #003f84;
	color: white;
	text-align: center;
	font-size: 12px;
}

.hand {
	left: 27%;
	position: absolute;
}

.hand img {
	margin-top: 3px;
	width: 32px;
}

.arrow {
	position: absolute;
	right: 5%;
}

.arrow img {
	width: 33px;
	margin-top: -17px;
}

.gztip {
	margin-top: 17px;
	font-size: 10px;
	position: absolute;
	right: 15%;
	color: #890002;;
}

.overdiv {
	top: 80px;
	position: absolute;
	left: 5%;
}

.overdiv img {
	width: 160px;
}
</style>
</head>
<body>
	<div class="backdetail">
		<div class="detail tmdiv"></div>
		<div class="detail ">
			<div class="detailhead">
				<img id="close" src="${ctx}/static/11act/images/detailclose.png">
			</div>
			<div class="rowtitle">活动介绍:</div>
			<div class="rowcontent">积累人气值赢得iPhone6s Plus，好友越多，人气值越高。</div>
			<div class="rowtitle">奖品详情:</div>
			<div class="rowcontent  jp">
				<section>
					<section class="jprow">
						<section>第一名</section>
						<section>iPhone6s Plus(64G)</section>
					</section>
					<section class="jprow">
						<section>第二名</section>
						<section>iPhone6(64G)</section>
					</section>
					<section class="jprow">
						<section>人气值满1000</section>
						<section>500M流量/20元话费</section>
					</section>
					<section class="jprow">
						<section>人气值满500</section>
						<section>10元话费</section>
					</section>
				</section>
			</div>
			<div class="rowtitle">活动规则 :</div>
			<div class="rolerow">
				<section>
					<section class="jprole">
						<section>1.</section>
						<section>活动日期：2015.10.25至2015.11.11；</section>
					</section>
					<section class="jprole">
						<section>2.</section>
						<section>邀请好友，即可攒人气；</section>
					</section>
					<section class="jprole">
						<section>3.</section>
						<section>一级好友攒10分，二级好友攒3分，最多两级；</section>
					</section>
					<section class="jprole">
						<section>4.</section>
						<section>系统自动实时计算人气值，具体人气值以平台为准；</section>
					</section>
					<section class="jprole">
						<section>5.</section>
						<section>活动奖品在活动结束后7天内发放；</section>
					</section>
					<section class="jprole">
						<section>6.</section>
						<section>在法律范围内，最终解释权归主办方所有。</section>
					</section>
				</section>
			</div>
		</div>

	</div>

	<!-- 
-->
	<div class="titlediv">
		<img src="${ctx}/static/11act/images/rqztitle.jpg">
	</div>
	<div class="topdiv">
		<div class="rolediv">活动规则</div>
		<div class="hand">
			<img src="${ctx}/static/11act/images/hand.jpg">
		</div>
		<!-- <div class="gztip">(点击右上角分享给好友)</div>
		<div class="arrow">
			<img src="${ctx}/static/11act/images/arrow.jpg">
		</div>
		 -->
	</div>
	<div class="descdiv">
		<img src="${ctx}/static/11act/images/rqzdesc.png">
		<c:if test="${actstate=='0'}">
			<div class="overdiv">
				<img src="${ctx}/static/11act/images/over.png">
			</div>
		</c:if>

	</div>
	<div class="myinfo">
		<div class="myinfodiv">
			<div class="mylogo">
				<img src="${ctx}/static/11act/images/mylogo.png">
			</div>
			<div class="myrqz">我的人气值:${count}.</div>
			<div class="mypm">
				<c:if test="${rank==null}">暂无排名</c:if>
				<c:if test="${rank!=null}">第${rank}名</c:if>
			</div>
		</div>
	</div>
	<div class="rqztitle">
		<div class="phbtitle">人气值排行榜</div>
	</div>
	<div class="pmdiv">
		<section class="phb">

			<c:forEach items="${top10}" var="p" varStatus="vs">
				<section class="row">
					<section class="col1 red ">
						<c:if test="${vs.count==1}">
							<img src="${ctx}/static/11act/images/first.png">
						</c:if>
						<c:if test="${vs.count==2}">
							<img src="${ctx}/static/11act/images/second.png">
						</c:if>
						<c:if test="${vs.count!=2 and vs.count!=1}">${vs.count}</c:if>
					</section>
					<section class="col3">
						<img src="${p[1]}">
					</section>
					<section
						class="col2 text-overflow  <c:if test="${vs.count==1}">red</c:if> <c:if test="${vs.count==2}">red</c:if>">${p[0]}</section>
					<section
						class="col4 text-overflow  <c:if test="${vs.count==1}">red</c:if> <c:if test="${vs.count==2}">red</c:if>">${p[2]}</section>
				</section>
			</c:forEach>
		</section>
	</div>
	<div class="bottomdiv">
		<img src="${ctx}/static/11act/images/bottom.jpg">
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#close").bind("click", function() {
			$(".backdetail").css("display", "none");
		});
		$(".rolediv").bind("click", function() {
			$(".backdetail").css("display", "block");
		});

	});
	var actstate = '${actstate}'
	function setnum() {
		//alert("aa");

	}

	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'hideOptionMenu', 'onMenuShareTimeline',
				'onMenuShareAppMessage', 'showMenuItems' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		wx.hideOptionMenu();
		wx
				.showMenuItems({
					menuList : [ 'menuItem:share:timeline',
							'menuItem:share:appMessage' ],
					success : function(res) {
					},
					fail : function(res) {
					}
				});
		wx.onMenuShareTimeline({
			title : '双11拼人气，赢iPhone', // 分享标题
			link : '${url}', // 分享链接
			imgUrl : 'http://soft.do-wi.cn/nsh/static/11act/images/rqzlogo.jpg', // 分享图标
			success : function() {
				// 用户确认分享后执行的回调函数
				//if (actstate == "1") {
					$.post("${ctx}/wxact/poshare/${openid}", function(d) {
						//alert("分享成功");
					});
				//}
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});

		wx.onMenuShareAppMessage({
			title : '双11拼人气，赢iPhone', // 分享标题
			desc : '攒人气，赢大奖！', // 分享描述
			
			link : '${url}', // 分享链接
			imgUrl : 'http://soft.do-wi.cn/nsh/static/11act/images/rqzlogo.jpg', // 分享图标
			type : 'link', // 分享类型,music、video或link，不填默认为link
			dataUrl : '', // 如果type是music或video，则要提供数据链接，默认为空
			success : function() {
				//if (actstate == "1") {
					$.post("${ctx}/wxact/poshare/${openid}", function(d) {
						//alert("分享成功");
					});
			//	}
			},
			cancel : function() {
				// 用户取消分享后执行的回调函数
			}
		});
	});
</script>
</html>