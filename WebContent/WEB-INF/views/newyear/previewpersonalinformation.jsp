
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>个人信息</title>
<link type="text/css"
	href="${ctx}/static/wxfile/newyear/css/previewpersonalinformation.css"
	rel="stylesheet" />
<style type="text/css">
.imgzoom_pack {
	width: 100%;
	height: 100%;
	position: fixed;
	left: 0;
	top: 0;
	background: rgba(0, 0, 0, .7);
	display: none;
	z-index: 9999;
}

.imgzoom_pack .imgzoom_x {
	color: #fff;
	height: 30px;
	width: 30px;
	line-height: 30px;
	background: #000;
	text-align: center;
	position: absolute;
	right: 5px;
	top: 5px;
	z-index: 1000;
	cursor: pointer;
}

.imgzoom_pack .imgzoom_img {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	overflow: hidden;
}

.imgzoom_pack .imgzoom_img img {
	width: 100%;
	position: absolute;
	top: 50%;
	left: 0;
}
</style>
</head>
<body>
	<section class="imgzoom_pack">
		<div class="imgzoom_x">X</div>
		<div class="imgzoom_img">
			<img src="" />
		</div>
	</section>
	<div id="whole_head">
		<div>
			<img id="tianjia" orsrc="${pro.url}" 
				src="${pro.url}?imageView2/2/w/300|imageMogr2/auto-orient">
		</div>
	</div>
	<div id="whole_middle">
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</div>
				<div id="xm" maxlength="5"></div>
			</div>
		</div>
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;院</div>
				<div id="xy" maxlength="20"></div>
			</div>
		</div>
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div">专业班级</div>
				<div id="zybj" maxlength="10"></div>
			</div>
		</div>
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div">手机号码</div>
				<div id="shouji" maxlength="11"></div>
			</div>
		</div>
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div">作品名称</div>
				<div id="zpmc" maxlength="8"></div>
			</div>
		</div>
		<div id="middltext">
			<div id="middltext_l">
				<div class="middltext_div11">作品介绍</div>
				<div id="zpjs" maxlength="50"></div>
			</div>
		</div>
		<input id="a" name="url"> <input id="b" name="collegestate"
			value="${col}">
		<div id="whole_foot">
			<div id="fanhuishouye">
				<button type="button" onclick="returnhome()" id="homepage">返回首页</button>
			</div>
			<div id="bianji">
				<button type="button" onclick="view()" id="edit">编辑</button>
			</div>
		</div>
	</div>
</body>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script src="${ctx}/static/scale/js/scale.js"></script>
<script type="text/javascript">
	$("#xm").html("${pro.name}");
	$("#xy").html("${pro.college}");
	$("#zybj").html("${pro.tclass}");
	$("#shouji").html("${pro.telephone}");
	$("#zpmc").html("${pro.title}");
	$("#zpjs").html("${pro.context}");

	$("#whole_head div").height($("#whole_head div").width());
	var img=new Image();
	
	img.onload=function(){
		if(img.width>img.height)
		{
		$("#whole_head div img").css("height","100%");
		$("#whole_head div img").css("left","50%");
		$("#whole_head div img").css("top","0");
		$("#whole_head div img").css("margin-left",   "-"+(img.width*$("#whole_head div").width()/img.height/2)+"px");
		}
		else
		{
		$("#whole_head div img").css("width","100%");
		$("#whole_head div img").css("top","50%");
		$("#whole_head div img").css("left","0");
		$("#whole_head div img").css("margin-top",   "-"+(img.height*$("#whole_head div").width()/img.width/2)+"px");
		}
	}
	img.src="${pro.url}?imageView2/2/w/300|imageMogr2/auto-orient";
	
	
	
	function view() {
		window.location.href = "${ctx}/newyearact/editsc";
	}

	function returnhome() {
		window.location.href = "${ctx}/wxurl/redirect?url=newyearact/";
	}
	$(document).ready(function() {

		ImagesZoom.init({
			"elem" : "#whole_head"
		});

	});
	
</script>
</html>