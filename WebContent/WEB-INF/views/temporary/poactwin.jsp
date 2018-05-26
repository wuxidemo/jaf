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
	background: url('${ctx}/static/11act/images/detailback.jpg') center;
	text-align: center;
}

.content {
	padding-top: 20px;
	padding-bottom: 40px;
}

.bottomdiv {
	position: fixed;
	width: 100%;
	left: 0;
	bottom: 0;
}

.bottomdiv img {
	width: 100%;
}

.title {
	width: 100%;
	text-align: center;
}

.title img {
	width: 60%;
}

.subtitle {
	margin-top: 10px;
	text-align: right;
}

.subtitle img {
	width: 50%;
}

.rowtitle {
	text-align: center;
	width: 100%;
	color: #e00000;
	font-size: 20px;
	margin: auto;
	font-weight: 600;
}

.phonediv {
	width: 80%;
	margin: auto;
	text-align: center;
}

.tip {
	color: #e00000;
	width: 100%;
	height: 30px;
	text-align: left;
}

.inputdiv {
	overflow: hidden;
	text-align: left;
	background-color: white;
	height: 30px;
	width: 100%;
	border-radius: 5px;
}

.inputdiv input {
	font-size: 17px;
	margin-left: 5px;
	width: 65%;
	border: none;
	box-shadow: none;
	height: 30px;
}

.submit {
	float: right;
	width: 29%;
	height: 30px;
	background-color: #e00000;
	line-height: 30px;
	text-align: center;
	color: white;
}

.view {
	float: right;
	width: 29%;
	height: 30px;
	background-color: #e00000;
	line-height: 30px;
	text-align: center;
	color: white;
}

.rolediv {
	width: 100%;
}

td {
	vertical-align: top;
	font-weight: 400;
}

.choises {
	display: -webkit-box;
	width: 80%;
	margin: 20px auto;
}

.choisescol {
	display: -webkit-box;
	width: 50%;
}

.radio {
	margin-top: 2px;
	border-radius: 50%;
	height: 16px;
	width: 16px;
	background-color: white;
}

.jpname {
	text-align: center;
	width: 60%;
}

.select {
	background-color: red !important;
}
</style>
</head>
<body>
	<div class="content">
		<div class="title">
			<img src="${ctx}/static/11act/images/rqztitle.png">
		</div>
		<div class="subtitle">
			<img src="${ctx}/static/11act/images/rqsubtitle.png">
		</div>
		<div class="rowtitle">
			<c:if test="${wr.winname==1}">恭喜您获得一等奖</c:if>
			<c:if test="${wr.winname==2}">恭喜您获得二等奖</c:if>
			<c:if test="${wr.winname==3}">恭喜您获得‘500M流量’或者‘20元话费’</c:if>
			<c:if test="${wr.winname==4}">恭喜您获得10元话费</c:if>
		</div>
	</div>
	<c:if test="${wr.phone==null}">
		<div class="phonediv">
			<div class="tip">输入手机号,领取好礼:</div>
			<div class="inputdiv">
				<input name="">
				<div class="submit">提&nbsp;&nbsp;交</div>
			</div>
		</div>
		<c:if test="${wr.winname==3}">
			<div class="phonediv">
				<section class="choises">
					<section class="choisescol c1">
						<section class="radio select"></section>
						<section class="jpname">500M流量</section>
					</section>
					<section class="choisescol c2">
						<section class="radio"></section>
						<section class="jpname">20元话费</section>
					</section>
				</section>
			</div>
		</c:if>
	</c:if>
	<c:if test="${wr.phone!=null}">
		<div class="phonediv">
			<div class="tip">您已输入手机号:</div>
			<div class="inputdiv">
				<input name="" readonly="readonly" value="${wr.phone}">
				<div class="view">获奖名单</div>
			</div>
		</div>
		<c:if test="${wr.winname==3}">
			<div class="phonediv">
				<section class="choises">
					<section class="choisescol">
						<section
							class="radio  <c:if test="${wr.subname==1}">select</c:if>"></section>
						<section class="jpname">500M流量</section>
					</section>
					<section class="choisescol">
						<section class="radio <c:if test="${wr.subname==0}">select</c:if>"></section>
						<section class="jpname">20元话费</section>
					</section>
				</section>
			</div>
		</c:if>
	</c:if>
	<div class="phonediv" style="margin-top: 40px;">
		<div class="tip">领奖规则:</div>
		<div class="rolediv">
			<table>
				<tr>
					<td>1.</td>
					<td>输入正确手机号码，领取奖项，如填写错误，则无法领奖；</td>
				</tr>
				<tr>
					<td>2.</td>
					<td>一二等奖工作人员会在联系确认后7天内发货；</td>
				</tr>
				<tr>
					<td>3.</td>
					<td>话费、流量会根据获奖用户所填手机号，在活动结束后7个工作日发放完毕；如未填，则默认放弃奖项。</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="bottomdiv">
		<img src="${ctx}/static/11act/images/bottom.jpg">
	</div>
	<form id="myform" style="display: none"
		action="${ctx}/wxact/savenum/${wr.id}" method="post">
		<input id="num" name="num"> <input id="sub" name="sub">
	</form>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".submit").bind("click", function() {
			if (!isnum($(".inputdiv input").val())) {
				alert("请输入正确的手机号码");
				return;
			}
			$("#num").val($(".inputdiv input").val());
			if ('${wr.winname}' == '3') {
				if ($($(".c1").children()[0]).hasClass("select")) {
					$("#sub").val(1);
				} else {
					$("#sub").val(0);
				}
			}

			$("#myform").submit();
		});
		$(".view").bind("click", function() {
			window.location.href = "${ctx}/wxact/poresult?kind=1";
		});
		$(".c1").bind("click", function() {
			$($(this).children()[0]).addClass("select");
			$($(".c2").children()[0]).removeClass("select");
		});
		$(".c2").bind("click", function() {
			$($(this).children()[0]).addClass("select");
			$($(".c1").children()[0]).removeClass("select");
		});
	});

	function isnum(tel) {
		var re = /^1\d{10}$/;
		return re.test(tel);

	}
</script>
</html>