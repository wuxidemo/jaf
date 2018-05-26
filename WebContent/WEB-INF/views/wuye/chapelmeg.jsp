<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 2016-4-20 #袁伟 版本[1.0] -->
<title>个人信息</title>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<style type="text/css">
.weui_input{
	font-size: 13px;
}
.weui_cell_hd{
	font-size: 14px;
	padding-right: .3em;
}
.weui_cells{
	background-color:#eeeff0;
}
.weui_cell{
	background-color: #fff;
}
.weui_input[type="radio"]{
	width: 0px;
}
.weui_input[type="radio"]+label{
	margin-right: 10px;
	font-size: 13px;
	color: #494949;
	position: relative;
	display: inline-block;
}
.weui_input[type="radio"]+label:BEFORE{
	content: " ";
	display:inline-block;
	width: 12px;
	height: 12px;
	border: 1px solid #9FA0A0;
	border-radius: 7px;
	position: relative;
	top: 2px;
	margin-right: 7px;
}
.radio_yw[type="radio"]+label:BEFORE{
	border: 1px solid #F8BA1E;
}
.radio_yw[type="radio"]+label:AFTER{
	content: " ";
	display:inline-block;
	width: 6px;
	height: 6px;
	border: 1px solid #F8BA1E;
	border-radius: 4px;
	position: absolute;
	background-color: #F8BA1E;
	top: 5px;
	left: 3px;
}

.weui_cell_select_1 .weui_cell_bd:after {
    -webkit-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    transform: rotate(45deg);
    height: 6px;
    width: 6px;
    border-width: 2px 2px 0 0;
    border-color: #C8C8CD;
    border-style: solid;
    position: absolute;
    top: 50%;
    right: 10%;
}

.weui_cell_select_1 .weui_cell_bd:after, 
.weui_select_before .weui_cell_hd:before {
    content: " ";
    display: inline-block;
    margin-top: -3px;
}

.weui_select{
	font-size: 13px;
	color: #9FA0A0;
}
.weui_btn_primary{
	background-color: #F8BA1E;
	font-size: 15px;
	margin-top: 40px;
}
.weui_btn_primary:ACTIVE{
	background-color: #e3a706;
}
.weui_cells{
	border-top: 0px;
}
</style>
</head>
<body>
	<div id="change_htm">
		<div class="weui_cells" style="border-bottom: 1px solid #eeeff0;">
			<!-- 头像  -->
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary head_img" id="tianjiadiv">
				<c:choose>
					<c:when test="${userinfo.headimgurl==null}">
						<!-- 默认头像 -->
						<img id="tianjia" src="${ctx}/static/wxfile/wuye/image/2.png">
					</c:when>
					<c:when test="${userinfo.headimgurl==''}">
						<!-- 默认头像 -->
						<img id="tianjia" src="${ctx}/static/wxfile/wuye/image/2.png">
					</c:when>
					<c:otherwise>
						<img id="tianjia" src="${userinfo.headimgurl}?imageView2/2/w/50|imageMogr2/auto-orient" alt="头像图片">
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
		<form action="" id="inputForm">
			<div class="weui_cells">
				<!-- 姓名 -->
				<div class="weui_cell weui_cells_form">
					<div class="weui_cell_hd">
						<label class="weui_label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" maxlength="5" name="name" value="${userinfo.name}"
							onblur="checkClear(this,0,'请输入姓名')" onkeyup="onchangeClear(this)"
							placeholder="请输入您的姓名" id="name" />
					</div>
					<div class="weui_cell_ft">
						<i class="weui_icon_warn"></i>
					</div>
				</div>
				<!-- 性别 -->
				<div class="weui_cell weui_cells_form">
					<div class="weui_cell_hd">
						<label class="weui_label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<c:choose>
							<c:when test="${userinfo.sex==1}">
								<input class="weui_input radio_yw" type="radio" name="sex"id="boy" value="1" checked="checked" /> 
								<label for="boy" onclick="choBoy()">男</label> 
								<input class="weui_input" type="radio" name="sex" id="gril" value="2" /> 
								<label for="gril" onclick="choGril()">女</label>
							</c:when>
							<c:otherwise>
								<input class="weui_input" type="radio" name="sex"id="boy" value="1" /> 
								<label for="boy" onclick="choBoy()">男</label> 
								<input class="weui_input radio_yw" type="radio" name="sex" id="gril" value="2" checked="checked" /> 
								<label for="gril" onclick="choGril()">女</label>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- 年龄 -->
				<div class="weui_cell weui_cells_form">
					<div class="weui_cell_hd">
						<label class="weui_label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" maxlength="2" name="age" value="${userinfo.age}"
							onblur="checkClear(this,0,'请输入姓名')" onkeyup="onchangeClear(this)"
							placeholder="请输入您的年龄" id="age" />
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
							onblur="checkClear(this,2,'请输入您的手机号')" placeholder="请输入您的手机号"
							name="phone" value="${userinfo.phone}">
					</div>
				</div>
				<!-- 验证码输入(name="authCode") -->
				<div class="weui_cell weui_cells_form"
					style="margin-bottom: 11px;">
					<div class="weui_cell_hd">
						<label class="weui_label">验&nbsp;&nbsp;证&nbsp;&nbsp;码</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" type="" maxlength="8" id="yzm"
							onblur="checkClear(this,2,'请输入验证码')" onkeyup="onchangeClear(this)"
							placeholder="请填写收到的验证码" />
					</div>
					<div id="hqyzm">
						<div id="getbtn" class="getYzm" onclick="getYzMess()">获取验证码</div>
					</div>
				</div>
				<!-- 社区选择 -->
				<div class="weui_cell weui_cell_select_1 weui_select_after"
					style="border-bottom: 1px solid #eeeff0;">
					<div class="weui_cell_hd">
						<label class="weui_label">社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<select class="weui_select" name="community.id"
							style="height: 30px;" id="community">
						</select>
					</div>
				</div>
			</div>
			<!-- 头像图片链接地址隐藏(切换图片地址保存在这，如果不切换头像图片，保存原来的) -->
			<input type="hidden" value="${userinfo.headimgurl}" id="headimgurl"
				name="headimgurl">
			<!-- 传给后台，让后台判断是否是新增还是修改 -->
			<c:choose>
				<c:when test="${xzorxg!=null}">
					<input type="hidden" value="${xzorxg}" id="xzorxg" name="xzorxg">
				</c:when>
				<c:otherwise>
					<input type="hidden" value="0" id="xzorxg" name="xzorxg">
				</c:otherwise>
			</c:choose>
			<!-- openid -->
			<input type="hidden" value="${openid}" id="openid" name="openid">
		</form>
		<div class="container" id="container">
			<div class="button">
				<div class="bd spacing">
					<a href="javascript:;" onclick="yzComparison()"
						class="weui_btn weui_btn_primary">保&nbsp;&nbsp;&nbsp;存</a>
				</div>
			</div>
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
	</div>
	<!-- 隐藏域 -->
	<input type="hidden" id="i_phone" value="">
	<input type="hidden" id="yzm_num" value="0">
	<input type="hidden" id="commid_yw" value="">
	<c:choose>
		<c:when test="${userinfo.headimgurl==null}">
			<input type="hidden" id="headimg_s" value="0">
		</c:when>
		<c:when test="${userinfo.headimgurl==''}">
			<input type="hidden" id="headimg_s" value="0">
		</c:when>
		<c:otherwise>
			<input type="hidden" id="headimg_s" value="1">
		</c:otherwise>
	</c:choose>
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
			//给社区选择框赋值
			getcommunitydata();
		});
		
/*
 * 微信图片上传方法 
 */
function initupload() {
	$("#tianjia").bind("click",
		function() {
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
								{
									"sid" : serverId
								},
								function(d) {
									$("#loadingToast").hide();
									if (d == null) {
										showHint("处理失败！");
										return false;
									} else {
										var imgUrl_c = d+ "?imageView2/2/w/50|imageMogr2/auto-orient";  
										$("#tianjia").attr("src",imgUrl_c);
										$("#headimgurl").val(d);
										$("#headimg_s").val(1);//确定图片已经上传
									}
							});
						}
					});
				}
			});
		});
}

//获取所有的社区列表接口
function getcommunitydata() {
	$.get("${ctx}/wxcommunity/getcommunities",
		function(data){
			if(data.result == '1') {
				var d = data.data;
				for(var i=0; i<d.length; i++) {
					if(d[i].name=='${userinfo.community.name}'){
						$("#community").append('<option value="'+d[i].id+'" selected="selected">'+d[i].name+'</option>');
					}else{
						$("#community").append('<option value="'+d[i].id+'">'+d[i].name+'</option>');
					}
				}
			}else if(data.result == '0'){
				return false;
			}
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
			$("#yzm_num").val("1");
			timeInterval();
			$.post(url, pdata, function(data) {
				if (data.result == 1) {
					showHint(data.msg);//提示验证码发送
					$("#i_phone").val(phone);
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
	var reg = new RegExp("^[0-9]*$");
	var name = $("#name").val();//名字
	var age = $("#age").val();//年龄
	var phone = $("#phone").val();//联系方式
	var yzm = $("#yzm").val();//验证码
	var cha_headimg = $("#headimg_s").val();
	if(cha_headimg == 0){
		showHint("请点击头像图片，上传!");
	}else if ("" == name.trim() || null == name) {
		showHint("请填写姓名");
	}else if(!(reg.test(age.trim()))){
		showHint("请输入正确年龄");
	}else if ("" == age.trim() || null == age) {
		showHint("请填写年龄");
	} else if ("" == phone.trim() || null == phone) {
		showHint("请填写联系方式");
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

/*
form表单提交 异步
1、先通过验证码是否正确
2、提交报修数据
*/
function sysb_form() {
	var commid = $('#community option:selected').val();
	$('#commid_yw').val(commid);
	//第二步提交数据 异步
	var options = {
		type : 'post',
		url : '${ctx}/wxpage/saveuserinfo',
		dataType : 'json',
		success : function(ret) {
			if (ret.result == "1") {
				//切换页面html
				change_htm();
			} else if (ret.result == "0") {
				showHint(ret.msg);
			}
		},
		error : function(ret) {
			showHint("保存失败");
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
				   +				"<h2 class='weui_msg_title'>保存成功</h2>"
				   +			"</div>"
				   +			"<div class='weui_opr_area'>"
				   +				"<p class='weui_btn_area'>"
				   +					"<a href='javascript:;' onclick='gotopelmeg()' class='weui_btn weui_btn_primary' style='background-color: #04BE02;'>返回</a>"
//					   +					"<a href='javascript:;' class='weui_btn weui_btn_default' style='background-color: #f7f7f7; color:ddd;'>取消</a>"
				   +				"</p>"
				   +			"</div>"
				   +		"</div>"
				   +	"</div>"
				   +"</div>";
		
	$("#change_htm").html(change_htm);
}
/*跳转到编辑页面*/
function gotopelmeg(){
	window.location.href = "/nsh/wxpage/towxuserinfo?commid="+$('#commid_yw').val();
}
//男女单选样式切换
function choGril(){//选女
	$("#gril").addClass("radio_yw");
	$("#boy").removeClass("radio_yw");
}
function choBoy(){//选男
	$("#boy").addClass("radio_yw");
	$("#gril").removeClass("radio_yw");
}
</script>
</html>