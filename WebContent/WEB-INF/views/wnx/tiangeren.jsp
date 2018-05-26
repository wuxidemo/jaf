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
<link rel="stylesheet" href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<title>填写个人资料</title>
<style type="text/css">
	body {
		margin: 0;
		font-family: Microsoft YaHei !important;
		font-size: 15px;
		width: 100%;
		height: 100%;
	}
	.weui_label {
		width: 5em !important;
	}
	#tianjia {
		float: right;
		background-size: cover;
		background-position: 50%;
		width: 44px;
		height: 44px;
	}
	.xingbie{
		color: #595757;
		width: 50%;
	}
	
	.weui_cell:before{
		border-top: none !important;
	    width: 100%;
	    height: 1px;
	    color: #D9D9D9;
	    -webkit-transform-origin: 0 0;
	    -ms-transform-origin: 0 0;
	    transform-origin: 0 0;
	    transform: scaleY(.5);
	    left: 0;
	}
	.youchang{
		color: #595757;
		width: 50%;
	}
	.tubiao{
		color: #595757;
		width: 15.4%;
	}
	.tubiao img{
		width: 8px;
	    height: 14px;
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    margin-top: -6px;
	    margin-left: 39%;
	}
	#hqyzm{
		text-align: center;
    	margin: auto;
	}
	#getbtn {
		width: 100%;
	    height: 26px;
	    float: right;
	    color: #F8BA1E;
	    font-size: 12px;
	    border: 1px solid #F8BA1E;
	    border-radius: 5px;
	    background-color: white;
	    line-height: 26px;
	}
	.jiazhen{
		width: 35px;
	    float: left;
	    border: 1px solid #F8BA1E;
	    border-radius: 9px;
	    color: #F8BA1E;
	    text-align: center;
	}
	.jiaoyu{
		width: 35px;
	    float: left;
	    border: 1px solid #F8BA1E;
	    border-radius: 9px;
	    color: #F8BA1E;
	    text-align: center;
	    margin-left: 10px;
	}
	.weixiu{
		width: 35px;
	    float: left;
	    border: 1px solid #F8BA1E;
	    border-radius: 9px;
	    color: #F8BA1E;
	    text-align: center;
	    margin-left: 10px;
	}
	.kong{
		width: 100%;
		height: 10px;
		background-color: #EEEEEE;
	}
	#a{
		display: none;
	}
	.contentback {
	    text-align: center;
	    width: 100%;
	    background-color: white;
	    border-top : 1px solid #DCDDDD;
		margin-bottom: 20px;
	}
	.contentblock {
	    float: left;
	    width: 10%;
	}
	.likecourse {
	    float: left;
	    width: 80%;
	    text-align: left;
	    font-size: 13px;
	    vertical-align: middle;
	}
	.onecourse {
	    width: 90%;
	    display: inline-block;
	    color: #F8BA1E;
	    height: 30px;
	    border: 1px solid #F8BA1E;
	    line-height: 30px;
	    text-align: center;
	    border-radius: 30px;
	    background-color: white;
	    font-size: 15px;
	    cursor: pointer;
	}
	.bgclass{
	    color: white;
	    background-color: #F8BA1E; 
	}
</style>
</head>
<body>
	<div class="weui_cells">
		<form id="tijiaol">
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary" id="tianjiadiv">
					<img id="tianjia" src="${headimgurl}?imageView2/2/w/50|imageMogr2/auto-orient">
				</div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" maxlength="5" id="myname" onblur="nam()"
						placeholder="请输入您的姓名" name="name" value="<c:if test="${wu!=null}">${wu.name}</c:if>">
				</div>
			</div>
			<div class="weui_cell weui_cell_select weui_select_after" style="border-top: 1px solid #DCDDDD;padding-left: 30px;">
				<div class="weui_cell_hd">
					<label class="weui_label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</label>
				</div> 
				<div class="weui_cell_bd weui_cell_primary">
					<select class="weui_select" id="mytype" name="sex">
						<option value="1" <c:if test="${wu!=null and wu.sex==1}">selected=""</c:if> >男</option>
						<option value="2" <c:if test="${wu!=null and wu.sex==0}">selected=""</c:if> >女</option>
					</select>
				</div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" maxlength="2" id="myage" onblur="myag()"
						placeholder="请输入您的年龄" name="age" type="tel">
				</div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">联系方式</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" type="tel" maxlength="11" id="phone" onblur="myphone()"
						placeholder="请输入您的手机号" name="phone" value="<c:if test="${wu!=null}">${wu.phone}</c:if>" >
				</div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">验&nbsp;证&nbsp;码</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" type="tel" maxlength="8" id="yzm" onblur="yanzhenma()"
						placeholder="请填写收到的验证码" onkeyup="setval(this.value)">
				</div>
				<div id="hqyzm">
					<div id="getbtn" onclick="sendsms()" name="">获取验证码</div>
				</div>
			</div>
			<div class="weui_cell weui_cell_select weui_select_after" style="border-top: 1px solid #DCDDDD;padding-left: 30px;">
				<div class="weui_cell_hd">
					<label class="weui_label">社&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</label>
				</div> 
				<div class="weui_cell_bd weui_cell_primary">
					<select class="weui_select" id="community" name="community.id">
					</select>
				</div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">才能类型</label>
				</div>
				
			</div>
			<div class="contentback" style="margin-bottom:0px;padding-top:10px;padding-bottom:10px;">
				<div class="contentblock">&nbsp;</div>
				<div class="likecourse">
					<table style="width:100%;">
						 <c:forEach items="${ablelist}" var="course" varStatus="cou">
						 	<c:if test="${cou.count%4 == 1 }"><tr style="height:50px;"></c:if>
						 		<td style="width:25%;">
						 			<div class="onecourse" onclick="changecolor(this)" value="${course.id}">
										${course.value}
									</div>
						 		</td>
						 	<c:if test="${cou.count%4 == 0 }"></tr></c:if>
						 	<c:set var = "course_count" value = "${cou.count}" /> 
						</c:forEach>
						
						<c:if test = "${course_count%4==1}"> 
							 <td style="width:25%;"></td> 
							 <td style="width:25%;"></td>
							 <td style="width:25%;"></td>  
						 	</tr > 
						 </c:if > 
						 <c:if test = "${course_count%4==2}"> 
						 	<td style="width:25%;"></td>
						 	<td style="width:25%;"></td>  
						 	</tr> 
						 </c:if>
						 <c:if test = "${course_count%4==3}"> 
						 	<td style="width:25%;"></td> 
						 	</tr> 
						 </c:if>
					</table>
				</div>
				<div class="contentblock">&nbsp;</div>
				<br/>
				<div style="clear: both;"></div>
			</div>
			<div class="weui_cell" style="border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">才能描述</label>
				</div>
			</div>
		</div>
		<div class="weui_dialog_bd">
			<div class="weui_cells weui_cells_form">
				<div class="weui_cell">
					<div class="weui_cell_bd weui_cell_primary">
						<textarea id="edtt" class="weui_textarea" placeholder="请简单描述您的才能(不能超过50字)"
							rows="5" onblur="edit()" name="abilitydescrib" maxlength="50"></textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="kong"></div>
		<div class="weui_cells" style="border-top: none;">
			<div class="weui_cell">
				<div class="weui_cell_hd">
					<label class="weui_label">服务时间</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" id="fuwushijian" onblur="tim()"
						placeholder="请填写您能提供服务的时间" name="servertime" maxlength="13">
				</div>
			</div>
			<div class="weui_cell weui_cell_select weui_select_after" style="border-top: 1px solid #DCDDDD;padding-left: 30px;">
				<div class="weui_cell_hd">
					<label class="weui_label">意向报酬</label>
				</div> 	
				<div class="weui_cell_bd weui_cell_primary">
					<select class="weui_select" id="paytype" name="paytype">
						<option selected="" value="1">有偿</option>
						<option value="0">无偿</option>
					</select>
				</div>
			</div>
			<div class="weui_cell" id="teshu" style="border-bottom: 1px solid #DCDDDD;border-top: 1px solid #DCDDDD;">
				<div class="weui_cell_hd">
					<label class="weui_label">参&nbsp;考&nbsp;价</label>
				</div>
				<div class="weui_cell_bd weui_cell_primary">
					<input class="weui_input" id="cankaojia" onblur="price()"
						placeholder="请填写参考价" maxlength="6" name="pay">
				</div>
			</div>
			<input id="a" name="headimgurl" type="hidden">
			<input id="abilityid" name="ability" type="hidden">
			<input id="openid" name="openid" type="hidden" value="${openid}">
			<input id="issave" name="issave" type="hidden">
		</div>
		</form>
	<div class="tjdiv">
		<a href="javascript:;" onclick="submit()"
			class="weui_btn weui_btn_warn">我要提交</a>
	</div>
	<!--微信提示 -->
	<div class="weui_allll" style="display: none;">
		<div class="weui_mask" id="onetishi"></div>
		<div class="weui_dialog" id="onetishi2">
			<div class="weui_dialog_hd"><strong class="weui_dialog_title"></strong></div>
			<div class="weui_dialog_bd" id="weui_dialog_bd">姓名不能为空!</div>
			<div class="weui_dialog_ft">
				<a href="javascript:;" class="weui_btn_dialog primary">确定</a>
			</div>
		</div>
	</div>
	<!--微信提示另一种方式 -->
	<div id="toast" style="display: none;">
		<div class="weui_mask_transparent"></div>
		<div class="weui_toast">
			<i class="weui_icon_msg  weui_icon_warn"></i>
			<p class="weui_toast_content" id="tipp"></p>
		</div>
	</div>
	<!-- 完成页面 -->
	<div class="page slideIn msg mypage"
		style="position: fixed; top: 0; left: 0; right: 0; background-color: white; bottom: 0; z-index: 99; display: none">
		<div class="weui_msg">
	        <div class="weui_icon_area">
				<i class="weui_icon_success weui_icon_msg"></i>
			</div>
	        <div class="weui_text_area">
	            <h2 class="weui_msg_title">提交成功!</h2>
	        </div>
	        <div class="weui_opr_area">
	            <p class="weui_btn_area">
	                <a href="javascript:;" class="weui_btn weui_btn_primary" onclick="view()">查看我的信息</a>
	                <a href="javascript:;" class="weui_btn weui_btn_default" onclick="returnhome()">返回</a>
	            </p>
	        </div>
		</div>
	</div>
	<div class="weui_dialog_confirm" id="dialog1" style="display: none;">
		<div class="weui_mask" style="display: block !important;"></div>
		<div class="weui_dialog" style="display: block;">
			<div class="weui_dialog_hd">
				<strong class="weui_dialog_title"></strong>
			</div>
			<div class="weui_dialog_bd" style="text-align: center !important;">是否用当前填写的信息替换原个人信息?</div>
			<div class="weui_dialog_ft">
				<a href="javascript:;" onclick="subm(0)"
					class="weui_btn_dialog default">否</a> <a href="javascript:;"
					onclick="subm(1)" class="weui_btn_dialog primary">是</a>
			</div>
		</div>
	</div>
 </div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wnx/js/example.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wnx/js/zepto.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript">
	var oldname = $("#myname").val();
	var oldphone = $("#phone").val();
	var oldsex = $("#mytype").val();
	
	$(document).ready(function(){
		$("#myage").val("");
		$("#yzm").val("");
		$("#edtt").val("");
		$("#fuwushijian").val("");
		$("#cankaojia").val("");
		getcommunitydata();
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
			wx.onMenuShareTimeline({
				title : '个人信息', // 分享标题
				link : '${baseurl}/wxurl/redirect?url=wxcommunity/myinfo', // 分享链接
				imgUrl : '${baseurl}/static/wxfile/wnx/image/tianxiexinxi.png' // 分享图标
			});
			wx.onMenuShareAppMessage({
				title : '个人信息', // 分享标题
				desc : '秀出你的技能', // 分享描述
				link : '${baseurl}/wxurl/redirect?url=wxcommunity/myinfo', // 分享链接
				imgUrl : '${baseurl}/static/wxfile/wnx/image/tianxiexinxi.png' // 分享图标
			});
			initupload();
		});
		
		$("#paytype").bind("change", function() {
			if($("#paytype").val() == "0"){
				$("#teshu").hide();
				$("#yxbc").css("border-bottom","1px solid #DCDDDD");
			}else{
				$("#teshu").show();
				$("#yxbc").css("border-bottom","0");
			}
		});
	});
	
	function changecolor(obj) {
		var thisobj = $(obj);
		thisobj.toggleClass("bgclass");
	}
	
	
	var flag = null;
	var telnum = '';
	var chaval = '';
	var count = null;
	var timer = null;
	var tijiao = 0;
	var error = '<div class="weui_cell_ft"><i class="weui_icon_warn"></i></div>';
	function setval(cha){
		chaval = cha;
	}
	
	function timecount() {
		time--;
		var tipstr = "";
		if (time <= 0) {
			tipstr = "重新发送";
			$("#getbtn").text(tipstr);
			clearInterval(timer);
			$("#getbtn").attr("onclick", "sendsms()");
			$("#phone").attr("disabled",false);
		} else  {
			tipstr = time + "秒后重发";
			$("#getbtn").text(tipstr);
			$("#getbtn").removeAttr("onclick");
		}
	}
	
	function timecountcuowu() {
		var tipstr = "";
			tipstr = "获取验证码";
			$("#getbtn").text(tipstr);
			clearInterval(timer);
			$("#getbtn").attr("onclick", "sendsms()");
	}
	
	//验证验证码是否正确
	function checkCaptcha(telnum,code) {
		if(tijiao == 1){
			return;
		}
		tijiao = 0;
		$.post("${ctx}/wxcommunity/verifycaptcha",
				{
					"phone" : telnum,
					"code" : code
				},
				function(data){
						if(data.result == 1){
							$(".weui_allll").show();
							$("#onetishi").show();
							$("#onetishi2").show();
							document.getElementById("weui_dialog_bd").innerHTML = "验证成功!";
							if (oldphone != ""
								&& oldname != ""
								&& ($("#phone").val() != oldphone || $("#myname").val() != oldname) ||$("#mytype").val()!=oldsex) {
								$("#dialog1").show();
								return false;
							}else{
								subm(0);
							}
						}else if(data.result == 0){
							$(".weui_allll").show();
							$("#onetishi").show();
							$("#onetishi2").show();
							document.getElementById("weui_dialog_bd").innerHTML = "验证码有误!";
							issub = false;
							timecountcuowu();
						}
				});
	}
	
	var issave = 1;
	function subm(state) {
		$("#dialog1").hide();
		issave = state;
		var options ={
				type : 'post',
				url :'${ctx}/wxcommunity/save',
				dataType : 'json',
				success :	function(d){
						issub = false;
						$("#loadingToast").hide();
						if(d.result == 0){
							showtip("您已经上传过作品，请不要重复上传");
						}
						if(d.result == 1){
							$(".mypage").show();
						}
						if(d.result == 2){
							showtip("提交失败!");
						}
				}
		};
		$("#phone").attr("disabled",false);
		$('#tijiaol').ajaxForm(options);
		$('#tijiaol').submit();
	}
	
	
	
	function sendsms(){
		var telnum = $("#phone").val();
		if(telnum == ''){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "请输入您的手机号码";
			return false;
		}else if(telnum.search(/^1[3|4|5|7|8][0-9]\d{8}$/) == -1){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "请输入正确的手机号码";
			return false;
		}else{
			$("#getbtn").removeAttr("onclick");
			$("#yzm").html("");
			$("#phone").attr("disabled",true);
			time = 180;
			timer = setInterval(timecount,1000);
			sendsmsiiii($("#phone").val());
		}
		
	}
	
	//发送短信接口
	function sendsmsiiii(telnum){
		$.post("${ctx}/wxcommunity/sendsms",
				{
					"phone" : telnum
				},
				 function(data){
					  if(data.result == 1){
						 	$(".weui_allll").show();
						 	$("#onetishi").show();
							$("#onetishi2").show();
							document.getElementById("weui_dialog_bd").innerHTML = "短信发送成功";
					  }else if(data.result == 0){
						  	$(".weui_allll").show();
						  	$("#onetishi").show();
							$("#onetishi2").show();
							document.getElementById("weui_dialog_bd").innerHTML = "短信发送失败";
					  }
			   });
	}
	
	//获取所有的社区列表接口
	function getcommunitydata() {
		$.get("${ctx}/wxcommunity/getcommunities",function(data){
			if(data.result == '1') {
				var d = data.data;
				for(var i=0; i<d.length; i++) {
					$("#community").append('<option value="'+d[i].id+'">'+d[i].name+'</option>'
							);
				}
			}else if(data.result == '0'){
				return false;
			}
		});
	}
	
	
	
	$(".weui_dialog_ft").bind("click",function(){
		$(".weui_allll").hide();
		$("#onetishi").hide();
		$("#onetishi2").hide();
	});
	
//焦点事件

	function nam(){
		if($("#myname").val().trim() != ""){
			hideerror($("#myname"));
		}else{
			showerror($("#myname"));
		}
	}
	
	function myag(){
		if($("#myage").val().trim() != ""){
			if(isNaN($("#myage").val())){
				showerror($("#myage"))
			}else{
				hideerror($("#myage"));
			}
		}else{
			showerror($("#myage"));
		}
	}
	
	function myphone(){
		$("#phone").val();
		if(($("#phone").val()) == ""){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "联系方式不能为空!";
			return false;
		}
		if (!testphone($("#phone").val())){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "联系方式格式不正确!";
			return false;
		}
	}
	
	function yanzhenma(){
		$("#yzm").val();
		if($("#yzm").val() == ""){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "验证码不能为空!";
			return false;
		}
	}
	
	function edit(){
		$("#edtt").val();
		if(($("#edtt").val()) == ""){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "才能描述不能为空!";
			return false;
		}
	}
	
	function tim(){
		if($("#fuwushijian").val().trim() != ""){
			hideerror($("#fuwushijian"));
		}else{
			showerror($("#fuwushijian"));
		}
	}
	
	function price(){
		if($("#cankaojia").val().trim() != ""){
			hideerror($("#cankaojia"));
		}else{
			showerror($("#cankaojia"));
		}
	}
	
	
//提交事件	
	var issub = false;
	
	function submit(){
		var isok = true;
		var data = {};
		
		var coustr = '';
		
		$(".onecourse").each(function(){
			if($(this).hasClass("bgclass")) {
				coustr += "," + $(this).attr("value").trim();
			}
		});
		
		if($("#myname").val().trim() != ""){
			hideerror($("#myname"));
			data.author = $("#myname").val();
		}else{
			showerror($("#myname"));
			isok = false;
		}
		if($("#myage").val().trim() != ""){
			hideerror($("#myage"));
			data.author = $("#myage").val();
		}else{
			showerror($("#myage"));
			isok = false;
		}
		if($("#fuwushijian").val().trim() != ""){
			hideerror($("#fuwushijian"));
			data.author = $("#fuwushijian").val();
		}else{
			showerror($("#fuwushijian"));
			isok = false;
		}
		if($("#paytype").val() == "1"){
			if($("#cankaojia").val().trim() != ""){
				hideerror($("#cankaojia"));
				data.author = $("#cankaojia").val();
			}else{
				showerror($("#cankaojia"));
				isok = false;
			}
		}else if($("#paytype").val() == "0"){
			hideerror($("#cankaojia"));
		}
		if(isok == false){
			return;
		}
		if(($("#phone").val()) == ""){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "联系方式不能为空!";
			return false;
		}
		if(edit() == false){
			return false;
		}
		if(coustr == ''){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "请选择才能类型";
			return false;
		}else{
			$("#abilityid").val(coustr.substring(1));
		}
		/* $("#a").val();
		if (($("#a").val()) == "") {
			$(".weui_mask").show();
			$(".weui_dialog").show();
			document.getElementById("weui_dialog_bd").innerHTML = "检查是否上传图片!";
			return false;
		} */
		if($("#yzm").val() == ""){
			$(".weui_allll").show();
			$("#onetishi").show();
			$("#onetishi2").show();
			document.getElementById("weui_dialog_bd").innerHTML = "验证码不能为空!";
			return false;
		}else{
			data.author = $("#yzm").val(); 
			$("#phone").attr("disabled",true);
			checkCaptcha($("#phone").val(),$("#yzm").val());
		}
		$("#issave").val(issave);
		$("#loadingToast").show();
	}
	
	function showerror($this) {
		if ($($this).parent().parent().children().length != 3) {
			$($this).parent().parent().append(error);
		}
	}
	function hideerror($this) {
		if ($($this).parent().parent().children().length == 3) {
			$($($this).parent().parent().children()[2]).remove();
		}
	}
	function initupload() {
		$("#tianjiadiv").bind(
				"click",
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
									$.post("${ctx}/wxcommunity/saveimg", 
											{
												"sid": serverId
											},
											function(d) {
												$("#loadingToast")
															.hide();
										if (d == null) {
											$(".weui_allll").show();
											$("#onetishi").show();
											$("#onetishi2").show();
											$(".weui_dialog_bd").html("处理失败!");
											return false;
										} else {
											var oImg = document
													.getElementById("tianjia");
											$(".weui_cell_bd weui_cell_primary").height($(".weui_cell_bd weui_cell_primary").width());
											oImg.onload=function(){
												if(oImg.width>oImg.height)
												{
												$(".weui_cell_bd weui_cell_primary img").css("height","100%");
												$(".weui_cell_bd weui_cell_primary img").css("left","50%");
												$(".weui_cell_bd weui_cell_primary img").css("top","0");
												$(".weui_cell_bd weui_cell_primary img").css("margin-left",   "-"+(oImg.width*$(".weui_cell_bd weui_cell_primary").width()/oImg.height/2)+"px");
												$(".weui_cell_bd weui_cell_primary img").css("width","auto");
												$(".weui_cell_bd weui_cell_primary img").css("margin-top", 0);
												}
												else
												{
												$(".weui_cell_bd weui_cell_primary img").css("width","100%");
												$(".weui_cell_bd weui_cell_primary img").css("top","50%");
												$(".weui_cell_bd weui_cell_primary img").css("left","0");
												$(".weui_cell_bd weui_cell_primary img").css("margin-top",   "-"+(oImg.height*$(".weui_cell_bd weui_cell_primary").width()/oImg.width/2)+"px");
												$(".weui_cell_bd weui_cell_primary img").css("height","auto");
												$(".weui_cell_bd weui_cell_primary img").css("margin-left", 0);
												}
											}
											oImg.src = d
													+ "?imageView2/2/w/50|imageMogr2/auto-orient";
											$("#a").val(d);
										}
									});
								}
							});
						}
					});
				});
	}
	
	function showtip(str) {
		$("#tipp").html(str);
		$("#toast").show();
		setTimeout(function() {
			$("#toast").hide();
		}, 2000);
	}
	
	function view(){
		window.location.href = "${ctx}/wxcommunity/myinfo?comid=${comid}";
	}
	
	function returnhome(){
		window.location.href = "${ctx}/wxurl/redirect?url=wxcommunity/?comid=${comid}";
	}
	
	function testphone(str) {
		return (/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/i
				.test(str));
	}
</script>
</html>