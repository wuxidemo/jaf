<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>四个菜单页面</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>
<script>
 jQuery(document).ready(function() {
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});

		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});
	 $("#in1").prop( "checked", true );
		
 });
 
 
 
 /* 查询当天的数据 */
 function event22(){
	 var key='';
		var obj = document.getElementsByName("typepage");
		for(var i=0; i<obj.length; i ++){
	        if(obj[i].checked){
	            var key=obj[i].value;
	        }
	    }
		
		$.post("${ctx}/wxpage/getday",{"key":key},function(data){
			
			/* 处理数据部分 */
			
		});	
	 
 }
 
 /*   查询最近七天的数据 */
  function event1(){
	  var key='';
		var obj = document.getElementsByName("typepage");
		for(var i=0; i<obj.length; i ++){
	        if(obj[i].checked){
	            var key=obj[i].value;
	        }
	    }
		
$.post("${ctx}/wxpage/getsevenday",{"key":key},function(data){
			
			/* 处理数据部分 */
			
		});	
 }
 
 /* 查询最近30天的数据 */
  function event2(){
	  var key='';
		var obj = document.getElementsByName("typepage");
		for(var i=0; i<obj.length; i ++){
	        if(obj[i].checked){
	            var key=obj[i].value;
	        }
	    }
		
$.post("${ctx}/wxpage/getthirtylist",{"key":key},function(data){
			
			/* 处理数据部分 */
			
		});	
	 
 }
 
 
 /* 根据开始和结束时间查询数据 */
 function but(){
	 var start=$("#datepicker").val();
	 var end=$("#datepicker1").val();
	 
	 var key='';
		var obj = document.getElementsByName("typepage");
		for(var i=0; i<obj.length; i ++){
	        if(obj[i].checked){
	            var key=obj[i].value;
	        }
	    }
	 
	 if($.trim(start).length == 0) {
			window.parent.showAlert("请选择开始时间！");
			return false;
		}
	 if($.trim(end).length == 0) {
			window.parent.showAlert("请选择结束时间！");
			return false;
		}
	 $.post("${ctx}/wxpage/gettimelist",{"start":start,"end":end,'key':key},function(data){
			
			/* 处理数据部分 */
			
		});	
 }
 
 </script>
<body>
	<div class="row-fluid">
		<div class=" span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 菜单点击查询
			</h3>
		</div>
	</div>
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<table style="width: 100%">
				<tr>
					<td style="">
						<button type="button" class="btn yellow" onclick="event22()"
							style="margin-left: 20px;">当天</button>
					</td>
					<td>
						<button type="button" class="btn green" onclick="event1()"
							style="margin-left: 20px;">最近7天</button>
					</td>
					<td>
						<button type="button" class="btn blue" onclick="event2()"
							style="margin-left: 20px;">最近30天</button>
					</td>

					<td style="padding-top: 10px"><label class="control-label"
						style="float: left; width: 80px; margin-top: 11px;">开始时间：</label>
						<input type="text" readonly="readonly" id="datepicker"
						name="search_GTE_createtime" maxlength="20"
						style="cursor: pointer; width: 37%; height: 25px;" class=""
						value="${GTE_createtime}"></td>
					<td style="padding-top: 10px"><label class="control-label"
						style="float: left; width: 80px; margin-top: 11px;">结束时间：</label>
						<input type="text" readonly="readonly" id="datepicker1"
						name="search_LTE_createtime" maxlength="20"
						style="cursor: pointer; width: 37%; height: 25px;" class=""
						value="${LTE_createtime}"></td>
					<td><label class="control-label"
						style="float: left; width: 80px;">&emsp;</label>
						<button type="submit" class="btn blue" id="search_btn"
							onclick="but()">查询</button>&nbsp;&nbsp;</td>
				</tr>
			</table>

			<table style="width: 100%; margin-top: 20px;">
				<tr>
					<td style="width: 9%; font-size: 20px">特惠商户首页：</td>
					<td style="width: 1%"><input type="radio" name="typepage"
						value="1" id="in1"></td>
					<td style="font-size: 18px; width: 5%;">首页</td>

					<td style="width: 1%"><input type="radio" name="typepage"
						value="2"></td>
					<td style="width: 5%; font-size: 18px;">社区</td>

					<td style="width: 1%"><input type="radio" name="typepage"
						value="3"></td>
					<td style="width: 5%; font-size: 18px;">优惠劵</td>


					<td style="width: 1%"><input type="radio" name="typepage"
						value="4"></td>
					<td style="font-size: 18px;">我的</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>统计图
			</div>
		</div>

		统计图部分



	</div>
</body>
</html>