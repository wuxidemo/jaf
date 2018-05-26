
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
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>编辑个人信息</title>
<link type="text/css"
	href="${ctx}/static/wxfile/newyear/css/editpersonalinformation.css"
	rel="stylesheet" />
</head>
<body>
	<div id="all"></div>
	<div id="xmbnwk">姓名不能为空</div>
	<div id="tjsb">
		<div id="tjsb_up">提交失败，请重</div>
		<div id="tjsb_down">新打开活动页面</div>
	</div>
	<div id="all_l">
		<div id="all_updo">
			<div id="all_lup">
				<div id="sc">修改成功</div>
			</div>
			<div id="all_ldown">
				<div>
					<div id="all_ldown_x">感谢您的投稿</div>
				</div>
				<div id="all_ldown_y">
					<p>后续活动请关注金阿福e服务微信平台！</p>
				</div>
			</div>
			<div id="cxfhsy">
				<div id="chakan">
					<button type="button" onclick="returnhome()" id="return_home">返回首页</button>
				</div>
				<div id="fanhuishouye">
					<button type="button" onclick="view()" id="check">查看</button>
				</div>
			</div>
		</div>
	</div>

	<div id="whole_head">
		<div>
			<img id="tianjia" src="${pro.url}?imageView2/2/w/300|imageMogr2/auto-orient">
		</div>
	</div>
	<div id="xzd">勾选图片后点击下方预览选择原图上传</div>
	<form id="tijiaol">
		<div id="whole_middle">
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</div>
					<input id="xm" type="text" maxlength="5" onblur="nam()" name="name"
						value="${pro.name}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;院</div>
					<input id="xy" type="text" maxlength="20" onblur="school()"
					name="college" value="${pro.college}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">专业班级</div>
					<input id="zybj" type="text" maxlength="10" onblur="grade()"
					name="tclass" value="${pro.tclass}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">手机号码</div>
					<input id="shouji" type="text" onblur="phone()" maxlength="11"
					name="telephone" value="${pro.telephone}">
				</div>
			</div>
			<div id="middltext">
				<div id="middltext_l">
					<div class="middltext_div">作品名称</div>
					<input id="zpmc" type="text" maxlength="8" onblur="designation()"
					name="title" value="${pro.title}">
				</div>
			</div>
			<div id="middltext">
				<div class="middltext_div11">作品介绍</div>
				<textarea id="zpjs" type="textarea" maxlength="50"
					onblur="introduce()" name="context">${pro.context}</textarea>
			</div>
			<input id="a" name="url" value="${pro.url}"> <input id="b"
				name="collegestate" value="${col}">
		</div>
	</form>
	<div id="whole_foot">
		<button type="button" id="tijiao" onclick="djtj()">提交</button>
	</div>
</body>
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$("#homepage").bind("click", function() {
		window.location.href = "${ctx}/wxurl/redirect?url=newyearact/";
	});
	wx.config({
		debug : false,
		appId : '${config.appId}',
		timestamp : '${config.timestamp}',
		nonceStr : '${config.nonceStr}',
		signature : '${config.signature}',
		jsApiList : [ 'onMenuShareTimeline', 'openLocation',
				'onMenuShareAppMessage', 'chooseImage', 'uploadImage' ]
	});
	wx.error(function(res) {
		//alert("加载错误:" + JSON.stringify(res));
	});
	wx.ready(function() {
		initupload();
	});
	
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
	
	
	
	
	
	function nam() {
		$("#xm").val();
		if (($("#xm").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "姓名不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}

	function school() {
		$("#xy").val();
		if (($("#xy").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "学院不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}

	function grade() {
		$("#zybj").val();
		if (($("#zybj").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "专业班级不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}
	function phone() {
		$("#shouji").val();
		if (($("#shouji").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "手机号码不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
		if (!(/^1[3|4|5|7|8][0-9]\d{4,8}$/i.test($("#shouji").val()))) {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "手机号码格式不对";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}

	function designation() {
		$("#zpmc").val();
		if (($("#zpmc").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "作品名称不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}

	function introduce() {
		$("#zpjs").val();
		if (($("#zpjs").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "作品介绍不能为空";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
	}

	// 获取设置上传参数
	function djtj(param) {
		if (nam() == false) {
			return false;
		}
		if (school() == false) {
			return false;
		}
		if (grade() == false) {
			return false;
		}
		if (phone() == false) {
			return false;
		}
		if (designation() == false) {
			return false;
		}
		if (introduce() == false) {
			return false;
		}
		$("#a").val();
		if (($("#a").val()) == "") {
			$("#all").show();
			$("#xmbnwk").show();
			document.getElementById("xmbnwk").innerHTML = "检查是否上传图片";
			setTimeout(function() {
				$("#all").hide();
				$("#xmbnwk").hide();
			}, 3000);
			return false;
		}
		var options = {
			type : 'post',
			url : "${ctx}/newyearact/upsave",
			dataType : 'json',
			success : function(data) {
				if (data.result == 1) {
					$("#all_l").show();
				}
				if (data.result == 0) {
					$("#all").show();
					$("#tjsb").show();
					$("#tjsb_up").show();
					$("#tjsb_down").show();
					document.getElementById("tjsb_up").innerHTML = "提交失败,请重";
					document.getElementById("tjsb_down").innerHTML = "新打开活动页面";
					setTimeout(function() {
						$("#all").hide();
						$("#tjsb").hide();
						$("#tjsb_up").hide();
						$("#tjsb_down").hide();
					}, 3000);
				}
				if (data.result == 2) {
					$("#all").show();
					$("#tjsb").show();
					$("#tjsb_up").show();
					$("#tjsb_down").show();
					document.getElementById("tjsb_up").innerHTML = "编辑失败,请重";
					document.getElementById("tjsb_down").innerHTML = "新上传图片";
					setTimeout(function() {
						$("#all").hide();
						$("#tjsb").hide();
						$("#tjsb_up").hide();
						$("#tjsb_down").hide();
					}, 3000);
				}
			},
			error : function(data) {
				//alert(data);
			}
		};
		$('#tijiaol').ajaxForm(options);
		$('#tijiaol').submit();
	}

	function view() {
		window.location.href = "${ctx}/newyearact/jump?col=0";
	}

	function returnhome() {
		window.location.href = "${ctx}/wxurl/redirect?url=newyearact/";
	}

	function initupload() {
		$("#tianjia")
				.bind(
						"click",
						function() {
							wx
									.chooseImage({
										count : 1, // 默认9
										sizeType : [ 'original', 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
										sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
										success : function(res) {
											var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
											wx
													.uploadImage({
														localId : localIds[0], // 需要上传的图片的本地ID，由chooseImage接口获得
														isShowProgressTips : 1, // 默认为1，显示进度提示
														success : function(res) {
															var serverId = res.serverId; // 返回图片的服务器端ID
															$
																	.post(
																			"${ctx}/newyearact/saveimg?sid="
																					+ serverId,
																			function(
																					d) {
																				if (d == null) {
																					$(
																							"#all")
																							.show();
																					$(
																							"#xmbnwk")
																							.show();
																					$(
																							"#xmbnwk")
																							.html(
																									"保存失败");
																					setTimeout(
																							function() {
																								$(
																										"#all")
																										.hide();
																								$(
																										"#xmbnwk")
																										.hide();
																							},
																							3000);

																				} else {
																					var oImg = document
																							.getElementById("tianjia");
																					oImg.onload=function(){
																						if(oImg.width>oImg.height)
																						{
																						$("#whole_head div img").css("height","100%");
																						$("#whole_head div img").css("left","50%");
																						$("#whole_head div img").css("top","0");
																						$("#whole_head div img").css("margin-left",   "-"+(oImg.width*$("#whole_head div").width()/oImg.height/2)+"px");
																						$("#whole_head div img").css("width","auto");
																						$("#whole_head div img").css("margin-top", 0);
																						}
																						else
																						{
																						$("#whole_head div img").css("width","100%");
																						$("#whole_head div img").css("top","50%");
																						$("#whole_head div img").css("left","0");
																						$("#whole_head div img").css("margin-top",   "-"+(oImg.height*$("#whole_head div").width()/oImg.width/2)+"px");
																						$("#whole_head div img").css("height","auto");
																						$("#whole_head div img").css("margin-left", 0);
																						}
																					}
																					oImg.src = d
																							+ "?imageView2/2/w/300|imageMogr2/auto-orient";
																					$(
																							"#a")
																							.val(
																									d);
																				}
																			});
														}
													});
										}
									});
						});
	}
</script>
</html>