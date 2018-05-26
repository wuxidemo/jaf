<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<title>设备管理</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/pagination.css" />
<script type="text/javascript" src="${ctx}/static/jquery.pagination/jquery.pagination.js"></script>
<script>
	jQuery(document).ready(function() {
		getuserpv()
	});
	
	var merdevList = '${merdevList}';
	var merdevobj = eval(merdevList);
	var k = 0;
	function getuserpv() {
		$.post("${ctx}/shake/getmsidedevicelist",function(d) {
			$("#uset").html("");
			if (d) {
				var datastr = eval(d);
				for (var i=0; i<datastr.length; i++) {	
					var merdevname = '';
					
					if(merdevobj != null && merdevobj != 'undefined' && merdevobj.length > 0){
						for(var j=0; j<merdevobj.length; j++) {
							if(merdevobj[j].deviceid == datastr[i].device_id) {
								merdevname = merdevobj[j].mername;
								k++;
								$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;">'
										+'<td style="vertical-align:middle;">'+k	
									    +'</td><td style="vertical-align:middle;">'+datastr[i].device_id
										+'</td><td style="vertical-align:middle;">'
										+ (merdevname == "" ? "" : merdevname)
										+ '</td><td style="vertical-align:middle;">'
										+ (datastr[i].status == 1 ? '<span class="label label-success">已激活</span>' : '<span class="label label-danger">未激活</span>')
										+ '</td><td style="vertical-align:middle;">'
										+ '<a href="${ctx}/shake/msidebinddevice?deviceid='+datastr[i].device_id+'&uuid='+datastr[i].uuid+'&major='+datastr[i].major+'&minor='+datastr[i].minor+'">绑定页面</a>&nbsp;'
										+ '</td></tr>');
							}
						}
						
					}else{
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;">'
								+'<td colspan="5" style="vertical-align:middle;">暂无数据！'
								+ '</td></tr>');
						break;
					}
				}
				window.parent.iFrameHeight();
			}
		});
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
					style="vertical-align: text-bottom;" />设备管理
			</h3>
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
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="sample_1"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10%;">序号</th>
						<th style="width: 10%;">设备id</th>
						<th style="width: 30%;">商户名称</th>
						<th style="width: 20%;">设备状态</th>
						<th style="width: 30%;">操作</th>
					</tr>
				</thead>
				<tbody id="uset">
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
