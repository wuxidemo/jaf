<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新增/修改赠予登记</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet"
	type="text/css">
<%-- 	<link type="text/css" href="${ctx}/static/wxfile/wnx/css/serve.css" rel="stylesheet" /> --%>
<%@ include file="../quote.jsp"%>
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript"
	src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>
<!-- 上传js -->
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
<!-- --------------------------------------------------------------------------------------------------------------------------------	 -->
<!--  云上传 -->
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
	$(document)
			.ready(
					function() {
						initDate();
						var test = $("input[type=checkbox]:not(.toggle)");
						if (test.size() > 0) {
							test.each(function() {
								if ($(this).parents(".checker").size() == 0) {
									$(this).show();
									$(this).uniform();
								}
							});
						}
						window.parent.scroll(0, 0);
						wxyt({
							div : "up2",
							baseurl : "${ctx}",
							tip : "(支持jpg,png格式.建议尺寸200x200像素 )",
							maxsize : 1048576,
							sucess : function(download_url, fileid, url) {
								$("#imgshow1").html("");
								$("#imgshow1")
										.html(
												'<div class="inerLt"style="background: url(\''
														+ download_url
														+ '?imageView2/2/w/200|imageMogr2/auto-orient\') no-repeat; background-size: cover;  background-position: 50%;">'
														+ '</div>');
								/* "<div class=\"span3\" style=\"width:200px;height:200px;margin:0px 0px\"><img   src="+download_url+" style=\"width:200px;height:200px;\"></div>" */
								$("#picurl").val(
										download_url
												+ '?imageView2/2/w/200/q/85');
								setTimeout('window.parent.iFrameHeight();', 100);
							},
							fail : function(d) {
								alert(d);
							}
						});
						computenum();
					});
	function initDate() {
		if (jQuery().datepicker) {
			$('#createtime').datepicker({
				rtl : App.isRTL()
			});
		}
	}
	function formsubmit() {
		var id = $("#id").val().trim();
		var num = $("#num").val().trim();
		var firstname = $("#firstname").val().trim();
		var lastname = $("#lastname").val().trim();
		var phone = $("#phone").val().trim();
		var doname = $("#doname").val().trim();
		var createtime = $("#createtime").val();
		var picurl = $("#picurl").val();
		var nums = $("input[name='count']");//赠予物品数量
		var giftname = $("input[name='name']");//赠予物品的名字，应该与赠予物品数量对应
		var numandgif = '';
		if (picurl == '') {
			$("#picurl")
					.val(
							"http://lyfts2-10017813.image.myqcloud.com/636bd7e1-6ebf-4c60-b116-2ec7ef1eeb32");
		}
		if (num == '') {
			window.parent.showAlert("请填写编号");
			return false;
		} else if (!(/^[A-Za-z0-9]+$/.test($("#num").val()))) {//"^\d{1,8}$"菜品编号为数字格式
			window.parent.showAlert("编号由数字字母组成");
			return false;
		} else if (firstname == '') {
			window.parent.showAlert("请填写受赠人姓氏");
			return false;
		} else if (lastname == '') {
			window.parent.showAlert("请填写受赠人名字");
			return false;
		} else if (phone == '') {
			window.parent.showAlert("请填写受赠人联系方式");
			return false;
		} else if (phone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1
				&& phone
						.search(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/) == -1) {
			window.parent.showAlert("联系方式格式不对");
			return false;
		} else if (doname == '') {
			window.parent.showAlert("请填写承办人");
			return false;
		} else if (createtime == '') {
			window.parent.showAlert("请填选赠予时间");
			return false;
		} else {
			for (var i = 0; i < nums.length; i++) {
				if (giftname[i].value == '') {
					window.parent.showAlert("请填写物品");
					return false;
				} else if (nums[i].value == '') {
					window.parent.showAlert("请填写数量");
					return false;
				} else if (!(/^[0-9]*[1-9][0-9]*$/
						.test(parseInt(nums[i].value)))) {//"^\d{1,8}$"菜品编号为数字格式
					window.parent.showAlert("数量为大于零的整数");
					return false;
				} else if (i == nums.length - 1) {
					numandgif += (giftname[i].value + ' ' + nums[i].value + ' 件');
				} else {
					numandgif += (giftname[i].value + ' ' + nums[i].value + ' 件,');

				}
			}
			$("#context").val(numandgif);

			var url = "${ctx}/sqgiftrecord/checknum";
			$.post(url, {
				"id" : id,
				"num" : num
			}, function(data) {
				if (data.result) {
					$("#inputForm").submit();
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
				<c:if test="${action == 'create' }">物品赠予登记</c:if>
				<c:if test="${action == 'update' }">物品赠予编辑</c:if>
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
				<c:if test="${action == 'create' }">物品赠予登记</c:if>
				<c:if test="${action == 'update' }">物品赠予编辑</c:if>
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/sqgiftrecord/createupdate" id="inputForm"
				class="form-horizontal" method="post">
				<input type="hidden" name="id" id="id" value="${sqgiftrecord.id}" />
				<div class="control-group">
					<label class="control-label">编号:</label>
					<div class="controls">
						<input type="text" id="num" class="span3 m-wrap"
							style="width: 40%;" name="num" value="${sqgiftrecord.num}"
							maxlength="10">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">受赠人姓:</label>
					<div class="controls">
						<input type="text" id="firstname" class="span3 m-wrap"
							style="width: 40%; float: left;" name="firstname"
							value="${sqgiftrecord.firstname}" maxlength="5"> <label
							class="control-label"
							style="width: 50px; float: left; text-align: right;">名:</label> <input
							type="text" id="lastname" class="span3 m-wrap"
							style="width: 40%; margin-left: 10px;" name="lastname"
							value="${sqgiftrecord.lastname}" maxlength="5">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">联系方式:</label>
					<div class="controls">
						<input type="text" id="phone" class="span3 m-wrap"
							style="width: 40%;" name="phone" value="${sqgiftrecord.phone}"
							maxlength="20">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">承办人:</label>
					<div class="controls">
						<input type="text" id="doname" class="span3 m-wrap"
							style="width: 40%;" name="doname" value="${sqgiftrecord.doname}"
							maxlength="10">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">赠予时间:</label>
					<div class="controls">
						<input type="text" id="createtime" class="span3 m-wrap"
							style="width: 40%;" name="createtime"
							value="${fn:substring(sqgiftrecord.createtime,0,10)}"
							maxlength="30">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">受赠物品:</label>
					<textarea id="context" rows="" cols="" maxlength="200"
						placeholder="一床棉被，两桶花生油"
						style="width: 40%; height: 50px; display: none;" name="context">${sqgiftrecord.context}</textarea>
					<div class="controls" id="sqgiftitem">
						<c:if test="${action == 'create' }">
							<div class="giftitem">
								<input type="text" placeholder="花生油" class="span3 m-wrap"
									style="width: 40%; float: left;" id="name" name="name"
									maxlength="15" value=""> <label class="control-label"
									style="width: 50px; float: left; text-align: right;">数量:</label>
								<input type="text" id="count" class="span3 m-wrap" name="count"
									value="" maxlength="5" onchange="computenum()"><span
									style="line-height: 34px;">件 </span> <input type="button"
									id="addsqgift" onclick="addclick(this)" />
							</div>
						</c:if>
						<c:if test="${action == 'update' }">
							<c:forEach items="${gifttimelist}" var="list" varStatus="status">
								<c:if test="${status.last}">
									<div class="giftitem">
										<input type="text" placeholder="花生油" class="span3 m-wrap"
											style="width: 40%; float: left;" id="name" name="name"
											maxlength="15" value="${list.name}"> <label
											class="control-label"
											style="width: 50px; float: left; text-align: right;">数量:</label>
										<input type="text" id="count" class="span3 m-wrap"
											name="count" value="${list.count}" maxlength="5"
											onchange="computenum()"><span
											style="line-height: 34px;">件 </span> <input type="button"
											id="addsqgift" onclick="addclick(this)" />
									</div>
								</c:if>
								<c:if test="${!status.last}">
									<div class="giftitem">
										<input type="text" placeholder="花生油" class="span3 m-wrap"
											style="width: 40%; float: left;" id="name" name="name"
											maxlength="15" value="${list.name}"> <label
											class="control-label"
											style="width: 50px; float: left; text-align: right;">数量:</label>
										<input type="text" id="count" class="span3 m-wrap"
											name="count" value="${list.count}" maxlength="5"
											onchange="computenum()"><span
											style="line-height: 34px;">件 </span> <input type="button"
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

				<!-- 图片上传	 -->
				<div class="row-fluid" id="upload1" style="margin-top: 22px;">
					<label for="fileToUpload1" class="control-label">展示图片:</label>
					<div class="controls" id="up2">
						<!-- <input id="fileToUpload1" name="fileToUpload1" type="file"onchange="uploadimge1();"style="width:72px;" /> 
						<span name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.建议尺寸360x230像素 )</span> -->
					</div>
				</div>
				<input type="hidden" id="picurl" name="picurl"
					value="${sqgiftrecord.picurl}">
				<div class="row-fluid" style="">
					<div class="controls">
						<div id="imgshow1" class="hello" style="float: left;">
							<c:if test="${action=='update'}">
								<c:choose>
									<c:when test="${sqgiftrecord.picurl==''}">
										<div class="span3"
											style="width: 200px; height: 200px; margin: 0px 0px;">
											<div class="item">
												<img
													src="http://lyfts2-10017813.image.myqcloud.com/636bd7e1-6ebf-4c60-b116-2ec7ef1eeb32"
													style="width: 200px; height: 200px;" />
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="span3"
											style="width: 200px; height: 200px; margin: 0px 0px;">
											<div class="item">
												<div class='inerLt'
													style="background: url('${sqgiftrecord.picurl}') no-repeat; background-size: cover;  background-position: 50%;"></div>
												<%-- <img src="${sqgiftrecord.picurl}" style="width: 200px; height: 200px;" /> --%>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${action=='create'}">
								<div class="span3"
									style="width: 200px; height: 200px; margin: 0px 0px;">
									<div class="item">
										<%-- <img src="${ctx}/static/images/zanwuPic2.jpg" /> --%>
										<img
											src="http://lyfts2-10017813.image.myqcloud.com/636bd7e1-6ebf-4c60-b116-2ec7ef1eeb32"
											style="width: 200px; height: 200px;" />
									</div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
				<!-- 图片上传结束 -->
				<br>
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存"
						onclick="formsubmit()" />&nbsp; <input id="cancel_btn"
						class="btn grey" type="button" value="取消" onclick="history.back()" />
					&nbsp; <br> &nbsp; <br> &nbsp; <br> &nbsp; <br>&nbsp;
					<br> &nbsp; <br> &nbsp; <br> &nbsp; <br>
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
								+ '<input type="text" placeholder="花生油"    class="span3 m-wrap" style="width: 40%;float: left;"  id="name" name="name" maxlength="15" value=""/>'
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