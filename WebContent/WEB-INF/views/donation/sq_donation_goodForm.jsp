<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新增/修改/查看义仓商品</title>
	<%@ include file="../quote.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
	<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet" type="text/css" />
	<!-- 上传js -->
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
<!-- --------------------------------------------------------------------------------------------------------------------------------	 -->
<!--  云上传 -->
<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
<style type="text/css">
.inerLt{
   width: 200px;
  padding-bottom: 200px;
  height: 0;
  margin-left: auto;
  margin-right: auto;
  margin-top: 7.5px;
    }
</style>
</head>
<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>
<script type="text/javascript">
jQuery(document)
		.ready(function() {
					var test = $("input[type=checkbox]:not(.toggle)");
					if (test.size() > 0) {
						test.each(function() {
							if ($(this).parents(".checker").size() == 0) {
								$(this).show();
								$(this).uniform();
							}
						});
					}
					var acc = '${action}'
					if (acc == 'view') {
						$("#num").attr("disabled", true);
						$("#name").attr("disabled", true);
						$("#price1").attr("disabled", true);
						$("#format").attr("disabled", true);
						$("#community").attr("disabled", true);
						$("#upload1").css("display", "none");
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
									.html('<div class="inerLt"style="background: url(\''+download_url+'?imageView2/2/w/200|imageMogr2/auto-orient\') no-repeat; background-size: cover;  background-position: 50%;">'+'</div>');
							$("#url").val(download_url+'?imageView2/2/w/200/q/85');
							setTimeout('window.parent.iFrameHeight();', 100);
						},
						fail : function(d) {
							alert(d);
						}
					});
				});
				
function formsubmit(obj) {
	if($(obj).val().trim()=="保存"){
		$("#state").val(null);
	}else if($(obj).val().trim()=="上架"){
		$("#state").val("1");
	}else if($(obj).val().trim()=="下架"){
		$("#state").val("0");
	}
	var th = $("#url").val();
	if ($("#num").val() == null || $.trim($("#num").val()) == '') {
		window.parent.showAlert("请填写商品编号");
		return false;
	}else if (!(/^[A-Za-z0-9]+$/.test($("#num").val()))) {//"^\d{1,8}$"菜品编号为数字格式
		window.parent.showAlert("商品编号由数字字母组成");
		/* $(this).focus();
		window.parent.myscrollTo($("#num")); */
		return false;
	}else if ($("#name").val() == null || $.trim($("#name").val()) == '') {
		window.parent.showAlert("请填写商品名称");
		return false;
	} else if ($("#price1").val() == null || $.trim($("#price1").val()) == '') {
		window.parent.showAlert("请填写商品价格");
		return false;
	} else if (!(/^[0-9]*[1-9][0-9]*$/.test($("#price1").val()))) {/* /^\d+(\.\d+)?$/ 整数或小数*/
		window.parent.showAlert("商品价格为大于0的整数");
		return false;
	} else if ($("#format").val() == null || $.trim($("#format").val()) == '') {
		window.parent.showAlert("请填写商品规格");
		return false;
	} else if (th.trim() == '') {
		window.parent.parent.showAlert("请填选商品图片");
		return false;
	}else {
		var id = $("#id").val();
		var num = $("#num").val();
		var url = "${ctx}/sq_donation_good/check";
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

function changprice(){
	$("#price").val($("#price1").val()*100);
}
</script>
<body>
<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				<c:if test="${action == 'view' }">商品详情</c:if>
				<c:if test="${action == 'create' }">新增商品</c:if>
				<c:if test="${action == 'update' }">编辑商品</c:if>
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
				<c:if test="${action == 'view' }">商品详情</c:if>
				<c:if test="${action == 'create' }">新增商品</c:if>
				<c:if test="${action == 'update' }">编辑商品</c:if>
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/sq_donation_good/createupdate" id="inputForm" class="form-horizontal" method="post">
				<input type="hidden" name="id" id="id"  value="${sqdonationgood[0]}" /> 		
				<div class="control-group">
					<label class="control-label">商品编号：</label>
					<div class="controls">
						<input type="text" id="num"  name="num"  class="span3 m-wrap" style="width: 40%;" value="${sqdonationgood[1]}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商品名称：</label>
					<div class="controls">
						<input type="text" id="name" name="name" class="span3 m-wrap" style="width: 40%;" value="${sqdonationgood[2]}" maxlength="20">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商品价格：</label>
					<div class="controls">
					   <input type="hidden" id="price" name="price" class="span3 m-wrap" style="width: 40%;"  value="${sqdonationgood[3]}" maxlength="8">
						<input type="text" id="price1" name="price1" onchange="changprice()"   placeholder="500" class="span3 m-wrap" style="width: 40%;"  
						value="<c:if test="${sqdonationgood[3]==null}"></c:if><c:if test="${sqdonationgood[3]!=null}"><fmt:formatNumber value='${sqdonationgood[3]/100}' pattern='##' minFractionDigits="0"></fmt:formatNumber></c:if>" maxlength="8">
						<span style=" vertical-align: middle;text-align: center;line-height:34px; ">元</span>
					</div>
				</div>
            <div class="control-group">
					<label class="control-label">商品规格：</label>
					<div class="controls">
						<input type="text" id="format" name="format" placeholder="桶,件,箱..." class="span3 m-wrap" style="width: 40%;" value="${sqdonationgood[4]}" maxlength="10">
					</div>
				</div>
			<!-- 图片上传	 -->
				<div class="row-fluid" id="upload1" style="margin-top: 22px;">
					<label for="fileToUpload1" class="control-label">商品图片：</label>
					<div class="controls" id="up2">
						<!-- <input id="fileToUpload1" name="fileToUpload1" type="file"onchange="uploadimge1();"style="width:72px;" /> 
						<span name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.建议尺寸360x230像素 )</span> -->
					</div>
				</div>
				<input type="hidden" id="url" name="url" value="${sqdonationgood[8]}"> 
				<div class="row-fluid" style="">
					<div class="controls">
						<div id="imgshow1" class="hello" style="float: left;">
							<c:if test="${action=='update'}">
								<c:choose>
									<c:when test="${sqdonationgood[8]==''}">
										<div class="span3" style="width:200px; height: 200px; margin: 0px 0px;">
											<div class="item">
												<img src="${ctx}/static/images/zanwuPic2.jpg" />
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="span3" style="width: 200px; height: 200px; margin: 0px 0px;">
											<div class="item">
												<%-- <img src="${sqdonationgood[8]}" style="width: 200px; height: 200px;" /> --%>
												<div class='inerLt' style="background: url('${sqdonationgood[8]}') no-repeat; background-size: cover;  background-position: 50%;"></div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if> 
							<c:if test="${action=='create'}">
								<div class="span3" style="width: 200px; height: 200px; margin: 0px 0px;">
									<div class="item">
										<img src="${ctx}/static/images/zanwuPic2.jpg" />
									</div>
								</div>
							</c:if>
							<c:if test="${action=='view'}">
								<c:choose>
									<c:when test="${sqdonationgood[8]==''}">
										<label class="control-label" style="margin-left: -188px;">商品图片:</label>
										<div class="span3" style="width: 200px; height: 200px; margin: 0px 0px;">
											<div class="item">
												<a href="javascript:;"> <img src="${ctx}/static/images/zanwuPic2.jpg" style="width: 200px; height: 200px;" />
												</a>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<label class="control-label" style="margin-left: -188px; margin-top: 20px;">商品图片:</label>
										<div class="span3" style="width: 200px; height: 200px; margin: 0px 0px; margin-top: 20px;">
											<div class="item">
												<!-- <a href="javascript:;" --><%-- onclick="window.open('${ctx}/${volunteers.url}','_blank');" --%>
												<%--  <img src="${sqdonationgood[8]}" style="width: 200px; height: 200px;" /> </a>--%>
												 <div class='inerLt' style="background: url('${sqdonationgood[8]}') no-repeat; background-size: cover;  background-position: 50%;"></div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>
						</div>
					</div>
				</div>
			<!-- 图片上传结束 -->
			<c:if test="${comm==null&&action== 'view' }" >
			<br />
			    <div class="control-group">
					<label class="control-label">所属社区：</label>
					<div class="controls">
						<input type="text" id="community" name="community" class="span3 m-wrap" style="width: 40%;" value="${sqdonationgood[9]}" maxlength="30">
					</div>
				</div>
				</c:if>
				<br />
				<div class="form-actions">
					<c:if test="${action != 'view' }">
						<input id="submit_btn" class="btn blue" type="button" 
						value="<c:if test="${sqdonationgood[5]==0||sqdonationgood[5]==null}">上架</c:if><c:if test="${sqdonationgood[5]==1}">下架</c:if>" 
						onclick="formsubmit(this)" />&nbsp; 
						<input id="state" name="state" type="hidden" value="${sqdonationgood[5]}">
						<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit(this)" />
					</c:if>
					<c:if test="${action == 'view' }">
						<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
					</c:if>
				</div>
			</form>
		</div>
	</div>
</body>
</html>