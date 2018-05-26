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
<meta name="format-detection"content="telephone=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 2016-4-22 #袁伟 版本[1.0] -->
<c:choose>
	<c:when test="${sqactid == null || sqactid == ''}">
		<title>申请服务</title>
	</c:when>
	<c:otherwise>
		<title>我要申请</title>
	</c:otherwise>
</c:choose>
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
.weui_btn_primary{
	background-color: #F8BA1E;
	font-size: 15px;
}
.button{
	width: 100%;
	margin-top: 30px;
}
.jx_1{
	height: 12px;
	background-color: #eeeff0;
	width: 100%;
}
</style>
</head>
<body>
	<div id="change_htm">
		<form action="" id="inputForm">
			<div class="weui_cells">
				<!-- 姓名 -->
				<div class="weui_cell weui_cells_form">
					<div class="weui_cell_hd">
						<label class="weui_label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" maxlength="5" name="name"
							value="" onblur="checkClear(this,0,'请输入姓名')"
							onkeyup="onchangeClear(this)" placeholder="请输入您的姓名" id="name" />
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
						<input class="weui_input radio_yw" type="radio" name="sex"
							id="boy" value="1" checked="checked" /> <label for="boy"
							onclick="choBoy()">男</label> <input class="weui_input"
							type="radio" name="sex" id="gril" value="2" /> <label for="gril"
							onclick="choGril()">女</label>
					</div>
				</div>
				<!-- 年龄 -->
				<div class="weui_cell weui_cells_form">
					<div class="weui_cell_hd">
						<label class="weui_label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" maxlength="2" name="age"
							value="" onblur="checkClear(this,0,'请输入姓名')"
							onkeyup="onchangeClear(this)" placeholder="请输入您的年龄" id="age" />
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
						<div id="getbtn" class="getYzm" onclick="getYzMess()">获取验证码</div>
					</div>
				</div>
				<!-- 家庭住址输入(name="authCode") -->
				<div class="weui_cell weui_cells_form"
					style="border-bottom: 1px solid #eeeff0;">
					<div class="weui_cell_hd">
						<label class="weui_label">家庭住址</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<input class="weui_input" type="" maxlength="30" id="address_home" name="address"
							onblur="checkClear(this,0,'')" onkeyup="onchangeClear(this)"
							placeholder="请填写您的家庭住址" />
					</div>
					<div class="weui_cell_ft">
						<i class="weui_icon_warn"></i>
					</div>
				</div>
				<c:if test="${sqactid == null || sqactid == ''}">
					<div class="jx_1"></div>
					<!-- 报修内容(标题区) -->
					<div class="weui_cell weui_cells_form">
						<div class="weui_cell_hd">
							<label class="weui_label">申请描述</label>
						</div>
					</div>
					<!-- 报修内容(内容区) -->
					<div class="weui_cell weui_cells_form"
						style="border-bottom: 1px solid #eeeff0; font-size: 13px;">
						<!-- 报修文字内容(name="content") -->
						<div class="weui_cell_bd weui_cell_primary">
							<textarea class="weui_textarea" name="content" maxlength="200"
								onblur="checkClear(this,1,'请填写申请描述')" id="text_content"
								placeholder="请简单描述您的要求（包括服务时间、服务需求）..." rows="4"></textarea>
						</div>
					</div>
				</c:if>
			</div>
			<!-- 后台传递数据 -->
			<input type="hidden" name='type' value="${type}">
			<c:if test="${sqactid != null && sqactid != ''}">
				<input type="hidden" name='pensionAct.id' value="${sqactid}">
			</c:if>
			<input type="hidden" name="openid" value="${openid}">
		</form>
		<!-- 按钮 -->
		<div class="container" id="container">
			<div class="button">
				<div class="bd spacing">
					<a href="javascript:;" onclick="yzComparison()"
						class="weui_btn weui_btn_primary">我要提交</a>
				</div>
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
	<!-- 隐藏域 -->
	<input type="hidden" id="i_phone" value="">
	<!-- 限制验证码多次点击 -->
	<input type="hidden" id="yzm_num" value="0">
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
						'onMenuShareAppMessage']
			});
			wx.error(function(res) {
				//alert("加载错误:" + JSON.stringify(res));
			});
			wx.ready(function() {
			});
		});
		
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
	var address_home = $("#address_home").val();//家庭住址
	var text_content = $("#text_content").val();//申请需求
	if ("" == name.trim() || null == name) {
		showHint("请填写姓名");
	} else if(!(reg.test(age.trim()))){
		showHint("请输入正确年龄");
	} else if ("" == age.trim() || null == age) {
		showHint("请填写年龄");
	} else if ("" == phone.trim() || null == phone) {
		showHint("请填写联系方式");
	} else if ("" == yzm.trim() || null == yzm) {
		showHint("请填写验证码");
	}else if("" == address_home.trim() || null == address_home){
		showHint("请填写家庭住址");
	}else if(!'${sqactid}'){
		if("" == text_content.trim() || null == text_content){
			showHint("请填写申请描述");
		}else{
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
	}else {
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
	//第二步提交数据 异步
	var options = {
		type : 'post',
		url : '${ctx}/wxpage/savepension',
		dataType : 'json',
		success : function(ret) {
			if (ret.result == "1") {
				//切换页面html
				change_htm(ret.applyid);
			} else if (ret.result == "0") {
				showHint(ret.msg);
			}
		},
		error : function(ret) {
			alert("保存失败");
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
				   +				"<p class='weui_btn_area'>";
		if(!'${sqactid}'){
			change_htm = change_htm	 + "<a href='javascript:;' onclick='gotopelact()' class='weui_btn weui_btn_primary' style='background-color: #04BE02;'>返回</a>";
		}else{
			change_htm = change_htm	 + "<a href='javascript:;' onclick='gotopelmeg()' class='weui_btn weui_btn_primary' style='background-color: #04BE02;'>返回</a>";
		}
//					   +					"<a href='javascript:;' class='weui_btn weui_btn_default' style='background-color: #f7f7f7; color:ddd;'>取消</a>"
			change_htm = change_htm	+ "</p>"
				   +			"</div>"
				   +		"</div>"
				   +	"</div>"
				   +"</div>";
		
	$("#change_htm").html(change_htm);
}
//跳转页面
function gotopelmeg(){
	window.location.href = "${ctx}/wxcommunity/pensiondetail?id=${sqactid}";
}
//跳转页面
function gotopelact(){
	window.location.href = '${ctx}/wxcommunity/myapply';
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