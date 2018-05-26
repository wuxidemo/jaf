<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>最美校园活动控制台</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>
<script>
	jQuery(document).ready(function() {
		$("#datepicker").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});

		$("#datepicker1").datepicker({
			dateFormat : 'yyyy mm dd',
			rtl : App.isRTL()
		});

		init_checkbox('.check_all', '.check_item');

	});

	var pageno = '';
	function deletepro(pagenum) {
		pageno = pagenum;
		var ids = getIds('.check_item');
		if (ids == 0) {
			window.parent.showAlert("请选择一条记录！");
		} else {
			parent.window.showConfirm("确定要将选中的数据删除吗?", sureDel);
		}
	}

	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/newyearact/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert("删除成功");
				window.location.href = '${ctx}/newyearact/listpro?page='+pageno;
			} else {
				window.parent.showAlert("删除失败");
			}
		});
	}
	
	
	function sureChange() {
		$.post('${ctx}/newyearact/changestage', {"stage" : actstate}, function(data) {
			window.parent.showAlert(data.msg);
			window.location.href='${ctx}/newyearact/listpro';
		});
	}
	
	var ruxuanid = '';
	function ruxuan(proid) {
		ruxuanid = proid;
		window.parent.showConfirm('你确定要将该作品入选复赛？',sureRuxuan);
	}
	
	function sureRuxuan() {
		$.post('${ctx}/newyearact/bechosen', {"proid" : ruxuanid}, function(data) {
			if(data.result == '1') {
				$("#state"+ruxuanid).html("<span class=\"label label-success\">复赛</span>");
				$("#act"+ruxuanid).html("<a href=\"javascript:;\" onclick=\"noruxuan('"+ruxuanid+"')\">取消入选</a> ");
			}
			window.parent.showAlert(data.msg);
		});
	}
	
	var noruxuanid = '';
	function noruxuan(proid) {
		noruxuanid = proid;
		window.parent.showConfirm('你确定要取消该作品的复赛资格？',sureNoRuxuan);
	}
	
	function sureNoRuxuan() {
		$.post('${ctx}/newyearact/nobechosen', {"proid" : noruxuanid}, function(data) {
			if(data.result == '1') {
				$("#state"+noruxuanid).html("<span class=\"label label-default\">初赛</span>");
				$("#act"+noruxuanid).html("<a href=\"javascript:;\" onclick=\"ruxuan('"+noruxuanid+"')\">入选</a> ");
			}
			window.parent.showAlert(data.msg);
		});
	}
	
	function showthis(obj) {
		var thisobj = $(obj);
		var imgurl = thisobj.attr("src");
		if(imgurl != '') {
			imgurl = imgurl.substring(0,imgurl.lastIndexOf("?"));
		}else{
			imgurl = '${ctx}/static/images/zanwuPic.jpg';
		}
		
		window.open(imgurl,"_blank");
		
	}
</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				作品管理
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
			<form class="form-horizontal" action="${ctx}/newyearact/listjdpro" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width:80px;">微信昵称：</label>
							<input type="text" id="wxname" class="" name="search_LIKE_wxname" value="${LIKE_wxname}" style="width:60%;height:32px;">
						</td>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width: 80px">上传时间：</label> 
							<input type="text" readonly="readonly" id="datepicker" name="search_GTE_createtime" maxlength="20" style="cursor: pointer; width:60%;height:32px;" class="" value="${GTE_createtime}">
						</td>
						<td >
							<label class="control-label" style="float: left;width: 80px">&emsp;&emsp;到&emsp;&emsp;</label> 
							<input type="text" readonly="readonly" id="datepicker1" name="search_LTE_createtime" maxlength="20" style="cursor: pointer; width:60%;height:32px;" class="" value="${LTE_createtime}">
						</td>
						
					</tr>
					<tr>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width:80px;">姓&emsp;&emsp;名：</label>
							<input type="text" id="name" class="" name="search_LIKE_name" value="${LIKE_name}" style="width:60%;height:32px;">
						</td>
						<td style="text-align:center;width:33%;">
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
						</td>
						<td style="text-align:center;width:33%;">&nbsp;</td>
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
				<a href="javascript:;">&nbsp;</a>
				<a href="javascript:;" class="btn red" onclick="deletepro('${prolist.number + 1}')">删除</a>
			</div>
		</div>

		<div class="portlet-body">

			<table id="contentTable" class="table table-striped table-bordered table-hover"  style="font-size:14px;">
				<thead>
					<tr>
						<th style="width: 3%"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 10%;">微信昵称</th>
						<th style="width: 10%;">姓名</th>
						<th style="width: 7%;">票数</th>
						<th style="width: 15%;">上传时间</th>
						<th style="width: 10%;">图片</th>
						<th style="width: 10%;">联系方式</th>
						<th style="width: 10%;">学校</th>
						<th style="width: 5%;">编号</th>
						<th style="width: 10%;">状态</th>
						<th style="text-align: center; width: 10%;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${prolist.content}" var="pro" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_item" class="check_item" value="${pro[0]}">
							</td>
							<td style="vertical-align: middle;">${pro[1]}</td>
							<td style="vertical-align: middle;">${pro[2]}</td>
							<td style="vertical-align: middle;"> 
								<c:if test="${pro[3]!= null}">${pro[3]}</c:if> 
								<c:if test="${pro[3]== null}">0</c:if>
							</td>
							<td style="vertical-align: middle;">${fn:substring(pro[4],0,10)}</td>
							<td style="vertical-align: middle;">
								<img src="${pro[5]}?imageView2/2/w/100/h/100/q/85" alt="${pro[2]}" onclick="showthis(this)" style="cursor:pointer;width:100px;height:100px;">
							</td>
							<td style="vertical-align: middle;">${pro[6]}</td>
							<td style="vertical-align: middle;">
								<c:if test="${pro[7] == 0}">太湖学院</c:if> 
								<c:if test="${pro[7] == 1}">江南大学</c:if>
							</td>
							<td style="vertical-align: middle;">${pro[8]}</td>
							<td style="vertical-align: middle;" id="state${pro[0]}">
								<c:if test="${pro[9] == null || pro[9] == 1}"><span class="label label-default">初赛</span></c:if> 
								<c:if test="${pro[9] == 2}"><span class="label label-success">复赛</span></c:if> 
								<c:if test="${pro[9] == 3}"><span class="label label-important">第一名</span></c:if>
								<c:if test="${pro[9] == 4}"><span class="label label-important">第二名</span></c:if>
								<c:if test="${pro[9] == 5}"><span class="label label-important">第三名</span></c:if>
							</td>
							<td style="vertical-align: middle;" id="act${pro[0]}">
								<c:if test="${actstage == 2 && (pro[9] == null || pro[9] == 1)}">
									<a href="javascript:;" onclick="ruxuan('${pro[0]}')">入选</a> 
								</c:if>
								<c:if test="${actstage == 2 && pro[9] == 2}">
									<a href="javascript:;" onclick="noruxuan('${pro[0]}')">取消入选</a> 
								</c:if>
								<%-- <c:if test="${stage == 1 || stage == 2}">
									<a href="javascript:;" onclick="delpro('${pro[0]}')">删除</a> 
								</c:if> --%>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${prolist.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="11" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${prolist}" paginationSize="5" />
		</div>
	</div>
</body>
</html>