<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>物业报修</title>
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
	pagin = $("#Pagination").pagination('${ctx}/pensionapply/penlist', opt);

	$("#search_btn").bind(
		"click",
		function() {
			var params = getMap(decodeURI($("#searchform")
					.serialize()));
			pagin = $("#Pagination").pagination(
					'${ctx}/pensionapply/penlist', opt, params);
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
				var ctime = formattime(data.content[i].createtime);
				var actname = data.content[i].pensionAct;
				var showname = "";
				if (actname == null || "" == actname) {
					showname += "空";
				}else{
					showname += actname.name;
				}

			$("#list")
					.append(
							'<tr><td><input type="checkbox" id="check_item" value="'+data.content[i].id+'" class="check_item"></td><td>'
									+ data.content[i].id
									+ '</td><td>'
									+ data.content[i].name
									+ '</td><td>'
									+ data.content[i].telephone
									+ '</td><td>'
									+ ctime
									+ '</td><td>'
									+ showname
									+ '</td><td>'
									+ '<a href="javascript:void(0);" onclick="showdetail(\''
									+ data.content[i].id
									+ '\')">查看</a>&nbsp;');
		}
		setTimeout('window.parent.iFrameHeight();', 100);

	}

	function resetAll() {
		$("#name").val('');
		$("#state").val('0');
		$("#community").val('0');
		$("#starttime").val('');
		$("#endtime").val('');

	}
	// 判断是否选择复选框
	function deletebatch() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		window.parent.showConfirm("你确定要删除所选择的记录吗？", sureDel);
	}
	// 执行批量删除操作
	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/repair/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				pagin.refresh(ids.split('|').length);
				window.parent.showAlert("删除成功");
			} else {
				window.parent.showAlert("删除失败");
			}
		});
	}

	// 是否删除一条记录
	var delid = '';
	function deleteone(sid) {
		delid = sid;
		window.parent.showConfirm("你确定要删除这条记录吗？", sureDelOne);
	}
	// 确认删除单条记录
	function sureDelOne() {
		$.post('${ctx}/repair/delete', {
			"ids" : delid
		}, function(data) {
			if (data.result) {
				pagin.refresh(1);
				parent.window.showAlert("删除成功");
			} else {
				parent.window.showAlert("删除失败");
			}
		});
	}
	
	function getMap(queryString) {
		if (null != queryString) {
			parameters = {};
			var parameterArray = queryString.split("&");
			var length = parameterArray.length;
			for (var i = 0; i < length; i++) {
				var parameter = parameterArray[i];
				index = parameter.indexOf("=");
				var key = parameter.substring(0, index);
				var value = parameter.substring(index + 1);
				if (null != key && key.length > 0) {
					parameters[key] = value;
				}
			}
			return parameters;

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

		return year + "-" + month + "-" + dd;
	}


	function showdetail(id) {
		var detailurl = '${ctx}/pensionapply/showdetail/' + id
		$.get(detailurl, function(data) {
			if (data.result == '1') {
				var d = data.data;
				$("#name").val(d.name);
				$("#sex").val(d.sex==1?'男':'女');
				$("#age").val(d.age);
				$("#createtime").val(formattime(d.createtime));
				$("#telephone").val(d.telephone);
				$("#address").val(d.address);
				if(d.type == "2"){
					$("#divcontent").show();
					$("#content").html(d.content);
				}else {
					$("#divcontent").hide();
				}
			

				$("#showdetaildiv").modal('show');
			}
		});
	}

	function hidemodal() {
		$("#showdetaildiv").modal("hide");
	}
</script>
<body style="min-height: 950px;">
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 申请列表
			</h3>
		</div>
	</div>

	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-search" id="searchform" action=""
				method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%;">
							<label class="control-label" style="float: left">活动类型:&emsp;</label> 
							<select id="type" name="search_EQ_type" style="float: left; width: 60%; height: 32px;" class="">
								<option value="0">--全部申请--</option>
								<option value="1">活动申请</option>
								<option value="2">直接申请</option>
							</select>
						</td>
						<td style="width: 33%;">
							<label class="control-label" style="float: left">活动名称:&emsp;</label> 
							<select id="penid" name="search_EQ_pensionAct.id" style="float: left; width: 60%; height: 32px;" class="">
								<option value="0">--全部活动--</option>
								<c:forEach items="${pensionacts}" var="pensionact">
									<option value="${pensionact.id}">${pensionact.name}</option>
								</c:forEach>
							</select>
						</td>
						<td style="width: 33%;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					 </tr>
				</table>
			</form>
		</div>
	</div>
	<div class="portlet box grey" >
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 2%;">全选<input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width:8%;">序号</th>
						<th style="width:12%;">姓名</th>
						<th style="width:15%;">电话</th>
						<th style="width:15%;">申请时间</th>
						<th style="width:15%;">报名活动</th>
						<th style="width:15%;">操作</th>
					</tr>
				</thead>
				<tbody id="list">

				</tbody>
			</table>
			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
	
	<!-- 报修详情 -->

	<div class="modal hide fade" id="showdetaildiv" tabindex="-2"
		role="dialog" style="top: 10%; width: 800px; height:600px; left: 40%;">
		
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">查看申请详情</h3>
		</div>
		
		<div id=""  style="height:500px;" >
			<form action="" id="inputForm" class="form-horizontal" method="post">
				<div class="control-group" style="padding-top: 10px;">
					<label class="control-label">姓名：</label> 
					<div class="controls">
						<input type="text" readonly="readonly" id="name"  name="name" class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>

				</div>
				
				<div class="control-group">
					<label class="control-label">性别：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="sex" name="sex"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">年龄：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="age" name="age"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">报名时间：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="createtime"
							name="createtime" class="span3 m-wrap" style="width: 60%;"
							value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">联系方式：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="telephone" name="telephone"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">家庭住址：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="address"
							name="address" class="span3 m-wrap" style="width: 60%;"
							value="" maxlength="10">
					</div>
				</div>
				
				<div class="control-group" id="divcontent" style=" display: none;">
					<label class="control-label">申请描述：</label>
					<div class="controls">
					<textarea rows="2" cols="3"  readonly="readonly" id="content"
							name="content" class="span3 m-wrap" style="width: 60%; "
							 maxlength="20"></textarea>
					</div>
				</div>
			
			</form>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary blue" type="button" onclick="hidemodal()" value="返回" />&nbsp; 
		</div>
	</div>
	

</body>
</html>