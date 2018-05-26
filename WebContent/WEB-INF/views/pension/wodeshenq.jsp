<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<script type="text/javascript" 
	src="${ctx}/static/wxfile/yicang/js/jquery-1.7.1.min.js"></script>
<style type="text/css">
	body{
		margin: 0;
		font-family: Microsoft YaHei;
		font-size: 14px;
		background-color: #eeeff0;
	}
	.foot{
	width: 100%;
    overflow: hidden;
    position: fixed;
    margin: 0;
    bottom: 0;
    border-top: 1px solid #C3C5C4;
    background-color: #FFFFFF;
}
.huodongliebiao{
	width: 33%;
    height: 50px;
    float: left;
    text-align: center;
    line-height: 50px;
    font-size: 18px;
    color: #231815;
    border-right: 1px solid #C3C5C4;
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
.wodeshenqin{
	width: 33%;
    height: 50px;
    float: left;
    text-align: center;
    line-height: 50px;
    font-size: 18px;
    color: #231815;
}
#ddd1{text-align: center;width:100%;height:30px;background-color:white;margin-top: 42px;display: none;}

#ddd2{text-align: center;width:100%;height:30px;background-color:white;margin-top: 15px;display: none;}
	.ball-beat div{ 		
		background-color: #f8ba1e;
		width: 15px;
  		height: 15px;
	  	border-radius: 100%;
	  	margin: 2px;
	  	-webkit-animation-fill-mode: both;
	  	animation-fill-mode: both;
	  	display: inline-block;
	  	-webkit-animation: ball-beat 0.7s 0s infinite linear;
	 	animation: ball-beat 0.7s 0s infinite linear
	 }
	 
	 .moreloading div {
	 	background-color: #f8ba1e;
		width: 15px;
  		height: 15px;
	  	border-radius: 100%;
	  	margin: 2px;
	  	-webkit-animation-fill-mode: both;
	  	animation-fill-mode: both;
	  	display: inline-block;
	  	-webkit-animation: ball-beat 0.7s 0s infinite linear;
	 	animation: ball-beat 0.7s 0s infinite linear
	 }
  
	  @-webkit-keyframes ball-beat {
	  50% {
	    opacity: 0.2;
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75); }

      100% {
      opacity: 1;
      -webkit-transform: scale(1);
            transform: scale(1); } }
            
      @-webkit-keyframes moreloading {
	  50% {
	    opacity: 0.2;
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75); }

      100% {
      opacity: 1;
      -webkit-transform: scale(1);
            transform: scale(1); } }

  @keyframes ball-beat {
  50% {
    opacity: 0.2;
    -webkit-transform: scale(0.75);
            transform: scale(0.75); }

  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }
            
  @keyframes moreloading {
  50% {
    opacity: 0.2;
    -webkit-transform: scale(0.75);
            transform: scale(0.75); }

  100% {
    opacity: 1;
    -webkit-transform: scale(1);
            transform: scale(1); } }
			
  .ball-beat > div:nth-child(2n-1) {
	  -webkit-animation-delay: 0.35s !important;
	  animation-delay: 0.35s !important; 
}
  .moreloading > div:nth-child(2n-1) {
	  -webkit-animation-delay: 0.35s !important;
	  animation-delay: 0.35s !important; 
}
.liebiao{
	width: 100%;
    overflow: hidden;
}
.alldiv{
	padding-left: 5%;
    padding-right: 5%;
    padding-top: 20px;
    padding-bottom: 20px;
    color: #0A0A0A;
    background-color: #FFFFFF;
    border-top: 1px solid #E1E1E1;
    border-bottom: 1px solid #E1E1E1;
    margin-bottom: 10px;
}
.title{
    overflow: hidden;
}
.huodonglx{
	background-color: #34b1ff;
    float: left;
    color: #FFFFFF;
    border-radius: 5px;
    width: 65px;
    text-align: center;
    margin-top: 3px; 
}
.huodongmc{
	width: 70%;
    float: left;
    margin-left: 15px;
    font-size: 18px;
    color: #0A0A0A;
    overflow: hidden;
}
.xia{
	margin-top: 15px;
    width: 100%;
    overflow: hidden;
}
.xingming{
	width: 50%;
    float: left;
    color: #494949;
}
.riqi{
	width: 50%;
    text-align: right;
    float: left;
    color: #808080;
}
.zhijieshenq{
	margin: auto;
    width: 65%;
    background-color: #F8BA1E;
    height: 40px;
    color: #ffffff;
    line-height: 40px;
    font-size: 18px;
    border-radius: 5px;
    text-align: center;
    margin-bottom: 20px;
    margin-top: 20px;
}
#jzgd{
	width: 100%;
    height: 40px;
    line-height: 30px;
    text-align: center;
    font-size: 14px;
    color: #727171;
}
.nodatadiv {
 	margin: auto;
    height: 450px;
    text-align: center; 
    background-color: #FFFFFF;
}	

.nodatadiv img {
	width: 120px;
    margin-top: 150px;
}
.loadp{
	margin-top: -23px;
    font-size: 18px;
    width: 100%;
    text-align: center;
    color: #7a7070;
}
</style>
<title>申请记录</title>
</head>
<body>
	<div class="liebiao">
		<div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>
	<div id="jzgd" onclick="add();">显示更多</div>
<!-- 	<div class="zhijieshenq" onclick="qushenq();">直接申请</div> -->
	<div style="width: 100%;height: 50px;"></div>
	<div class="foot">
		<div class="huodongliebiao">养老服务</div>
		<div class="huodongliebiao_m" onclick="qushenq();">申请服务</div>
		<div class="wodeshenqin">申请记录</div>
	</div>
</body>
<script type="text/javascript">
	showload();
	var size=10;
	var start=0;
	var Allstart = 0;
	var isall = 0;
	
	var wodeopenid = '${openid}'; 

	$(document).ready(function() {
		$(".huodongliebiao").css("color","#231815");
		$(".wodeshenqin").css("color","#F8BA1E");
		getdata(start,size,wodeopenid);
	});
	
	
	
	//点击显示更多
	function add(kind){
		if(isall==0){
			if(kind=undefined){
				showmoreload();
			}
			getdata(Allstart,size,wodeopenid);
		}
	}
	
	//我的申请列表点击跳转看详情
	function tiaozhuan(id){
		window.open("${ctx}/wxpage/showdetail?id="+id);
	}
	//我要申请
	function qushenq(){
		window.open("${ctx}/wxpage/toaddinfo?type=2");
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
	
	
	
	//点击活动列表
	$(".huodongliebiao").bind("click",function(){
		$(".huodongliebiao").css("color","#F8BA1E");
		$(".wodeshenqin").css("color","#231815");
		window.open("${ctx}/wxcommunity/showpension");
	});
	
	
	//点击我的申请
	$(".wodeshenqin").bind("click",function(){
		$(".huodongliebiao").css("color","#231815");
		$(".wodeshenqin").css("color","#F8BA1E");
		window.open("${ctx}/wxcommunity/myapply");
	});
	
	
	//我的申请活动
	function getdata(start,size,openid){
		$.post("${ctx}/wxcommunity/mypensionapply",
				{
					"start" : start,
					"size" : size,
					"openid" : openid
				},
				function (data){
					hideload();
					hidemoreload();
					if(data.result == 0){
						if(start == 0){
							$(".liebiao")
							.html(
									'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
							$("#jzgd").css("display","none");
							$("body").css("background-color","#ffffff");
							isall=1;
						}else{
							$("body").css("background-color","#eeeff0");
							document.getElementById("jzgd").innerHTML = "已无更多";
							$("#jzgd").css("color", "rgb(253, 84, 79)");
							isall=1;
						}
					}else if(data.result == 1){
						$("body").css("background-color","#eeeff0");
						if(data.data.length < size){
							document.getElementById("jzgd").innerHTML = "已无更多";
							$("#jzgd").css("color", "rgb(253, 84, 79)");
							isall=1;
						}else{
							$("#jzgd").css("display","block");
							$("#jzgd").css("color", "#727171");
							isall=0;
						}
						Allstart = start+data.data.length;
						
						for(var i = 0;i<data.data.length;i++){
							var id = data.data[i][4];
							var miaoshu = data.data[i][5];
							$(".liebiao").append('<div class="alldiv" onclick="tiaozhuan('+id+');">'
													+'<div class="title">'
														+(data.data[i][0] == null ? '<div class="huodonglx" style="background-color:#ffbc15;">申请服务</div>' : '<div class="huodonglx" style="background-color:#34b1ff;">养老服务</div>')
														+(data.data[i][0] == null ? '<div class="huodongmc">'+miaoshu.substr(0,10)+'...</div>' : '<div class="huodongmc">'+data.data[i][1]+'</div>') 
													+'</div>'
													+'<div class="xia">'
														+'<div class="xingming">姓名&nbsp;:&nbsp;'+data.data[i][2]+'</div>'
														+'<div class="riqi">日期&nbsp;:&nbsp;'+formattime(data.data[i][3])+'</div>'
													+'</div>'
												+'</div>'
								
							);
						}
					}
			})
	}
		
		
		
		function showload() {
			$("#ddd1").css("display","block");
		}
		
		function hideload() {
			$("#ddd1").css("display","none");
		}
		
		function showmoreload()
		{
			$("#ddd2").css("display","block");
			$("#jzgd").css("display","none");
		}
		function hidemoreload()
		{
			$("#ddd2").css("display","none");
			$("#jzgd").css("display","block");
		}
</script>
</html>