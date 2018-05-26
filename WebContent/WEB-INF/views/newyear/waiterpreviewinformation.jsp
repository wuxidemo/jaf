
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
	href="${ctx}/static/wxfile/newyear/css/waiterpreviewinformation.css"
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
	<div id="whole_middle">
		<div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;:</div>
					<div id="xm"></div>
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">手机号码&nbsp;:</div>
					<div id="shouji"></div>
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">店铺名称&nbsp;:</div>
					<div id="dpmc"></div>
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">个人心语&nbsp;:</div>
					<div id="grxy"></div>
				</div>
			</div>
		</div>
		<div id="henxian1"></div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">个人工作照&nbsp;:</div>
					<div id="grgzz">
						<img id="tianjia" orsrc="${wait.url}" 
							src="">	 				
					</div>
				</div>
			</div>
			<div id="henxian2"></div>
			<input id="a" name="url">
			<div id="whole_foot">
				<div id="fanhuishouye">
				<button type="button" onclick="returnhome()" id="homepage">返回首页</button>
			</div>
			<div id="bianji">
				<button type="button" onclick="edit()" id="edit">编辑</button>
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
$(document).ready(function(){
	$("#xm").html("${wait.name}");
	$("#shouji").html("${wait.telephone}");
	$("#dpmc").html("${wait.mername}");
	$("#grxy").html("${wait.context}");
	
	//$("#grgzz").height($("#grgzz").width());
	bindshow("#tianjia");
	$("#tianjia").attr("src","${wait.url}?imageView2/2/w/300|imageMogr2/auto-orient");
});	
	
	/* img.onload=function(){
		if(img.width>img.height)
		{
		$("#grgzz img").css("height","100%");
		$("#grgzz img").css("left","50%");
		$("#grgzz img").css("top","0");
		$("#grgzz img").css("margin-left",   "-"+(img.width*$("#grgzz").width()/img.height/2)+"px");
		}
		else
		{
		$("#grgzz img").css("width","100%");
		$("#grgzz img").css("top","50%");
		$("#grgzz img").css("left","0");
		$("#grgzz img").css("margin-top",   "-"+(img.height*$("#grgzz").width()/img.width/2)+"px");
		}
	} */
	
	function edit() {
		window.location.href = "${ctx}/waiter/waditsc";
	}
	
	function returnhome() {
		window.location.href = "${ctx}/wxurl/redirect?url=waiter/";
	}
	
	function bindshow(tab) {
		$(tab).css("position", "absolute");
		$($(tab).parent()).css("position", "relative");
		$($(tab).parent()).css("overflow", "hidden");
		$(tab).bind(
				"load",
				function() {
					if ($(this).attr("asrc") == null) {
						var $this = $(this);
						var oImg = new Image();
						oImg.onload = function() {
							if (oImg.width > oImg.height) {
								$this.css("height", "100%");
								$this.css("left", "50%");
								$this.css("top", "0");
								$this.css("margin-left", "-"
										+ (oImg.width * $this.parent().width()
												/ oImg.height / 2) + "px");
								$this.css("width", "auto");
								$this.css("margin-top", 0);
							} else {
								$this.css("width", "100%");
								$this.css("top", "50%");
								$this.css("left", "0");
								$this.css("margin-top", "-"
										+ (oImg.height * $this.parent().width()
												/ oImg.width / 2) + "px");
								$this.css("height", "auto");
								$this.css("margin-left", 0);
							}
						}
						oImg.src = $(this).attr("src");

					}

				});
				$(tab).attr("src",$(tab).attr("src"));
	}
	
	$(document).ready(function() {

		ImagesZoom.init({
			"elem" : "#grgzz"
		});

	}); 
</script> 
</html>