<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
	String district = "";
	if (request.getParameter("search_EQ_categoryValue.id") != null)
		district = new String(request.getParameter("search_EQ_categoryValue.id").getBytes("ISO-8859-1"),
				"UTF-8");
%>

<html>
<head>
<title>社区管理</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet"
	href="${ctx}/static/jquery.pagination/dw.pagination.css" />
</head>
<style type="text/css">
#contentTable td {
	WORD-WRAP: break-word;
}
</style>
<script type="text/javascript"
	src="${ctx}/static/jquery.pagination/dw.pagination.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.form/jquery.form.min.js"></script>
<script type="text/javascript">
var pagin;
$(function(){
	init_checkbox('.check_all','.check_item');
	var url='${ctx}/system/getcategoryvalue';
	$.post(url,{"value":"商圈区域"},function(data){
		var html='';
		html+='<option value="-1">--请选择--</option>';
		$("#search_district").empty();
		$("#edit_district").empty();
		if(data.result){
			var category=data.obj;
			var length=data.obj.length;
			for(var i=0;i<length;i++){
				html+='<option value="'+category[i].id+'">'+category[i].value+'</option>';
			}
			$("#search_district").html(html);
			$("#edit_district").html(html);
			var district='<%=district%>';
				if (district != '') {
					$("#search_district").val(district);
				}
			}
		});

		var opt = {
			callback : pageselectCallback,
			items_per_page : 5, 
		};
		pagin = $("#Pagination").pagination('${ctx}/community/comlist', opt);

		$("#search_btn")
				.bind(
						"click",
						function() {
							var params = getMap(decodeURI($("#searchform")
									.serialize()));
							pagin = $("#Pagination").pagination(
									'${ctx}/community/comlist', opt, params);
						});

	});

	function pageselectCallback(data) {
		$("#list").empty();
		for (var i = 0; i < data.content.length; i++) {
			$("#list")
					.append(
							'<tr>	<td><input type="checkbox" id="check_item" value="'+data.content[i].id+'" class="check_item"></td><td>'
									+ i
									+ '</td><td>'
									+ data.content[i].name
									+ '</td><td>'
									+ data.content[i].categoryValue.value
									+ '</td><td>'
									+ data.content[i].user.realname
									+ '</td><td>'
									+ data.content[i].createtime
									+ '</td><td><a href="javascript:;" onclick="show_edit(\''
									+ data.content[i].id
									+ '\',\''
									+ data.content[i].name
									+ '\',\''
									+ data.content[i].categoryValue.id
									+ '\',\''
									+ data.content[i].telephone
									+ '\')">修改</a>	<a href="javascript:;" onclick="showaddadmin(\''
									+ data.content[i].id
									+ '\')">添加管理员</a>	<a href="javascript:;" onclick="showadminlist(\''
									+ data.content[i].id
									+ '\')">查看管理员列表</a></td></tr>');
		}

	}

	function resetAll() {
		$("#search_name").val('');
		$("#search_district").val('-1');

	}
	function deleteCommunity() {
		var ids = getIds('.check_item');
		if (ids.length == 0) {
			parent.window.showAlert("请选择一条记录！");
			return;
		}
		sureDel();
	}

	function sureDel() {
		var ids = getIds('.check_item');
		$.post('${ctx}/community/delete', {
			"ids" : ids
		}, function(data) {
			if (data.result) {
				pagin.refresh(ids.split('|').length);
				alert("删除成功");
			} else {
				alert("删除失败");
			}
		});
	}
	function show_add() {
		$("#id").val('');
		$("#name").val('');
		$("#edit_district").val('-1');
		$("#telephone").val('');
		$("#form_community").modal('show');
	}
	function show_edit(id, value, cid, telephone) {
		$("#id").val(id);
		$("#name").val(value);
		$("#edit_district").val(cid);
		$("#telephone").val(telephone);
		$("#form_community").modal('show');
	}
	function Check_Submit() {
		var id = $("#id").val();
		var name = $("#name").val();
		var cid = $("#edit_district").val();
		if ($.trim(name).length == 0) {
			window.parent.showAlert("社区名称不能为空！");
			return false;
		}
		if (cid == '-1') {
			window.parent.showAlert("社区区域不能为空！");
			return false;
		}
		var url = '${ctx}/community/checkname';
		$.post(url, {
			"id" : id,
			"name" : name,
			"cid" : cid
		}, function(data) {
			if (data.result) {
				var options = {
					type : 'post',
					url : '${ctx}/community/createmap',
					dataType : 'json',
					success : function(ret) {
						if (ret == "1") {
							pagin.refresh();
							$("#form_community").modal('hide');
						}
					},
					error : function(ret) {

					}
				};
				$('#inputForm').ajaxForm(options);
				$('#inputForm').submit();

			} else {
				alert(data.msg);
				return false;
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
					style="vertical-align: text-bottom;" /> 社区管理
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
						<td style="width: 33%;"><label class="control-label"
							style="float: left">社区名称：</label> <input type="text"
							id="search_name" name="search_LIKE_name" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_name }"></td>
						<td style="width: 33%;"><label class="control-label"
							style="float: left">社区区域：</label> <select id="search_district"
							name="search_EQ_categoryValue.id" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class="">
								<option value="-1">--请选择--</option>
						</select></td>
						<td style="width: 33%;">
							<button type="button" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn" id="search_btn"
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
				<a href="javascript:;" class="btn blue" onclick="show_add()"><i
					class=""></i> 新增</a> <a href="javascript:;" class="btn red"
					onclick="deleteCommunity()"><i class=""></i>删除</a>
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
						<th>序号</th>
						<th>社区名称</th>
						<th>社区区域</th>
						<th>变更人</th>
						<th>变更时间</th>
						<th>管理</th>
					</tr>
				</thead>
				<tbody id="list">





				</tbody>
			</table>
			<div id="Pagination" class="pagination"></div>
		</div>
	</div>
	<!-- 模态窗口 -->
	<div class="modal hide fade" id="form_community" tabindex="-1"
		role="dialog" style="top: 10%; width: 50%; left: 40%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">
				<span id="form_title"> <img
					src="${ctx}/static/images/xtgl.png"
					style="vertical-align: baseline;" /> <i class="icon-angle-right"></i>
					新增/修改社区
				</span>
			</h3>
		</div>
		<div id="" class="modal-body" style="font-size: 35;">
			<form action="${ctx}/community/createmap" method="post"
				id="inputForm" class="form-horizontal">
				<div class="control-group">
					<label class="control-label">社区名称:</label>
					<div class="controls">
						<input type="text" id="name" name="name" maxlength="20"
							style="width: 60%; height: 32px" class="title required" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">社区区域:</label>
					<div class="controls">
						<select id="edit_district" name="categoryValue.id"
							style="float: left; width: 60%; height: 32px;" class="">
							<option value="-1">--请选择--</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" id="telephone" name="telephone" maxlength="12"
							style="width: 60%; height: 32px" class="title required" /> <input
							type="hidden" id="id" name="id" value="">
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input id="submit_btn" class="btn btn-primary green" type="button"
				onclick="Check_Submit()" value="保存" />&nbsp;
		</div>
	</div>

	<div class="modal hide fade" id="openaccount" tabindex="-2"
		role="dialog" style="top: 10%; width: 800px; left: 40%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">添加社区管理员</h3>
		</div>
		<div id="" class="modal-body">
			<form action="${ctx}/community/addadmin" method="post"
				id="opencountform" class="form-horizontal">

				<input type="hidden" name="communityid" id="communityid" value="" />

				<div class="control-group">
					<label for="phoneno" class="control-label">手机号码:</label>
					<div class="controls">
						<input type="text" id="phoneno" class="span m-wrap"
							style="height: 32px; width: 60%;" name="phoneno" maxlength="15" />
						<span style="color: #cecece; height: 32px; line-height: 32px;">用于登录系统的账号，请确保真实有效</span>
					</div>
				</div>

				<div class="control-group">
					<label for="uname" class="control-label">用户姓名:</label>
					<div class="controls">
						<input type="text" id="uname" name="uname"
							style="height: 32px; width: 60%;" class="span m-wrap"
							maxlength="20" /> <span
							style="color: #cecece; height: 32px; line-height: 32px;">登录后用于显示的用户名字</span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls" id="errormsg" style="color: red;"></div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary green" type="button"
				onclick="submitform()" value="确定" />&nbsp; <input
				class="btn btn-primary grey" type="button" onclick="hideopen()"
				value="取消" />
		</div>
	</div>

	<div class="modal hide fade" id="showadminlistdiv" tabindex="-2"
		role="dialog" style="top: 10%; width: 800px; left: 40%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">社区管理员列表</h3>
		</div>
		<div id="" class="modal-body">
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>管理员登陆账号</th>
						<th>管理员姓名</th>
						<th>管理员手机号码</th>
						<th>管理员状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="adminlist">
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary green" type="button"
				onclick="adminlisthide()" value="确定" />&nbsp;
		</div>
	</div>

	<script type="text/javascript">
		var shequid = '';

		function clearopen() {
			$("#communityid").val("");
			$("#phoneno").val("");
			$("#uname").val("");
			$("#errormsg").empty();
		}

		function showaddadmin(commid) {
			clearopen();
			$("#communityid").val(commid);
			$("#openaccount").modal("show");
		}

		function hideopen() {
			$("#openaccount").modal("hide");
		}

		function submitform() {

			$("#errormsg").empty();

			var communityid = $("#communityid").val();
			var phoneno = $("#phoneno").val();
			var uname = $("#uname").val();

			if (phoneno.trim() == '') {
				$("#errormsg").html("登陆的手机号码不能为空！");
				$(this).focus();
				return false;
			} else if (!(/^(13[0-9]{9})|(15[0-9][0-9]{8})|(17[0-9][0-9]{8})|(18[0-9][0-9]{8})$/
					.test(phoneno))) {
				$("#errormsg").html("手机号码格式不对！");
				$(this).focus();
				return false;
			} else if (uname.trim() == '') {
				$("#errormsg").html("用户姓名不能为空！");
				$(this).focus();
				return false;
			} else {
				var checkurl = "${ctx}/system/user/checkTelephone?telephone="
						+ phoneno;
				$.get(checkurl, function(data) {
					if (data == 'false') {
						$("#errormsg").html("该手机号已被占用");
						$("#phoneno").focus();
						return false;
					} else {
						var sendurl = '${ctx}/community/addadmin';
						$.post(sendurl, {
							"communityid" : communityid,
							"phoneno" : phoneno,
							"uname" : uname
						}, function(data) {
							hideopen();
							window.parent.showAlert("创建社区管理员成功，登陆用户名为"
									+ phoneno + "，初始登陆密码为  000000 ");
						});
					}
				});
			}
		}

		function showadminlist(commid) {
			shequid = commid;
			$("#adminlist").empty();
			var posturl = '${ctx}/community/getcommadmin';
			$
					.post(
							posturl,
							{
								"commid" : commid
							},
							function(data) {
								if (data.result == '1') {
									var d = data.data;
									for (var i = 0; i < d.length; i++) {
										$("#adminlist")
												.append(
														'<tr class="odd gradeX">'
																+ '<td>'
																+ (i + 1)
																+ '</td>'
																+ '<td>'
																+ d[i].name
																+ '</td>'
																+ '<td>'
																+ d[i].realname
																+ '</td>'
																+ '<td>'
																+ d[i].telephone
																+ '</td>'
																+ '<td>'
																+ (d[i].enabled == '0' ? "<span class=\"label label-warning\">冻结</span>"
																		: "<span class=\"label label-success\">正常</span>")
																+ '</td>'
																+ '<td>'
																+ (d[i].enabled == '0' ? "<a href=\"javascript:;\" onclick=\"askforenable("
																		+ d[i].id
																		+ ")\">解冻账号</a>&nbsp;"
																		: "<a href=\"javascript:;\" onclick=\"askfordisable("
																				+ d[i].id
																				+ ")\">冻结账号</a>&nbsp;")
																+ '<a href="javascript:;" onclick="askforresetpass('
																+ d[i].id
																+ ')">重置密码</a>'
																+ '</td>'
																+ '</tr>');
									}
								} else {
									$("#adminlist")
											.append(
													'<tr class="odd gradeX">'
															+ '<td colspan="6" style="text-align:center">暂无数据'
															+ '</td>' + '</tr>');
								}
							});

			$("#showadminlistdiv").modal("show");
		}

		function adminlisthide() {
			$("#showadminlistdiv").modal("hide");
		}

		var tempuserid = '';
		function askfordisable(userid) {
			tempuserid = userid;
			window.parent.showConfirm("你确定要冻结该账号吗？", suredisable);
		}

		function suredisable() {
			var disurl = '${ctx}/system/user/disableuser';
			$.post(disurl, {
				"uid" : tempuserid
			}, function(data) {
				//adminlisthide();
				showadminlist(shequid);
				window.parent.showAlert(data.msg);
			});
		}

		function askforenable(userid) {
			tempuserid = userid;
			window.parent.showConfirm("你确定要解除冻结该账号吗？", sureenable);
		}

		function sureenable() {
			var ableurl = '${ctx}/system/user/enableuser';
			$.post(ableurl, {
				"uid" : tempuserid
			}, function(data) {
				//adminlisthide();
				showadminlist(shequid);
				window.parent.showAlert(data.msg);
			});
		}

		function askforresetpass(userid) {
			tempuserid = userid;
			window.parent.showConfirm("你确定要重置该账号的密码吗？", resetpass);
		}

		function resetpass() {
			var reseturl = '${ctx}/system/user/resetpass'
			$.post(reseturl, {
				"uid" : tempuserid
			}, function(data) {
				//adminlisthide();
				showadminlist(shequid);
				window.parent.showAlert(data.msg);
			});
		}
	</script>

</body>
</html>