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
	pagin = $("#Pagination").pagination('${ctx}/repair/replist', opt);

	$("#search_btn").bind(
		"click",
		function() {
			var params = getMap(decodeURI($("#searchform")
					.serialize()));
			pagin = $("#Pagination").pagination(
					'${ctx}/repair/replist', opt, params);
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
			var statestr = '';
			var state = data.content[i].state;
			if(state == 1) {
				statestr += '<span class="label label-important">未解决</span>';
			}else if(state == 2) {
				statestr += '<span class="label label-warning">处理中</span>';
			}else if(state == 3) {
				statestr += '<span class="label label-default">暂不解决</span>';
			}else if(state == 4){
				statestr += '<span class="label label-success">已解决</span>';
			}
			$("#list").append(
							'<tr><td><input type="checkbox" id="check_item" value="'+data.content[i].id+'" class="check_item"></td><td>'
									+ data.content[i].name
									+ '</td><td>'
									+ data.content[i].telephone
									+ '</td><td>'
									+ ctime
									+ '</td><td><div style="width:350px; text-align:center; text-overflow :ellipsis; white-space: nowrap;overflow: hidden;" title="'+data.content[i].content+'">'
									+ data.content[i].content
									+ '</div></td><td>'
									+ data.content[i].address
									+ '</td><td>'
									+ data.content[i].community.name
									+ '</td><td id="state'+data.content[i].id+'" value="'+state+'">'
									+ statestr
									+ '</td><td>'
									+ '<a href="javascript:void(0);" onclick="showdetail(\''
									+ data.content[i].id
									+ '\')">详情</a>&nbsp;'
									+ '<a href="javascript:;" onclick="deleteone(\''
									+ data.content[i].id + '\')">删除</a>');
		}
		setTimeout('window.parent.iFrameHeight();',100);

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
		window.parent.showConfirm("你确定要删除所选择的记录吗？",sureDel);
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
		window.parent.showConfirm("你确定要删除这条记录吗？",sureDelOne);
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
		
		if(month < 10) {
			month = "0"+month;
		}
		if(dd < 10) {
			dd = "0" + dd;
		}
			if(hour < 10) {
				hour = "0" + hour;
			}
			if(minute < 10) {
				minute = "0" + minute;
			}
			if(second < 10) {
				second = "0" + second;
			} 
		
		return year+"-"+month+"-"+dd;
	}
	
	function inprogress() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return false;
		}else{
			var prourl = '${ctx}/repair/inprogress';
			$.post(prourl,{"ids":ids},function(data){
				window.parent.showConfirm(data.sbmsg+"<br/>确定要改变状态？",sureInProgress);
			})
		}
	}
	
	function sureInProgress() {
		var ids = getIds('.check_item');
		var prourl = '${ctx}/repair/sureinprogress';
		$.post(prourl,{"ids":ids},function(data){
			var result = data.result;
			var idstr = data.changeids;
			
			if(data.result == '1') {
				if(idstr != '') {
					var idarr = idstr.split(",");
					var len = idarr.length;
					for(var i=0;i<len;i++) {
						$("#state"+idarr[i]).html('<span class="label label-warning">处理中</span>');
					}
					window.parent.showAlert("状态改变成功");
				}else{
					window.parent.showAlert("没有符合条件的记录要改变状态");
				}
				
			}else{
				window.parent.showAlert("状态改变失败");
			}
			
			$('.check_all').prop("checked",false);
			$('.check_item').prop("checked",false);
			
		})
	}
	
	function solved() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return false;
		}else{
			var prourl = '${ctx}/repair/solved';
			$.post(prourl,{"ids":ids},function(data){
				window.parent.showConfirm(data.sbmsg+"<br/>确定要改变状态？",sureSolved);
			})
		}
	}
	
	function sureSolved() {
		var ids = getIds('.check_item');
		var prourl = '${ctx}/repair/suresolved';
		$.post(prourl,{"ids":ids},function(data){
			var result = data.result;
			var idstr = data.changeids;
			
			if(data.result == '1') {
				if(idstr != '') {
					var idarr = idstr.split(",");
					var len = idarr.length;
					for(var i=0;i<len;i++) {
						$("#state"+idarr[i]).html('<span class="label label-success">已解决</span>');
					}
					window.parent.showAlert("状态改变成功");
				}else{
					window.parent.showAlert("没有符合条件的记录要改变状态");
				}
				
			}else{
				window.parent.showAlert("状态改变失败");
			}
			
			$('.check_all').prop("checked",false);
			$('.check_item').prop("checked",false);
			
		})
	}
	
	function nosolved() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return false;
		}else{
			var prourl = '${ctx}/repair/nosolved';
			$.post(prourl,{"ids":ids},function(data){
				window.parent.showConfirm(data.sbmsg+"<br/>确定要改变状态？",sureNoSolved);
			})
		}
	}
	
	function sureNoSolved() {
		var ids = getIds('.check_item');
		var prourl = '${ctx}/repair/surenosolved';
		$.post(prourl,{"ids":ids},function(data){
			var result = data.result;
			var idstr = data.changeids;
			
			if(data.result == '1') {
				if(idstr != '') {
					var idarr = idstr.split(",");
					var len = idarr.length;
					for(var i=0;i<len;i++) {
						$("#state"+idarr[i]).html('<span class="label label-default">暂不解决</span>');
					}
					window.parent.showAlert("状态改变成功");
				}else{
					window.parent.showAlert("没有符合条件的记录要改变状态");
				}
				
			}else{
				window.parent.showAlert("状态改变失败");
			}
			
			$('.check_all').prop("checked",false);
			$('.check_item').prop("checked",false);
			
		})
	}
	
	function showdetail(id) {
		var detailurl = '${ctx}/repair/showdetail/'+id
		$.get(detailurl,function(data){
			if(data.result == '1') {
				var d = data.data;
				$("#id").val(d.id);
				$("#pname").val(d.name);
				var sta = d.state;
				if (sta == 1) {
					$("#stater").val("未解决");
				} else if (sta == 2) {
					$("#stater").val("处理中 ");
				} else if (sta == 3) {
					$("#stater").val("暂不解决 ");
				} else if (sta == 4) {
					$("#stater").val("已解决");
				}
				$("#comname").val(d.community.name);
				$("#telephone").val(d.telephone);
				$("#address").val(d.address);
				$("#createtime").val(formattime(d.createtime));
				$("#content").val(d.content);
				var url = d.infourl
				if (""== url || url == null) {
					$("#img").css("display", "none");
				} else {
					$("#introimg").attr("src", url);
					$("#img").css("display", "block");
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
					style="vertical-align: text-bottom;" /> 物业报修
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
			<form class="form-search" id="searchform" action="${ctx}/community"
				method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%;">
							<label class="control-label" style="float: left">&emsp;报修人:&emsp;</label> 
							<input type="text" id="name" name="search_LIKE_name" maxlength="20" style="float: left; width: 60%; height: 32px;  " class="" value="${LIKE_name }">
						</td>
						<td style="width: 33%;">
							<label class="control-label" style="float: left">状态:&emsp;</label> 
							<select id="state" name="search_EQ_state" style="float: left; width: 60%; height: 32px;" class="">
								<option value="0">--全部--</option>
								<option value="1">未解决</option>
								<option value="2">处理中</option>
								<option value="3">暂不解决</option>
								<option value="4">已解决</option>
							</select>
						</td>
						<c:if test="${iscomm == '0' }">
							<td style="width: 33%;">
								<label class="control-label" style="float: left">社区:&emsp;</label> 
								<select id="community" name="search_EQ_community.id" style="float: left; width: 60%; height: 32px;" class="">
									<option value="0">--选择社区--</option>
									<c:forEach items="${communitys}" var="community">
										<option value="${community.id}">${community.name}</option>
									</c:forEach>
								</select>
							</td>
						</c:if>
						<c:if test="${iscomm == '1' }">
							<td style="width: 33%;">&nbsp;</td>
						</c:if>
					 </tr>
					 <tr>
					 	<td style="width:33%;">
							<label class="control-label" style="float:left">报修时间:&emsp;</label> 
							<input type="text" id="starttime" name="search_GTE_createtime" maxlength="20" readonly="readonly" style="width:60%;height:32px;cursor: pointer;" value="${GTE_createtime }"> 
						</td>
						<td style="width:33%;">
							<label class="control-label" style="float:left">&emsp;到:&emsp;</label> 
							<input type="text" id="endtime" name="search_LTE_createtime" maxlength="20" readonly="readonly" style="width:60%;height:32px;cursor: pointer;" value="${LTE_createtime }"> 
						</td>
						<td style="width: 33%;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
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
			<div class="actions">
				<a href="javascript:;">&nbsp;</a>
				<c:if test="${iscomm == '1'}">
					<a href="javascript:;" class="btn yellow" onclick="inprogress()"><i class=""></i>处理中</a>
					<a href="javascript:;" class="btn green" onclick="solved()"><i class=""></i>已解决</a>
					<a href="javascript:;" class="btn orange" onclick="nosolved()"><i class=""></i>暂不解决</a>
				</c:if>
				<a href="javascript:;" class="btn red" onclick="deletebatch()"><i class=""></i>删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 2%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width:8%;">报修人</th>
						<th style="width:8%;">联系方式</th>
						<th style="width:10%;">报修时间</th>
						<th style="width:22%;">报修内容</th>
						<th style="width:15%;">地点</th>
						<th style="width:10%;">社区</th>
						<th style="width:5%;">状态</th>
						<th style="width:20%;">操作</th>
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
		role="dialog" style="top: 10%; width: 800px; height:800px; left: 40%;">
		
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">查看报修详情</h3>
		</div>
		
		<div id=""  style="height:700px;" >
			<form action="" id="inputForm" class="form-horizontal" method="post">
				<div class="control-group" style="padding-top: 10px;">
					<label class="control-label">报修人：</label> 
					<!--  
					<label class="control-label label label-important" id="state" style="width: 40px; float: right; margin-right: 50%;"></label>
					-->
					<div class="controls">
						<input type="text" readonly="readonly" id="pname"  name="pname" class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>

				</div>
				
				<div class="control-group">
					<label class="control-label">状态：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="stater" name="stater"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">所属社区：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="comname" name="comname"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">联系方式：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="telephone"
							name="telephone" class="span3 m-wrap" style="width: 60%;"
							value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">地点：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="address" name="address"
							class="span3 m-wrap" style="width: 60%;" value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">报修时间：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="createtime"
							name="createtime" class="span3 m-wrap" style="width: 60%;"
							value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">报修内容：</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<textarea readonly="readonly" id="content" class="span3 m-wrap"
						rows="3" style="width:46%;"></textarea>
				</div>

				<!--
					<div class="control-group" id="info">
						<p>报修人：<span>${repair.name }</span></p>
						<p>所属社区：<span>${repair.community.name }</span></p>
						<p>联系方式：<span>${repair.telephone }</span></p>
						<p>地点：<span>${repair.address }</span></p>
						<p>报修时间：<span id=>${repair.createtime }</span></p>
						
						<br>
						<p>${repair.content }</p>
					</div>
					-->

				<div class="control-group" id="introface">

					<div id="img" class="controls" style="max-height: 270px; overflow: hidden;">
						<img alt="缩略图" src="" id="introimg" width="200px" >
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary blue" type="button" onclick="hidemodal()" value="确定" />&nbsp; 
		</div>
	</div>
	

</body>
</html>