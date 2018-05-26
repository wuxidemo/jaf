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
		initPagination();
		init_checkbox('.check_all','.check_item');
	});
	
	var totalnum = parseInt('${count}');
	var mernamestr = '${mername}'
	function initPagination() {
		$("#Pagination").pagination(totalnum, {
			num_edge_entries : 1, //边缘页数
			num_display_entries : 10, //主体页数
			callback : pageselectCallback,
			items_per_page : pageSize, //每页显示1项
			prev_text : "前一页",
			next_text : "后一页",
			link_to : "javascript:void(0);"
		});
	}
	
	var pageSize = 10;
	var merdevstr = '${merdevList}';
	var merdevobj = eval(merdevstr);
	var k = 0;
	function getuserpv(index) {
		$.post("${ctx}/shake/getdevicelist?pageSize="+ pageSize + "&pageIndex=" + index+ "&mername=" + mernamestr,function(d) {
			$("#uset").html("");
			if (d) {
				var datastr = eval(d);
				for (var i=0; i<datastr.length; i++) 
				{	
					var merdevname = '';
					
					if(merdevobj != null && merdevobj != 'undefined' && merdevobj.length > 0 && mernamestr != '') {
						$("#Pagination").remove();
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
										+ (merdevname == "" ? '<a href="${ctx}/shake/bindmerchant?deviceid='+datastr[i].device_id+'">绑定商家</a>&nbsp;' : '<a href="${ctx}/shake/unbindmerchant?deviceid='+datastr[i].device_id+'">解除绑定</a>&nbsp;')
										+ '</td></tr>');
							}
						}
					}else if(merdevobj != null && merdevobj != 'undefined' && merdevobj.length > 0 && mernamestr == ''){
						for(var j=0; j<merdevobj.length; j++) {
							if(merdevobj[j].deviceid == datastr[i].device_id) {
								merdevname = merdevobj[j].mername;
								break;
							}
						}
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;">'
								+'<td style="vertical-align:middle;">'+(i+1)	
							    +'</td><td style="vertical-align:middle;">'+datastr[i].device_id
								+'</td><td style="vertical-align:middle;">'
								+ (merdevname == "" ? "" : merdevname)
								+ '</td><td style="vertical-align:middle;">'
								+ (datastr[i].status == 1 ? '<span class="label label-success">已激活</span>' : '<span class="label label-danger">未激活</span>')
								+ '</td><td style="vertical-align:middle;">'
								+ (merdevname == "" ? '<a href="${ctx}/shake/bindmerchant?deviceid='+datastr[i].device_id+'">绑定商家</a>&nbsp;' : '<a href="${ctx}/shake/unbindmerchant?deviceid='+datastr[i].device_id+'">解除绑定</a>&nbsp;')
								+ '</td></tr>');
					}else if((merdevobj == null || merdevobj == 'undefined') && mernamestr != ''){
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;text-align:center;">'
								+'<td colspan="5" style="vertical-align:middle;">暂无数据！</td></tr>');
						break;
					}else if((merdevobj == null || merdevobj == 'undefined') && mernamestr == '') {
						$("#uset").append('<tr class="odd gradeX" style="background-color: #ffff;">'
								+'<td style="vertical-align:middle;">'+(i+1)	
							    +'</td><td style="vertical-align:middle;">'+datastr[i].device_id
								+'</td><td style="vertical-align:middle;">'
								+ (merdevname == "" ? "" : merdevname)
								+ '</td><td style="vertical-align:middle;">'
								+ (datastr[i].status == 1 ? '<span class="label label-success">已激活</span>' : '<span class="label label-danger">未激活</span>')
								+ '</td><td style="vertical-align:middle;">'
								+ (merdevname == "" ? '<a href="${ctx}/shake/bindmerchant?deviceid='+datastr[i].device_id+'">绑定商家</a>&nbsp;' : '<a href="${ctx}/shake/unbindmerchant?deviceid='+datastr[i].device_id+'">解除绑定</a>&nbsp;')
								+ '</td></tr>');
					}
				}
				window.parent.iFrameHeight();
			}
		});
	}
	function pageselectCallback(index, jq) {
		getuserpv(index + 1);
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
		
		window.parent.showConfirm("确定要删除所选择的页面吗？",sureDel);
	}
	
	function sureDel() {
		$("#delForm").append('<input name="idstr" value="'+delstr+'" />');
		$("#delForm").submit();
	}
	
	function resetAll() {
		$("#mername").val("");
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
					style="vertical-align: text-bottom;" />&nbsp;设备管理
			</h3>
		</div>
	</div>
	<div class="portlet box grey" style="margin-bottom:0px;height:auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/shake/devicelist" method="post">
			<table style="width: 100%">
			<tr>
				<td>
					<label class="control-label" style="float:left">名称：</label> 
					<input type="text" id="mername" name="mername" maxlength="20" style="float:left;width: 40%;" value="${mername}"> 
				</td>
				<td>
					<button type="submit" class="btn blue" id="search_btn" style="margin-left:50px;">查询</button>&nbsp;&nbsp;
					<button type="button" class="btn" id="reset_btn" onclick="resetAll()">重置</button>
				</td>
				</tr>
				
			</table>
		    </form>
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
			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
</body>
</html>
