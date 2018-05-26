<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<title>最美服务员</title>
<style type="text/css">
body{
	margin: 0;
	font-family: Microsoft YaHei;
}
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
.div_list{
	width:95%;
	margin: 19px auto auto 15px;
}
.div_bg{
	clear: both;
	background-color: #e6e6e6;
	height: 40px;
}
.div_rank0{
	margin-top: -20px;
	width: 100%;
}
.div_rank{	
	margin: -33px auto 10px 15px;
	width: 70px;
	height: 25px;
	line-height:25px;
	border-radius: 6px;
    text-align: center;
    color: white;	
	background-color: #ef2e2f;
	font-size:large;
	z-index: 99999;
}
.div_img{	
	clear: both;
	position: relative;
    overflow: hidden;
    width: 40%;
    padding-bottom: 40%;
    margin-bottom: 10px;
    margin-right: 5%;
    height: 0px;
    float: left;
}
.div_img img{
	width: 100%;
   
}
.img_prize{
    clear: both;
    margin-top: -44%;
	width:17%;
	float:right;
	z-index: 9999;
}
.img_prize img{
	width: 80%;
}
.div_info{
	width: 55%;
	height:140px;
	float: left;
	font-size: 15px;
}
.mn{
    margin-top: 5%;
    font-size: 17px;
}
.div_info p{
	margin: 7px auto 5px auto;
}
.div_vote{
	height:18%;
	width:80px;
	margin-top: 10px;
	background-color: #e6e6e6;
	line-height: 25px;
	text-align:center;
	border-radius:10px;
	font-size: large;
}
.div_vote img{
	margin-right: 6px;
    margin-top: 4px;
    height: 16px;
	
}
.div_vote div{
	margin-top: 4px;
}
hr{
	clear: both;
    margin: 10px 10px -8px 10px;
}
.div_list2{
 	overflow:hidden;
	width: 100%;
	padding-top:20px;
	background-color: #e6e6e6;
}
.list2_left{
    margin-top: 5px;
	float:left;
	background-color:white;
	width: 46%;
	margin-left: 2.8%;
}
.list2_img{
	width: 90%;
	padding-top: 90%;
	margin: 10px;
	
}

.list2_name{
    clear: both;
	margin-left: 10px;
    margin-top: 10px;
}
.list2_shop{
	clear:both;
	float:left;
	margin-left: 10px;
}
.list2_num{
	margin-right:10px;
	float:right;
	font-size: large;
}
.list2_num img{
	height:15px;
	margin-right:5px;
}
.ban{
	width:100%;
	 margin-bottom: -4px;
}
.ban img{
	width: 100%;
}
.foot{
	width: 100%;
	height: 30px;
	background-color: #e6e6e6;
}

</style>
</head>
<body>
<div>
	<section class="imgzoom_pack">
		<div class="imgzoom_x">X</div>
		<div class="imgzoom_img">
			<img src="" />
		</div>
	</section>

	<div class="ban"><img class="tianjia" src="${ctx}/static/wxfile/newyear/image/awardbanner.png"></div>
	<div class="div_bg"></div>
	<div class="div_rank0">
		<div class="div_rank">一等奖</div>
	</div>
	<div id="win1"></div>
	
	<div class="div_bg"></div>
	<div class="div_rank0">
		<div class="div_rank">二等奖</div>
	</div>
	<div id="win2"></div>
	
	<div class="div_bg"></div>
	<div class="div_rank0">
		<div class="div_rank">三等奖</div>
	</div>
	<div id="win3"></div>
	
	<div class="div_list2"></div>
	<div class="foot"></div>	
</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/lazyload/lazyload.js"></script>
<script src="${ctx}/static/scale/js/scale.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	getdata();
});
function getdata() {
	$
			.post(
					"${ctx}/waiter/getwinlist",
					function(d) {
						if (d.result == "1") {
							var size = d.data.length > 9 ? 9
									: d.data.length;
							for (var i = 0; i < size; i++) {
								var mc;	
								var xy=d.data[i][3];
								if(xy.length>18){
									xy=xy.substr(0,17)+"...";
								}
								var name=d.data[i][4];
								if(name.length>7){
									name=name.substr(0,6)+"...";
								}
								
								if (i == 0) {
									mc = "prize01";				
									$("#win1").append(
											'<div class="div_list"><div class="div_img"><img class="tab" orsrc="'
											+d.data[i][2]
											+ '" asrc="'
											+d.data[i][2]
											+'?imageView2/2/w/300|imageMogr2/auto-orient" src=""></div><div class="div_info"><div class="mn">'
											+d.data[i][1]
											+'</div><p>店铺名称：'
											+name
											+'</p><p>个人心语：'
											+xy
											+'</p><div class="div_vote"><img src="${ctx}/static/wxfile/newyear/image/piao_01.png">'
											+d.data[i][5]
											+'</div></div><div class="img_prize"><img src="${ctx}/static/wxfile/newyear/image/'+mc+'.png"></div></div>'	
									);					
								} else if (i==1 || i==2 || i==3) {
									mc = "prize02";									
									$("#win2").append(
											'<div class="div_list"><div class="div_img"><img class="tab" orsrc="'
											+d.data[i][2]
											+ '" asrc="'
											+d.data[i][2]
											+'?imageView2/2/w/300|imageMogr2/auto-orient" src=""></div><div class="div_info"><div class="mn">'
											+d.data[i][1]
											+'</div><p>店铺名称：'
											+name
											+'</p><p>个人心语：'
											+xy
											+'</p><div class="div_vote"><img src="${ctx}/static/wxfile/newyear/image/piao_01.png">'
											+d.data[i][5]
											+'</div></div><div class="img_prize"><img src="${ctx}/static/wxfile/newyear/image/'+mc+'.png"></div></div>'
										
									);
									if(i!=3){
										$("#win2").append('<div class="hr"><hr></div>');
									}
								} else if(i>=4 && i<=8) {
									mc = "prize03";									
									$("#win3").append(
											'<div class="div_list"><div class="div_img"><img class="tab" orsrc="'
											+d.data[i][2]
											+ '" asrc="'
											+d.data[i][2]
											+'?imageView2/2/w/300|imageMogr2/auto-orient" src=""></div><div class="div_info"><div class="mn">'
											+d.data[i][1]
											+'</div><p>店铺名称：'
											+name
											+'</p><p>个人心语：'
											+xy
											+'</p><div class="div_vote"><img src="${ctx}/static/wxfile/newyear/image/piao_01.png">'
											+d.data[i][5]
											+'</div></div><div class="img_prize"><img src="${ctx}/static/wxfile/newyear/image/'+mc+'.png"></div></div>'	
									);
									if(i!=8){
										$("#win3").append('<div class="hr"><hr></div>');
									}
								}											
							}

							if (d.data.length > 9) {
								for (var i = 9; i < d.data.length; i++) {
									var shop = d.data[i][4];
									if (shop.length > 5) {
										shop = shop.substr(0, 4) + "...";
									}
									j=i+1;
									var html = '<div class="list2_left"><div class="list2_name">'
											+j+"&nbsp&nbsp"
											+d.data[i][1]
											+'</div><div class="list2_img"><img class="tab" orsrc="'
											+ d.data[i][2]
											+ '" asrc="'
											+d.data[i][2]
											+'?imageView2/2/w/300|imageMogr2/auto-orient" src=""></div><div><div class="list2_shop">'
											+shop
											+'</div><div class="list2_num"><img src="${ctx}/static/wxfile/newyear/image/piao_01.png">'
											+d.data[i][5]
											+'</div></div></div>';
											$(".div_list2").append(html);
																						
								}
							}	
							bindshow(".tab");
 							lazyinit(".tab");
							
							ImagesZoom.init({
								"elem" : ".div_img"
							});
							ImagesZoom.init({
								"elem" : ".list2_img"
							});
						}

					});
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
}

</script>
</html>