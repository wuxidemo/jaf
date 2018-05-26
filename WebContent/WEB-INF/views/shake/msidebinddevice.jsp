<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>服务登记管理</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/pagination.css" />
<script type="text/javascript" src="${ctx}/static/jquery.pagination/jquery.pagination.js"></script>
<script>
	jQuery(document).ready(function() {
		getuserpv();
		init_checkbox('.check_all','.check_item');
	});
	
	var pageids = '${page_ids}';
	
	var pagecommstr = '${pagecomment}';
	var j = 0;
	
	function getuserpv() {
		$.post("${ctx}/shake/getmsidepagelistforbind",{"hello":"hello"},function(d) {
			$("#uset").html("");
			if (d) {
				var datastr = eval(d);
				for (var i=0; i<datastr.length; i++) 
				{
					var datacomm = datastr[i].comment;
					var shotcomment = datacomm.substring(1,datacomm.length-1)
					if(pagecommstr == datacomm) {
						j++;
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;"><td style="vertical-align: middle;"><input type="checkbox" id="check_item" value="'+datastr[i].page_id+'" '+(pageids.indexOf(datastr[i].page_id) >= 0 ? "checked" : "")+' class="check_item">'
							    +'</td><td style="vertical-align:middle;">'+datastr[i].page_id
								+'</td><td style="vertical-align:middle;"><img src="'+ datastr[i].icon_url
								+ '" width=50 height=50 /></td><td style="vertical-align:middle;">'
								+ datastr[i].title
								+ '</td><td style="vertical-align:middle;">'
								+ datastr[i].description
								+ '</td><td style="vertical-align:middle;">'
								+ datastr[i].title
								+ '</td></tr>');
					}

				}
				if(j == 0) {
					$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;"><td colspan="7" style="vertical-align: middle;">暂无记录'
							+ '</td></tr>');
				}
				countchecked();
				setTimeout('window.parent.iFrameHeight()',100);
				
			}
		});
	}
	
	$(".odd").live("click",function(){
		if($(this).find("input:checkbox").prop("checked")) {
			$(this).find("input:checkbox").prop("checked",false);
		}else{
			$(this).find("input:checkbox").prop("checked",true);
		}
		countchecked();
	}); 
	
	function countchecked() {
		var idstr = "";
		$(".check_item").each(function(){
			if($(this).prop("checked")) {
				idstr += "," + $(this).val();
			}
		});
		
		if($.trim(idstr).length == 0) {
			$("#count").html('已选择<span style="color:red;">&nbsp;0&nbsp;</span>个页面！');
			return ;
		}
		
		delstr = idstr.substring(1);
		
		var idarr = delstr.split(",");
		
		$("#count").html('已选择<span style="color:red;">&nbsp;'+idarr.length+'&nbsp;</span>个页面！');
	}
	
	function init_checkbox(class_all,class_item){
		$(class_all).live("click", function(e) {
			e.stopPropagation();
			if (this.checked) {
				$(class_item).attr("checked", true);
			} else {
				$(class_item).attr("checked", false);
			}
			countchecked();
		});
		$(class_item).live("click", function(e) {
			e.stopPropagation();
			var flag = true;
			;
			$(class_item).each(function() {
				if (!this.checked) {
					flag = false;
				}
			});
			$(class_all).attr("checked", flag);
			countchecked();
		});
		
	}
	
	var delstr = "";
	function del() {
		var idstr = "";
		$(".check_item").each(function(){
			if($(this).prop("checked")) {
				idstr += "," + $(this).val();
			}
		});
		
		if($.trim(idstr).length == 0) {
			window.parent.showAlert("你没有选择任何页面!");
			return ;
		}
		
		delstr = idstr.substring(1);
		
		var idarr = delstr.split(",");
		
		if(idarr.length > 30) {
			window.parent.showAlert("最多只能绑定30个页面!");
			return ;
		}
		
		window.parent.showConfirm("已绑定的页面会被解除绑定，你确定要将所选页面绑定到该设备吗？",sureDel);
	}
	
	function sureDel() {
		$("#delForm").append('<input name="idstr" value="'+delstr+'" />');
		$("#delForm").submit();
	}
	
</script>
</head>
<body>
	<form action="${ctx}/shake/savemsidebind" method="post" style="display:none;" id="delForm" >
		<input type="hidden" name="deviceid" value="${deviceid}" />
		<input type="hidden" name="uuid" value="${uuid}" />
		<input type="hidden" name="major" value="${major}" />
		<input type="hidden" name="minor" value="${minor}" />
		<input type="hidden" name="page_ids" value="${page_ids}" />
	</form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/sbgl.png"
					style="vertical-align: text-bottom;" />页面列表
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;" class="btn blue" onclick="del()"><i
					class=""></i> 保存</a>
					
				<a href="javascript:;" class="btn red" onclick="history.back();"><i
					class=""></i> 取消</a>
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<!-- <div id="count"></div> -->
			<div id="count" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			<table id="sample_1"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 3%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 7%;">id</th>
						<th style="width: 15%;">页面图标</th>
						<th style="width: 25%;">标题</th>
						<th style="width: 25%;">副标题</th>
						<th style="width: 25%;">备注</th>
					</tr>
				</thead>
				<tbody id="uset">
				</tbody>
			</table>

			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
</body>
</html>
