<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String district = "";
	if (request.getParameter("search_EQ_community.id") != null)
		district = new String(request.getParameter("search_EQ_community.id").getBytes("ISO-8859-1"),
				"UTF-8");
%>
<html>
<head>
<title>物业缴费</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/dw.pagination.css" />
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
</head>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
</style>
<script type="text/javascript" src="${ctx}/static/jquery.pagination/dw.pagination.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.form/jquery.form.min.js"></script>
<script type="text/javascript">
var pagin;
$(function(){
	init_checkbox('.check_all','.check_item');
		var opt = {
			callback : pageselectCallback,
			items_per_page : 10, 
		};
		pagin = $("#Pagination").pagination('${ctx}/sqpropertyfee', opt);

		$("#search_btn")
				.bind(
						"click",
						function() {
							var params = getMap(decodeURI($("#searchform")
									.serialize()));
							pagin = $("#Pagination").pagination(
									'${ctx}/sqpropertyfee', opt, params);
						});

	});

	function pageselectCallback(data) {
		$("#list").empty();
		for (var i = 0; i < data.content.length; i++) {
			var state = data.content[i].state;
			var fee=data.content[i].fee/100//+().toFixed(2)
			var statestr='';
			if(state == 0) {
				statestr += '<span class="label label-important">未交费</span>';
			}else if(state == 1){
				statestr += '<span class="label label-success">已缴费</span>';
			}
			$("#list")
					.append(
							'<tr>	<td><input type="checkbox" id="check_item" value="'+data.content[i].id+'" class="check_item"></td><td>'
									+ data.content[i].build
									+ '</td><td>'
									+ data.content[i].number
									+ '</td><td>'
									+ data.content[i].householder
									+ '</td><td>'
									+ data.content[i].telephone
									+ '</td><td>'
									+fee.toFixed(2)
									+ '</td><td>'
									+statestr
									+ '</td><td><a href="javascript:;" onclick="delsq(\''
									+ data.content[i].id
									+ '\')">删除</a></td></tr>');
			setTimeout('window.parent.iFrameHeight();',100);
		}

	}

	function resetAll() {
		$("#search_householder").val('');
		$("#search_telephone").val('');
		$("#search_district").val('-1');

	}
	function del() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		parent.window.showConfirm("您确定删除该信息？", sureDel);
	}

	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/sqpropertyfee/delete', {
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
	function delsq(id) {
	    ids = id;
		parent.window.showConfirm("您确定删除该信息？", sureDelSq);
}
	function sureDelSq() {
		$.post('${ctx}/sqpropertyfee/delete', {
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
</script>
<body>
<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 物业缴费
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
						<td style="width: 25%;">
						<label class="control-label"style="float: left;width: 70px;text-align: right;">户主：</label> 
						<input type="text" id="search_householder" name="search_LIKE_householder" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""value="${LIKE_householder }">
						</td>
						<td style="width: 25%;">
						<label class="control-label"style="float: left">联系方式：</label> 
						<input type="text" id="search_telephone" name="search_LIKE_telephone" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""value="${LIKE_telephone}">
						</td>
						<c:if test="${comm==null}">
                        <td style="width: 25%;">
						<label class="control-label" style="float: left;width: 70px;text-align: right;">社区：</label> 
						<select id="search_district" name="search_EQ_community.id" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--全部--</option>
								<c:forEach items="${commlist}" var="commlist" varStatus="status">
							       <option value="${commlist.id}" <c:if test="${EQ_community.id==commlist.id}" > selected="selected" </c:if>>--${commlist.name}--</option>
					        	</c:forEach>
						</select>
						</td>
						<td style="width:25%;text-align: center;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
						</td>
						</c:if> 
						<c:if test="${comm!=null}" >
						<td style="width:25%;text-align: center;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
						</td>
						<td style="width:25%;text-align: center;">
							&nbsp;
						</td>
						</c:if>
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
			<div class="actions">
			    <a href="javascript:;" class="btn red" onclick="del()"><i class=""></i>删除</a>	    
               <c:if test="${comm!=null}" >
               <a href="${ctx}/sqpropertyfee/jumpdata" class="btn blue"><i class=""></i>导入数据</a> 
               </c:if>	
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close"></button>
					${message}
				</div>
			</c:if>
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 2%">
						<input type="checkbox" id="check_all" value="" class="check_all">
						</th>
						<th>楼号</th>
						<th>门牌号</th>
						<th>户主</th>
						<th>联系方式</th>
						<th>缴费金额</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="list">

				</tbody>
			</table>
			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
</body>
</html>