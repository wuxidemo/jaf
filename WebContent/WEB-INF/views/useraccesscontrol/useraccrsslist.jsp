<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>门禁管理</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/dw.pagination.css" />
</head>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
</style>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.pagination/dw.pagination.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.form/jquery.form.min.js"></script>
<script type="text/javascript">
var pagin;
$(function(){
	init_checkbox('.check_all','.check_item');
	initDate();

	var opt = {
		callback : pageselectCallback,
		items_per_page :10, 
	};
	
	pagin = $("#Pagination").pagination('${ctx}/accesscontrol/aclist', opt);

	$("#search_btn").bind(
		"click",
		function() {
			var params = getMap(decodeURI($("#searchform")
					.serialize()));
			pagin = $("#Pagination").pagination(
					'${ctx}/accesscontrol/aclist', opt, params);
		});

	});
	
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

	function pageselectCallback(data) {
		$("#list").empty();
		for (var i = 0; i < data.content.length; i++) {
			$("#list").append(
							'<tr><td><input type="checkbox" id="check_item" value="'+data.content[i].id+'" class="check_item"></td><td>'
									+ data.content[i].id
									+ '</td><td>'
									+ data.content[i].openid
									+ '</td><td>一单元</td>');
			
		}
		setTimeout('window.parent.iFrameHeight();',100);

	}


	// 判断是否选择复选框
	function deletebatch() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		window.parent.showConfirm("你确定要删除所选择的记录吗？",sureDel);
	}
	// 执行批量删除操作
	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/accesscontrol/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				pagin.refresh(ids.split('|').length);
				parent.window.showAlert("删除成功");
			} else {
				parent.window.showAlert("删除失败");
			}
		});
	}
	//新增
	function create() {
		$("#showdetaildiv").modal('show');
		$("#introimg").attr("src","${ctx}/static/images/20160421135436.png"); 
	}
	//收起弹框	
	function hidemodal() {
		$("#showdetaildiv").modal("hide");
	}

</script>
<body style="min-height: 950px;">
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 门禁住户管理

			</h3>
			
		</div>
	</div>
<hr>
	<br>
	<div class="portlet box grey" >
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;" class="btn blue" id="search_btn" onclick="create()" >新增</a>
				<a href="javascript:;" class="btn red" id="search_btn" onclick="deletebatch()" >删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10%;"><input type="checkbox" id="check_all" value="" class="check_all">全选</th>
						<th style="width:15%;">序号</th>
						<th style="width:30%;">编号</th>
						<th style="width:20%;">单元号</th>
					</tr>
				</thead>
				<tbody id="list">

				</tbody>
			</table>
			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
	
	<!-- 网格详情 -->

	<div class="modal hide fade" id="showdetaildiv" tabindex="-2"
		role="dialog" style="top: 10%; width: 700px; height:550px; left: 40%;">
		
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">添加门禁</h3>
		</div>
		
		<div id=""  style="height:450px;" >
			<form action="" id="inputForm" class="form-horizontal" method="post">
				<div class="control-group" id="introface">
				
					<div id="img" class="controls" style="padding-top: 80px;">
						<img alt="缩略图" src="" id="introimg">
					</div>
					<div style="padding-left:36%;padding-top: 15px"><span style="font-size: 15px">用户用微信扫描即可登记</span></div>
					
				</div>
			</form>
		</div>
		<!-- 确定按钮 -->
		<div class="modal-footer" id="save">
			<input class="btn btn-primary blue" type="button" onclick="hidemodal();" value="确认添加" />&nbsp; 
		</div>
	</div>
	
	
	

</body>
</html>