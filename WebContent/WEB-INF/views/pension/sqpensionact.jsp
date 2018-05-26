<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	String district = "";
	if (request.getParameter("search_LIKE_name") != null)
		district = new String(request.getParameter("search_LIKE_name").getBytes("ISO-8859-1"),
				"UTF-8");
%>
<html>
<head>
<title>养老活动报名</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" href="${ctx}/static/jquery.pagination/dw.pagination.css" />
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/timepicker.css" />
</head>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
</style>
<script type="text/javascript" src="${ctx}/static/jquery.pagination/dw.pagination.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.form/jquery.form.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.inputmask.bundle.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
	var pagin;
	$(function() {
		               init_checkbox('.check_all','.check_item');	
						/* 分页 */
						var opt = {
							callback : pageselectCallback,
							items_per_page : 5,
						};
						pagin = $("#Pagination").pagination('${ctx}/sqpensionact', opt);
						$("#search_btn")
								.bind(
										"click",
										function() {
											checkUser();
											var params = getMap(decodeURI($("#searchform").serialize()));
											pagin = $("#Pagination").pagination(
															'${ctx}/sqpensionact',opt, params);
										});
						
						/* 容器 */
						window.parent.scroll(0, 0);
						$.getJSON(
										'${ctx}/wxyt/config',
										function(data) {
											if (data.result == "1") {
												var sign = data.sign;// "ZkXygoKlOhG1lUq5e6nvDqB8DN1hPTEwMDEzNDE5JmI9bHV5ZnRlc3Qmaz1BS0lERTlqdVZ0REtHSWloQmVzRDhIU3pyODVlNkNNN3ZMcmkmZT0xNDQ5MTMyNDQzJnQ9MTQ0OTEyODg5MiZyPTE1MzkxODE4MjImdT0wJmY9"
												var url = data.url
														+ '?sign='
														+ encodeURIComponent(sign);
												UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
												UE.Editor.prototype.getActionUrl = function(
														action) {
													if (action == 'uploadimage'
															|| action == 'uploadscrawl'
															|| action == 'uploadimage') {
														return url;
													} else if (action == 'uploadvideo') {
														return 'http://a.b.com/video.php';
													} else {
														return this._bkGetActionUrl
																.call(this,
																		action);
													}
												}
											}
										});
						/* 容器 */
						wxyt({
							div : "introup",
							baseurl : "${ctx}",
							tip : "(支持jpg,png格式.建议尺寸628*470)",
							maxsize : 1048576,
							sucess : function(download_url, fileid, url) {
								$("#thumbnailurl")
										.val(
												download_url
														+ '?imageView2/2/w/628/h/470/q/85');

								$("#introimg").attr("src", download_url);
								$("#introimg").css("width", "300px");
								$("#introimg").css("height", "200px");

								setTimeout('window.parent.iFrameHeight();', 100);
							},
							fail : function(d) {
								alert(d);
							}
						});
						initDate();
					});

	function pageselectCallback(data) {
		$("#list").empty();
		for (var i = 0; i < data.content.length; i++) {
			var state="";
			if(data.content[i][7]==0){
			    state="下线";
			}else if(data.content[i][7]==1){
				state="上线";
			}else if(data.content[i][7]==2){
				state="已结束";
			}else if(data.content[i][7]==3){
				state="上线中";
			}
			
			$("#list")
					.append(
							'<tr>	<td><input type="checkbox" id="check_item" value="'+data.content[i][0]+'" class="check_item"></td><td>'
									+ data.content[i][1]
									+ '</td><td>'
									+ (data.content[i][2] == null ? ''
											: formattime(data.content[i][2]))
									+ '</td><td>'
									+ (data.content[i][3] == null ? ''
											: formattime(data.content[i][3]))
									+ '</td><td>'
									+ data.content[i][4]
									+ '</td><td>'
									+ data.content[i][5]
									+ '</td><td id="'
									+ data.content[i][0]
									+ '">'
									+ state
									+ '</td><td><a href="javascript:;" onclick="showupdateoraddorview(\''
									+ data.content[i][0]
									+ '\',\''
									+ 0
									+ '\')">查看</a>&nbsp;'+
									(data.content[i][7] == 2? '' : '<a href="javascript:;" onclick="showupdateoraddorview(\''
										+ data.content[i][0]
									+ '\',\''
									+ 1
									+ '\')">编辑</a>&nbsp;')
									+(data.content[i][7] ==2? '' : '<a href="javascript:;" id="isshow'
									+ data.content[i][0]
									+ '" onclick="isshow(\''
									+ data.content[i][0]
									+ '\')">'
									+ (data.content[i][7] == 0 ? '上线' : '下线')
									+ '</a>&nbsp; ')
									+' <a href="javascript:;" onclick="deletevol1(\''
									+ data.content[i][0]
									+ '\')">删除</a></td></tr>');
			setTimeout('window.parent.iFrameHeight();', 100);
		}

	}





	/* 重置 */
	function resetAll() {
		$("#search_name").val("");
		$("#search_starttime").val("");
		$("#search_endtime").val("");
	}
	/* 删除 */
	function deletevol1(id) {
		ids = id;
		parent.window.showConfirm("你确定要删除该信息?", suredel1);
	}
	function suredel1() {
		$.post('${ctx}/sqpensionact/delete?ids=' + ids, function(data) {
			if (data.result) {
				 pagin.refresh(ids.split('|').length); 
				window.parent.showAlert(data.msg);
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
		$.post('${ctx}/sqpensionact/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				 pagin.refresh(ids.split('|').length); 
				window.parent.showAlert(data.msg);
			} else {
				window.parent.showAlert(data.msg);
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
	function initDate() {
		if (jQuery().datepicker) {
			$('#search_starttime').datepicker({
				rtl : App.isRTL()
			});
		}
		if (jQuery().datepicker) {
			$('#search_endtime').datepicker({
				rtl : App.isRTL()
			});
		}

	}
	function checkUser() {
		var time1 = new Date($('#search_starttime').val()).getTime();
		var time2 = new Date($('#search_endtime').val()).getTime();
		if (time1 > time2) {
			$("#search_starttime").val("");
			$("#search_endtime").val("");
			window.parent.showAlert("请选择正确日期，结束时间大于开始时间！");
			return false;
		} else {
			return true;
		}
	}

	/*模态窗口 编辑和新增和查看 */
	function showupdateoraddorview(id, val) {
		
		/* 时间的赋值开始 */
		if (jQuery().datepicker) {
			$('.date-picker').datepicker({
				rtl : App.isRTL()
			});
		}
		$('.timepicker-default').timepicker({
			showSeconds : false,
			showMeridian : false
		});
		
		/* 编辑 */
		if (id != null && val == 1) {
			$("#id").attr("disabled", false);
			$("#name").attr("disabled", false);
			$("#max").attr("disabled", false);
			$("#container").attr("disabled", false);
			$("#startdate").attr("disabled", false);/* 开始日期 */
			$("#ustime").attr("disabled", false);/* 开始分秒 */
			$("#enddate").attr("disabled", false);/* 结束日期 */
			$("#uetime").attr("disabled", false);/* 结束时间 */
			$("#pic1").show();
			$("#pic2").hide();
			$("#submit_btn").show();
			$("#start").show();
			$("#end").show();
			$("#start1").hide();
			$("#end1").hide();
			var url = '${ctx}/sqpensionact/checkbyid';
			$.post(url, {
				"id" : id
			}, function(data) {
				if (data.result) {
					$("#title").html("编辑活动详情");
					$("#id").val(data.data.id);
					$("#name").val(data.data.name);
					$("#max").val(data.data.max);
					/* 开始时间 */
					$("#startdate").val(data.startdate);/* 开始日期 */
					$("#ustime").val(data.stime);
					/* 结束时间 */
					$("#enddate").val(data.enddate);/* 结束日期 */
					$("#uetime").val(data.etime);
					$("#thumbnailurl").val( data.data.picurl);
					if (data.data.picurl == null || data.data.picurl == '') {
						$("#introimg").attr('src','${ctx}/static/images/zanwuPic.jpg');
					} else {
						$("#introimg").attr('src', data.data.picurl);
					}
					$("#container").val(data.data.content);
				} else {
					window.parent.showAlert(data.msg);
					return false;
				}
			});
		} else if (id != null && val == 0) {//查看
			var url = '${ctx}/sqpensionact/checkbyid';
			$.post(url, {
				"id" : id
			}, function(data) {
				if (data.result) {
					$("#title").html("查看活动详情");
					$("#id").val(data.data.id);
					$("#name").val(data.data.name);
					$("#max").val(data.data.max);
					$("#startdate1").val(data.startdate);/* 开始日期 */
					$("#ustime1").val(data.stime);
					$("#enddate1").val(data.enddate);/* 结束日期 */
					$("#uetime1").val(data.etime);
					
					$("#thumbnailurl").val( data.data.picurl);
					if (data.data.picurl == null || data.data.picurl == '') {
						$("#introimg2").attr('src',
								'${ctx}/static/images/zanwuPic.jpg');
					} else {
						$("#introimg2").attr('src', data.data.picurl);
					}
					$("#container").val(data.data.content);
				} else {
					window.parent.showAlert(data.msg);
					return false;
				}
			});
			$("#id").attr("disabled", true);
			$("#name").attr("disabled", true);
			$("#max").attr("disabled", true);
			$("#startdate").attr("disabled", true);
			$("#ustime").attr("disabled", true);
			$("#enddate").attr("disabled", true);
			$("#uetime").attr("disabled", true);
			$("#container").attr("disabled", true);
			$("#pic1").hide();
			$("#pic2").show();
			$("#submit_btn").hide();
			$("#start").hide();
			$("#end").hide();
			$("#start1").show();
			$("#end1").show();
		} else {//新增

			var todaydate = getFormatedToday();
			var lastdayofthismonth = getFormatedLastDayOfThisMonth();
			$("#startdate").val(todaydate);
			$("#enddate").val(lastdayofthismonth);
			var now = new Date();
			var hours=now.getHours();
			var minute = now.getMinutes();
			/* var second = now.getSeconds(); */
			/*  if (hours < 10) { hours = '0' + hours;} 
			 if (minute < 10) {minute = '0' + minute;}
			$("#ustime").val( hours+ ":" + minute);  */
			$("#ustime").val("00:00"); 
			$("#uetime").val("23:59");
			/* 时间赋值结束 */
			$("#title").html("新增活动");
			$("#id").val(null);
			$("#name").val('');
			$("#max").val('');
			$("#container").val('');
			$("#thumbnailurl").val('');
			$("#id").attr("disabled", false);
			$("#name").attr("disabled", false);
			$("#max").attr("disabled", false);
			$("#container").attr("disabled", false);
			$("#startdate").attr("disabled", false);/* 开始日期 */
			$("#ustime").attr("disabled", false);/* 开始分秒 */
			$("#enddate").attr("disabled", false);/* 结束日期 */
			$("#uetime").attr("disabled", false);/* 结束时间 */
			$("#pic1").show();
			$("#pic2").hide();
			$("#submit_btn").show();
			$("#start").show();
			$("#end").show();
			$("#start1").hide();
			$("#end1").hide();
			$("#introimg").attr('src', '${ctx}/static/images/zanwuPic.jpg');
		}
		$("#showupdateoraddorview").modal("show");
	}
	/* 关闭弹窗 */
	function hideopen() {
		$("#showupdateoraddorview").modal("hide");
	}

	function formsubmit() {
		var name = $("#name").val();
		var startdate = $("#startdate").val();
		var stime = $("#ustime").val();
		var enddate = $("#enddate").val();
		var etime = $("#uetime").val();
		var max = $("#max").val();
		var thumbnailurl = $("#thumbnailurl").val();
		var uecontent = $("#container").val();

		if ($.trim(name) == '') {
			window.parent.showAlert("你没有填写活动名称");
			return false;
		}

		if ($.trim(startdate) == '') {
			window.parent.showAlert("你没有选择报名的起始日期");
			return false;
		}

		if ($.trim(stime) == '') {
			window.parent.showAlert("你没有选择报名的起始时间");
			return false;
		}

		if ($.trim(enddate) == '') {
			window.parent.showAlert("你没有选择报名的截止日期");
			return false;
		}

		if ($.trim(etime) == '') {
			window.parent.showAlert("你没有选择报名的截止时间");
			return false;
		}
		
		if(startdate > enddate) {
			window.parent.showAlert("截止时间不能早于起始时间");
			return false;
		}
		
		if(startdate == enddate && stime > etime) {
			window.parent.showAlert("截止时间不能早于起始时间");
			return false;
		}

		if ($.trim(max) == '') {
			window.parent.showAlert("你没有填写最大人数");
			return false;
		}

		if ($.trim(thumbnailurl) == '') {
			window.parent.showAlert("你没有上传活动缩略图");
			return false;
		}

		if (!isInt(max)) {
			window.parent.showAlert("最大人数是一个正整数");
			return false;
		}

		if ($.trim(uecontent) == '') {
			window.parent.showAlert("你没有填写活动信息");
			return false;
		}
		
		var options = {
				type : 'post',
				url : '${ctx}/sqpensionact/saveorupdate',
				dataType : 'json',
				success : function(ret) {
					if (ret == "1") {
						pagin.refresh();
						$("#showupdateoraddorview").modal('hide');
					}
				},
				error : function(ret) {
				}
			};
		$('#inputForm').ajaxForm(options);
		$('#inputForm').submit();
	}
	function isInt(num) {
		var reg = new RegExp("^[1-9][0-9]*$");
		return reg.test(num);
	}

	/*获取格式化的今天的日期*/
	function getFormatedToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		return year + "-" + month + "-" + dd;
	}

	/*获取格式化的本月的最后一天的日期*/
	function getFormatedLastDayOfThisMonth() {
		var current = new Date();
		var currentMonth = current.getMonth();
		var nextMonth = ++currentMonth;
		var nextMonthDayOne = new Date(current.getFullYear(), nextMonth, 1);
		var minusDate = 1000 * 60 * 60 * 24;
		var date = new Date(nextMonthDayOne.getTime() - minusDate);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		return year + "-" + month + "-" + dd;
	}
	/* 时间格式 */
	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();

		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		if (hour < 10) {
			hour = "0" + hour;
		}
		if (minute < 10) {
			minute = "0" + minute;
		}
		if (second < 10) {
			second = "0" + second;
		}

		return year + "-" + month + "-" + dd + " " + hour + ":" + minute + ":"
				+ second;
	}

	function isshow(id) {
		$.post('${ctx}/sqpensionact/isshow?id=' + id, function(data) {
			if (data.isshow == 1) {
				window.parent.showAlert("上线成功");
				 $("#"+id).html("上线"); 
				$("#isshow" + id).html("下线");
			} else if (data.isshow == 0) {
				window.parent.showAlert("下线成功");
				 $("#"+id).html("下线"); 
				$("#isshow" + id).html("上线");
			}else if (data.isshow ==3) {
				window.parent.showAlert("已申请上线");
				 $("#"+id).html("上线中"); 
				$("#isshow" + id).html("下线");
			}
		});
	}
</script>
<body style="min-height: 800px;">
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" />活动报名
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
			<form class="form-search" id="searchform"
				action="${ctx}/sqpensionact" method="post">
				<table style="width: 100%">
					<tr>
						<td style="width: 25%;"><label class="control-label"
							style="float: left; width: 70px; text-align: right;">活动名称：</label>
							<input type="text" id="search_name" name="search_LIKE_name"
							maxlength="20" style="float: left; width: 60%; height: 32px;"
							class="" value="${LIKE_name}"></td>
						<td style="width: 25%"><label class="control-label"
							style="float: left">报名时间：</label> <input type="text"
							id="search_starttime" name="search_EQ_starttime" maxlength="20"
							readonly="readonly"
							style="float: left; width: 60%; height: 32px; cursor: pointer;"
							value="${EQ_starttime}"></td>
						<td style="width: 25%"><label class="control-label"
							style="float: left; width: 98px; text-align: right;">到：</label> <input
							type="text" id="search_endtime" name="search_EQ_endtime"
							maxlength="20" readonly="readonly"
							style="float: left; width: 60%; height: 32px; cursor: pointer;"
							value="${EQ_endtime}"></td>
						<td style="width: 25%; text-align: center;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
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
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;" onclick="showupdateoraddorview(null,null)"
					class="btn blue"> 新增</a>&nbsp; <a href="javascript:;"
					class="btn red" onclick="deletevol2()">删除</a>
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
						<th style="width: 2%"><input type="checkbox" id="check_all"
							value="" class="check_all"></th>
						<th>活动名称</th>
						<th>报名起始时间</th>
						<th>报名截止时间</th>
						<th>最大人数</th>
						<th>当前人数</th>
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

	<!-- 模态窗口 编辑添加查看-->
	<div class="modal hide fade" id="showupdateoraddorview" tabindex="-1"
		role="dialog" style="top: 10%; width: 60%; left: 30%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">
				<span id="form_title"> <img
					src="${ctx}/static/images/xtgl.png"
					style="vertical-align: baseline;" /> <i class="icon-angle-right"></i>
					<span id="title">新增/修改/查看活动</span>
				</span>
			</h3>
		</div>
		<div id="" class="modal-body" style="font-size: 35;">
			<form action="${ctx}/sqpensionact/saveorupdate" method="post"
				id="inputForm" class="form-horizontal">
				<input type="hidden" name="picurl" id="thumbnailurl"
					value="${merchant.thumbnailurl}" />
				<div class="control-group">
					<label class="control-label">活动名称:</label>
					<div class="controls">
						<input type="hidden" id="id" name="id" value=""> <input
							type="text" id="name" name="name" maxlength="20"
							style="width: 65%; height: 32px" class="title required" />
					</div>
				</div>
				<div class="control-group" id="start">
					<label class="control-label">报名起始时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="startdate"
								 name="startdate" size="16" type="text"
								readonly="readonly" style="height: 34px; cursor: pointer;"
								value="" disabled="disabled" /><span class="add-on" id="sdate"><i
								class="icon-calendar"></i></span>
						</div>
						&nbsp;
						<div class="input-append bootstrap-timepicker-component">
							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="ustime" name="stime" disabled="disabled" /> <span
								class="add-on"  id="sdate1"><i class="icon-time" ></i></span>
						</div>
					</div>
				</div>
				<div class="control-group" id="start1">
					<label class="control-label">报名起始时间:</label>
					<div class="controls">
						<input type="text" id="startdate1" name="startdate1" readonly="readonly" disabled="disabled"
							style="width: 30%; height: 32px;" class="title required" />&nbsp;&nbsp;&nbsp;
						<input type="text" id="ustime1" name="ustime1" readonly="readonly" disabled="disabled"
							style="width: 30%; height: 32px;" class="title required" />
					</div>
				</div>
				<div class="control-group" id="end">
					<label class="control-label">报名截止时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="enddate"
								name="enddate" size="16" type="text" readonly="readonly"
								style="height: 34px; cursor: pointer;" value="" /><span
								class="add-on"  id="sdate2"><i class="icon-calendar"></i></span>
						</div>
						&nbsp;
						<div class="input-append bootstrap-timepicker-component">
							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="uetime" name="etime" /> <span class="add-on"  id="sdate3"><i
								class="icon-time"></i></span>
						</div>
					</div>
				</div>
				<div class="control-group" id="end1">
					<label class="control-label">报名截止时间:</label>
					<div class="controls">
						<input type="text" id="enddate1" name="enddate1"  readonly="readonly" disabled="disabled"
							style="width: 30%; height: 32px;" class="title required" />&nbsp;&nbsp;&nbsp;
						<input type="text" id="uetime1" name="etime1"  readonly="readonly" disabled="disabled"
							style="width: 30%; height: 32px;" class="title required" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">最大参与人数:</label>
					<div class="controls">
						<input type="text" id="max" name="max" maxlength="8"
							style="width: 30%; height: 32px" class="title required" /><span
							style="font-size: 14px; margin-left: 10px;">人</span>
					</div>
				</div>

				<div id="pic1">
					<div class="control-group">
						<label for="fileToUploadintro" class="control-label">缩略图:</label>
						<div class="controls" id="introup"></div>
					</div>
					<div class="control-group" id="introface">
						<label class="control-label"></label>
						<div class="controls">
							<img alt="商户缩略图" src="${ctx}/static/images/zanwuPic.jpg"
								id="introimg" style="width: 300px; height: 200px;" />
						</div>
					</div>
				</div>

				<div id="pic2">
					<div class="control-group">
						<label for="fileToUploadintro" class="control-label">缩略图:</label>
						<div class="controls">
							<img alt="商户缩略图" src="${ctx}/static/images/zanwuPic.jpg"
								id="introimg2" style="width:300px; height: 200px;" />
						</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">活动信息:</label>
					<div class="controls">
						<textarea id="container" name="content" rows="" cols=""
							style="width:65%; height: 200px;" maxlength="200"></textarea>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input id="submit_btn" class="btn btn-primary green" type="button"
				onclick="formsubmit()" value="保存" />&nbsp; <input
				class="btn btn-primary grey" type="button" onclick="hideopen()"
				value="取消" />
		</div>
	</div>
</body>
</html>