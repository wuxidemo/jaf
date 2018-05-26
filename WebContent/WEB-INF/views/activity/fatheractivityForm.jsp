<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
	<title>首页布局终端分配</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css"href="${ctx}/static/multiselect/jquery.multiselect2side.css" />
	<script type="text/javascript" src="${ctx}/static/multiselect/jquery.multiselect2side.js"></script>
</head>

<script>
	jQuery(document).ready(function() {
		
		var action = '${action}';
		var faid = '${fa.id}';
		if(action == 'create') {
			setallacts();
		}else{
			var yesurl = '${ctx}/fatheractivity/getyesacts';
			$.post(yesurl,{"faid":faid},function(data){
				if(data.result == '1') {
					var yesdata = data.yesdata;
					var nodata = data.nodata;
					setupdateacts(yesdata,nodata);
				}
			})
		}
	
	});
	
	function setallacts() {
		$("#mselect").html("<select multiple=\"multiple\" id=\"my_multi_select1\" size='20' name=\"actids\"></select>");
		$('#my_multi_select1').multiselect2side({
			moveOptions : false,
			labelsx : '',
			labeldx : ''
		});
		var acturl = '${ctx}/activity/getallactivity';
		$.get(acturl,function(data){
			if(data.result == '1') {
				var alldata = data.data;
				for(var i=0;i<alldata.length;i++) {
					$('#my_multi_select1').multiselect2side('addOption',
							{
								name : alldata[i].title,
								value : alldata[i].id,
								selected : false
							});
				}
				window.parent.iFrameHeight();
			}
		});
	}
	
	function setupdateacts(yesdata,nodata) {
		$("#mselect").html("<select multiple=\"multiple\" id=\"my_multi_select1\" size='20' name=\"actids\"></select>");
		$('#my_multi_select1').multiselect2side({
			moveOptions : false,
			labelsx : '',
			labeldx : ''
		});
		for(var i=0;i<yesdata.length;i++) {
			$('#my_multi_select1').multiselect2side('addOption',
					{
						name : yesdata[i].title,
						value : yesdata[i].id,
						selected : true
					});
		}
		
		for(var i=0;i<nodata.length;i++) {
			$('#my_multi_select1').multiselect2side('addOption',
					{
						name : nodata[i].title,
						value : nodata[i].id,
						selected : false
					});
		}
		window.parent.iFrameHeight();
	}
	
	function formSubmit() {
		var name = $("#name").val();
		var len = $("#my_multi_select1").val();
		
		if($.trim(name) == '') {
			window.parent.showAlert("你没有填写父活动名称！");
			return;
		}/* else if(len == undefined || len == null || len == '') {
			window.parent.showAlert("请至少选择一个子活动！");
			return;
		} */ 
		
		$("#inputForm").submit();
	}
</script>


<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				创建父活动
			</h3>
		</div>
	</div>
	
	<div class="portlet box grey" style="margin-top: 20px;height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>选择子活动
			</div>
		</div>
		<div class="portlet-body form" style="padding-top: 20px;">
			<form id="inputForm" action="${ctx}/fatheractivity/${action}"
				method="post" class="form-horizontal">
				<input type="hidden" id="faid" name="id" value="${fa.id}" />
				
				<div class="control-group">
					<label class="control-label">父活动名称:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap" style="width: 40%;" name="name" value="${fa.name}"  maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">选择子活动:</label>
					<div id="mselect" class="controls">
						<select name="actids" id='my_multi_select1' multiple='multiple'size='20'>
						</select>
					</div>
				</div>
				<div class="form-actions">
					<button class="btn blue" type="button" onclick="formSubmit()">保存</button>
					&nbsp; <input id="cancel_btn" class="btn" type="button" value="取消" onclick="history.back()" />
	
				</div>
			</form>
		</div>
	</div>
</body>
</html>