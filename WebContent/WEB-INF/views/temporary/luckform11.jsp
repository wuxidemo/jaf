<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>脱光奖</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />脱光奖
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
			</div>
		</div>
		<div class="portlet-body">

			<form action="" id="inputForm" class="form-horizontal" method="post"
				style="margin: 0px;">

				<div class="control-group">
					<label class="control-label">奖项时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="time"
								name="starttime" readonly size="16" type="text"
								style="height: 34px; cursor: pointer;" value="" /><span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<a href="javascript:void(0);" onclick="savedata()" id="cja4"
							class="btn blue">保存</a>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<table id="contentTable"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>序号</th>
									<th>流水号</th>
									<th>昵称</th>
									<th>微信编号</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="jp1">
							</tbody>
						</table>
					</div>
				</div>

			</form>
		</div>
	</div>

</body>
<script type="text/javascript">
	jQuery(document).ready(function() {
		if (jQuery().datepicker) {
			$('.date-picker').datepicker({});
		}

		$('#time').bind("change", function() {
			freshdata($(this).val());
		});
	});

	function getnowdata(kjid) {
		var ids = "";
		$("#jp" + kjid + " tr").each(function() {
			ids += $(this).attr("rid") + ",";
		});
		if (ids.endWith(",")) {
			ids = ids.substr(0, ids.length - 1);
		}
		return ids;
	}
	function savedata() {
		var ids = getnowdata(1);
		var time = gettime();
		if (ids == "") {
			window.parent.showAlert("无数据");
			return null;
		}
		if (time == null) {
			return;
		}
		$.post("${ctx}/ticketrecord/savewin11?ids=" + ids + "&sort=" + 5
				+ "&time=" + time, function(d) {
			if (d == "1") {
				window.parent.showAlert("数据保存成功");
				freshdata(time);
			}
		});
	}
	function gettime() {
		var time = $("#time").val();
		if (time == "") {
			window.parent.showAlert("请选择时间");
			return null;
		} else {
			return time;
		}
	}
	function freshdata(time) {
		$
				.post(
						"${ctx}/ticketrecord/data11?time=" + time,
						function(d) {
							var html = "";
							if(d.length>0&&d[0].state==2)
								{$("#cja4").css("display","none");}
							else
								{
								$("#cja4").css("display","");
								}
							for (var i = 0; i < d.length; i++) {
								var state = "";
								if (d[i].state == 1) {
									state = "待确认";
								} else if (d[i].state == 2) {
									state = "已中奖";
								} else {
									state = "废票";
								}
								html += "<tr rid='"+d[i].id+"' openid='"+d[i].openid+"' ><td>"
										+ (i + 1)
										+ "</td><td>"
										+ d[i].code
										+ "</td><td>"
										+ d[i].name
										+ "</td><td>"
										+ d[i].openid
										+ "</td><td>"
										+ state
										+ "</td><td><a href='http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=${token}&media_id="
										+ d[i].url
										+ "' target='_blank'>查看图片</a>"
										+ (d[i].state == 1 ? "&nbsp;&nbsp; <a class='dela' onclick='del("
												+ d[i].id
												+ ")' href='javascript:void(0)' >作废</a>"
												: "" + "</td></tr>");
							}
							$("#jp1").html(html);
							window.parent.iFrameHeight();
						});
	}
	function sure(id) {
		$.post("${ctx}/ticketrecord/sure/" + id, function(d) {
			if (d == "1")
				freshdata($("#time").val());
		});
	}
	function del(id) {
		$.post("${ctx}/ticketrecord/delr/" + id, function(d) {
			if (d == "1")
				freshdata($("#time").val());
		});
	}
</script>
</html>