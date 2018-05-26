<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<script type="text/javascript"
	src="${ctx}/static/wxfile/yicang/js/jquery-1.7.1.min.js"></script>
<script src="${ctx}/static/Clamp/clamp.js"></script>
<link type="text/css" rel="stylesheet"
	href="${ctx}/static/wxfile/wuye/css/pensionservice.css">
<script src="${ctx}/static/Clamp/clamp.js"></script>
<title>养老服务活动</title>
<style type="text/css">
.huodongliebiao,.wodeshenqin{
	width: 33%;
}
.huodongliebiao_m{
	width: 33%;
    height: 50px;
    float: left;
    text-align: center;
    line-height: 50px;
    font-size: 18px;
    color: #231815;
    border-right: 1px solid #C3C5C4;
}
</style>
</head>
<body>
	<div class="liebiao">
		<div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>

	<div class="moreloading" id="ddd2" sss="a">
		<div></div>
		<div></div>
		<div></div>
	</div>
	<div id="jzgd" onclick="add();">显示更多</div>
	<div style="width: 100%; height: 50px;"></div>
	<div class="foot">
		<div class="huodongliebiao">养老服务</div>
		<div class="huodongliebiao_m" onclick="qushenq();">申请服务</div>
		<div class="wodeshenqin">申请记录</div>
	</div>
</body>
<script type="text/javascript">
	//我要申请
	function qushenq(){
		window.open("${ctx}/wxpage/toaddinfo?type=2");
	}
	showload();
	var size = 10;
	var start = 0;
	var Allstart = 0;
	var isall = 0;

	$(document).ready(function() {
		$(".huodongliebiao").css("color", "#F8BA1E");
		$(".wodeshenqin").css("color", "#231815");
		yanglaohuodong(start, size);
	});

	//点击显示更多
	/* function add(i){
	       var spanId=i;	
			 var jj=jx[i];
			$("#0"+i).html(jj);
			$("#0"+i).append(
			       '<span id="iner'+i+'" style="background-color:#efefef;color:#727171;padding-left:5px;padding-right:5px;float: right;font-size:14px;"onclick="reduce('+i+')">收起全部'+'</span>'		
			);
			 			
	}*/

	//收起全部
	/* function reduce(i){		 
	 	var paragraph=document.getElementById("0"+i);
		$clamp(paragraph, {clamp: 3, useNativeClamp: false, animate: false,truncationChar:' ',truncationHTML:'...<span class="setcolor" id="'+i+'" style="background-color:#efefef;color:#727171;padding-left:5px;padding-right:5px;font-size:14px;float:right;" onclick="add('+i+')">显示全部</span>'});
	}*/

	//点击显示更多
	function add(kind) {
		if (isall == 0) {
			if (kind = undefined) {
				showmoreload();
			}
			yanglaohuodong(Allstart, size);
		}
	}

	//点击活动列表
	$(".huodongliebiao").bind("click", function() {
		$(".huodongliebiao").css("color", "#F8BA1E");
		$(".wodeshenqin").css("color", "#231815");
		window.open("${ctx}/wxcommunity/showpension");
	});

	//点击我的申请
	$(".wodeshenqin").bind("click", function() {
		$(".huodongliebiao").css("color", "#231815");
		$(".wodeshenqin").css("color", "#F8BA1E");
		window.open("${ctx}/wxcommunity/myapply");
	});

	//点击查看详情
	function xiangq(id) {
		window.open("${ctx}/wxcommunity/pensiondetail?id=" + id);
	}

	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();

		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}

		return year + "-" + month + "-" + dd;
	}

	function yanglaohuodong(start, size) {
		$
				.post(
						"${ctx}/wxcommunity/allpensionservice",
						{
							"start" : start,
							"size" : size
						},
						function(d) {
							hideload();
							hidemoreload();
							if (d.result == 0) {
								if (start == 0) {
									$(".liebiao")
											.html(
													'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
									$("#jzgd").css("display", "none");
									$("#jzgd").css("display", "none");
									$("body").css("background-color","#ffffff");
									isall = 1;
								} else {
									$("body").css("background-color","#eeeff0");
									document.getElementById("jzgd").innerHTML = "已无更多";
									$("#jzgd").css("color", "rgb(253, 84, 79)");
									isall = 1;
								}
							} else if (d.result == 1) {
								$("body").css("background-color","#eeeff0");
								if (d.data.length < size) {
									document.getElementById("jzgd").innerHTML = "已无更多";
									$("#jzgd").css("color", "rgb(253, 84, 79)");
									isall = 1;
								} else {
									$("#jzgd").css("display", "block");
									$("#jzgd").css("color", "#727171");
									isall = 0;
								}
								Allstart = start + d.data.length;

								for (var i = 0; i < d.data.length; i++) {
									var createtime = d.data[i].createtime;
									var state = d.data[i].state;
									var name = d.data[i].name;
									var content = d.data[i].content;
									var picurl = d.data[i].picurl
											+ "?imageView2/2/w/300|imageMogr2/auto-orient";
									var id = d.data[i].id;
									//jx[i]= content;
									$(".liebiao")
											.append(
													'<div class="alldiv">'
															+ '<div class="top">'
															+ '<div class="riqi">日期:'
															+ formattime(createtime)
															+ '</div>'
															+ (state == 1 ? '<div class="zhuangtai" style="color:#0B8F77;">正进行</div>'
																	: (state == 2 ? '<div class="zhuangtai" style="color:#fd544f;">已结束</div>'
																			: ''))
															+ '</div>'
															+ '<div class="bottom">'
															+ '<div class="kong"></div>'
															+ '<div class="middle" onclick="xiangq('
															+ id
															+ ');">'
															+ '<div class="left">'
															+ '<div class="tupian">'
															+ '<div style="background: url(\''
															+ picurl
															+ '\') no-repeat; background-size: cover;  background-position: 50%;"></div>'
															+ '</div>'
															+ '</div>'
															+ '<div class="right">'
															+ '<div class="mingcheng">'
															+ name
															+ '</div>'
															+ '<div class="miaoshu" id="0'+i+'">'
															+ content
															+ '</div>'
															+ '</div>'
															+ '</div>'
															+ '<div class="kong"></div>'
															+ '</div>'
															+ '</div>'
															+ '<div class="hui"></div>');
									var paragraph = document.getElementById("0"
											+ i);
									$clamp(paragraph, {
										clamp : 3,
										useNativeClamp : false,
										animate : false,
										truncationChar : ' ',
										truncationHTML : '...'
									});
								}
							}
						})
	}

	function showload() {
		$("#ddd1").css("display", "block");
	}

	function hideload() {
		$("#ddd1").css("display", "none");
	}

	function showmoreload() {
		$("#ddd2").css("display", "block");
		$("#jzgd").css("display", "none");
	}
	function hidemoreload() {
		$("#ddd2").css("display", "none");
		$("#jzgd").css("display", "block");
	}
</script>
</html>