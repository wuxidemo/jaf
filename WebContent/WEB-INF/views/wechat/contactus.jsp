<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<style type="text/css">
body {
	background-color: #dcdddd;
	margin: 0;
}

.topinfo {
	width: 100%;
}

/* .titleimg {
	width: 100%;
}

.titleimg img {
	width: 100%;
}
*/
 .titlecontent {
	width: 100%;
	
}  

.content {
	width: 80%;
	text-align: left;
	margin: auto;
	color:black;
	padding: 20px;
    background-color: #d2f3f3;
    font-size:20px;
}

.jointitle {
	background-color: #dee6e4;
	color: white;
	height: 40px;
	line-height: 45px;
}

.jointitle label:nth-child(1) {
	margin-left: 25px;
	font-size: 20px;
}

.jointitle label:nth-child(2) {
	font-size: 15px;
	margin-left: 15px;
	margin-top: 5px;
}

.subdiv { 
	width: 100%;
	text-align: center;
	margin-top: 20px;
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
	padding-left: 15px;
}

.subdiv table tr td:nth-child(2) {
	width: 70%;
}

.subdiv table input {
	width: 90%;
	border: 1px solid #e8e8e8;
	height: 35px;
}

.subdiv table textarea {
	width: 90%;
	border: 1px solid #e8e8e8;
	height: 60px;
}

.btn {
	background-color: #2bc4b6;
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
	font-size: 12px;
	margin-top: 15px;
	text-align: center;
	margin-bottom: 30px;
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
<title>联系我们</title>
</head>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>

<body style="background-color: #ffffff">
	<div class="topinfo" style="background-color: #7aded7">
		<div class="titlecontent">
		<!--  <div class="content">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金阿福e服务，致力于打造一个属于微时代的商业步行街！
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;金阿福e服务微信公众号作为城市商圈线上服务的统一入口，结合微信支付、微信卡券、微信周边"摇一摇"等功能,服务于商圈内餐饮、休闲娱乐等行业，促进业绩增长及异业合作，提升商圈品牌知名度与活跃度。度维商圈是度维科技实施城市商业服务互联网+的核心策略，实现城市商业服务能力移动化、社交化、便捷化的核心产品。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最接地气的微生活平台，紧扣移动互联网脉搏，创造互联网+共赢体系，金阿福e服务期待各位商家加盟！<br>	
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加盟热线：<a style="color:black ;" href="tel://4000510222">400-0510-222</a>
			</div> -->
			<img src="${ctx}/static/images/yyy.png" style="width:100%;height:aout;">
		</div>
		
		<div class="jointitle" >
			<label style="color:black;">联系我们</label><label style="color: 68696B;">(请填写您的信息)</label>
		</div>
	</div>
	
	<div class="subdiv" style="background-color: #ffffff">
		<c:if test="${app==null}">
			<form id="myform" action="${ctx}/wxorder/saveapply" method="post">
				<table>
					<tr>
						<td><span class="required"style="color: red;">*</span>&nbsp;姓名:</td>
						<td><input id="name" name="name" maxlength="4" style="font-size:16;"></td>
					</tr>
					<tr>
						<td><span class="required"style="color: red;">*</span>&nbsp;联系电话:</td>
						<td><input id="telephone" name="telephone" maxlength="12"style="font-size:16;"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;备注:</td>
						<td><textarea rows="" cols="" name="memo"maxlength="20"style="font-size:16;padding: 8px;"></textarea></td>

					</tr>
				</table>
			</form>
			<div style="font-size: 10;width: 120;position: relative;right: -235;margin-top:-18;height:20px;line-height:15px;"><label">(共可输入20个字符)</label></div>
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
	<div class="tip"style="background-color: #ffffff">温馨提示： 我们会在3个工作日内联系您，请保持电话畅通。</div>
	<div id="showtip" class="showtip"></div>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	});
	//document.addEventListener('touchmove', function(e) {
	//	e.preventDefault();
	//}, false);
	function mysubmit() {
		var name = $("#name").val();
		var tel = $("#telephone").val();
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