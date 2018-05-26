<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String district = "";
	if (request.getParameter("search_urls") != null)
		district = new String(request.getParameter("search_urls").getBytes("ISO-8859-1"),"UTF-8");
%>
<html>
<head>
<title>评论详情</title>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet" type="text/css" />
<%@ include file="../quote.jsp"%>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
</head>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
.ali .ali1 .ali2{
font-size: 14px;
font-weight: normal;
line-height: 20px;
overflow: hidden;
}
.ali{
float: left;
width: 75px;
text-align: right;
padding-right: 10px;

overflow: hidden;
}
.ali2{
float: left;
width: 10%;
padding-left: 10px;
padding-right: 10px;
overflow: hidden;
}
.ali1{
clear:both;
padding-left: 10px;
overflow: hidden;
}
</style>

<script type="text/javascript">
showload();
var start = 0;//初始数据
var Allstart = 0;//每次添加时的初始数据 
var size = 10;//每页多少数据
var allsize = 0;//当前数据数量
var isall=0;
var merid='${merid}';
var scrollid="";
/* setCookie("scrollid","");  */

$(document).ready(function(){
	initDate();
	getData(Allstart,size); 
});

//加载更多这一功能
function add(kind) {
	if(isall==0){
		if(kind=undefined){
		showmoreload();	
		}
		getData(Allstart,size); 
		}
	}
//ajax请求获取数据
function  getData(start,size){
	//alert(hahhah);
	var search_realname=$("#search_realname").val();
	var startscore=$("#startscore").val();
	var endscore=$("#endscore").val();
	var urls=$("#search_urls").val();
	var starttime=$("#starttime").val();
	var endtime=$("#endtime").val();
	
	$.post('${ctx}/mercomment/list',
			{
	        	"LIKE_realname":search_realname,
	        	"EQ_startscore":startscore,
				"EQ_endscore":endscore,
				"EQ_urls":urls,
				"EQ_starttime":starttime,
				"EQ_endtime":endtime,
				"merid":merid,
				"start":start,
				"size":size
			},
			function(data,status){  
			//console.log("6:"+new Date().getTime());
				hideload(); 
				hidemoreload();
				if(data.result == 0 ){
							if(start == 0){
								$(".allcard").html('<div class="nodatadiv"><div class="loadp p2size" style="text-align: center;background-color: #eee;">暂无数据</div></div>');
								$("#jzgd").css("display","none");
								isall=1;
							}else{
								$("#jzgd").html("已无更多");
								$("#jzgd").css("background-color","#efefed");
								isall=1;
							}
					}else{
						if(data.data.length < size){
							$("#jzgd").html("已无更多");
							$("#jzgd").css("background-color","#efefed");
							isall=1;
						}else{
							$("#jzgd").css("display","block");
							isall=0;
						}
						Allstart = start+data.data.length;
				for(var i = 0;i < data.data.length;i++){
					/* 0id 1微信编号 2评价内容 3merid 4分数 5时间 6订单编号 7图片 8昵称 9头像*/
					var url=data.data[i][7];
					var urlhtml ='';
					var d=1;
					if(url ==null||url=='') {
						url=null;
					}else{
						$("#picdiv").show();
						 var arr =url.split(',');
						for(var j=0;j<arr.length;j++){
							urlhtml += '<img src="'+arr[j]+'" style="width:80px;padding-left:5px;float:left;"/>';
						} 
					}
					$(".allcard").append('<div class="rowdiv"style="border:1px solid #efefed" id="mer'+data.data[i][0]+'">'
							+'<div class="ali1" style="padding-top:10px;"><div class="ali"  style="margin:10px;">用户昵称：</div><div class="ali2" style="margin:10px;">'+data.data[i][8]+'</div>'
							                                    +'<div class="ali" style="margin:10px;">评分：</div><div class="ali2" style="margin:10px;">'+data.data[i][4]+'分</div>'
							                                    +'<div class="ali" style="margin:10px;">评价时间：</div><div class="ali2" style="margin:10px;">'+ formattime(data.data[i][5])+'</div>'
							                                    +'<div class="ali">&nbsp;</div><div class="ali2" style="margin:10px;"><button type="button" onclick="del('+data.data[i][0]+')" class="btn red" id="search_btn" style="width:100px;;height:20px;padding:0px;">删除</button></div>'
							+'</div>'
							+'<div class="ali1"><hr style="border:1px dashed #efefed;margin:0px;height:1px" /><div class="ali" style="margin:10px;">评价：</div><div class="ali2" style="width:50%;WORD-WRAP: break-word;margin:10px;">'+data.data[i][2]+'</div></div>'
							+(url==null ? ' ' : '<div class="ali1" id="picdiv"style="height:85px;padding-bottom:10px;"><div class="ali" style="margin:10px;">图片：</div><div class="ali2" id="pic" style="width:80%;margin:10px;">'+urlhtml+'</div></div>') 
							+'</div>'  
					  );
					setTimeout('window.parent.iFrameHeight();',100);
				}
				allscrollTo($("#mer"+data.data[0][0]));
				/*  if(scrollid!='')
					{
					allscrollTo($("#mer"+scrollid));
					scrollid="";
					}  */
			}
	});
}

function allscrollTo(el, offeset) {
	   pos = el ? el.offset().top : 0;
    jQuery('html,body').animate({
            scrollTop: (pos-10) + (offeset ? offeset : 0)
        }, 'slow');
}
function showload(){
	$(".rundiv").css("display","block");
	//$(".loadimg").css("display","block");
}
function hideload(){
	$(".rundiv").css("display","none");//将元素内容删除
	//setTimeout(function(){},500);
}
function showmoreload(){
	$(".moreloading").css("display","block");
	$("#jzgd").css("display","none");
	//$(".loadimg").css("display","block");
}
function hidemoreload(){
	$(".moreloading").css("display","none");//将元素内容删除
	$("#jzgd").css("display","block");
	//setTimeout(function(){},500);
}


function resetAll() {
	$("#search_realname").val('');
	$("#startscore").val('-1');
    $("#endscore").val('-1');
	$("#search_urls").val('-1');
	$("#starttime").val('');
	$("#endtime").val('');
}
function del(id) {
	    ids = id;
		parent.window.showConfirm("您确定删除该评论？", sureDel);
}
function sureDel() {
	$.post('${ctx}/mercomment/delete', {
		"ids" :ids
	}, function(data) {
		if (data.result) {
			window.parent.showAlert("删除成功");	
			$("#mer"+ids).remove();
		} else {
			window.parent.showAlert("删除失败");	
		}
	});
}

function initDate(){
	if (jQuery().datepicker) {
        $('#starttime').datepicker({
            rtl : App.isRTL()
        });
    }
	if (jQuery().datepicker) {
        $('#endtime').datepicker({
            rtl : App.isRTL()
        });
    }
}
function checkUser(){
	var score1 = $('#startscore').val();
	var score2 = $('#endscore').val();
	var time1 = new Date($('#starttime').val()).getTime();
	var time2 = new Date($('#endtime').val()).getTime();
	if(score2!=-1&&score1>score2){
		$("#startscore").val("-1");
		$("#endscore").val("-1");
		window.parent.showAlert("请选择正确分数，结束分数大于开始分数！");
		 return false;
	}else if(time1>time2){
		$("#starttime").val("");
		$("#endtime").val("");
		window.parent.showAlert("请选择正确日期，结束时间大于开始时间！");
		 return false;
	}else{
		var start = 0;//初始数据
		var size = 10;//每页多少数据
		var merid='${merid}';
		$(".allcard").html('');
		getData(start,size);
	}	   
 }
 
function formattime(timestr) {
	var date = new Date(timestr);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var dd = date.getDate();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var second = date.getSeconds();

	if (month < 10) {
		month = "0" + month;
	}
	if (dd < 10) {
		dd = "0" + dd;
	}
	if (hour < 10) {
		hour = "0" + hour;
	}
	if (minute < 10) {
		minute = "0" + minute;
	}
	if (second < 10) {
		second = "0" + second;
	}

	return year + "-" + month + "-" + dd + " " + hour + ":" + minute + ":"
			+ second;
}
</script>
<body>
<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
			<img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;" /> 评论详情</h3>
		</div>
		<div class="portlet box grey" style="margin-bottom: 0px; height: auto;border: 1px  solid #9d9c9c;border-left: 0;border-right: 0;">
		<div class="portlet-body">
			<table style="width:100%">
					<tr>
						<td style="width:15%;">
						<label class="control-label"style="float: left"><span style="color: red">*</span>商家名称：</label> 
						<label class="control-label"style="float: left">${mer[0]}</label> 
					  </td>
						<td style="width:15%;">
						<label class="control-label"style="float: left">综合评分：</label> 
						<label class="control-label"style="float: left"><fmt:formatNumber value='${mer[1]}' pattern='##.#' minFractionDigits="1"></fmt:formatNumber>分
						</label> 
						</td>
						<td style="width:15%;">
						<label class="control-label"style="float: left">评价总次数：</label> 
						<label class="control-label"style="float: left">${mer[2]}次</label> 
						</td>
						<td style="width:15%;">
						<label class="control-label"style="float: left">评价总人数：</label> 
						<label class="control-label"style="float: left">${mer[3]}人</label> 
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
		</div></div>
	</div>
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			
				<table style="width: 100%">
				<tr>
						<td style="width: 25%;">
						<label class="control-label" style="float: left;text-align: right;">用户昵称：</label>
						 <input type="text" id="search_realname" name="search_LIKE_realname" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="" value="${LIKE_name }">
						</td>
						<td style="width: 25%">
			            <label class="control-label" style="float:left;width: 70px;text-align: right;">评分：</label> 
				    	 <select id="startscore" name="search_EQ_startscore" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--请选择--</option>
								<option value="1">--1--</option>
								<option value="2">--2--</option>
								<option value="3">--3--</option>
								<option value="4">--4--</option>
								<option value="5">--5--</option>
						</select>
			            </td>
			            <td style="width: 25%">
			            <label class="control-label" style="float:left;width: 40px;text-align: right;">到：</label> 
			       		<select id="endscore" name="search_EQ_endscore" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--请选择--</option>
								<option value="1">--1--</option>
								<option value="2">--2--</option>
								<option value="3">--3--</option>
								<option value="4">--4--</option>
								<option value="5">--5--</option>
						</select>
			           </td>
						<td style="width: 25%;">&nbsp;</td>
					</tr>
					<tr>
						<td style="width: 25%;">
						<label class="control-label" style="float: left;width: 70px;text-align: right;">图片：</label>
						 <select id="search_urls" name="search_EQ_urls" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--全部--</option>
								<option value="1">--有--</option>
								<option value="0">--无--</option>
						</select>
						</td>
						<td style="width: 25%">
			            <label class="control-label" style="float:left;text-align: right;">评价时间：</label> 
				    	<input type="text" id="starttime"  name="search_EQ_starttime" maxlength="20"   readonly="readonly" style="float:left;width:60%;height:32px;cursor: pointer;" value="${EQ_starttime }"> 
			            </td>
			            <td style="width: 25%">
			            <label class="control-label" style="float:left;width: 40px;text-align: right;">到：</label> 
			       		<input type="text" id="endtime"  name="search_EQ_endtime" maxlength="20" readonly="readonly" style="float:left;width:60%;height:32px;cursor: pointer;" value="${EQ_endtime }"> 
			           </td>
						<td style="width: 25%;">
							<button type="button"  class="btn blue" id="search_btn" onclick="checkUser()">查询</button>&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
						</td>
					</tr>
				</table>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close"></button>
					${message}
				</div>
			</c:if>
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<tbody id="list">
				
				<div class="allcard">
		         <div class="rundiv">
		        	<div class="loadp p2size">加载中...</div>
	        	</div>
	           </div>
	          <div class="moreloading">
        		<div class="loadp">加载中...</div>
         	</div>
	         <div id="jzgd" onclick="add()" style="clear:both;text-align: center;background-color: #efefed">点击加载更多</div>
	         <div class="kong"></div>
			</tbody>
			</table>
		</div>
	</div>
</body>

</html>