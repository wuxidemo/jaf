<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>全城抽奖</title>
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
					style="vertical-align: text-bottom;" />全城抽奖
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
			</div>
			<div class="actions">
			<a href="javascript:void(0);" onclick="fresh()" target="_blank" class="btn blue">刷新token</a>
			
				<a href="javascript:void(0);" onclick="down()" target="_blank" class="btn blue">下载</a>
				
				<a href="javascript:void(0);" onclick="down1()" target="_blank" class="btn blue">下载手机号</a>
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
					<label class="control-label">一等奖:</label>
					<div class="controls">
						<a href="javascript:void(0);" onclick="cj1()" id="cja1"
							class="btn blue">抽奖</a> <a href="javascript:void(0);"
							style="display: none" onclick="saverr(1)" id="savea1"
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
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="jp1">
							</tbody>
						</table>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">二等奖:</label>
					<div class="controls">
						<a href="javascript:void(0);" onclick="cj2()" id="cja2"
							style="display: none" class="btn blue">抽奖</a> <a
							href="javascript:void(0);" style="display: none"
							onclick="saverr(2)" id="savea2" class="btn blue">保存</a>
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
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="jp2">
							</tbody>
						</table>
					</div>
				</div>



				<div class="control-group">
					<label class="control-label">三等奖:</label>
					<div class="controls">
						<a href="javascript:void(0);" onclick="cj3()" id="cja3"
							style="display: none" class="btn blue">抽奖</a> <a
							href="javascript:void(0);" style="display: none"
							onclick="saverr(3)" id="savea3" class="btn blue">保存</a>
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
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="jp3">
							</tbody>
						</table>
					</div>
				</div>



				<div class="control-group">
					<label class="control-label">四等奖:</label>
					<div class="controls">
						<a href="javascript:void(0);" onclick="cj4()" id="cja4"
							style="display: none" class="btn blue">抽奖</a> <a
							href="javascript:void(0);" style="display: none"
							onclick="saverr(4)" id="savea4" class="btn blue">保存</a>
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
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="jp4">
							</tbody>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>

</body>
<script type="text/javascript">
	var jp1count = 10;
	var jp2count = 20;
	var jp3count = 50;
	var jp4count = 100;
	var token='${token}';
	
	
	jQuery(document).ready(
			function() {
				if (jQuery().datepicker) {
					$('.date-picker').datepicker({});
				}

				$('#time').bind(
						"change",
						function() {
							if ($(this).val() != "") {
								$.post("${ctx}/ticketrecord/getwindata?time="
										+ $(this).val() + "&type=qccjhd",
										function(d) {
											setalldata(d);
										});
							}
						});
			});
	function setalldata(d) {
		$("#jp1").html("");
		$("#jp2").html("");
		$("#jp3").html("");
		$("#jp4").html("");
		for (var i = 0; i < d.data1.length; i++) {
			$("#jp1")
					.append(
							"<tr rid='"+d.data1[i].tkid+"' openid='"+d.data1[i].openid+"' ><td>"
									+ (i + 1)
									+ "</td><td>"
									+ d.data1[i].tkid
									+ "</td><td>"
									+ d.data1[i].name
									+ "</td><td></td></tr>");
		}

		for (var i = 0; i < d.data2.length; i++) {
			$("#jp2")
					.append(
							"<tr rid='"+d.data2[i].tkid+"' openid='"+d.data2[i].openid+"'><td>"
									+ (i + 1)
									+ "</td><td>"
									+ d.data2[i].tkid
									+ "</td><td>"
									+ d.data2[i].name
									+ "</td><td></td></tr>");
		}
		for (var i = 0; i < d.data3.length; i++) {
			$("#jp3")
					.append(
							"<tr rid='"+d.data3[i].tkid+"' openid='"+d.data3[i].openid+"'><td>"
									+ (i + 1)
									+ "</td><td>"
									+ d.data3[i].tkid
									+ "</td><td>"
									+ d.data3[i].name
									+ "</td><td></td></tr>");
		}
		for (var i = 0; i < d.data4.length; i++) {
			$("#jp4")
					.append(
							"<tr rid='"+d.data4[i].tkid+"' openid='"+d.data4[i].openid+"'><td>"
									+ (i + 1)
									+ "</td><td>"
									+ d.data4[i].tkid
									+ "</td><td>"
									+ d.data4[i].name
									+ "</td><td></td></tr>");
		}
		window.parent.iFrameHeight(); 
		$("#cja1").css("display", "none");
		$("#savea1").css("display", "none");
		$("#cja2").css("display", "none");
		$("#savea2").css("display", "none");
		$("#cja3").css("display", "none");
		$("#savea3").css("display", "none");
		$("#cja4").css("display", "none");
		$("#savea4").css("display", "none");
		if (d.data1.length == 0) {
			$("#cja1").css("display", "");
			return;
		} else if (d.data1.length < jp1count) {
			$("#cja1").css("display", "");
			return;
		}
		if (d.data2.length == 0) {
			$("#cja2").css("display", "");
			return;
		} else if (d.data2.length < jp2count) {
			$("#cja2").css("display", "");
			return;
		}
		if (d.data3.length == 0) {
			$("#cja3").css("display", "");
			return;
		} else if (d.data3.length < jp3count) {
			$("#cja3").css("display", "");
			return;
		}
		if (d.data4.length == 0) {
			$("#cja4").css("display", "");
			return;
		} else if (d.data4.length < jp4count) {
			$("#cja4").css("display", "");
			return;
		}
		

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

	function cj1() {
		setdata(jp1count, 1);
	}
	function cj2() {
		setdata(jp2count, 2);
	}
	function cj3() {
		setdata(jp3count, 3);
	}
	function cj4() {
		setdata(jp4count, 4);
	}
	function setdata(count, kjid) {
		var time = gettime();
		
		var ids=getnowdata(kjid);
		if (ids!=""&&ids.split(",").length >= count) {
			window.parent.showAlert("数据已满");
			return;
		}
		if (time != null) {
			$
					.post(
							"${ctx}/ticketrecord/luckdata?time=" + time
									+ "&type=qccjhd&count=" + count + "&ids="
									+ getnowdata(kjid)+"&openids="+getnowopenids(kjid),
							function(d) {
								if (d.result == 2) {
									window.parent.showAlert("数据不足");
								}
								var html = "";
								for (var i = 0; i < d.data.length; i++) {
									html += "<tr rid='"+d.data[i].id+"' openid='"+d.data[i].openid+"' ><td>"
											+ (i + 1)
											+ "</td><td>"
											+ d.data[i].code
											+ "</td><td>"
											+ d.data[i].name
											+ "</td><td><a onclick=\"openimg('"+d.data[i].url+"')\" href='javascript:void(0);' >查看图片</a> <a class='dela' href='#' >作废</a></td></tr>";
								}
								$("#jp" + kjid).html(
										html + $("#jp" + kjid).html());
								refreshsort(kjid);
								$("#savea" + kjid).css("display", "");
								window.parent.iFrameHeight();
							});
		}
	}
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
	function getnowopenids(kjid) {
		var ids = "";
		$("#jp" + kjid + " tr").each(function() {
			ids += $(this).attr("openid") + ",";
		});
		if (ids.endWith(",")) {
			ids = ids.substr(0, ids.length - 1);
		}
		return ids;
	}
	function saverr(kjid) {
		var ids = getnowdata(kjid);
		if (ids == "") {
			window.parent.showAlert("无数据");
			return;
		}
		$("#cja" + kjid).css("display", "none");
		$.post("${ctx}/ticketrecord/savewin?ids=" + ids + "&sort=" + kjid
				+ "&time=" + gettime(), function(d) {
			if (d == "1") {
				window.parent.showAlert("数据保存成功");
			}
		});
		$("#savea" + kjid).css("display", "none");
		$("#jp" + kjid + " .dela").remove();
		$("#cja" + (kjid + 1)).css("display", "");
	}

	function refreshsort(kjid) {
		var trs = $("#jp" + kjid + " tr");
		for (var i = 0; i < trs.length; i++) {
			$($(trs[i]).children()[0]).html(i + 1);
		}
		$("#jp" + kjid + " tr .dela").unbind("click");
		$("#jp" + kjid + " tr .dela").bind(
				"click",
				function() {
					$.post("${ctx}/ticketrecord/delr/"
							+ $(this).parent().parent().attr("rid"),
							function() {
							});
					$(this).parent().parent().remove();

				});
		window.parent.iFrameHeight();

	}
	function down()
	{
		window.open("${ctx}/ticketrecord/outdata?time="+gettime());
	}
	
	function down1()
	{
		window.open("${ctx}/ticketrecord/outdata1?time="+gettime());
	}
	
	function fresh(){
		$.post("${ctx}/wxurl/getak",function(d){
			token=d;
		});
	}
	function openimg(mid)
	{
	window.open("http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="+token+"&media_id="+mid,"_blank")
		
	}
</script>
</html>