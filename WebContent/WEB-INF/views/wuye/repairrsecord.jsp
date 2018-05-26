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
<!-- 2016-4-16 #袁伟 版本[1.0] -->
<title>物业报修(${comname})</title>

<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wnx/css/weui.min.css" />
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/wuyebaoxiu.css" />
<!-- 和其他页面有冲突的css -->
<style type="text/css">
.footer{
	position: fixed;
	bottom: 0px;
	left: 0px;
	background-color: #fff;
	z-index: 5;
}
.ko{
	width: 100%;
	background-color: #eeeff0;
}
#jzgd {
    width: 100%;
    background-color: white;
    text-align: center;
    color: #eb621d;
    line-height: 35px;
    font-size: 15px;
}
.head_i{
	background-color: #fff;
}

@keyframes show{
	
	to{ 
	-webkit-transform: translate3d(0, 0, 0);
	    transform: translate3d(0, 0, 0);
	opacity: 1;
	}
}
@-webkit-keyframes show {
	
	to{ 
	-webkit-transform: translate3d(0, 0, 0);
	    transform: translate3d(0, 0, 0);
	opacity: 1;
	}
}

@-webkit-keyframes hide {

  to {
    opacity: 0;
    -webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
  }
}

@keyframes hide {

  to {
    opacity: 0;
    -webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
  }
}
.hide{
	animation-name: hide;
	animation-duration:0.5s;
    animation-delay:0;
    animation-fill-mode: forwards;
    -webkit-animation-name: hide;
    -webkit-animation-duration: 0.5s;
    -webkit-animation-delay:0;
    -webkit-animation-fill-mode:forwards ;
}
.show{
	animation-name: show;     
    animation-duration:0.5s;            
    animation-delay:0;                 
    animation-fill-mode:forwards ;                                                                           
    -webkit-animation-name:show;
    -webkit-animation-duration: 0.5s;
     -webkit-animation-delay:0;
    -webkit-animation-fill-mode:forwards ;
}
.nodata{
	width: 40%;
    padding: 100px 30% 0px;
}
</style>
</head>
<body bgcolor="#eeeff0">
	<!-- 头部(页面pNav导航) -->
	<div class="head clearfix" id="head" role="header">
		<div class="box_tab" style="border-right: 1px solid #E1E1E1;border-bottom: 1px solid #E1E1E1;" onclick="gotobx()">我要报修</div>
		<div class="box_tab  on" onclick="gotobxxq()">报修记录</div>
	</div>
	<!-- 状态选择 -->
	<div class="head_i clearfix" role="header">
		<div class="chos">
			<div class="state" id="state">
				<p id="state_que">全部</p>
				<!-- 隐藏状态属性 -->
				<input type="hidden" value="0" id="hid_state"/>
			</div>
			<ul class="chos_states" id="chos_states">
				<li class="chos_states_li" id="chos_states_li">全部</li>
				<li value="0">全部</li>
				<li value="1">已解决</li>
				<li value="2">未解决</li>
			</ul>
			<div class="shield" id="shield"></div>
		</div>
	</div>
	<!-- 内容部分(信息显示)[有图片] -->
	<div class="content_main" role="content" id="content_main">
		
	</div>
	<p  onclick="content_get()" id="jzgd">点击加载更多</p>
	<!-- 撑空间 -->
	<div class="ko" id="ko"></div>
	<!-- 底部(模块mNav导航) -->
	<div class="footer" id="footer" role="footer">
		<div class="left_footer lo" style="border-right: 1px solid #E1E1E1">物业报修</div>
		<div class="right_footer" onclick="gotowyjf()">物业缴费</div>
	</div>
	<!-- 分页隐藏域 -->
	<input type="hidden" value="0" id="page_f"/>
	<input type="hidden" value="${openid}" id="openid"/>
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
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/wxfile/wuye/js/wuye.js"
	type="text/javascript"></script>
<script src="${ctx}/static/Clamp/clamp.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
					
				});
				//切换状态
				$("#page_f").val(0);
				changeState(1);
				content_get(2);
			});
	//选择状态
	function changeState() {
		$("#state").bind("click", function() {//要选择时
			$("#chos_states_li").html($("#state_que").html());
			//样式切换
			$("#shield").css("display","block");
			//左移动画
			sh();
		});
		$("#chos_states li:gt(0)").bind("click", function() {
			$("#state_que").html($(this).html());//选择后显示赋值
			$("#chos_states_li").html($(this).html());
			$("#hid_state").val($(this).val());//状态属性赋值
			$("#page_f").val(0);//清零分页记录
			//加载按钮的显示
			$("#jzgd").html("已无更多");
			$("#jzgd").css("background-color","#eeeff0");
			$("#jzgd").css("color","#FD544F");
			$("#jzgd").css("position","relative");
			$("#jzgd").css("top","-2px");
			//左移动画
			hd();
			//调用加载数据
			content_get(1);
		});
		$("#chos_states li:eq(0)").bind("click", function() {
			//左移动画
			hd();
		});
	}
	function sh(){
		$('#chos_states').removeClass("show").removeClass("hide").addClass("show");
		//在动画效果结束后给该模块一个动画结束时的固定样式。在下次移除class时不会出现直接消失的情况
		$('#chos_states').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			    $(this).css("transform","translate3d(0, 0, 0)"); 
			    $(this).css("-webkit-transform","translate3d(0, 0, 0)"); 
				$(this).css("opacity","1"); 
			    $(this).removeClass("hide");
		    });
	}
	function hd(){
		$("#shield").css("display","none");
		$('#chos_states').removeClass("hide").removeClass("show").addClass("hide");
		//在动画效果结束后给该模块一个动画结束时的固定样式。在下次移除class时不会出现直接消失的情况
		$('#chos_states').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			    $(this).css("transform","translate3d(100%, 0, 0)"); 
			    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
				$(this).css("opacity","0"); 
			    $(this).removeClass("hide");
		    });
	}

	//页面跳转(物业保修)
	function gotobx() {
		window.location.href = "${ctx}/wxcommunity/repair?commid=${commid}";
	}
	//页面跳转(报修列表)
	function gotobxxq() {
		window.location.href = "${ctx}/wxcommunity/torepair?commid=${commid}";
	}
	//报修详情
	function gotoDetail(id){
		window.location.href = "${ctx}/wxcommunity/redetail?id="+id; 
	}
	//页面跳转(物业缴费)
	function gotowyjf() {
		window.location.href = "${ctx}/wxcommunity/showwyjf";
	}

	/**********************************报修记录************************************/
	//报修记录获取
	function content_get(m){
		var openid = $("#openid").val();
		var start = $("#page_f").val();//分页开始
		var state =  $("#hid_state").val();//选择的查看数据状态[0,1,2]
		var size = 10;
		var repairHtml = "";
		var url = "${ctx}/wxcommunity/replist";
		var obj = {
				"openid":openid,//社区id
				"state":state,//状态
				"start":start,//每页起始条数
				"size":size//每次加载条数
		};
		$.post(
			url,
			obj,
			function(e){
				if(e.result == 0){//没有返回数据时显示无法加载
					if(!(null == m || "" == m)){
						$("#content_main").html("");
						$("#nodata").remove();
						$("#jzgd").before("<img src='/nsh/static/wxfile/main1601/image/nodata.png' class='nodata' id='nodata'>");
						$("#jzgd").html("暂无数据");
						$("#jzgd").css("background-color","#eeeff0");
						$("#jzgd").css("color","#7a7070");
						$("#jzgd").css("font-size","18px");
						$("#jzgd").css("position","relative");
						$("#jzgd").css("top","-35px");
					}else{
						$("#nodata").remove();
						$("#jzgd").html("已无更多");
						$("#jzgd").css("background-color","#eeeff0");
						$("#jzgd").css("color","#FD544F");
						$("#jzgd").css("position","relative");
						$("#jzgd").css("top","-2px");
						$("#jzgd").css("font-weight","normal");
					}
				}else if(e.result == 1){
					$("#nodata").remove();
					start =parseInt(start, 10) + size;
					$("#page_f").val(start);
					var dataLen = e.data.length;
					for(var i = 0 ; i < dataLen ; i++){
						repairHtml = repairHtml + "<div class='content_only'>"
// 												+ "<article>"	
// 												+ "<header>"
												+ "<div class='tittle clearfix'>"
												//接收的时间是毫秒 用Date方法处理
												+ "<p class='tittle_time fl'>日期：<time>"+timeSelectD(e.data[i].createtime)+"</time></p>";
						if(e.data[i].state==4){//state等于4是已经解决的，不等于4就是处理中
							repairHtml = repairHtml	+ "<p class='tittle_state sta1 fr'>已解决</p>";
						}else{
							repairHtml = repairHtml	+ "<p class='tittle_state sta2 fr'>未解决</p>";
						}
						if("" == e.data[i].infourl || null == e.data[i].infourl){//没插图
							repairHtml = repairHtml	+ "</div>"
// 													+ "</header>"
// 													+ "<section>"
													+ "<div class='content_content clearfix' onclick='gotoDetail("+e.data[i].id+")'>"
													+ "<div class='content_text  content_no_img'>"
													+ "<p class='three_content'>"+e.data[i].content+"</p>"
													+ "</div>"
													+ "</div>"
// 													+ "</section>"
// 													+ "</article>"
													+ "</div>";	
						}else{//有插图
							repairHtml = repairHtml	+ "</div>"
// 													+ "</header>"
// 													+ "<section>"
													+ "<div class='content_content clearfix content_yw' onclick='gotoDetail("+e.data[i].id+")'>"
													+ "<div class='content_image' style='background: url(\""+e.data[i].infourl+"?imageView2/2/w/200|imageMogr2/auto-orient\") no-repeat;background-size: cover;'></div>"
													+ "<div class='content_text' style='padding-left:75px;'>"
													+ "<p class='three_content'>"+e.data[i].content+"</p>"
													+ "</div>"
													+ "</div>"
// 													+ "</section>"
// 													+ "</article>"
													+ "</div>";	
						}
						
					}
					//当返回数据小于或等于一页数据时(显示无法加载)
					if(dataLen < size){
						$("#jzgd").html("已无更多");
						$("#jzgd").css("background-color","#eeeff0");
						$("#jzgd").css("color","#FD544F");
						$("#jzgd").css("position","relative");
						$("#jzgd").css("top","-2px");
						$("#jzgd").css("font-weight","normal");
					}
					if(null == m || "" == m){//区分点击加载和刷新页面
						$("#content_main").append(repairHtml);//加载就在后面添加
					}else{
						$("#content_main").html(repairHtml);//刷新或换状态就刷新全部内容
					}
				}
					//每次加载都将页面文本部分3行省略处理
					line_content();
					height_cont();
			}
		);
	}
	//js库文本几行显示方法
	function line_content(){
		var p_length = $(".three_content").length;
		for(var i = 0; i < p_length ; i++){
			$clamp($(".three_content")[i], {
				clamp : 3,//参数输入几就显示几行
				useNativeClamp : false
			});
		}
	}
	//自适应高度
	function height_cont(){
		var p_length = $(".content_yw").length;
		for(var i = 0; i < p_length ; i++){
			if(parseInt($($(".content_yw")[i]).height(), 10)<66){
				$($(".content_yw")[i]).height(66);
			}
		}
	}
</script>
</html>