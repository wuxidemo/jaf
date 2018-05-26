<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<title>提交页面</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/pagination.css" />
<script type="text/javascript" src="${ctx}/static/jquery.pagination/jquery.pagination.js"></script>
<script>
	jQuery(document).ready(function() {
		getuserpv();
		init_checkbox('.check_all','.check_item');
	});
	
	var pagecommstr = '${pagecomment}';
	var j = 0;
	function getuserpv() {
		$.post("${ctx}/shake/getmsidepagelist",function(d) {
			$("#uset").html("");
			if (d) {
				var datastr = eval(d);
				for (var i=0; i<datastr.length; i++) 
				{
					var datacomm = datastr[i].comment;
					var shotcomment = datacomm.substring(1,datacomm.length-1)
					if(pagecommstr == datacomm) {
						j++;
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;"><td style="vertical-align: middle;"><input type="checkbox" id="check_item" value="'+datastr[i].page_id+'" class="check_item"/>'
							    +'</td><td style="vertical-align:middle;">'+datastr[i].page_id
								+'</td><td style="vertical-align:middle;"><img src="'+ datastr[i].icon_url
								+ '" width=50 height=50 /></td><td style="vertical-align:middle;">'
								+ datastr[i].title
								+ '</td><td style="vertical-align:middle;">'
								+ datastr[i].description
								+ '</td><td style="vertical-align:middle;">'
								+ datastr[i].title
								+ '</td><td style="vertical-align:middle;">'
								+ '<a href="${ctx}/shake/updatemsidepage?pageid='+datastr[i].page_id+'">编辑</a>&nbsp;'
								+ '<a href="javascript:;" onclick="askfordel('+datastr[i].page_id+')">删除</a>&nbsp;'
								+ '</td></tr>');
					}
				}
				if(j == 0) {
					$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;"><td colspan="7" style="vertical-align: middle;">暂无记录'
							+ '</td></tr>');
				}
				setTimeout('window.parent.iFrameHeight()',100);
			}
		});
	}
	
	function init_checkbox(class_all,class_item){
		$(class_all).live("click", function() {
			if (this.checked) {
				$(class_item).attr("checked", true);
			} else {
				$(class_item).attr("checked", false);
			}
		});
		$(class_item).live("click", function() {
			var flag = true;
			;
			$(class_item).each(function() {
				if (!this.checked) {
					flag = false;
				}
			});
			$(class_all).attr("checked", flag);
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
			window.parent.showAlert("请选择一个页面!");
			return ;
		}
		
		delstr = idstr.substring(1);
		
		window.parent.showConfirm("你确定要删除所选择的页面吗？",sureDel);
	}
	
	function askfordel(pageid){
		delstr = pageid;
		window.parent.showConfirm("你确定要删除这个页面吗？",sureDel);
	}
	
	function sureDel() {
		$("#delForm").append('<input name="idstr" value="'+delstr+'" />');
		$("#delForm").append('<input name="token" value="token" />');
		$("#delForm").submit();
	}
	
	
</script>
<style type="text/css">
  td{
word-break: break-all;
}
</style>
</head>
<body>
	<form action="${ctx}/shake/deletepage" method="post" style="display:none;" id="delForm"/></form>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/sbgl.png"
					style="vertical-align: text-bottom;" />&nbsp;页面列表
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="${ctx}/shake/addmsidepage" class="btn blue"><i
					class=""></i> 新增</a>
					
				<a href="javascript:;" class="btn red" onclick="del()"><i
					class=""></i> 批量删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="sample_1"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 3%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 7%;">页面id</th>
						<th style="width: 15%;">页面图标</th>
						<th style="width: 20%;">标题</th>
						<th style="width: 20%;">副标题</th>
						<th style="width: 20%;">备注</th>
						<th style="width: 15%;">操作</th>
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
