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
<!-- 2016-4-15 #袁伟 版本[1.0] -->
<title>评价</title>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<!-- <link type="text/css" rel="stylesheet" -->
<%-- 	href="${ctx}/static/wxfile/wuye/css/comment.css" /> --%>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<!-- 和其他页面有冲突的css -->
<style type="text/css">
.weui_textarea {
	background-color: #f8f8f8;
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
	width: 55px;
	height: 55px;
	position: relative;
}
.close_img{
	position: absolute;
	top: -5px;
	right: -5px;
	width: 10px;
	height: 10px;
	background-color: #000;
	border-radius: 10px;
}
.weui_btn {
	background-color: #F8BA1E;
}

.wy_sy_btn {
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	background-color: #fff;
}

.tittle {
	padding: 0px;
}

.tittle_a {
	width: 85%;
	margin: 10px auto;
}

.weui_btn_area {
	margin: 0.6em 15px .3em;
}

@media screen and (min-width: 639px) {
	.tittle_a {
		width: 82%;
		margin: 10px auto;
	}
}
.weui_textarea{
	font-size: 13px;
}
.weui_uploader_bd{
	overflow-x: visible;
	overflow-y: visible;
}
</style>
</head>
<body>
	<div id="change_htm">
		<!-- 整体内容 -->
		<div class="weui_cells">
			<form action="${ctx}/wxcommunity/" id="inputForm">
				<div class="weui_cell weui_cells_form tittle_a">
					<!-- 头部评价分数(星星图片显示) -->
					<div class="tittle" id="" role="tittleComment">
						<!-- 图片提示 -->
						<div class="text_comment fl">总体评价</div>
						<!-- 图片评价等级显示 -->
						<div class="img_comment fl">
							<img id="img_comment0" alt="1星"
								src="${ctx}/static/wxfile/main1601/stars/0.png"> <img
								id="img_comment1" alt="2星"
								src="${ctx}/static/wxfile/main1601/stars/0.png"> <img
								id="img_comment2" alt="3星"
								src="${ctx}/static/wxfile/main1601/stars/0.png"> <img
								id="img_comment3" alt="4星"
								src="${ctx}/static/wxfile/main1601/stars/0.png"> <img
								id="img_comment4" alt="5星"
								src="${ctx}/static/wxfile/main1601/stars/0.png">
						</div>
					</div>
				</div>
				<!-- 整合文字内容和图片内容 -->
				<div class="together">
					<!-- 报修内容(内容区) -->
					<div class="weui_cell weui_cells_form">
						<!-- 报修文字内容(name="content") -->
						<div class="weui_cell_bd weui_cell_primary">
							<textarea class="weui_textarea" name="content" maxlength="200"
								onblur="checkClear(this,1,'请输入评价内容')" id="text_cont"
								placeholder="写下你的赞美和吐槽（200字以内）..." rows="8"></textarea>
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
				<!-- 隐藏域 -->
				<input type="hidden" value="" id="imgUrl" name="urls" /> <input
					type="hidden" value="0" id="img_score" name="score" /> <input
					type="hidden" value="${openid}" name="openid" /> <input
					type="hidden" value="${merid}" name="merid" /> <input type="hidden"
					value="${orderid}" name="orderid" />
				<!-- 			<input type="hidden" value="aaa"  name="openid"/> -->
				<!-- 			<input type="hidden" value="bb"  name="merid"/> -->
				<!-- 			<input type="hidden" value="123213"  name="orderid"/> -->
			</form>
		</div>
		<!-- 提交按钮 -->
		<div class="wy_sy_btn">
			<div class="weui_btn_area">
				<a class="weui_btn weui_btn_primary" href="javascript:void(0)"
					id="showTooltips" onclick="form_sys_comm()"
					style="margin-top: 0px;">确定</a>
			</div>
		</div>
		<!-- 弹窗提示模块 -->
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
		<!-- 隐藏域 -->
		<!-- 星星显示与否判断 -->
		<input type="hidden" value="0" id="img_hide" />
		<!-- 图片上传数量判断 -->
		<input type="hidden" value="0" id="img_scop" />
		<!-- 隐藏正在加载图 -->
		<div id="loadingToast" class="weui_loading_toast"
			style="display: none;">
			<div class="weui_mask_transparent"></div>
			<div class="weui_toast">
				<div class="weui_loading">
					<!-- :) -->
					<div class="weui_loading_leaf weui_loading_leaf_0"></div>
					<div class="weui_loading_leaf weui_loading_leaf_1"></div>
					<div class="weui_loading_leaf weui_loading_leaf_2"></div>
					<div class="weui_loading_leaf weui_loading_leaf_3"></div>
					<div class="weui_loading_leaf weui_loading_leaf_4"></div>
					<div class="weui_loading_leaf weui_loading_leaf_5"></div>
					<div class="weui_loading_leaf weui_loading_leaf_6"></div>
					<div class="weui_loading_leaf weui_loading_leaf_7"></div>
					<div class="weui_loading_leaf weui_loading_leaf_8"></div>
					<div class="weui_loading_leaf weui_loading_leaf_9"></div>
					<div class="weui_loading_leaf weui_loading_leaf_10"></div>
					<div class="weui_loading_leaf weui_loading_leaf_11"></div>
				</div>
				<p class="weui_toast_content">数据加载中</p>
			</div>
		</div>
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
				/*
					评分星星选择
				 */
				starCom("#img_comment0");
				starCom("#img_comment1");
				starCom("#img_comment2");
				starCom("#img_comment3");
				starCom("#img_comment4");
			});
	/*
	 * 微信图片上传方法 
	 */
	function initupload() {
		var img_num;
		$("#imageFile").bind("click",
			function() {
				img_num = $("#img_scop").val();
				if (img_num < 4) {
					var num = 4 - parseInt(img_num, 10);
					wx.chooseImage({
						count : num, // 默认9
						sizeType : [ 'original',
									'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
						sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
						success : function(res) {
								var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
								for(var i = 0 ; i < localIds.length ; i++){
									wx.uploadImage({
										localId : localIds[i], // 需要上传的图片的本地ID，由chooseImage接口获得
										isShowProgressTips : 1, // 默认为1，显示进度提示
										success : function(res) {
											var serverId = res.serverId; // 返回图片的服务器端ID
											$("#loadingToast").show();
											$.post("${ctx}/wxcommunity/saveimg",
													{"sid" : serverId},
													function(d){
														$("#loadingToast").hide();
														if (d == null) {
															showHint("处理失败！");
															return false;
														} else {
															//在添加图片区域前面添加图片显示模块
															$("#weui_uploader_input_wrp").before("<div class='weui_uploader_input_wrp no' onclick='deleteImg(this)'"
																								+ "style='background: url(\""+d+"?imageView2/2/w/200|imageMogr2/auto-orient\") no-repeat;background-size: cover;'>"
																								+ "<img alt='' src='${ctx}/static/wxfile/images/close.png' class='close_img'></div>");
																					
															//4张图片地址拼接，一次性传给后台
															var imgUrl = $("#imgUrl").val();
															if (!imgUrl) {
																$("#imgUrl").val(d);
															} else {
																d = d + "," + $("#imgUrl").val();
																$("#imgUrl").val(d);
															}
															img_num = parseInt(img_num, 10) + 1;
															$("#img_scop").val(img_num);//记录上传图片张数
															if(img_num == 4){
																$("#weui_uploader_input_wrp").css("display","none");
															}
	
														}
													});
												}
										});
									}
								}
						});
				} else {
					showHint("抱歉，最多上传4张图片！");
				}
			});
	}
	/*删除自己*/
	function deleteImg(e){
		var img_num = $("#img_scop").val();
		img_num = parseInt(img_num, 10) - 1;
		repImgUrl(e);//删除input中储存的图片地址
		$(e).remove();//移除图片
		$("#img_scop").val(img_num);//记录上传图片张数
		$("#weui_uploader_input_wrp").css("display","block");
	}
	/*替换多张图片地址链接中的匹配部分*/
	function repImgUrl(e){
		var bgimg;//div的背景background的值
		var start;//截取url前面位置
		var end;//截取url后面位置
		var img_1;//获取需删除图片地址
		var img_s;//原来图片拼接的字符串
		var img_s1 = [];//原图片地址的数组
		var img_s2 = [];//替换后图片地址的数组
		var img_x;//替换后图片拼接的字符串
		bgimg = $(e).css("background");
		start = bgimg.indexOf("(h");
		end = bgimg.indexOf("?image");
		img_1 = bgimg.substring((start+1),end);
		img_s = $("#imgUrl").val();
		img_s1 = img_s.split(",");
		for(var i = 0 ; i < img_s1.length ; i++){
			if(img_s1[i]!=img_1){
				img_s2.push(img_s1[i]);
			}
		}
		for(var j = 0 ; j < img_s2.length ; j++){
			if(j!=0){
				img_x = img_x + "," + img_s2[j];
			}else{
				img_x = img_s2[j];
			}
		}
		$("#imgUrl").val(img_x);
	}
	/*
	 评分星星选择
	 */
	function starCom(id) {
		$(id).bind({click : function() {//点击选择时处理
					if (
						$(this).prevAll().length > 0) {
						for (var i = ($(this).prevAll().length - 1); i >= 0; i--) {
							$($(this).prevAll()[i]).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
							$(this).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
						}
					} else {
						$(this).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
					}
					$("#img_hide").val("1");
					$("#img_score").val($(this).prevAll().length + 1);
				},
				mouseover : function() {//鼠标移上去时处理(PC端使用)
					var img_hide = $("#img_hide").val("0");
					for (var i = ($(this).siblings().length - 1); i >= 0; i--) {
						$($(this).siblings()[i]).attr("src","${ctx}/static/wxfile/main1601/stars/0.png");
						$(this).attr("src","${ctx}/static/wxfile/main1601/stars/0.png");
					}
					if ($(this).prevAll().length > 0) {
						for (var i = ($(this).prevAll().length - 1); i >= 0; i--) {
							$($(this).prevAll()[i]).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
							$(this).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
						}
					} else {
						$(this).attr("src","${ctx}/static/wxfile/main1601/stars/1.png");
					}
				},
				mouseout : function() {//鼠标移上去时处理(PC端使用)
					var img_hide = $("#img_hide").val();
					if ("1" == img_hide) {
						return false;
					} else {
						if ($(this).prevAll().length > 0) {
							for (var i = ($(this).prevAll().length - 1); i >= 0; i--) {
								$($(this).prevAll()[i]).attr("src","${ctx}/static/wxfile/main1601/stars/0.png");
								$(this).attr("src","${ctx}/static/wxfile/main1601/stars/0.png");
							}
						} else {
							$(this).attr("src","${ctx}/static/wxfile/main1601/stars/0.png");
						}
					}
				}
		});
	}
	/*
	 * 订单评价提交
	 */
	function form_sys_comm() {
		var img_sc = $('#img_score').val();
		var text_c = $('#text_cont').val();
		if("0" == img_sc){
			showHint("请评价打分");
		}else if("" == text_c || null == text_c){
			showHint("请输入评价内容");
		}else{
			var options = {
				type : 'post',
				url : '${ctx}/wxcommunity/savemercomment',
				dataType : 'json',
				success : function(ret) {
					if (ret.result == "1") {
	// 					showHint(ret.msg);
						change_htm();
					} else if (ret.result == "0") {
						showHint(ret.msg);
					}
				},
				error : function(ret) {
					alert(ret);
				}
			};
			$('#inputForm').ajaxForm(options);
			$('#inputForm').submit();
		}
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
					   +				"<h2 class='weui_msg_title'>评价成功</h2>"
					   +			"</div>"
					   +			"<div class='weui_opr_area'>"
					   +				"<p class='weui_btn_area'>"
					   +					"<a href='javascript:;' onclick='success_go()' class='weui_btn weui_btn_primary' style='background-color: #04BE02;'>返回</a>"
// 					   +					"<a href='javascript:;' class='weui_btn weui_btn_default' style='background-color: #f7f7f7; color:ddd;'>取消</a>"
					   +				"</p>"
					   +			"</div>"
					   +		"</div>"
					   +	"</div>"
					   +"</div>";
			
		$("#change_htm").html(change_htm);
	}
	//页面跳转(评价成功后)
	function success_go() {
		window.location.href = "${ctx}/wxpage/ord";
	}
</script>
</html>