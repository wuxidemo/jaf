<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String district = "";
	if (request.getParameter("search_EQ_state") != null)
		district = new String(request.getParameter("search_EQ_state").getBytes("ISO-8859-1"), "UTF-8");
%>
<html>
<head>
<title>义仓商品表</title>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
	<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet" type="text/css" />
	<%@ include file="../quote.jsp"%>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		init_checkbox('.check_all', '.check_item');
	});
	
	/* 重置 */
	function resetAll() {
		$("#name").val("");
		$("#search_state").val("-1");
		$("#search_community").val("-1");
	}
	function deletevol1(id) {
		idTemp = id;
		parent.window.showConfirm("你确定要删除该信息?", suredel1);
	}
	function suredel1() {
		$.post('${ctx}/sq_donation_good/delete?ids=' + idTemp, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/sq_donation_good';
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
		$.post('${ctx}/sq_donation_good/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert(data.msg);
				window.location.href = '${ctx}/sq_donation_good';
			} else {
				window.parent.showAlert(data.msg);
			}
		});

	}
</script>
<body>
<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				义仓商品管理
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
			<form class="form-search" action="${ctx}/sq_donation_good" method="post" onsubmit = "return checkUser();">
			<table style="width: 100%">
		   
		    <tr>
				<td >
					<label class="control-label" style="float:left">商品名称：</label> 
					<input type="text" id="name"  name="search_LIKE_name" maxlength="20" style="float:left;width: 60%;height:32px;" value="${LIKE_name}"> 
				</td>
				<td >
					<label class="control-label" style="float:left">商品状态：</label> 
					 <select id="search_state" name="search_EQ_state" maxlength="20" style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--请选择--</option>
								<option value="1" <c:if test="${EQ_state == 1}">selected="selected"</c:if> >--上架--</option>
								<option value="0" <c:if test="${EQ_state == 0}">selected="selected"</c:if>>--下架--</option>
						</select>
				</td>
				 <c:if test="${comm==null}" >
                    <td >
						<label class="control-label" style="float: left;width: 70px;text-align: right;">社区：</label> 
						<select id="search_community" name="search_EQ_community.id" style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1" <c:if test="${EQ_community==-1}" > selected="selected" </c:if>>--全部--</option>
								<c:forEach items="${commlist}" var="commlist" varStatus="status">
							       <option value="${commlist.id}" <c:if test="${EQ_community==commlist.id}" > selected="selected" </c:if>>--${commlist.name}--</option>
					        	</c:forEach>
						</select>   
				</td>
                </c:if>
				<td>
				<button type="submit" class="btn blue" id="search_btn" >查询</button>&nbsp;&nbsp;
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
			<div class="actions">
			<c:if test="${comm!=null}" ><a href="${ctx}/sq_donation_good/create" class="btn blue"> 新增</a></c:if>&nbsp;
				<a href="javascript:;" class="btn red" onclick="deletevol2()" >批量删除</a>
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
					   <th style="width: 2%">
					    <input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 10%;">商品编号</th>
                        <th style="width: 28%;">商品名称</th>
						<th style="width: 10%;">价格</th>
						<th style="width: 15%;">规格</th>
						<th style="width:10%;">状态</th>
						<c:if test="${comm==null}" ><th style="width:10%;">社区</th></c:if>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${donationgoods.totalPages!=0}">
						 <c:forEach items="${donationgoods.content}" var="donationgoods" varStatus="status">
							<tr>
							    <td><input type="checkbox" id="check_item"
									value="${donationgoods[0]}" class="check_item"></td>
								<td style="vertical-align: middle;">${donationgoods[1]}</td>
								<td style="vertical-align: middle;">${donationgoods[2]}</td>
								<td style="vertical-align: middle;">
								<fmt:formatNumber value='${donationgoods[3]/100}' pattern='##' minFractionDigits="0"></fmt:formatNumber>元
								</td>
								<td style="vertical-align: middle;">${donationgoods[4]}</td>
								<td style="vertical-align: middle;"><c:if test="${donationgoods[5]==0}">下架</c:if><c:if test="${donationgoods[5]==1}">上架</c:if></td>
								<c:if test="${comm==null}" ><td style="vertical-align: middle;"><div style="width:161px;text-overflow :ellipsis ; white-space: nowrap;overflow: hidden;" title="${donationgoods[9]}">${donationgoods[9]}</div></td></c:if>
								<td style="vertical-align: middle;">
								<a href="${ctx}/sq_donation_good/view?id=${donationgoods[0]}">查看</a>&nbsp; 
								 <c:if test="${comm!=null}" ><a href="${ctx}/sq_donation_good/update?id=${donationgoods[0]}">编辑</a>&nbsp; </c:if>
								<a href="javascript:;" onclick="deletevol1('${donationgoods[0]}')">删除</a>&nbsp; 
								<a href="${ctx}/sq_donation_good/state?id=${donationgoods[0]}&state=${donationgoods[5]}">
								<c:if test="${donationgoods[5]==0}">上架</c:if>
								<c:if test="${donationgoods[5]==1}">下架</c:if>
								</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${donationgoods.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="9" style="text-align: center;">无记录</td>
						</tr>
					</c:if> 
				</tbody>
			</table>
			 <tags:pagination page="${donationgoods}" paginationSize="5"/> 
		</div> 
	</div>
</body>
</html>