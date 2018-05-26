<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="format-detection" content="telephone=no" />
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>社区商户(${comname})</title>
<link type="text/css"
	href="${ctx}/static/wxfile/main1601/css/sh.css" rel="stylesheet" />
</head>
<body>
<!-- <div class="top" onclick="sq()"></div> -->
<div class="aa" onclick="hide()"></div>
<!-- 
<div class="searchcontent">
 <div class="Head"><img src="${ctx}/static/wxfile/wnx/image/ltjt.png">全部社区</div>
</div>
 -->
<div class="card">
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
	<div id="jzgd" onclick="getmore()">点击加载更多</div>
    <div class="ywgd">已无更多</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
function show() {
	$('.searchcontent').removeClass("rightin").removeClass("rightout").addClass("rightin")
	.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		$(this).css("transform","translate3d(0%, 0, 0)"); 
		$(this).css("-webkit-transform","translate3d(0%, 0, 0)"); 
		$(this).css("opacity","1"); 
	    $(this).removeClass("rightin");
	    });
} 
	function hd(){
	$('.searchcontent').removeClass("rightout").removeClass("rightin").addClass("rightout")
	 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $(this).css("transform","translate3d(100%, 0, 0)"); 
	    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
		$(this).css("opacity","0"); 
	    $(this).removeClass("rightout");
	    });
	}
	function hide(){
		$('.aa').css("display","none");   
		$('.searchcontent').removeClass("rightout").removeClass("rightin").addClass("rightout")
		 .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		    $(this).css("transform","translate3d(100%, 0, 0)"); 
		    $(this).css("-webkit-transform","translate3d(100%, 0, 0)"); 
			$(this).css("opacity","0"); 
		    $(this).removeClass("rightout");
		    });
	}
 function  sq(){
	 show();
	 $(".Head img").click(function() { 
		  $('.aa').css("display","none"); 
		  hd();	
	  });
	 $(".aa").css("display","block");
     $("#"+ID).css("background-color","#e1e3e1");
     $("#"+ID).css("color","#f8ba1e");
  }

 $('.kong').click(function(){
		$('.sq').hide();
		$(".aa").css("display", "none");
		$('.kong').hide();
		$('body').css("position","");
 });
 
 
function setCount2(){
	$(".sq").hide();
	 $(".aa").css("display","none");
}




var start = 0;
var size = 10;
var isall = 0;

function getmore() {
     if (isall == 0) {
	         showmoreload();
	         getdata(ID);
                     }
                   }
                   
$(document).ready(function() {
	var comid='${comid}';
	var comname='${comname}';
	showload();
	//getsq();
	if(comid=='')
		{
		getdata(0);
		ID=0;
		 $(".top").html("全部社区"+'<img  src="${ctx}/static/wxfile/main1601/image/jtgray.png"/>');
		}
	else
		{		
		getdata(comid);
		ID=comid;
		$(".top").html(comname+'<img  src="${ctx}/static/wxfile/main1601/image/jtgray.png"/>');
		}
	


});

function getsq(){
	$.post('${ctx}/wxpage/getcommunities',function(data){
		var sq=data.data;
		$(".searchcontent").append(
				'<div id="0" class="head">全部社区'+'</div>'	
		);		
		for(i=0;i<sq.length;i++){
			$(".searchcontent").append(
					'<div class="head" id="'+sq[i].id+'">'+sq[i].name+'</div>'       			
        	);
			
		}
		
		 $ (".head").click (function () {	
			    $('.aa').css("display","none");  
                $(".head").css("background-color","white");
                $(".head").css("color","");                            
                 $(this).css("background-color","#e1e3e1");	
                 $(this).css("color","#f8ba1e");
                 var aa=$(this).attr("id");
                 setCookie("comID",aa,99999999);
                 var ll=$(this).text();
 				 setCookie("comName",encodeURI(encodeURI(ll)),999999999);	
                 $('.Head').html($(this).text()+'<img src="${ctx}/static/wxfile/wnx/image/ltjt.png">');
                 $(".card").empty();
                 start=0;
                 $(".ywgd").hide();              
                 isall=0;                         
                 $(".top").html($(this).text()+'<img  src="${ctx}/static/wxfile/main1601/image/jtgray.png"/>');
                 getdata(this.id);
                 hd();
                                        })
		
		
		
		
	});

}




var ID;
function getdata(id) {
	ID=id;
	$.post('${ctx}/wxpage/getmerbycommunity',{"lat":31.252525,"lon":121.256598,'start' : start,'size' : size,'commid':id},function(data) {		
		
		                hideload();
						hidemoreload();
						var list = data.data;
if(data.result ==1){				
					
				if (list.length == 0) {
							                   if (start == 1) {
							                    // 第一次无数据   展示暂无数据提示
							                     $(".card").html(
							                    '<div class="nodatadiv">	<img src="${ctx}/static/wxfile/images/nodata.png"><div class="loadp p2size">暂无数据</div></div>')
						                          $("#jzgd").hide();
							                      isall = 1;
							                             } else {
								                        //展示 无更多数据
						                                $("#jzgd").hide();
						                                $(".ywgd").css("display","block");											
								                        isall = 1;
							                          }
							                          return;
	
					        	    } else {
							                   if (list.length < size) {
								               //展示 无更多数据
							                   $("#jzgd").hide();
						                       $(".ywgd").css("display","block");
								               isall = 1;
							                            } else {
								                         //点击加载更多								
							                               }
						                   }

						for (var i = 0; i < list.length; i++) {
							if (list[i][1].indexOf("http://") >= 0) {

							} else {
								list[i][1] = '${ctx}/' + list[i][1];
							}	
						    
							var scorestr = '';
							var scorehui = '';
							var score = list[i][8];
							if(score == 0) {
								scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" /><img src="${ctx}/static/wxfile/main1601/stars/0.png" />'; 
							}else{
								var scoreint = parseInt(score);
								var scoreremain = parseInt((score-scoreint)*10);
								if(scoreremain == 0) {
									for(var j=1;j <= scoreint;j++){
										scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
									}
									var noscore = 5-scoreint;
									for(var k=1;k<=noscore ; k++){
										scorehui += '<img src="${ctx}/static/wxfile/main1601/stars/0.png" />';
									}
								}else{
									for(var j=1;j <= scoreint;j++){
										scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/1.png" />';
									}
									scorestr += '<img src="${ctx}/static/wxfile/main1601/stars/0.'+scoreremain+'.png" />'; 
									var noscore = 4-scoreint;
									for(var k=1;k<=noscore ; k++){
										scorehui += '<img src="${ctx}/static/wxfile/main1601/stars/0.png"/>';
									}
								}
							}
							
							
							$(".card").append('<div class="rowdiv">'
															+'<div id="beforecard1"></div>'
															+'<div id="card" onclick="showcard('+list[i][0]+')">'
																+'<div id="left">'
																	+'<div>'
																		+'<img src="'+list[i][1]+'">'
																	+'</div>'
																+'</div>'
																+'<div id="right">'
																	+'<div class="pbetweenright_middle">'
																		+'<div class="right_top">'
																			+'<div class="right_top1">'+(list[i][2] == null ? "" : list[i][2])
																			+'</div>'
																		+'</div>'
																		+'<div class="right_middle1">'
																			+'<div class="xingxing">'
																				+scorestr+scorehui
																				+'<div class="right_m11">'
																					+list[i][8]
																				+'</div>'
																			+'</div>'
																			+'<div class="right_m21">'+list[i][4]+'</div>'
																			+'</div>'
																		+'</div>'
																		+(list[i][7] == null ? "" : '<div class="right_down">')
																		+(list[i][7] == null ? "" :'<div class="right_d1">')
																			+(list[i][7] == null ? "" : '<img src="${ctx}/static/wxfile/main1601/image/quan.jpg">')
																		+'</div>'
																		+(list[i][7] == null ? "" :'<div class="right_d2">')+(list[i][7] == null ? "" : list[i][7] )
																		+'</div>'
																	+'</div>'
																	+'</div>'
																	+'</div>'
																+'</div>'
															+'</div>'
															+'<div id="aftercard2"></div>'
															+'<div id="gekai"></div>'
												+'</div>'	
						);	

						}
						start += size;
						
						 }else{
							 $(".ywgd").hide();
						     $("#jzgd").hide();
							 $(".card").append(	
									 '<div class="nodatadiv">	<img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp p2size">暂无数据</div></div>' 
// 							 '<div class="zwsj">暂无数据'+'</div>'		 
							 );
						 }	
						
						
					});
}


function showcard(id)
{
	window.open("${ctx}/wxpage/merdetail?id="+id+"&token=token");
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
//设置cookie方法
function setCookie(key, val, time) {
	var date = new Date();
	var expiresDays = time;
	date.setTime(date.getTime() + expiresDays);
	document.cookie = key + "=" + val + ";expires=" + date.toGMTString()+";path=/";
}
</script>
</html>