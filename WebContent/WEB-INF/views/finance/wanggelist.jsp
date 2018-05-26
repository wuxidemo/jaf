<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>网格管理</title>
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
	pagin = $("#Pagination").pagination('${ctx}/areamanage/salist', opt);

	$("#search_btn").bind(
		"click",
		function() {
			var params = getMap(decodeURI($("#searchform")
					.serialize()));
			pagin = $("#Pagination").pagination(
					'${ctx}/areamanage/salist', opt, params);
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
									+ data.content[i].name
									+ '</td><td>'
									+ data.content[i].telephone
									+ '</td><td>'
									+ data.content[i].area
									+ '</td><td>'
									+ '<a href="javascript:void(0);" onclick="showdetail(\''
									+ data.content[i].id
									+ '\')">详情</a>&nbsp;'
									+ '<a href="javascript:void(0);" onclick="modify(\''
									+ data.content[i].id 
									+ '\')">编辑</a>&nbsp;<a href="javascript:;" onclick="deleteone(\''
									+data.content[i].id
									+'\')">删除</a>');
		}
		setTimeout('window.parent.iFrameHeight();',100);

	}
	
	function resetAll() {
		$("#sname").val("");
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
		$.post('${ctx}/areamanage/delete', {
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
	
	// 是否删除一条记录
	var delid = '';
	function deleteone(sid) {
		delid = sid;
		window.parent.showConfirm("你确定要删除这条记录吗？",sureDelOne);
	}
	// 确认删除单条记录
	function sureDelOne() {
		$.post('${ctx}/areamanage/delete', {
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
	//显示详情
	function showdetail(id) {
		var url = '${ctx}/areamanage/showdetail/'+id
		$.get(url,function(data){
			if(data.result == '1') {
				var d = data.data;
				$("#id").val(d.id);
				$("#name").val(d.name)
				$("#telephone").val(d.telephone);
				$("#area").html(d.area);
				var lourl = d.logourl
				if (lourl == "") {
					$("#photo").show();
					$("#introimg").show();
					$("#introface").css("display", "none");
					$("#uppic").css("display", "none");
				} else {
					$("#introimg").show();
					$("#photo").show();
					$("#uppic").css("display", "none");
					$("#introface").css("display", "block");
					$("#introimg").attr("src",lourl);
				}
				$("#introimg").show();
				$("#save").css("display","none");
				$("#sure").css("display","block");
				$("#detail").show();
				$("#update").hide();
				$("#add").hide();
				$("#showdetaildiv").modal('show');
			}
		});
	}
	//收起弹框	
	function hidemodal() {
		$("#showdetaildiv").modal("hide");
	}
	//编辑网格
	function modify(id){
		var url = '${ctx}/areamanage/showdetail/'+id
		$.get(url,function(data){
			if(data.result == '1') {
				var d = data.data;
				$("#id").val(d.id);
				$("#name").val(d.name);
				$("#telephone").val(d.telephone);
				$("#area").html(d.area);
				var lourl = d.logourl;
				var upurl = $("#logourl").val();
				
				if("" == lourl || lourl == null){
					$("#introface").hide();
				}else{
					if ("" == upurl || upurl == null) {
						$("#introimg").show();
						$("#introface").css("display", "block");
						$("#introimg").attr("src",lourl);
					} else{
						$("#introimg").show();
						$("#introface").css("display", "block");
						$("#introimg").attr("src",upurl);
					}
				}
				$("#sure").css("display","none");
				$("#save").css("display","block");
				$("#uppic").show();
				$("#photo").hide();
				$("#update").show();
				$("#detail").hide();
				$("#add").hide();
				$("#inputForm").find("textarea").removeAttr("readonly");
				$("#inputForm").find("input").removeAttr("readonly");
				$("#showdetaildiv").modal('show');
			}
		});
	}
	//保存编辑网格	
	function save(){
		var name=$("#name").val();
		var phone=$("#telephone").val();
		var area=$("#area").val();
		var url=$("#introimg").attr("src");
		
		if(name==""){
			window.parent.showAlert("你没有填写负责人！");
			$("#name").focus();
			return false;
		}else if(phone==""){
			window.parent.showAlert("你没有填写联系电话！");
			$("#telephone").focus();
			return false;
		}else if(phone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1){
			window.parent.showAlert("联系电话格式不对！");
			$("#telephone").focus();
			return false;
		}else if(area==""){
			window.parent.showAlert("你没有填写负责范围！");
			$("#area").focus();
			return false;
		}else if(url==""){
			window.parent.showAlert("你没有上传证件照！");
			return false;
		}
		if($("#id").val()!=""){
			
			$("#logourl").val(url);
			
			var id=$("#id").val();
			$("#inputForm").attr("action","${ctx}/areamanage/update/"+id);
			$("#inputForm").submit();
		}else{
			$("#inputForm").attr("action","${ctx}/areamanage/save/");
			$("#inputForm").submit();
		}
	}
	//上传图片
	jQuery(document).ready(function() {
	    wxyt({
			div : "detailup",
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸200*200)",
			maxsize : 1048576,
			sucess : function(download_url, fileid, url) {
				
				$("#introface").css("display", "block");
				$("#introimg").show();
				$("#logourl").val(download_url);
				$("#thumburl").val(download_url+'?imageView2/2/w/258/h/170/q/85');
				$("#introimg").attr("src",download_url);
				
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				parent.window.showAlert(d);
			}
		});
	});
	
	//添加按钮操作
	function add(){
		$("#name").val('');
		$("#telephone").val('');
		$("#area").html('');
		$("#logourl").val('');
		$("#introimg").attr("src", "${ctx}/static/images/zanwuPic.jpg")
		$("#add").show();
		$("#detail").hide();
		$("#update").hide();
		
		$("#inputForm").find("input").removeAttr("readonly");
		$("#inputForm").find("textarea").removeAttr("readonly");
		$("#photo").hide();
		$("#showdetaildiv").modal('show');
		$("#showdetaildiv span").show();
		$("#sure").css("display","none");
		$("#save").css("display","block");
		$("#uppic").show();
	}
	

</script>
<body style="min-height: 950px;">
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 网格管理
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
						<td style="width: 30%;">
							<label class="control-label" style="float: left">&emsp;负责人:&emsp;</label> 
							<input type="text" id="sname" name="search_LIKE_name" maxlength="20" style="float: left; width: 60%; height: 32px;" class="" value="${LIKE_name }">
						</td>
						<td style="width: 80%;">
							<button type="button" class="btn blue" id="search_btn" style="margin-left: 20px" >查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn grey" id="reset_btn" onclick="resetAll()" >重置</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
				<a href="javascript:;" class="btn blue" onclick="add()">新增</a>
				<a href="javascript:;" class="btn red" onclick="deletebatch()"><i class=""></i>删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width:15%;">负责人</th>
						<th style="width:20%;">联系电话</th>
						<th style="width:30%;">负责范围</th>
						<th style="width:25%;">操作</th>
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
		role="dialog" style="top: 10%; width: 700px; height:700px; left: 40%;">
		
		<div class="modal-header" id="detail" style="display: none;">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">查看网格管理</h3>
		</div>
		
		<div class="modal-header" id="add" style="display: none;">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">新建网格管理</h3>
		</div>
		
		<div class="modal-header" id="update" style="display: none;">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">编辑网格管理</h3>
		</div>
		
		<div id=""  style="height:600px;" >
			<form action="" id="inputForm" class="form-horizontal" method="post">
				<div class="control-group" style="padding-top: 10px;">
					<input type="hidden" id="id" name="id" value=""/>
					<input type="hidden" id="logourl" name="logourl" value=""/>
					<input type="hidden" id="thumburl" name="thumburl" value=""/>
					<label class="control-label"><span style="color:red;display: none;">*</span>&nbsp;负责人：</label> 
					<!--  
					<label class="control-label label label-important" id="state" style="width: 40px; float: right; margin-right: 50%;"></label>
					-->
					<div class="controls">
						<input type="text" readonly="readonly" id="name"
							 name="name" class="span3 m-wrap" style="width: 60%;" 
							 value="" maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><span style="color:red;display: none;">*</span>&nbsp;联系电话：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="telephone"
							name="telephone" class="span3 m-wrap" style="width: 60%;"
							value="" maxlength="13">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label"><span style="color:red; display: none;">*</span>&nbsp;负责范围：</label>
					<div class="controls">
						<textarea rows="5" cols="2" readonly="readonly"  id="area" name="area"
							class="span3 m-wrap" style="width: 60%;" maxlength="20"></textarea>
					</div>
				</div>
				
				<div class="control-group" id="uppic" >
					<label for="fileToUploadintro" class="control-label"><span style="color:red;display: none;">*</span>&nbsp;证件照:</label>
					<div class="controls" id="detailup" >
						
					</div>
				</div>
				
				<div class="control-group" id="introface" >
					<label  class="control-label" id="photo">证件照:</label>
					<div class="controls">
						<img alt="缩略图" src=""  id="introimg" style="width: 200px">
					</div>
				</div>
			
				
			</form>
		</div>
		<!-- 确定按钮 -->
		<div class="modal-footer" id="sure">
			<input class="btn btn-primary blue" type="button" onclick="hidemodal()" value="确定" />&nbsp; 
		</div>
		
		<div class="modal-footer" id="save">
			<input class="btn btn-primary blue" type="button" onclick="save();" value="保存" />&nbsp; 
			<input class="btn btn-primary grey" type="button" onclick="hidemodal();" value="取消" />&nbsp; 
		</div>
	</div>
	
	
	

</body>
</html>