<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新增/修改企业捐献登记</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<%@ include file="../quote.jsp"%>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
<style type="text/css">
.inerLt {
	width: 200px;
	padding-bottom: 200px;
	height: 0;
	margin-left: auto;
	margin-right: auto;
	margin-top: 7.5px;
}

#addsqgift {
	outline: none;
	height: 30px;
	width: 30px;
	margin-left: 10px;
	background: url('${ctx}/static/images/adddonation.png') no-repeat;
	border: none;
}

#reducesqgift {
	outline: none;
	height: 30px;
	width: 30px;
	margin-left: 10px;
	background: url('${ctx}/static/images/reducedonation.png') no-repeat;
	border: none;
}

#count {
	width: 15%;
	margin-left: 10px;
	margin-right: 10px;
}

.giftitem {
	margin-top: 10px;
}
</style>
</head>
<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
	$(document).ready(function() {
		initDate();
		changtype();
		computenum();
	});
	/* 日期控件 */
	function initDate() {
		if (jQuery().datepicker) {
			$('#createtime').datepicker({
				rtl : App.isRTL()
			});
		}
	}
	/* 捐献内容的选择 */
	function changtype() {
		var type = $("#contexttype").val();
		if (type == 1) {
			$("#goods").hide();
			$("#money").show();
		} else if (type == 2) {
			$("#money").hide();
			$("#goods").show();
			window.parent.iFrameHeight();
		}
	}

	function formsubmit() {
		var id = $("#id").val().trim();
		var num = $("#num").val().trim();
		var company = $("#company").val().trim();
		var name = $("#name").val().trim();
		var phone = $("#phone").val().trim();
		var createtime = $("#createtime").val();
		var contexttype = $("#contexttype").val();
		var price = $("#price").val();
		/* var context=$("#context").val().trim(); */

		var nums = $("input[name='count']");//赠予物品数量
		var giftname = $("input[name='companyname']");//赠予物品的名字，应该与赠予物品数量对应
		var numandgif = '';

		if (num == '') {
			window.parent.showAlert("请填写交易编号");
			return false;
		} else if (!(/^[A-Za-z0-9]+$/.test($("#num").val()))) {//"^\d{1,8}$"菜品编号为数字格式
			window.parent.showAlert("交易编号由数字字母组成");
			return false;
		} else if (company == '') {
			window.parent.showAlert("请填写企业名称");
			return false;
		} else if (name == '') {
			window.parent.showAlert("请填写联系人");
			return false;
		} else if (phone == '') {
			window.parent.showAlert("请填写联系方式");
			return false;
		} else if (phone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1
				&& phone
						.search(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/) == -1) {
			window.parent.showAlert("联系方式格式不对");
			return false;
		} else if (createtime == '') {
			window.parent.showAlert("请填选捐献时间");
			return false;
		} else if (contexttype == 1 && price == '') {
			window.parent.showAlert("请填写捐献金额");
			return false;
		} else if (contexttype == 1
				&& !(/^[0-9]*[1-9][0-9]*$/.test($("#price").val()))) {/* /^\d+(\.\d+)?$/ 整数或小数*/
			window.parent.showAlert("捐献金额为大于0的整数");
			return false;
		} else {

			for (var i = 0; i < nums.length; i++) {
				if (contexttype == 2 && giftname[i].value == '') {
					window.parent.showAlert("请填写受赠物品");
					return false;
				} else if (contexttype == 2 && nums[i].value == '') {
					window.parent.showAlert("请填写数量");
					return false;
				} else if (contexttype == 2
						&& !(/^[0-9]*[1-9][0-9]*$/
								.test(parseInt(nums[i].value)))) {//"^\d{1,8}$"菜品编号为数字格式
					window.parent.showAlert("数量为大于零的整数");
					return false;
				} else if (contexttype == 2 && i == (nums.length - 1)) {
					numandgif += (giftname[i].value + ' ' + nums[i].value + ' 件');
				} else {
					numandgif += (giftname[i].value + ' ' + nums[i].value + ' 件,');
				}
			}
			$("#context").val(numandgif);

			var url = "${ctx}/sqdonation/checknum1";
			$.post(url, {
				"id" : id,
				"num" : num
			}, function(data) {
				if (data.result) {
					$("#inputForm1").submit();
				} else {
					window.parent.showAlert(data.msg);
					return false;
				}
			});

		}
	}
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />
				<c:if test="${action == 'create' }">企业捐献登记</c:if>
				<c:if test="${action == 'update' }">企业捐献编辑</c:if>
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
				<c:if test="${action == 'create' }">企业捐献登记</c:if>
				<c:if test="${action == 'update' }">企业捐献修改</c:if>
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/sqdonation/createupdate" method="post"
				id="inputForm1" class="form-horizontal">
				<input type="hidden" name="id" id="id" value="${sqdonation.id}" />
				<div class="control-group">
					<label class="control-label">交易编号:</label>
					<div class="controls">
						<input type="text" id="num" class="span3 m-wrap"
							style="width: 40%;" name="num" value="${sqdonation.num}"
							maxlength="10">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">企业名称:</label>
					<div class="controls">
						<input type="text" id="company" class="span3 m-wrap"
							style="width: 40%; float: left;" name="company"
							value="${sqdonation.company}" maxlength="20">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">联系人:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap"
							style="width: 40%;" name="name" value="${sqdonation.name}"
							maxlength="10">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" id="phone" class="span3 m-wrap"
							style="width: 40%;" name="phone" value="${sqdonation.phone}"
							maxlength="20">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">捐献时间:</label>
					<div class="controls">
						<input type="text" id="createtime" class="span3 m-wrap"
							style="width: 40%; cursor: pointer;" name="createtime"
							readonly="readonly"
							value="${fn:substring(sqdonation.createtime,0,10)}"
							maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">捐献内容:</label>
					<div class="controls">
						<select id="contexttype" name="contexttype" onchange="changtype()"
							style="float: left; width: 40%; height: 32px;" class="">
							<option value="1"
								<c:if test="${sqdonation.contexttype =='1'}">selected="selected"</c:if>>--钱财--</option>
							<option value="2"
								<c:if test="${sqdonation.contexttype =='2'}">selected="selected"</c:if>>--物品--</option>
						</select>
					</div>
				</div>
				<div class="control-group" id="money">
					<label class="control-label">捐献金额:</label>
					<div class="controls">
						<input type="text" id="price" class="span3 m-wrap"
							placeholder="1000" maxlength="8"
							style="width: 40%; text-align: left;" name="price"
							value="<c:if test="${sqdonation.price ==null}"></c:if><c:if test="${sqdonation.price!=null}"><fmt:formatNumber value='${sqdonation.price/100}'  pattern='##' minFractionDigits="0"></fmt:formatNumber></c:if>">
						<span
							style="vertical-align: middle; text-align: center; line-height: 34px;">元</span>
					</div>
				</div>
				<div class="control-group" id="goods" style="display: none;">
					<label class="control-label">捐献物品:</label>
					<textarea id="context" name="context" rows="" cols=""
						maxlength="200" placeholder="一床棉被，两桶花生油"
						style="width: 40%; height: 50px; display: none;">${sqdonation.context}</textarea>
					<div class="controls" id="sqgiftitem">
						<c:if test="${action == 'create' }">
							<div class="giftitem">
								<input type="text" placeholder="花生油" class="span3 m-wrap"
									style="width: 40%; float: left;" id="companyname"
									name="companyname" maxlength="15" value=""> <label
									class="control-label"
									style="width: 50px; float: left; text-align: right;">数量:</label>
								<input type="text" id="count" class="span3 m-wrap" name="count"
									value="" maxlength="5" onchange="computenum()"><span
									style="line-height: 34px;">件 </span><input type="button"
									id="addsqgift" onclick="addclick(this)" />
							</div>
						</c:if>
						<c:if test="${action == 'update' }">
							<c:forEach items="${listdonation}" var="list" varStatus="status">
								<c:if test="${status.last}">
									<div class="giftitem">
										<input type="text" placeholder="花生油" class="span3 m-wrap"
											style="width: 40%; float: left;" id="companyname"
											name="companyname" maxlength="15" value="${list.name}">
										<label class="control-label"
											style="width: 50px; float: left; text-align: right;">数量:</label>
										<input type="text" id="count" class="span3 m-wrap"
											name="count" value="${list.count}" maxlength="5"
											onchange="computenum()"><span
											style="line-height: 34px;">件 </span><input type="button"
											id="addsqgift" onclick="addclick(this)" />
									</div>
								</c:if>
								<c:if test="${!status.last}">
									<div class="giftitem">
										<input type="text" placeholder="花生油" class="span3 m-wrap"
											style="width: 40%; float: left;" id="companyname"
											name="companyname" maxlength="15" value="${list.name}">
										<label class="control-label"
											style="width: 50px; float: left; text-align: right;">数量:</label>
										<input type="text" id="count" class="span3 m-wrap"
											name="count" value="${list.count}" maxlength="5"
											onchange="computenum()"><span
											style="line-height: 34px;">件 </span><input type="button"
											id="reducesqgift" onclick="reduceclick(this)" />
									</div>
								</c:if>

							</c:forEach>
						</c:if>
						
					</div>
					<div class="controls">
						<label class="control-label" style="text-align: left;" id="sqnum">共计0件</label>
					</div>
				</div>
				<br>
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存"
						onclick="formsubmit()" />&nbsp; <input id="cancel_btn"
						class="btn grey" type="button" value="取消" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	function reduceclick(obj) {
		$(obj).parent("div").remove();//当前div被删除
		computenum();
	}
	function addclick(obj) {
		$(obj).hide();
		$(obj)
				.parent('div')
				.append(
						'<input type="button" id="reducesqgift"  onclick="reduceclick(this)"/>');//上一个div添加减号
		$("#sqgiftitem")
				.append(
						' <div class="giftitem">'
								+ '<input type="text" placeholder="花生油"    class="span3 m-wrap" style="width: 40%;float: left;"  id="companyname" name="companyname" maxlength="15" value=""/>'
								+ '<label class="control-label" style="width:50px;float: left;text-align: right;">数量:</label>'
								+ '<input type="text" id="count" class="span3 m-wrap"  name="count" value="" maxlength="5" onchange="computenum()"/><span style="line-height: 34px;">件 </span>'
								+ '<input type="button" id="addsqgift" onclick="addclick(this)"/>'
								+ '</div>');//添加新的物品
		window.parent.iFrameHeight();
	}
	function computenum() {
		var nums = $("input[name='count']")
		var num = 0;
		for (var i = 0; i < nums.length; i++) {
			if (nums[i].value != ''
					&& (/^[0-9]*[1-9][0-9]*$/.test(parseInt(nums[i].value)))) {
				num += parseInt(nums[i].value);
			}
		}
		$('#sqnum').html('共计' + num + '件');
	}
</script>
</html>