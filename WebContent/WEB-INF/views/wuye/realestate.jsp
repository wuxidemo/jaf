<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 2016-4-14 #袁伟 版本[1.0] -->
<!-- 动态变换社区名字 -->
<title>物业报修(${commname})</title>

<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<!-- 和其他页面有冲突的css -->
<style type="text/css">
.weui_label {
	color: #494949;
}

.weui_input {
	font-size: 13px;
}

.weui_uploader_input_wrp:before {
	background: url("${ctx}/static/wxfile/wuye/image/1.png") no-repeat;
	background-size: 100% 100%;
	width: 50%;
	height: 40%;
}

.no:BEFORE {
	background: url("");
}

.weui_uploader_input_wrp:after {
	width: 0px;
}

.weui_uploader_input_wrp {
	border: 1px dashed #9fa0a0;
}

.weui_textarea {
	background-color: #f8f8f8;
	/* 	border-radius: 5px 5px 0px 0px; */
}
/*
.weui_uploader_input{
	border-radius: 0px 0px 5px 5px;
} */
.weui_btn_primary {
	background-color: #F8BA1E;
}

.footer {
	position: fixed;
	bottom: 0px;
	left: 0px;
	background-color: #fff;
}

.ko {
	width: 100%;
	background-color: #eeeff0;
}

.weui_cell_hd {
	padding-right: .3em;
}
.weui_btn_area {
	margin: 0.6em 15px 1em;
}
.jx_1{
/*  	border-top: 1px solid #DCDDDD;  */
/* 	border-bottom: 1px solid #DCDDDD; */
	height: 12px;
	background-color: #eeeff0;
	width: 100%;
}
.weui_cells{
	border-top: 0px;
}
</style>
</head>
<body ontouchstart>
	<div id="change_htm">
		<!-- 头部(页面pNav导航) -->
		<div class="head clearfix" id="head" role="header">
			<div class="box_tab on" style="border-right: 1px solid #E1E1E1;" onclick="gotobx()">我要报修</div>
			<div class="box_tab" onclick="gotobxxq()" style="border-bottom: 1px solid #E1E1E1;">报修记录</div>
		</div>
		<!-- 内容部分(信息填写) -->
		<div class="body" role="mainbody">
			<!-- form表单 -->
			<form action="" id="inputForm">
				<!-- 姓名(name="name") -->
				<div class="weui_cells">
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">报&nbsp;&nbsp;修&nbsp;&nbsp;人</label>
						</div>
						<div class="weui_cell_bd weui_cell_primary">
							<input class="weui_input" maxlength="5" name="name"
								onblur="checkClear(this,0,'请输入姓名')"
								onkeyup="onchangeClear(this)" placeholder="请输入您的姓名（5字以内）"
								id="name" />
						</div>
						<div class="weui_cell_ft">
							<i class="weui_icon_warn"></i>
						</div>
					</div>

					<!-- 手机号码[需要验证](name="telephone") -->
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">联系方式</label>
						</div>
						<div class="weui_cell_bd weui_cell_primary">
							<input class="weui_input" type="tel" maxlength="11" id="phone"
								onblur="checkClear(this,2,'请输入手机号码')" placeholder="请输入您的电话号码"
								name="telephone" value="">
						</div>
					</div>
					<!-- 验证码输入(name="authCode") -->
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">验&nbsp;&nbsp;证&nbsp;&nbsp;码</label>
						</div>
						<div class="weui_cell_bd weui_cell_primary">
							<input class="weui_input" type="" maxlength="8" id="yzm"
								onblur="checkClear(this,2,'请输入验证码')" onkeyup="onchangeClear(this)"
								placeholder="请填写收到的验证码" />
						</div>
						<div id="hqyzm">
							<div id="getbtn" class="getYzm" onclick="getYzMess()" name="">获取验证码</div>
						</div>
					</div>
					<!-- 地点 (name="address")-->
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点</label>
						</div>
						<div class="weui_cell_bd weui_cell_primary">
							<input class="weui_input" type="" maxlength="20" id="adress"
								onblur="checkClear(this,0,'')" onkeyup="onchangeClear(this)"
								name="address" placeholder="(20字以内)" />
						</div>
						<div class="weui_cell_ft">
							<i class="weui_icon_warn"></i>
						</div>
					</div>
					<div class="jx_1"></div>
					<!-- 报修内容(标题区) -->
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">报修内容</label>
						</div>
					</div>
					<!-- 整合文字内容和图片内容 -->
					<div class="together">
						<!-- 报修内容(内容区) -->
						<div class="weui_cell weui_cells_form">
							<!-- 报修文字内容(name="content") -->
							<div class="weui_cell_bd weui_cell_primary">
								<textarea class="weui_textarea" name="content" maxlength="50"
									onblur="checkClear(this,1,'请填写报修内容')" id="text_content"
									placeholder="请填写所需要报修的情况（50字以内）..." rows="4"></textarea>
							</div>
						</div>
						<!-- 报修内容图片上传 -->
						<div class="weui_cell weui_cells_form clearbefor">
							<div class="weui_cell_bd weui_cell_primary"
								style="display: block;">
								<div class="weui_uploader">
									<div class="weui_uploader_bd" id="imageShow">
										<!-- 图片显示区域 -->
										<!-- <ul class="weui_uploader_files">
										<li class="weui_uploader_file" style="background-image: url()"></li>
									</ul> -->
										<!-- 图片上传(name="imageFile") -->
										<div class="weui_uploader_input_wrp"
											id="weui_uploader_input_wrp">
											<img class="weui_uploader_input" id="imageFile" src="" /> <img
												class="" id="imageFile1" src="" style="display: none;" />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 隐藏图片url提交时上传 -->
				<input id="hid" name="infourl" type="hidden">
				<!-- 隐藏固定数据 -->
				<input name="openid" value="${openid}" type="hidden"> <input
					name="commid" value="${commid}" type="hidden" id="commid">
				<!-- 隐藏是否保存信息状态[暂定1保存，0不保存] -->
				<input name="yesorno" value="" type="hidden" id="opinion_c">
			</form>
			<!-- 隐藏原信息 -->
			<input value="<c:if test="${name!=null}">${name}</c:if>"
				type="hidden" id="y_name"> <input
				value="<c:if test="${phone!=null}">${phone}</c:if>" type="hidden"
				id="y_phone">
			<!-- 提交按钮 -->
			<div class="wy_sy_btn">
				<div class="weui_btn_area">
					<a class="weui_btn weui_btn_primary" href="javascript:void(0)"
						id="showTooltips" onclick="yzComparison()">提&nbsp;&nbsp;交</a>
				</div>
			</div>
			<!-- 撑空间 -->
			<div class="ko" id="ko"></div>
		</div>
		<!-- 底部(模块mNav导航) -->
		<div class="footer" id="footer" role="footer">
			<div class="left_footer lo" style="border-right: 1px solid #E1E1E1">物业报修</div>
			<div class="right_footer" onclick="gotowyjf()">物业缴费</div>
		</div>
		<!-- 弹窗提示模块1 -->
		<div class="weui_allll" id="weui_al" style="display: none;">
			<div class="weui_mask" id="onetishi" style="display: none;"></div>
			<div class="weui_dialog" id="onetishi2" style="display: none;">
				<div class="weui_dialog_hd">
					<strong class="weui_dialog_title"></strong>
				</div>
				<div class="weui_dialog_bd" id="weui_dialog_bd">才能描述不能为空!</div>
				<div class="weui_dialog_ft">
					<a href="javascript:void(0);" class="weui_btn_dialog primary"
						onclick="closeHint()">确定</a>
				</div>
			</div>
		</div>
		<!-- 弹窗提示模块2 -->
		<div class="weui_allll" id="weui_al_2" style="display: none;">
			<div class="weui_mask" id="onetishi_2" style="display: none;"></div>
			<div class="weui_dialog" id="onetishi2_2" style="display: none;">
				<div class="weui_dialog_hd">
					<strong class="weui_dialog_title"></strong>
				</div>
				<div class="weui_dialog_bd" id="weui_dialog_bd_2">才能描述不能为空!</div>
				<div class="weui_dialog_ft">
					<a href="javascript:void(0);" class="weui_btn_dialog primary"
						style="border-right: 2px solid #eeeff0;"
						onclick="que_ch_mess('1')">是</a> <a href="javascript:void(0);"
						class="weui_btn_dialog primary" onclick="que_ch_mess('0')">否</a>
				</div>
			</div>
		</div>
		<!-- 隐藏域 -->
		<input id="comparisonyzm" type="hidden"> 
		<input id="comparisonRe" type="hidden" value="0">
		<input type="hidden" id="yzm_num" value="0">
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wuye/js/wuye.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.form/jquery.form.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				wx.config({
					debug : false,
					appId : '${config.appId}',
					timestamp : '${config.timestamp}',
					nonceStr : '${config.nonceStr}',
					signature : '${config.signature}',
					jsApiList : [ 'onMenuShareTimeline', 'openLocation',
							'onMenuShareAppMessage', 'chooseImage',
							'uploadImage' ]
				});
				wx.error(function(res) {
					//alert("加载错误:" + JSON.stringify(res));
				});
				wx.ready(function() {
					initupload();
				});
				set_name_iphone();//原提交过物业保修的名字和电话直接显示
			});

	/*
	 * 微信图片上传方法 
	 */
	function initupload() {
		$("#imageFile").bind("click",function() {
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
						$("#loadingToast").show();
						$.post(
							"${ctx}/wxcommunity/saveimg",
							{"sid" : serverId},
							function(d) {
								$("#loadingToast").hide();
								if (d == null) {
									showHint("处理失败！");
									return false;
								} else {
// 									$("#imageFile").hide();
									var oImg1 = document.getElementById("weui_uploader_input_wrp");
									$("#weui_uploader_input_wrp").height($("#weui_uploader_input_wrp").width());
									$("#weui_uploader_input_wrp").addClass("no");
									oImg1.style.background = "url('"+ d
															+ "?imageView2/2/w/50|imageMogr2/auto-orient"
															+ "') no-repeat";
									oImg1.style.backgroundSize = "cover";
									$("#hid").val(d);
								}
							});
						}
					});
				}
			});
		});
	}

	/*
	 * 获取验证码(先比对手机号码是否符合规范)
	 */
	function getYzMess() {
		var yzm_num = $("#yzm_num").val();
		if("0"==yzm_num){
			var phone = $("#phone").val();//获取电话号码
			var url = '${ctx}/wxcommunity/sendsms';//链接地址
			var pdata = {
				"phone" : phone
			};//链接参数
			if (checkClear(this, 2, "请输入正确的手机号码")) {
				timeInterval();
				$("#yzm_num").val("1");
				$.post(url, pdata, function(data) {
					if (data.result == 1) {
						showHint(data.msg);//提示验证码发送
						opt_ts();//提示保存信息
					} else if (data.result == 0) {
						$("#getbtn").removeClass("onn");
						$("#yzm_num").val("0");
						showHint(data.msg);
					}
				});
			}
		}
	}
	/*
	 * 验证码比对
	 */
	function yzComparison() {
		var name = $("#name").val();//报修人
		var adress = $("#adress").val();//地址
		var text_content = $("#text_content").val();//报修内容
		var yzm = $("#yzm").val();//验证码
		var phone = $("#phone").val();//获取电话号码 
		if ("" == name.trim() || null == name) {
			showHint("请填写姓名");
		} else if ("" == phone.trim() || null == phone) {
			showHint("请填写电话");
		} else if ("" == adress.trim() || null == adress) {
			showHint("请填写地点");
		} else if ("" == text_content.trim() || null == text_content) {
			showHint("请填写报修内容");
		} else if ("" == yzm.trim() || null == yzm) {
			showHint("请填写验证码");
		} else {
			var url = "${ctx}/wxcommunity/verifycaptcha";
			var pdata = {
				"phone" : phone,
				"code" : yzm
			};
			$.post(url, pdata, function(data) {
				if (data.result == 1) {
					sysb_form();//form表单提交 异步
				} else if (data.result == 0) {
					showHint("验证码错误");
				}
			});
		}
	}
	/*****************************start 2016-4-18[添]********************************/
	//用户的旧信息填入
	function set_name_iphone() {
		$("#name").val($("#y_name").val());
		$("#phone").val($("#y_phone").val());
	}
	/*
		询问用户是否保存新填的信息
		0不保存
		1保存
	 */
	function que_ch_mess(i) {
		if (i == 0) {
			$("#opinion_c").val(0);
		} else if (i == 1) {
			$("#opinion_c").val(1);
		}
		closeHint_2();
	}
	/*
		判断是否需要保存提示
	 */
	function opt_ts() {
		var name = $("#name").val();
		var phone = $("#phone").val();
		var y_name = $("#y_name").val()
		var y_phone = $("#y_phone").val()
		if ("" == y_name || "" == y_phone) {
			$("#opinion_c").val(1);
		} else if (y_name == name & y_phone == phone) {
			return;
		} else {
			showHint_2('是否保存新填信息');
		}
	}
	/*********************************end***********************************/
	/*
		form表单提交 异步
		1、先通过验证码是否正确
		2、提交报修数据
	 */
	function sysb_form() {
		//第二步提交数据 异步
		var options = {
			type : 'post',
			url : '${ctx}/wxcommunity/saverepair',
			dataType : 'json',
			success : function(ret) {
				if (ret.result == "1") {
					change_htm();
// 					gotobxxq();
// 					showHint(ret.msg);
				} else if (ret.result == "0") {
					showHint(ret.msg);
				}
			},
			error : function(ret) {
				alert("error");
			}
		};
		$('#inputForm').ajaxForm(options);
		$('#inputForm').submit();
	}
	//提交成功后替换页面html避免重新提交
	function change_htm(){
		$("#change_htm").html("");
		var change_htm = "<div class='container' id='container'>"
					   + 	"<div class='msg'>"
					   +		"<div class='weui_msg'>"
					   +			"<div class='weui_icon_area'>"
					   +				"<i class='weui_icon_safe weui_icon_safe_success'></i>"
					   +			"</div>"
					   +			"<div class='weui_text_area'>"
					   +				"<h2 class='weui_msg_title'>提交成功</h2>"
					   +			"</div>"
					   +			"<div class='weui_opr_area'>"
					   +				"<p class='weui_btn_area'>"
					   +					"<a href='javascript:;' onclick='gotobxxq()' class='weui_btn weui_btn_primary' style='background-color: #04BE02;'>返回</a>"
// 					   +					"<a href='javascript:;' class='weui_btn weui_btn_default' style='background-color: #f7f7f7; color:ddd;'>取消</a>"
					   +				"</p>"
					   +			"</div>"
					   +		"</div>"
					   +	"</div>"
					   +"</div>";
			
		$("#change_htm").html(change_htm);
	}
	
	//页面跳转(物业保修)
	function gotobx() {
		window.location.href = "${ctx}/wxcommunity/repair?commid=${commid}";
	}
	//页面跳转(报修列表)
	function gotobxxq() {
		window.location.href = "${ctx}/wxcommunity/torepair?commid=${commid}";
	}
	//页面跳转(物业缴费)
	function gotowyjf() {
		window.location.href = "${ctx}/wxcommunity/showwyjf";
	}
</script>
</html>