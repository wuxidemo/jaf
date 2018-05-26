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
<title>获奖名单</title>
<style type="text/css">
body {
	margin: 0;
	font-family: 'Microsoft YaHei';
	font-size: 15px;
	text-align: center;
}

.head {
	height: 60px;
	background-color: fd4d43;
	color: white;
	font-size: 24px;
	text-align: center;
	line-height: 60px;
}

.timechoise {
	background-color: #fdf7d3;
	height: 40px;
}

.jpcontent {
	margin-top: 5px;
	padding-top: 10px;
}

.time {
	height: 100%;
	line-height: 40px;
	display: -webkit-box;
}

.time section {
	width: 33%;
	line-height: 40px;
	color: red;
	height: 40px;
}

.leftarrow {
	
}

.rightarrow {
	
}

.nowtime {
	height: 30px;
	background-color: white;
	line-height: 30px;
}

.myjp {
	margin-bottom: 10px;
	width: 100%;
	color: #fd4d43;
	font-weight: 600;
	font-size: 18px;
	color: #fd4d43;
	font-weight: 600;
	font-weight: 600;
}

.jpss {
	text-align: center;
	padding: 13px;
	background-color: #fdf7d3;
	width: 80%;
	margin: auto;
	padding: 13px;
	background-color: #fdf7d3;
	width: 80%;
}

.jpss table {
	margin: auto;
	width: 90%;
}

.jpss table tr td:FIRST-CHILD {
	width: 65px;
	vertical-align: top;
}

.left {
	background: url('/nsh/static/11act/gzfx/fxleft.png') no-repeat scroll
		4px 9px;
}

.right {
	background: url('/nsh/static/11act/gzfx/fxright.png') no-repeat scroll
		right;
	visibility: hidden;
}
.jpse section {
	display: -webkit-box;
}

.scol1 {
	width: 20%;
}

.scol2 {
	text-align: left;
	display: block !important;
	width: 80%;
	word-wrap: break-word;
}
.scol2 div {
	width: 30%;
	float: left;
}
</style>
</head>
<body>
	<div class="head bdiv">获奖名单</div>
	<div class="timechoise bdiv">
		<section class="time">
			<section class="left">前一天</section>
			<section style="padding-top: 5px;">
				<div class="nowtime">2015-10-24</div>
			</section>
			<section class="right">后一天</section>
		</section>
	</div>
	<div class="jpcontent bdiv">
		<div class="myjp" id="myjp"></div>
		<div class="myjp" id="myphone"></div>
		<div class="jpss">

			<section class="jpse">
				<section class="srpw">
					<section class="scol1">一等奖:</section>
					<section class="scol2" id="jp1"></section>
				</section>
				<section>
					<section class="scol1">二等奖:</section>
					<section class="scol2" id="jp2"></section>
				</section>
				<section>
					<section class="scol1">三等奖:</section>
					<section class="scol2" id="jp3"></section>
				</section>
			</section>
		</div>
	</div>
	<div class="bottom"></div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var times = [];
	if ('${times}' != '') {
		times = '${times}'.split(",");
	}
	var now = times.length - 1;
	$(document).ready(function() {
		if (times.length != 0) {
			$(".nowtime").html(times[now]);
			showdata(times[now]);
			if (now == 0) {
				$(".left").css("visibility", "hidden");
			}
		} else {
			$(".timechoise").css("display", "none");
		}
		$(".left").bind("click", function() {
			if (now == 1) {
				$(".left").css("visibility", "hidden");
			}
			if (now == times.length - 1) {
				$(".right").css("visibility", "visible");
			}
			now--;
			$(".nowtime").html(times[now]);
			showdata(times[now]);
		});
		$(".right").bind("click", function() {
			if (now == times.length - 2) {
				$(".right").css("visibility", "hidden");
			}
			if (now == 0) {
				$(".left").css("visibility", "visible");
			}
			now++;
			$(".nowtime").html(times[now]);
			showdata(times[now]);
		});
	});
	function showdata(time) {
		$
				.post(
						"${ctx}/wxact/sharedata?time=" + time,
						function(d) {
							if (d.jp1.length > 0) {
								var html = "";
								for (var i = 0; i < d.jp1.length; i++) {
									html += "<div>"+d.jp1[i].tkid+"</div>"
								}
								$("#jp1").html(html);
							} else {
								$("#jp1").html("暂无记录");
							}

							if (d.jp2.length > 0) {
								var html = "";
								for (var i = 0; i < d.jp2.length; i++) {
									html += "<div>"+d.jp2[i].tkid+"</div>"
								}
								$("#jp2").html(html);
							} else {
								$("#jp2").html("暂无记录");
							}

							if (d.jp3.length > 0) {
								var html = "";
								for (var i = 0; i < d.jp3.length; i++) {
									html += "<div>"+d.jp3[i].tkid+"</div>"
								}
								$("#jp3").html(html);
							} else {
								$("#jp3").html("暂无记录");
							}

							if (d.mys != null) {
								if (d.myjp != null) {
									var jpn = "";
									if (d.myjp.winname == 1) {
										jpn = "一";
									} else if (d.myjp.winname == 2) {
										jpn = "二";
									} else if (d.myjp.winname == 3) {
										jpn = "三";
									}
									$("#myjp").html("恭喜您获得" + jpn + "等奖");
									$("#myphone").css("display", "block");
									if (d.myjp.phone != null) {
										$("#myphone").html(
												"获奖手机号码为" + d.myjp.phone);
									} else {
										$("#myphone")
												.html(
														"您还未填写获奖手机号码,<a href=\"${ctx}/wxurl/redirect?url=/wxact/sharewin\">点击这里</a>去填写吧");
									}
								} else {
									$("#myjp").html("您的抽奖编号为:" + d.mys.id+"<br>您未中奖请继续参与");
									$("#myphone").css("display", "none");
								}
							} else {
								$("#myjp").html("您未参加当天抽奖");
								$("#myphone").css("display", "none");
							}
						});
	}
	String.prototype.endWith = function(str) {
		if (str == null || str == "" || this.length == 0
				|| str.length > this.length)
			return false;
		if (this.substring(this.length - str.length) == str)
			return true;
		else
			return false;
		return true;
	}
</script>
</html>