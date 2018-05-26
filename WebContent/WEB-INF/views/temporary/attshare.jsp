<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<title>关注并分享 天天领礼包</title>
<style type="text/css">
#sp {
	color: red;
	/*  text-indent: 2em; */
}

#id1 {
	width: 100%;
	height: 150px;
	background: url('${ctx}/static/images/021.png');
	filter:
		'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='
		scale ')';
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
	margin-top: -10px;
	text-align: center;
}

#num {
	width: 200px;
	height: 24px;
	/* padding: 8px; */
	margin-top: 34px;
	-webkit-border-radius: 20px 20px 20px 20px;
	border: 0px;
	text-align: center;
	/* margin-right: -20px; */
	font-size: 18px;
}

#but {
	width: 205px;
	height: 25px;
	margin-top: 15px;
	background-color: #ffffff;
	-webkit-border-radius: 20px 20px 20px 20px;
	border: 0px;
	color: #D57438;
	margin-right: -20px;
	margin-left: 90px;
	padding-top: 10px;
}

#id2 {
	width: 100%;
	height: 150px;
	background: url('${ctx}/static/images/jz3.png');
	filter:
		'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='
		scale ')';
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
	text-align: center;
	margin-top: -25px;
}

#id3 {
	width: 100%;
	height: 200px;
	background: url('${ctx}/static/images/jz4.png');
	filter:
		'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='
		scale ')';
	-moz-background-size: 100% 100%;
	background-size: 100% 100%;
	margin-top: -17px;
}
</style>
<script>
	function formsubmit() {
		if ($("#num").val() == null || $.trim($("#num").val()) == '') {
			alert("请输入电话号码");
			$(this).focus();
			return false;
		} else if (!(/^1[3|4|5|8|2|7][0-9]\d{8}$/.test($("#num").val()))) {
			alert("手机格式不对！");
			$(this).focus();
			return false;
		} else {
			$("#subform").submit();
		}
	}
	function formsubmit1() {
		url = "${ctx}/wxurl/redirect?url=wxact/share";
		window.location.href = url;

	}
</script>
</head>
<body style="margin: 0px;">
	<!--  顶部 -->
	<div style="width: 100%; height: auto;">
		<img src="${ctx}/static/images/jz1.png" style="width: 100%">
	</div>
	<!--  上部 -->
	<div id="id1">

        <form action="${ctx}/wxact/sharesavenum" method="post" id="subform">
		<input type="hidden" name="id" id="id" value="${wr.id}">
		<div style="width: 100%; height: 75px;">
			<input type="text" name="num" id="num" placeholder="请输入手机号码"
				maxlength="11" value="${wr.phone}" <c:if test="${wr.phone!=null}">disabled='disabled'</c:if>>
		</div>
		
		<div style="width: 100%; height: 75px;">
			
			<c:choose>
				<c:when test="${wr.phone!=null}">
					<div
				style="width: 80%; height: 40px; margin: 21px auto; line-height: 40px;color: #D57438;"onclick="formsubmit1()">
				继续分享</div>
				</c:when>
				<c:otherwise>
					<div
				     style="width: 80%; height: 40px; margin: 21px auto; line-height: 40px;color: #D57438;"onclick="formsubmit()">
				提交</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		</form>
	</div>
	<!--  中部 -->
	<div id="id2">

		<p style="font-size: 25px; color: #FCE660; padding-top: 70px;">
			
			<c:choose>
				<c:when test="${wr.winname==1}">
		                            恭喜你获得一等奖
		      </c:when>
				<c:when test="${wr.winname==2}">
		                            恭喜你获得二等奖
		      </c:when>
				<c:otherwise>
		                             恭喜你获得三等奖
		      </c:otherwise>
			</c:choose>
		</p>
	</div>
	<!--   下部 -->
	<div id="id3">
		<div
			style="width: 90%; height: auto; padding-left: 8px; padding-right: 8px;">
			<p style="font-size: 17px; color: red;">领奖规则:</p>
			<table style="color: red;">
				<tr>
					<td style="vertical-align: top;">1.</td>
					<td>请输入手机号领取话费；手机号填写错误或三日内没有填写视为放弃；</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">2.</td>
					<td>话费将于获奖名单公布后三日内到账。</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>