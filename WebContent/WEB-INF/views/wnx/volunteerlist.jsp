<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
	String district = "";
	if (request.getParameter("search_EQ_paytype") != null)
		district = new String(request.getParameter("search_EQ_paytype")
				.getBytes("ISO-8859-1"), "UTF-8");
%>
<html>
<head>
<title>我能行人员管理</title>
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<%@ include file="../quote.jsp"%>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
	});

	function resetAll() {
		$("#search_name").val("");
		$("#search_paytype").val("-1");
		$("#search_isshow").val("-1");
		$("#search_community").val("-1");
		$("input[class='searchability']").each(function() {
			if (this.checked) {
				this.checked = false;
			}
		});
	}

	function deletevol1(id) {
		idTemp = id;
		parent.window.showConfirm("你确定要删除该信息?", suredel1);
	}
	function suredel1() {
		$.post('${ctx}/volunteer/delete?ids=' + idTemp, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/volunteer';
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
		$.post('${ctx}/volunteer/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/volunteer';
			} else {
				window.parent.showAlert(data.msg);
			}
		});

	}

	function showrefuse(id) {
		$("#form_refuse").modal('show');
		$("#id").val(id);
	}
	function hiderefuse() {
		$("#form_refuse").modal('hide');
	}
	/* 拒绝理由提交前的验证 */
	function refuse_Submit() {
		var id = $("#id").val();
		var reason = $("#failreason").val();
		if (reason.trim() == "") {
			window.parent.showAlert("拒绝原因不能为空!");
			return false;
		}else {
			$("#inputForm").submit();
		}
	}

	function isshow(openid) {
		$.post('${ctx}/wxcommunity/isshow?openid=' + openid, function(data) {
			if (data.isshow == 1) {
				window.parent.showAlert(data.msg);
				//window.location.href = '${ctx}/volunteer';
				$("#"+openid).html("上线");
				$("#isshow"+openid).html("下线");
			} else if (data.isshow == 0) {
				window.parent.showAlert(data.msg);
				//window.location.href = '${ctx}/volunteer';
				$("#"+openid).html("下线");
				$("#isshow"+openid).html("上线");
			}
		});
	}
</script>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
</style>
<body>
	<!-- BEGIN PAGE HEADER-->
	<!-- 内容页 固定头部 -->
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;" /> 我能行人员管理
			</h3>
		</div>
	</div>
	<!-- END PAGE HEADER-->
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-search" action="${ctx}/volunteer" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 25%;"><label class="control-label" style="float: left">姓名：</label> <input type="text" id="search_name" name="search_LIKE_name" maxlength="20" style="float: left; width: 60%; height: 32px;" class="" value="${LIKE_name }"></td>
						<td style="width: 25%;"><label class="control-label" style="float: left">意向报酬：</label> 
						<select id="search_paytype" name="search_EQ_paytype" style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1" <c:if test="${EQ_paytype==-1}" > selected="selected" </c:if>>--请选择--</option>
								<option value="1" <c:if test="${EQ_paytype==1}" > selected="selected" </c:if>>--有偿--</option>
								<option value="0" <c:if test="${EQ_paytype==0}" > selected="selected" </c:if>>--无偿--</option>
						</select></td>
						<td style="width:25%;"><label class="control-label" style="float: left">状态：</label> 
						<select id="search_isshow" name="search_EQ_isshow" style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1" <c:if test="${EQ_isshow==-1}" > selected="selected" </c:if>>--请选择--</option>
								<option value="1" <c:if test="${EQ_isshow==1}" > selected="selected" </c:if>>--线上--</option>
								<option value="0" <c:if test="${EQ_isshow==0}" > selected="selected" </c:if>>--线下--</option>
								<option value="2" <c:if test="${EQ_isshow==2}" > selected="selected" </c:if>>--拒绝--</option>
								<option value="3" <c:if test="${EQ_isshow==3}" > selected="selected" </c:if>>--待审核--</option>
						</select>
						</td>
					 <c:if test="${comm==null}" >
						<td style="width: 25%;"><label class="control-label" style="float: left">社区：</label> 
						<select id="search_community" name="search_EQ_community" style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1" <c:if test="${EQ_community==-1}" > selected="selected" </c:if>>--全部--</option>
								<c:forEach items="${commlist}" var="commlist" varStatus="status">
							       <option value="${commlist.id}" <c:if test="${EQ_community==commlist.id}" > selected="selected" </c:if>>--${commlist.name}--</option>
					        	</c:forEach>
						</select>
						</td>
					</c:if>
					</tr>
					<tr>
						<td style="width: 75%;" colspan="3"><c:forEach items="${keywordlist}" var="keywordlist" varStatus="status">
								<div style="width: 20%; float: left;">
									<input type="checkbox" id="search_${keywordlist.id}" name="search_LIKE_${keywordlist.id}" class="searchability" maxlength="20" style="float: left; height: 32px;" value="${keywordlist.value}" <c:forEach items="${list}" var="list" varStatus="status">
							    <c:if test="${list.value==keywordlist.value}" >checked="checked"</c:if>
						    	</c:forEach>> <label class="control-label" style="float: left; line-height: 32px; padding-left: 15px;">${keywordlist.value}</label>
								</div>
							</c:forEach></td>
						<td style="width: 25%;">
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn" onclick="resetAll()">重置</button>
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
			<div class="actions">
				<a href="javascript:;" class="btn red" onclick="deletevol2()" style="margin-top: -10px;"><i class=""></i>批量删除</a>
			</div>
		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close"></button>${message}
				</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 2%"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 3%">序号</th>
						<th style="width: 8%">姓名</th>
						<th style="width: 20%">才能类型</th>
						<th style="width: 12%">联系方式</th>
						<th style="width: 13%">服务时间</th>
						<th style="width: 10%">意向报酬</th>
						<th style="width: 10%">状态</th>
						 <c:if test="${comm==null}" >
						<th>社区</th>
						</c:if>
						<th style="width: 15%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${volunteer.totalPages!=0}">
						<c:forEach items="${volunteer.content}" var="volunteer" varStatus="status">
							<tr>
								<td><input type="checkbox" id="check_item" value="${volunteer[0]}" class="check_item"></td>
								<td>${status.count}</td>
								<td>${volunteer[1]}</td>
								<%-- <td>${volunteer[5]}</td> --%>
								<td><div style="width:323px;text-overflow :ellipsis ; white-space: nowrap;overflow: hidden;" title="${volunteer[5]}">${volunteer[5]}</div></td>
								<td>${volunteer[3]}</td>
								<td>${volunteer[6]}</td>
								<td><c:if test="${volunteer[8]== 0}">无偿</c:if> <c:if test="${volunteer[8]== 1}">有偿</c:if></td>
								<td id="${volunteer[14]}">
									<c:if test="${volunteer[10]== 0}">待审核</c:if> 
									<c:if test="${volunteer[10]== 2}">拒绝</c:if> 
									<c:if test="${volunteer[10]== 1}">
										<c:if test="${volunteer[11]== 0}">线下</c:if>
										<c:if test="${volunteer[11]==1}">线上</c:if>
									</c:if>
								</td>
								
								<c:if test="${comm==null}" >
						        <th style="width: 10%;text-align: center;vertical-align: middle;font-weight:normal;">${volunteer[15]}</th>
						        </c:if>
						        
								<td>
									<c:if test="${volunteer[10]== 0}">
										<a href="${ctx}/volunteer/via?id=${volunteer[0]}">通过</a>&nbsp;
										<a href="javascript:;" onclick="showrefuse('${volunteer[0]}')">拒绝</a>&nbsp;
										<a href="${ctx}/volunteer/check?id=${volunteer[0]}">详情</a>&nbsp;
										<a href="javascript:;" onclick="deletevol1('${volunteer[0]}')">删除</a>
									</c:if> 
									<c:if test="${volunteer[10]== 1}">
										<a href="${ctx}/volunteer/check?id=${volunteer[0]}">详情</a>&nbsp;
										<c:if test="${volunteer[11]== 1}">
											<a href="javascript:;" onclick="isshow('${volunteer[14]}')" id="isshow${volunteer[14]}">下线</a>
										</c:if>
										<c:if test="${volunteer[11]==0}">
											<a href="javascript:;" onclick="isshow('${volunteer[14]}')" id="isshow${volunteer[14]}">上线</a>
										</c:if>&nbsp;
										<a href="javascript:;" onclick="deletevol1('${volunteer[0]}')">删除</a>
									</c:if>
									<c:if test="${volunteer[10]== 2}">
										<a href="${ctx}/volunteer/check?id=${volunteer[0]}">详情</a>&nbsp;
										<a href="javascript:;" onclick="deletevol1('${volunteer[0]}')">删除</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${volunteer.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${volunteer}" paginationSize="5" />
		</div>
	</div>
	<!-- 	弹出框 -->
	<div class="modal hide fade" id="form_refuse" tabindex="-1" role="dialog" style="top: 10%; width: 50%; left: 40%;">
		<div id="" class="modal-body" style="font-size: 35;">
			<form action="${ctx}/volunteer/refuse" method="post" id="inputForm" class="form-horizontal">
				<div class="control-group">
					<label class="control-label">&nbsp; </label>
				</div>
				<div class="control-group" style="text-align: center;">
					<label style="font-size: 18px;">拒绝申请</label> <input type="hidden" id="id" name="id" value="">
				</div>
				<div class="control-group">
					<label class="control-label">拒绝理由：</label>
					<div class="controls" style="color: red;">
						<textarea rows="" cols="" style="width: 280px; height: 100px;" placeholder="请输入拒绝理由，字数不超过50字" maxlength="50" id="failreason" name="failreason"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<input id="submit_btn" class="btn btn-primary green" type="button" onclick="refuse_Submit()" value="保存" />&nbsp; <input type="button" class="btn" id="search_btn" onclick="hiderefuse()" value="取消">
				</div>
			</form>
		</div>
	</div>
</body>
</html>