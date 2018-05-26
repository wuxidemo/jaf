<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>商户点击查询</title>
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
	
	event3();
 });
 
 
 
 /* 查询当天的数据 */
 function event222(){
		$.post("${ctx}/wxpage/getmerchantday",function(d){
			$("#bdy").empty();
			   if(d.result == "1"){
				   var list=d.listday;
				   for(var i=0;i<list.length;i++){
					   $("#bdy").append(' <tr>'
							                +'<td>'+(i+1)
							                +'</td>'
							                +'<td>'+list[i][1]
							                +'</td>'
							                +'<td>'+list[i][2]
							                +'</td>'
							             +'</tr>'
							   
					   
					   )
					   
				   }
				   
			   }else{
				   $("#bdy").append('<tr>'
				             +'<td colspan="3">'
				             +'无点击记录'
				             +'</td></tr>'
		                    )
			   }
			   window.parent.iFrameHeight();
		});	
	 
 }
 
 /*   查询最近七天的数据 */
  function event1(){	
   $.post("${ctx}/wxpage/getsevenmerchant",function(d){
			
		$("#bdy").empty();
		   if(d.result == "1"){
			   var list=d.listsevenday;
			   for(var i=0;i<list.length;i++){
				   $("#bdy").append('<tr>'
						             +'<td>'+(i+1)
						             +'</td>'
						             +'<td>'+list[i][1]
						             +'</td>'
						             +'<td>'+list[i][2]
						             +'</td>'
						             +'</tr>'
						   
				   
				   )
				   
			   }
			   
		   }else{
			   $("#bdy").append(' <tr>'
			             +'<td colspan="3">'
			             +'无点击记录'
			             +'</td></tr>'
	                    )
		   }
		   window.parent.iFrameHeight();
			
		});	
 }
 
 /* 查询最近30天的数据 */
  function event2(){
    $.post("${ctx}/wxpage/getthirtymerchant",function(d){
			
    	$("#bdy").empty();
		   if(d.result == "1"){
			   var list=d.listthirtyday;
			   for(var i=0;i<list.length;i++){
				   $("#bdy").append(' <tr>'
						             +'<td>'+(i+1)
						             +'</td><td>'+list[i][1]
						             +'</td><td>'+list[i][2]
						             +'</td></tr>'
						   
				   
				   )
				   
			   }
			   
		   }else{
			   $("#bdy").append(' <tr>'
			             +'<td colspan="3">'
			             +'无点击记录'
			             +'</td></tr>'
	                    )
		   }
		   window.parent.iFrameHeight();
			
		});	
	 
 }
 
     /*   查询所有的点击记录 */
     function event3(){
    	 $.post("${ctx}/wxpage/getsummerchant",function(d){
    	
    	    	$("#bdy").empty();
    			   if(d.result == "1"){
    				   var list=d.listsumday;
    				   for(var i=0;i<list.length;i++){
    					  
    					   $("#bdy").append(' <tr>'
    							             +'<td>'+(i+1)
    							             +'</td><td>'+list[i][1]
    							             +'</td><td>'+list[i][2]
    							             +'</td></tr>'
    							            
    							   
    					   
    					   )
    					   
    				   }
    				   
    			   }else{
    				   $("#bdy").append(' <tr>'
    				             +'<td colspan="3">'
    				             +'无点击记录'
    				             +'</td></tr>'
    		                    )
    			   }
    			   window.parent.iFrameHeight();
    				
    			});	
    	 
     }
     
 
 
 
 /* 根据开始和结束时间查询数据 */
 function but(){
	 var start=$("#datepicker").val();
	 var end=$("#datepicker1").val();
	 var mername=$("#name").val();
	 
	 if($.trim(mername).length == 0 && $.trim(start).length == 0) {
			window.parent.showAlert("请补全查找条件!");
			return false;
		}
	 if($.trim(start).length != 0 &&$.trim(end).length == 0) {
			window.parent.showAlert("请选择结束时间！");
			return false;
		}
	 if($.trim(start).length == 0 &&$.trim(end).length != 0) {
			window.parent.showAlert("请选择开始时间！");
			return false;
		}
	
	 $.post("${ctx}/wxpage/zhuhe",{"start":start,"end":end,'name':mername},function(d){
		
		 $("#bdy").empty();
		   if(d.result == "1"){
			   var list=d.listsumday;
			   for(var i=0;i<list.length;i++){
				   $("#bdy").append(' <tr>'
						             +'<td>'+(i+1)
						             +'</td><td>'+list[i][1]
						             +'</td><td>'+list[i][2]
						             +'</td></tr>'
						   
				   
				   )
				   
			   }
			   
		   }else{
			   $("#bdy").append(' <tr>'
			             +'<td colspan="3">'
			             +'无点击记录'
			             +'</td></tr>'
	                    )
		   }
		   window.parent.iFrameHeight();
			
			
		});	
 }
 
 </script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png">商户点击查询
			</h3>
		</div>
	</div>
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-serch"></i>查询
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<table style="width: 100%">
				<tr>
					<td style="width: 10%">
						<button type="button" class="btn yellow" onclick="event222()"
							style="margin-left: 20px;">当天</button>
					</td>
					<td style="width: 10%">
						<button type="button" class="btn green" onclick="event1()"
							style="margin-left: 20px;">最近7天</button>
					</td>
					<td style="width: 10%">
						<button type="button" class="btn blue" onclick="event2()"
							style="margin-left: 20px;">最近30天</button>
					</td>

					<td style="padding-top: 10px; width: 35%"><label
						class="control-label"
						style="float: left; width: 80px; margin-top: 11px;">开始时间：</label>
						<input type="text" readonly="readonly" id="datepicker"
						name="search_GTE_createtime" maxlength="20"
						style="cursor: pointer; width: 37%; height: 25px;" class=""
						value="${GTE_createtime}"></td>
					<td style="padding-top: 10px; width: 35%"><label
						class="control-label"
						style="float: left; width: 80px; margin-top: 11px;">结束时间：</label>
						<input type="text" readonly="readonly" id="datepicker1"
						name="search_LTE_createtime" maxlength="20"
						style="cursor: pointer; width: 37%; height: 25px;" class=""
						value="${LTE_createtime}"></td>

				</tr>
				<tr>
					<td colspan="3" style="width: 1%"><label class="control-label"
						style="float: left; width: 80px; padding-left: 4%; margin-top: 7px">商家名称：</label>
						<input type="text" id="name" class="" name="search_LIKE_name"
						value="${LIKE_name}" style="width: 40%; height: 25px;"></td>
					<td colspan="3"><label class="control-label"
						style="float: left; width: 80px;">&emsp;</label>
						<button type="submit" class="btn blue" id="search_btn"
							onclick="but()">查询</button>&nbsp;&nbsp;</td>
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
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 5%">序号</th>
						<th style="width: 10%">商家名称</th>
						<th style="width: 5%">点击量</th>
					</tr>
				</thead>
				<tbody id="bdy">


				</tbody>

			</table>
		</div>
	</div>
</body>
</html>