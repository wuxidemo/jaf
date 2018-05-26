<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	/* background-color: #dcdddd; */
	margin: 0;
}

.topinfo {
	width: 100%;
}

.titlecontent {
	width: 100%;
	text-align: center;
	background: url('${ctx}/static/images/contentback.png');
	background-size: 100%;
}

.content {
	width: 80%;
	text-align: left;
	margin: auto;
	color: white;
	padding-bottom: 10px;
}

.jointitle {
	background-color: #87c150;
	color: white;
	height: 40px;
	line-height: 40px;
}

.jointitle label:nth-child(1) {
	margin-left: 25px;
	font-size: 25px;
}

.jointitle label:nth-child(2) {
	font-size: 15px;
	margin-left: 15px;
}

.subdiv { 
	width: 100%;
	text-align: center;
}

.subdiv table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 5px;
}

.subdiv table tr {
	margin-bottom: 15px;
}

.subdiv table tr td:nth-child(1) {
	width: 30%;
	padding-left: 30px;
	padding-right: 10px;
	white-space: nowrap;
}

.subdiv table tr td:nth-child(2) {
	width: 70%;
}

.subdiv table input {
	width: 90%;
	border: 1px solid #e8e8e8;
	height: 35px;
	border-radius: 5px;
}

.btn {
	background-color: #87c150;
	border: medium none;
	box-shadow: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	height: 40px;
	width: 90%;
	border-radius: 5px;
}

.btndiv {
	text-align: center;
}

.tip {
	color: #3e3a39;
	font-size: 13px;
	margin-top: 20px;
	text-align: center;
	margin-bottom: 5px;
}

.subdiv img {
	margin-top: 30px;
	width: 80%;
}

.applydiv {
	margin-top: 10px;
}

.showtip {
	background-color: rgba(0, 0, 0, 0.7);
	border-radius: 0.3125em;
	bottom: -30px;
	color: white;
	width: 150px;
	height: 30px;
	left: 50%;
	position: fixed;
	text-align: center;
	z-index: 999;
	line-height: 30px;
	margin-left: -75px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>加入我们</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<body>
	<div class="topinfo">
		<div class="titleimg" style="text-align:center;margin-bottom:10px;">
			<img src="${ctx}/static/jsy/logo.png" height="125px">
		</div>
		<div class="jointitle">
			<label>加入我们</label><label>(请填写您的信息)</label>
		</div>
	</div>
	<div class="subdiv">
		<c:if test="${app==null}">
			<form id="myform" action="${ctx}/wxpage/savejsyjoininfo" method="post">
				<table>
					<tr>
						<td>姓名:</td>
						<td><input id="name" name="name" maxlength="4"></td>
					</tr>
					<tr>
						<td>联系手机号:</td>
						<td><input id="telephone" name="telephone" maxlength="12"></td>
					</tr>
					<tr>
						<td>推荐人姓名:</td>
						<td><input id="referee" name="referee" maxlength="4"></td>
					</tr>
					<tr>
						<td>推荐人手机号:</td>
						<td><input id="refereephone" name="refereephone" maxlength="12"></td>
					</tr>
				</table>
			</form>
			<div class="btndiv">
				<button class="btn" onclick="mysubmit()">提 交</button>
			</div>


		</c:if>
		<c:if test="${app!=null and app.state==1}">
			<img alt="" src="${ctx}/static/images/applying.png">
			<div class="applydiv">受理中...</div>
		</c:if>
		<c:if test="${app!=null and app.state==2}">
			<img alt="" src="${ctx}/static/images/applyed.png">
			<div class="applydiv">成功</div>
		</c:if>

	</div>
	<div class="tip">温馨提示： 我们会在3个工作日内联系您，请保持电话畅通。</div>
	<div style="text-align: center;margin-top:0px;margin-bottom:0px;">
		 <img alt="" src="${ctx}/static/jsy/telephone.png" style="vertical-align: middle;"><span style="font-size: 13px;">&nbsp;热线电话：<a href="tel:4000510222">4000510222</a></span>
    </div>
	<div style="text-align:center;margin-top:0;">
		<img src="${ctx}/static/jsy/city.jpg" width="100%">
	</div>
	<div id="showtip" class="showtip"></div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#name").val("");
		$("#telephone").val("");
		$("#referee").val("");
		$("#refereephone").val("");
	});
	function mysubmit() {
		var name = $("#name").val();
		var tel = $("#telephone").val();
		var refereename = $("#referee").val();
		var refereetel = $("#refereephone").val();
		if (name.trim() == "") {
			alerttip("请输入姓名", 2000);
			return false;
		}
		if (tel.trim() == "") {
			alerttip("请输入联系电话", 2000);
			return false;
		} else {
			if (!isnum(tel)) {
				alerttip("联系电话输入不正确", 2000);
				return false;
			}
		}
		
		if(tel == refereetel) {
			alerttip("电话号码不能相同", 2000);
			return false;
		}
		
		if(refereetel != '' && refereename =='') {
			alerttip("请输入推荐人姓名", 2000);
			return false;
		}
		
		if(refereename !='' && refereetel == '' ) {
			alerttip("请输入推荐人手机号码", 2000);
			return false;
		}
		
		if (!isnum(refereetel)) {
			alerttip("推荐人手机号码输入不正确", 2000);
			return false;
		}
		
		
		$("#myform").submit();
		$(".btn").attr("disabled", "true");
	}
	function hidetip() {
		$("#showtip").css("bottom", "-30px");
	}
	function alerttip(str, ms) {
		$("#showtip").html(str);
		$("#showtip").animate({
			bottom : "30px"
		}, 500);
		setTimeout("hidetip()", ms);
	}
	function isnum(num) {
		var reg = new RegExp("^[0-9]*$");
		return reg.test(num);
	}
</script>
</html>