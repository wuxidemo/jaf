<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>最美服务员活动控制台</title>
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
	function deletewaiter(pagenum) {
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
		$.post('${ctx}/waiter/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				window.parent.showAlert("删除成功");
				window.location.href = '${ctx}/waiter/listwaiter?page='+pageno;
			} else {
				window.parent.showAlert("删除失败");
			}
		});
	}
	
	var actstate = ''
	function changestage(num) {
		
		var stageurl = '${ctx}/waiter/getactstage';
		$.get(stageurl,function(data){
			
			var actstageint = parseInt(data.actstage);
			
			if(actstageint>=1 && actstageint<=2 && parseInt(num) >= (actstageint + 2)) {
				window.parent.showAlert("不能跨阶段设置更改活动状态");
				return false;
			}
			
			if(data.actstage == '4' && parseInt(num) < 4) {
				window.parent.showAlert("活动投票已经结束，不能变更状态");
				return false;
			}else if(data.actstage == '3' && parseInt(num) < 3) {
				window.parent.showAlert("当前活动已进入投票阶段，不能再进入审核阶段或者上传资料阶段");
				return false;
			}else if(data.actstage == '2' && parseInt(num) < 2) {
				window.parent.showAlert("当前活动已进入审核阶段，不能再进入上传资料阶段");
				return false;
			}else{
				actstate = num;
				 if(num == '1') {
					window.parent.showConfirm('你确定要将活动的状态改为<span style="color:red">&nbsp;资料上传&nbsp;</span>阶段？',sureChange);
				}else if(num == '2') {
					window.parent.showConfirm('你确定要将活动的状态改为<span style="color:red">&nbsp;进入审核&nbsp;</span>阶段？',sureChange);
				}else if(num == '3') {
					window.parent.showConfirm('你确定要将活动的状态改为<span style="color:red">&nbsp;进入复赛&nbsp;</span>阶段？',sureChange);
				}else if(num == '4') {
					window.parent.showConfirm('你确定要将活动的状态改为<span style="color:red">&nbsp;中奖&nbsp;</span>阶段？',sureChange);
				}
			}
		});
		
		
	}
	
	function sureChange() {
		$.post('${ctx}/waiter/changestage', {"stage" : actstate}, function(data) {
			window.parent.showAlert(data.msg);
			window.location.href='${ctx}/waiter/listwaiter';
		});
	}
	
	var ruxuanid = '';
	function ruxuan(proid) {
		ruxuanid = proid;
		window.parent.showConfirm('你确定要将该资料入选复赛？',sureRuxuan);
	}
	
	function sureRuxuan() {
		$.post('${ctx}/waiter/bechosen', {"waiterid" : ruxuanid}, function(data) {
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
		window.parent.showConfirm('你确定要取消该资料的复赛资格？',sureNoRuxuan);
	}
	
	function sureNoRuxuan() {
		$.post('${ctx}/waiter/nobechosen', {"waiterid" : noruxuanid}, function(data) {
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
	
	var waid = '';
	var ranking = '';
	function setrank(wid,rank) {
		waid = wid;
		ranking = rank;
		if(rank == '3') {
			window.parent.showConfirm("你确定要将该服务员设置为&nbsp;<span style=\"color:red;font-size:16px;\">一等奖</span>&nbsp;吗？",sureSet);
		} else if(rank == '4') {
			window.parent.showConfirm("你确定要将该服务员设置为&nbsp;<span style=\"color:red;font-size:16px;\">二等奖</span>&nbsp;吗？",sureSet);
		} else if(rank == '5') {
			window.parent.showConfirm("你确定要将该服务员设置为&nbsp;<span style=\"color:red;font-size:16px;\">三等奖</span>&nbsp;吗？",sureSet);
		}
	}
	
	function sureSet() {
		var seturl = '${ctx}/waiter/setrank';
		$.post(seturl,{"wid":waid,"rank":ranking},function(data){
			if(data.result == '1') {
				window.parent.showAlert(data.msg);
				if(ranking == '3') {
					$("#state"+waid).html("<span class=\"label label-important\">一等奖</span>");
				} else if(ranking == '4') {
					$("#state"+waid).html("<span class=\"label label-important\">二等奖</span>");
				} else if(ranking == '5') {
					$("#state"+waid).html("<span class=\"label label-important\">三等奖</span>");
				}
			}
		});
	}
	
	
</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				资料管理
			</h3>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<h3 style="float:left;">
				活动阶段变更：
			</h3>
			<div style="margin-top:15px;float:left;">
				<button type="button" class="btn yellow" onclick="changestage(1)" style="margin-left:20px;">资料上传</button>
				<button type="button" class="btn green" onclick="changestage(2)" style="margin-left:20px;">进入审核</button>
				<button type="button" class="btn blue" onclick="changestage(3)" style="margin-left:20px;">进入复赛</button>
				<button type="button" class="btn red"  onclick="changestage(4)" style="margin-left:20px;">&emsp;中奖&emsp;</button>
			</div>
			
			<div style="margin-top:15px;float:right;">
				<c:if test="${actstage == 1 }">
					<div style="font-size:24px;display:inline-block;vertical-align: middle;">当前活动阶段：</div><div style="margin-left:20px;font-size:24px;color:red;display:inline-block;vertical-align: middle;">资料上传</div>
				</c:if>
				<c:if test="${actstage == 2 }">
					<div style="font-size:24px;display:inline-block;vertical-align: middle;">当前活动阶段：</div><div style="margin-left:20px;font-size:24px;color:red;display:inline-block;vertical-align: middle;">进入审核</div>
				</c:if>
				<c:if test="${actstage == 3 }">
					<div style="font-size:24px;display:inline-block;vertical-align: middle;">当前活动阶段：</div><div style="margin-left:20px;font-size:24px;color:red;display:inline-block;vertical-align: middle;">进入复赛</div>
				</c:if>
				<c:if test="${actstage == 4 }">
					<div style="font-size:24px;display:inline-block;vertical-align: middle;">当前活动阶段：</div><div style="margin-left:20px;font-size:24px;color:red;display:inline-block;vertical-align: middle;">&emsp;中奖&emsp;</div>
				</c:if>
			</div>
			
		</div>
	</div>
	<div class="portlet box grey" style="margin-bottom: 0px; height: auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top: 25px;">
			<form class="form-horizontal" action="${ctx}/waiter/listwaiter" method="post">
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
						<td style="width:33%;">
							<label class="control-label" style="float: left;width: 80px">&emsp;&emsp;到&emsp;&emsp;</label> 
							<input type="text" readonly="readonly" id="datepicker1" name="search_LTE_createtime" maxlength="20" style="cursor: pointer; width:60%;height:32px;" class="" value="${LTE_createtime}">
						</td>
						
					</tr>
					<tr>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width: 80px">状&emsp;&emsp;态：</label> 
							<select id="state" class="" name="search_EQ_state" style=" width:60%;height:32px;">
								<option value="-1" <c:if test="${EQ_state == '-1'}">selected="selected"</c:if>>--请选择--</option>
								<option <c:if test="${EQ_state == '1'}">selected="selected"</c:if> value="1">初赛</option>
								<option <c:if test="${EQ_state == '2'}">selected="selected"</c:if> value="2">复赛</option>
								<option <c:if test="${EQ_state == '3'}">selected="selected"</c:if> value="3">一等奖</option>
								<option <c:if test="${EQ_state == '4'}">selected="selected"</c:if> value="4">二等奖</option>
								<option <c:if test="${EQ_state == '5'}">selected="selected"</c:if> value="5">三等奖</option>
							</select>
						</td>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width:80px;">姓&emsp;&emsp;名：</label>
							<input type="text" id="name" class="" name="search_LIKE_name" value="${LIKE_name}" style="width:60%;height:32px;">
						</td>
						<td style="width:33%;">
							<label class="control-label" style="float: left;width:80px;">商&emsp;&emsp;家：</label>
							<input type="text" id="name" class="" name="search_LIKE_mername" value="${LIKE_mername}" style="width:60%;height:32px;">
						</td>
					</tr>
					<tr>
						<td style="width:33%;">&nbsp;</td>
						<td style="width:33%;">&nbsp;</td>
						<td style="width:33%;" colspan="3">
							<label class="control-label" style="float: left;width:80px;">&emsp;</label>
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
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
				<a href="javascript:;">&nbsp;</a>
				<a href="javascript:;" class="btn red" onclick="deletewaiter('${waiterlist.number + 1}')">删除</a>
			</div>
		</div>

		<div class="portlet-body">

			<div id="message" class="alert alert-success">
				参与活动人数:&nbsp;&nbsp;<span style="color:red; font-size:20px; margin-right:30px;">${allwaiternum}</span>
				参与投票人数:&nbsp;&nbsp;<span style="color:red; font-size:20px; margin-right:30px;">${allwaiterthnum}</span>
			</div>
				
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
						<th style="width: 10%;">商铺</th>
						<th style="width: 5%;">编号</th>
						<th style="width: 10%;">状态</th>
						<th style="text-align: center; width: 10%;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${waiterlist.content}" var="waiter" varStatus="status">
						<tr>
							<td>
								<input type="checkbox" id="check_item" class="check_item" value="${waiter[0]}">
							</td>
							<td style="vertical-align: middle;">${waiter[1]}</td>
							<td style="vertical-align: middle;">${waiter[2]}</td>
							<td style="vertical-align: middle;"> 
								<c:if test="${waiter[3]!= null}">${waiter[3]}</c:if> 
								<c:if test="${waiter[3]== null}">0</c:if>
							</td>
							<td style="vertical-align: middle;">${fn:substring(waiter[4],0,10)}</td>
							<td style="vertical-align: middle;">
								<img src="${waiter[5]}?imageView2/2/w/100/h/100/q/85" alt="${waiter[2]}" onclick="showthis(this)" style="cursor:pointer;width:100px;height:100px;">
							</td>
							<td style="vertical-align: middle;">${waiter[6]}</td>
							<td style="vertical-align: middle;">${waiter[7]}</td>
							<td style="vertical-align: middle;">${waiter[8]}</td>
							<td style="vertical-align: middle;" id="state${waiter[0]}">
								<c:if test="${waiter[9] == null || waiter[9] == 1}"><span class="label label-default">初赛</span></c:if> 
								<c:if test="${waiter[9] == 2}"><span class="label label-success">复赛</span></c:if> 
								<c:if test="${waiter[9] == 3}"><span class="label label-important">一等奖</span></c:if>
								<c:if test="${waiter[9] == 4}"><span class="label label-important">二等奖</span></c:if>
								<c:if test="${waiter[9] == 5}"><span class="label label-important">三等奖</span></c:if>
								<c:if test="${waiter[9] == 6}"><span class="label label-important">幸运奖</span></c:if>
							</td>
							<td style="vertical-align: middle;" id="act${waiter[0]}">
								<c:if test="${actstage == 2 && (waiter[9] == null || waiter[9] == 1)}">
									<a href="javascript:;" onclick="ruxuan('${waiter[0]}')">入选</a> 
								</c:if>
								<c:if test="${actstage == 2 && waiter[9] == 2}">
									<a href="javascript:;" onclick="noruxuan('${waiter[0]}')">取消入选</a> 
								</c:if>
								<%-- <c:if test="${stage == 1 || stage == 2}">
									<a href="javascript:;" onclick="delpro('${pro[0]}')">删除</a> 
								</c:if> --%>
								
								<%-- <c:if test="${actstage == 4 && (waiter[9] >= 2)}">
									<a href="javascript:;" onclick="setrank('${waiter[0]}','3')">第一名</a> <br/>
									<a href="javascript:;" onclick="setrank('${waiter[0]}','4')">第二名</a> <br/>
									<a href="javascript:;" onclick="setrank('${waiter[0]}','5')">第三名</a> <br/>
								</c:if> --%>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${waiterlist.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="11" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${waiterlist}" paginationSize="5" />
		</div>
	</div>
</body>
</html>