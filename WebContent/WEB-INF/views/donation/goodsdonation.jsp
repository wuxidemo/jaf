<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String district = "";
	if (request.getParameter("search_EQ_state") != null)
		district = new String(request.getParameter("search_EQ_state").getBytes("ISO-8859-1"), "UTF-8");
%>
<html>
<head>
<title>物品捐献记录</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
<%@ include file="../quote.jsp"%>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
		initDate();
	});
	function initDate() {
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
	function checkUser() {
		var time1 = new Date(document.getElementById('starttime').value)
				.getTime();
		var time2 = new Date(document.getElementById('endtime').value)
				.getTime();
		if (time1 > time2) {
			$("#starttime").val("");
			$("#endtime").val("");
			window.parent.showAlert("请选择正确日期，结束时间大于开始时间！");
			return false;
		} else {
			return true;
		}
	}

	/* 重置 */
	function resetAll() {
		$("#name").val("");
		$("#context").val("");
		$("#search_community").val("-1");
		$("#starttime").val("");
		$("#endtime").val("");
	}
	function deletevol1(id) {
		idTemp = id;
		parent.window.showConfirm("你确定要删除该信息?", suredel1);
	}
	function suredel1() {
		$.post('${ctx}/sqdonation/delete?ids=' + idTemp, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/sqdonation/goodsdonation';
			} else {
				window.parent.showAlert(data.msg);
			}
		});
	}

	function deletevol2() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		parent.window.showConfirm("确定要将选中的数据删除吗?", suredel2);
	}

	function suredel2() {
		var ids = getIds('.check_item');
		$.post('${ctx}/sqdonation/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/sqdonation/goodsdonation';
			} else {
				window.parent.showAlert(data.msg);
			}
		});

	}
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" /> 物品捐献记录
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
			<form class="form-search" action="${ctx}/sqdonation/goodsdonation"
				method="post" onsubmit="return checkUser();">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 70px; text-align: right;">捐献人：</label>
							<input type="text" id="name" name="search_LIKE_name"
							maxlength="20" style="float: left; width: 60%; height: 32px;"
							value="${LIKE_name}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left">捐献物品：</label> <input type="text" id="context"
							name="search_LIKE_context" maxlength="20"
							style="float: left; width: 60%; height: 32px;"
							value="${LIKE_context}"></td>
						<td><c:if test="${comm==null}">
								<label class="control-label" style="float: left">社区：</label>
								<select id="search_community" name="search_EQ_community"
									style="float: left; width: 60%; height: 32px;" class="">
									<option value="-1"
										<c:if test="${EQ_community==-1}" > selected="selected" </c:if>>--全部--</option>
									<c:forEach items="${commlist}" var="commlist"
										varStatus="status">
										<option value="${commlist.id}"
											<c:if test="${EQ_community==commlist.id}" > selected="selected" </c:if>>--${commlist.name}--</option>
									</c:forEach>
								</select>
							</c:if></td>
					</tr>
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left">捐献时间：</label> <input type="text"
							id="starttime" name="search_EQ_starttime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px; cursor: pointer;"
							value="${EQ_starttime }"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left; width: 70px; text-align: right;">到：</label> <input
							type="text" id="endtime" name="search_EQ_endtime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px; cursor: pointer;"
							value="${EQ_endtime }"></td>
						<td>
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
							<button type="button" class="btn" id="reset_btn"
								onclick="resetAll()">重置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption" style="width: 70%;">
				<i class="icon-globe"></i><label id="smsnumber"
					style="margin-bottom: 0px;">共收到物品${goodsnum}件</label>
			</div>
			<div class="actions">
				<c:if test="${comm!=null}">
					<a href="${ctx}/sqdonation/creategoods" class="btn blue"> 新增</a>
				</c:if>
				&nbsp; <a href="javascript:;" class="btn red" onclick="deletevol2()">批量删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close"></button>${message}
				</div>
			</c:if>
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 2%"><input type="checkbox" id="check_all"
							value="" class="check_all"></th>
						<th style="width: 15%;">编号</th>
						<th style="width: 10%;">捐献人</th>
						<th>联系方式</th>
						<th style="width: 20%;">捐献物品</th>
						<c:if test="${comm==null}">
							<th style="width: 10%;">社区</th>
						</c:if>
						<th>捐献时间</th>
						<th style="width: 15%;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${goodsdonation.totalPages!=0}">
						<c:forEach items="${goodsdonation.content}" var="goodsdonation"
							varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item"
									value="${goodsdonation[0]}" class="check_item"></td>
								<td style="vertical-align: middle;">${goodsdonation[1]}</td>
								<td style="vertical-align: middle;">${goodsdonation[2]}</td>
								<td style="vertical-align: middle;">${goodsdonation[3]}</td>
								<td style="vertical-align: middle;"><div
										style="width: 323px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"
										title="${goodsdonation[5]}">${goodsdonation[5]}</div></td>
								<c:if test="${comm==null}">
									<td style="vertical-align: middle;"><div
											style="width: 161px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"
											title="${goodsdonation[15]}">${goodsdonation[15]}</div></td>
								</c:if>
								<td style="vertical-align: middle;">${fn:substring(goodsdonation[6],0,10)}</td>
								<td style="vertical-align: middle;"><c:if
										test="${comm!=null}">
										<a href="${ctx}/sqdonation/updategoods?id=${goodsdonation[0]}">编辑</a>&nbsp;</c:if>
									<a href="javascript:;"
									onclick="deletevol1('${goodsdonation[0]}')">删除</a></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${goodsdonation.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="9" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${goodsdonation}" paginationSize="5" />
		</div>
	</div>
</body>
</html>