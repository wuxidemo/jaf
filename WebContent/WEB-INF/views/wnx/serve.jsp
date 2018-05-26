<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>服务(${comname})</title>
<link type="text/css" href="${ctx}/static/wxfile/wnx/css/serve.css" rel="stylesheet" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
</head>
<body>
<div class="aa" onclick="hd()"></div>

<div id="Div1">
      <div class="fdj" onclick="sousuo()"><img src="${ctx}/static/wxfile/wnx/image/fdj.png" /></div>
      <input class="full-width has-padding has-border" id="" type="text" placeholder="搜索行家姓名，具体才能等"/>
</div>
<div class="Dv">
<!-- 
    <div class="Dv1" id="0" onclick="showsq()">
        <div class="Dv1sq" id="0">全部社区  </div>
        <img class="Dv1img" src="${ctx}/static/wxfile/wnx/image/grayjt.png" />
    </div>  
     -->
    <div class="Dv2" id="0" onclick="showns()">
        能手分类 
        <img src="${ctx}/static/wxfile/wnx/image/grayjt.png" /></div>
    <div class="Dv3" id="-1" onclick="Dv3()">报酬   <img src="${ctx}/static/wxfile/wnx/image/grayjt.png" /></div>
    <div class="searchcontent">
	</div> 
</div>
<div class="content">
<!-- <div class="inner"> -->
<!--     <div class="inerLt"><img src="#" /></div>      -->
<!-- 	<div class="inerRt"> -->
<!-- 	     <div class="inerRt1"><div class="name">王先生</div><div class="Name">（家政）</div><div class="cost">免费</div></div> -->
<!-- 	     <div class="cnzs"><div class="cnzsiner"></div></div> -->
<!-- 	</div> -->
<!-- 	 </div> -->
	
     <div class="ball-beat" id="ddd1" sss="a">
			<div></div>
			<div></div>
			<div></div>
		</div>		
</div>
<div id="jzgd" onclick="getmore()">点击加载更多</div>
	<div class="ywgd">已无更多</div>
<div class="botm">
    <div class="botmLt" onclick="botmLt()">
	        <div class="botmLt1"><img src="${ctx}/static/wxfile/wnx/image/wsnsyellow.png"/></div> 
	        <div class="botmLt2">我是能手</div>	
	</div>
	<div class="botmRt" onclick="botmRt()">
	        <div class="botmRt1"><img src="${ctx}/static/wxfile/wnx/image/grxxgray.png" /></div>
		    <div class="botmRt2">个人信息</div>
	</div>
</div>


   <div class="moreloading" id="ddd2" sss="a">
		<div></div>
		<div></div>
		<div></div>
	</div>
<!-- 	<div id="jzgd" onclick="getmore()">点击加载更多</div> -->
<!-- 	<div class="ywgd">已无更多</div> -->
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
	debug : false,
	appId : '${config.appId}',
	timestamp : '${config.timestamp}',
	nonceStr : '${config.nonceStr}',
	signature : '${config.signature}',
	jsApiList : [ 'onMenuShareTimeline', 'openLocation',
			'onMenuShareAppMessage' ]
});
wx.error(function(res) {
	//alert("加载错误:" + JSON.stringify(res));
});
wx.ready(function() {
	wx.onMenuShareTimeline({
		title : '我是能手', // 分享标题
		link : '${baseurl}/wxcommunity/', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/wnx/image/wsxns.png' // 分享图标

	});

	wx.onMenuShareAppMessage({
		title : '我是能手', // 分享标题
		desc : '有困难,来找我', // 分享描述
		link : '${baseurl}/wxcommunity/', // 分享链接
		imgUrl : '${baseurl}/static/wxfile/wnx/image/wsxns.png' // 分享图标
	});
});
var cookieCode = ${comid};
var cookieName = '${comname}';
//alert(cookieName);

$(document).ready(function() {
	if(cookieCode=="" || cookieName==""){
		getdata();
	}else{
	//	$('.Dv1sq').html(cookieName);
	//	$('.Dv1img').attr("src","/nsh/static/wxfile/main1601/image/jtyellow.png");
	//	$('.Dv1sq').css("color","#ffab13");
	//	$('.Dv1sq').attr("id",cookieCode);
	//	commid=$('.Dv1sq').attr("id");
		start=0;
		$('.content').empty();
		getdata();
	}
	
	
 //$.get('${ctx}/wxcommunity/getcommunities',function(data){
	// sq=data;
 //})
 $.get('${ctx}/wxcommunity/getkind',function(data){
	 ns=data;
 })
});
var cs=0;
var cs1=0;
var cs3=0;
var searchcontent1;
var searchcontent2;
var searchcontent3;
var ns;
var sq;
//var keyword=$('.has-border').attr("id");
var commid=${comid};
var kind=0;
var pay=-1;
var start = 0;
var size = 10;
var isall = 0;
function sousuo(){
	$('.content').empty();
	start=0;
	getdata();
}
function Dv3(){
	if(cs3==0){
		$(".searchcontent").empty();
		$(".searchcontent").append('<div class="Head" id="0" >'+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">报酬'+'</div>')
		$(".searchcontent").append(
				'<div class="head" id="-1">报酬'+'</div>'
				+'<div class="head" id="0">无偿'+'</div>'
				+'<div class="head" id="1">有偿'+'</div>');
		show();
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		 $(".head").click(function() { 
				$('.aa').css("display","none"); 
				$('.head').css("color","black");
				
				$(".Dv2").css("color","black");
				$('.Dv2 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv2ns").css("color","black");
				$(".Dv1sq").css("color","black");
				$('.Dv1 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				
				$(this).css("color","#ffab13");	
				$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				$('.Dv3').html($(this).text()+'<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>'); 
				var aa=$(this).attr("id");	
				$('.Dv3').attr("id",aa);
				$('.Dv3').css("color","#ffab13");
				hide();
				searchcontent3=$(".searchcontent").html();
				pay=aa;
				$('.content').empty();
				start=0;
				getdata();
				cs3=cs3+1;
			});
		 
	}else{
		$(".searchcontent").empty();
		$(".searchcontent").append(searchcontent3);
		show();
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		 $(".head").click(function() { 
				$('.aa').css("display","none"); 
				$('.head').css("color","black");
				
				$(".Dv2").css("color","black");
				$('.Dv2 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv2ns").css("color","black");
				$(".Dv1sq").css("color","black");
				$('.Dv1 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				
				$(this).css("color","#ffab13");	
				$('.Dv3').html($(this).text()+'<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>'); 
				var aa=$(this).attr("id");	
				$('.Dv3').attr("id",aa);
				$('.Dv3').css("color","#ffab13");
				hide();
				searchcontent3=$(".searchcontent").html();
				pay=aa;
				$('.content').empty();
				start=0;
				getdata();
			});
	}
	
	
}

function showns(){
	if(cs1==0){
	 $(".searchcontent").empty();
	 $(".searchcontent").append('<div class="Head" id="0">'+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">能手分类'+'</div>'
			                     +'<div class="head" id="0">能手分类'+'<div>')
	//获取才能的分类
		 if(ns.result == 1){
			  for (i = 0; i < ns.data.length; i++) {				 
 					$(".searchcontent").append(
 							'<div class="head" id="'+ns.data[i].id+'">'
 									+ ns.data[i].value + '</div>');
				}		  
			  }else{}
		 show();
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		 $(".head").click(function() { 
				$('.aa').css("display","none");          //让遮盖层隐藏	
				$('.head').css("color","black");
				$(".Dv1sq").css("color","black");
				$('.Dv1img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv3").css("color","black");
				$('.Dv3 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(this).css("color","#ffab13");
				$('.Dv2').html($(this).text()+'<img class="Hdimg" src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>'); 
				var cc=$(this).attr("id");	
				$('.Dv2').attr("id",cc);
				$('.Dv2').css("color","#ffab13");
				//$(".searchcontent").empty();
				$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				hide();
				searchcontent2=$(".searchcontent").html();
				kind=cc;
				$('.content').empty();
				start=0;
				getdata();
				cs1=+1;
			});
				
	}else{
		$(".searchcontent").empty();
		$(".searchcontent").append(searchcontent2);
		show();
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		 $(".head").click(function() { 
				$('.aa').css("display","none");          //让遮盖层隐藏	
				$('.head').css("color","black");
				$(".Dv1sq").css("color","black");
				$('.Dv1img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv3").css("color","black");
				$('.Dv3 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(this).css("color","#ffab13");
				$('.Dv2').html($(this).text()+'<img  src="/nsh/static/wxfile/main1601/image/jtyellow.png"/>'); 
				var cc=$(this).attr("id");	
				$('.Dv2').attr("id",cc);
				$('.Dv2').css("color","#ffab13");
				//$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				hide();	
				searchcontent2=$(".searchcontent").html();
				kind=cc;
				$('.content').empty();
				start=0;
				getdata();
			});
		 
	}
}


function showsq() {
	if(cs==0){
	 $(".searchcontent").empty();
		if(cookieCode==0){
			$(".searchcontent").append('<div class="Head" id="0">'+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">'+cookieName+'</div>'
					 +'<div class="head" id="0" style="color:#ffab13">全部社区'+'<div>')
		}else{
			$(".searchcontent").append('<div class="Head" id="0">'+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">'+cookieName+'</div>'
					 +'<div class="head" id="0">全部社区'+'<div>')
		}
		 

	
	//获取社区的分类
		  if(sq.result == 1){	
			 				
		  for (i = 0; i < sq.data.length; i++) {
			  var num=sq.data[i].id;
			  var ee=$(".Dv1sq").attr("id");
			  if(num==ee){
// 				  $(this).css("color","#ffab13");
				  $(".searchcontent").append(
						   '<div class="head" id="'+num+'" style="color:#ffab13">'+ sq.data[i].name + '</div>'				
									);	
			  }else{
				  $(".searchcontent").append(
						   '<div class="head" id="'+num+'">'+ sq.data[i].name + '</div>'				
									);	
			  }
							 
			}	
		  
		  }else{}
		 
		  show();		 
		  $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		  $(".head").click(function() { 
				$('.aa').css("display","none");          //让遮盖层隐藏	
				$('.head').css("color","black");
				
				$(".Dv2").css("color","black");
				$('.Dv2 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv2ns").css("color","black");
				$(".Dv3").css("color","black");
				$('.Dv3 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				
				$(this).css("color","#ffab13");
				$('.Dv1sq').html($(this).text()); 
				$('.Dv1img').attr("src","/nsh/static/wxfile/main1601/image/jtyellow.png");
				var dd=$(this).attr("id");
				setCookie("comID",dd,99999999);
				var ll=$(this).text();
				setCookie("comName",encodeURI(encodeURI(ll)),999999999);	
				$('.Dv1sq').attr("id",dd);
				$('.Dv1sq').css("color","#ffab13");
				$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				hide();	
				searchcontent1=$(".searchcontent").html();
				commid=dd;
				$('.content').empty();
				start=0;
				getdata();
				cs=cs+1;
			});	
		  
	}else{
		$(".searchcontent").empty();
		$(".searchcontent").append(searchcontent1);
		show();
		 $(".Head img").click(function() { 
			  $('.aa').css("display","none"); 
			  hide();	
		  });
		  $(".head").click(function() { 
				$('.aa').css("display","none");          //让遮盖层隐藏	
				$('.head').css("color","black");
				
				$(".Dv2").css("color","black");
				$('.Dv2 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				$(".Dv2ns").css("color","black");
				$(".Dv3").css("color","black");
				$('.Dv3 img').attr("src","${ctx}/static/wxfile/wnx/image/grayjt.png");
				
				$(this).css("color","#ffab13");
				$('.Dv1sq').html($(this).text());
				$('.Dv1img').attr("src","/nsh/static/wxfile/main1601/image/jtyellow.png");
				var dd=$(this).attr("id");
				setCookie("comID",dd,99999999);
				var ll=$(this).text();
				setCookie("comName",encodeURI(encodeURI(ll)),999999999);	
				$('.Dv1sq').attr("id",dd);
				$('.Dv1sq').css("color","#ffab13");
				$('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
				//$(".searchcontent").empty();
				hide();	
				searchcontent1=$(".searchcontent").html();
				commid=dd;
				$('.content').empty();
				start=0;
				getdata();
			});
		 
	}
	 
} 

function show(){
	   $('.aa').css("display","block");
	$('.searchcontent').removeClass("rightin").removeClass("rightout").addClass("rightin")
	.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		$(this).css("transform","translate3d(0%, 0, 0)"); 
		$(this).css("-webkit-transform","translate3d(0%, 0, 0)"); 
		$(this).css("opacity","1"); 
	    $(this).removeClass("rightin");
	    });
}

function hide(){
	$('.searchcontent').removeClass("rightout").removeClass("rightin").addClass("rightout")
	 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $(this).css("transform","translate3d(100%, 0, 0)"); 
	    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
		$(this).css("opacity","0"); 
	    $(this).removeClass("rightout");
	    });
}
function hd(){
	$('.aa').css("display","none");   
	$('.searchcontent').removeClass("rightout").removeClass("rightin").addClass("rightout")
	 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $(this).css("transform","translate3d(100%, 0, 0)"); 
	    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
		$(this).css("opacity","0"); 
	    $(this).removeClass("rightout");
	    });
}
function botmRt(){
   // $(".botmLt1 img").attr("src","${ctx}/static/wxfile/wnx/image/wsnsgray.png");
	//$(".botmLt2").css("color","#7c7374");
	//$(".botmRt1 img").attr("src","${ctx}/static/wxfile/wnx/image/grxxyellow.png");
	//$(".botmRt2").css("color","#ffab13");
	window.location.href="${ctx}/wxurl/redirect?url=wxcommunity/myinfo?comid=${comid}";
};
function botmLt(){
    $(".botmLt1 img").attr("src","${ctx}/static/wxfile/wnx/image/wsnsyellow.png");
	$(".botmLt2").css("color","#ffab13");
	$(".botmRt1 img").attr("src","${ctx}/static/wxfile/wnx/image/grxxgray.png");
	$(".botmRt2").css("color","#7c7374");
}

function getmore() {
	if (isall == 0) {
		showmoreload();
		getdata();
	}
}

function getdata() {
	
	$.post("${ctx}/wxcommunity/list",{'keyword' :$('.has-border').val(),'commid' : commid,'kind' : kind,"pay":pay,'start' : start,'size' : size},function(data) {
		hideload();
		hidemoreload();
		if (data.result == '1') {
			if(data.data.length==0){
			  if (start==0){
   		           $(".content").html(
   		        		'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>'   
   		           )
   		           $("#jzgd").hide();
				  isall = 1;
			  }else{
				//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
			  }
			  return;
			}else{
				if(data.data.length<size){
					//展示 无更多数据
					$("#jzgd").hide();
					$(".ywgd").css("display", "block");
					isall = 1;
				}
				else{
					
				}
			}				
			for (var i = 0; i < data.data.length; i++) {
								$(".content")
										.append(
											'<div class="inner" onclick="showcard('+data.data[i][0]+')" id="'+data.data[i][0]+'">'
												+'<div class="inerLot">'

												   +'<div class="inerLt" style="background: url(\''+data.data[i][3]+'?imageView2/2/w/100|imageMogr2/auto-orient\') no-repeat; background-size: cover;  background-position: 50%;">'+'</div>' 
	                                            +'</div>'
												+'<div class="inerRt">'
												     +'<div class="inerRt1">'
												        +'<div class="name">'+data.data[i][1]+'</div>'+'<div class="Name">'+'<div class="lt">&nbsp;('+'</div>'+'<div class="ct">'+data.data[i][5]+'</div>'+'<div class="rt">&nbsp;)'+'</div>'+'</div>'
												        +'<div class="cost">'+(data.data[i][7] ==0 ? "免费" :data.data[i][8])+'</div>'
												     +'</div>'
												     +'<div class="cnzs">'+data.data[i][6]+'</div>'                      
												+'</div>'
											+'</div>');
							}
							start += size;
						} else if (data.result == '0') {
							if (start == 0) {
								$(".content")
										.html(
												'<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
								$("#jzgd").hide();
								$(".ywgd").hide();
								isall = 1;
							} else {
								$("#jzgd").hide();
								$(".ywgd").css("display", "block");
								isall = 1;
							}
					                 }
					});

}

// function to(id) {
// 	window.location.href = "${ctx}/jsypage/query?id=" + id;
// }
// function showload() {
// 	$(".rundiv").css("display", "block");
// }
// function hideload() {
// 	$(".rundiv").css("display", "none");
// }
// function showmoreload() {
// 	$(".moreloading").css("display", "block");
// 	$("#jzgd").css("display", "none");
// }
// function hidemoreload() {
// 	$(".moreloading").css("display", "none");
// 	$("#jzgd").css("display", "block");
// }

//获取cookie的值
function getCookie(name) {
	var cookieArray = document.cookie.split("; "); //得到分割的cookie名值对    
	var cookie = new Object();
	for (var i = 0; i < cookieArray.length; i++) {
		var arr = cookieArray[i].split("="); //将名和值分开    
		if (arr[0] == name)
			return unescape(arr[1]); //如果是指定的cookie，则返回它的值    
	}
	return "";
}

//设置cookie方法
function setCookie(key, val, time) {
	var date = new Date();
	var expiresDays = time;
	date.setTime(date.getTime() + expiresDays);
	document.cookie = key + "=" + val + ";expires=" + date.toGMTString()+";path=/";
}
function showcard(id)
{
	window.open("${ctx}/wxcommunity/getvoldetail?id="+id);
} 
//黄色点点加载更多
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