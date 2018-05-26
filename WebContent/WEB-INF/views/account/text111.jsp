<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>新申请用户管理</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/static/yjyupload/yjyupload.css" />
<%@ include file="../quote.jsp"%>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script src="${ctx}/static/mt/media/js/form-components.js"></script>

<script
	src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
<script src="${ctx}/static/mt/media/js/gallery.js"></script>
<script src="${ctx}/static/mt/media/js/jquery.fancybox.pack.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>

<script type="text/javascript"
	src="${ctx}/static/rating/lib/jquery.raty.min.js"></script>

</head>
<%@ include file="../quote.jsp"%>

<script type="text/javascript">
jQuery(document).ready(function() {
	
	 var acc='${acc}';
		if(acc=='show'){
			
		    $("#activityDate").attr("disabled",true);
			
		}  
	
	
	initDate();
});

function remove(){
	$("#imgshow1").css("display","none");
	
}

var processdate=0;
function uploadimge(){
	var size=getFileSize("fileToUpload");
	if(size>4194304)
		{
		  window.parent.showAlert("图片大小不能超过4m");

	         return false;
		}
	var filepath=$("#fileToUpload").val();
	var extStart=filepath.lastIndexOf(".");
	var ext=filepath.substring(extStart,filepath.length).toUpperCase();
	if(ext!=".PNG"&&ext!=".JPG"){
	window.parent.showAlert("只支持jpg,png的图片!");
	return false;
	}
 $.ajaxFileUpload({
	  url:'${ctx}/volunteers/upfile', //链接到服务器的地址
	  fileElementId:'fileToUpload',  //文件选择框的id属性
	  dataType:'json',
	  success:function(data){
		  if(data['result']==1){
			 /* if(data.width!=290||data.height!=204){
				 window.parent.showAlert("图片尺寸不正确,请确保图片尺寸为290x204!");
					return;
			 }  */
		  }
		  
		
		  $("#imgshow").html("");
		  $("#imgshow").html("<div class=\"span3\" style=\"width:"+data.twidth+"px;height: "+data.theight+"px;margin:0px 0px\"><div class=\"item\"><a href=\"javascript:;\" onclick=\"window.open('${ctx}/"+data.path+"','_blank');\"><img  src=\"${ctx}/"+data.thumbnail+"\" /></a></div></div>");
	      $("#url11").val(data.path);
	      $("#thumbnailurl11").val(data.thumbnail);
	   
		  window.parent.iFrameHeight();
	  },
	  error : function(data) {
			processdata=100;
			window.parent.showAlert("上传失败");
		}
 });
	processdata=0;
	doProgressLoop();
}

function doProgressLoop() { 
   if (processdata < 100) {
	    setTimeout("doProgressLoop()", 1000);
   }
}



function initDate() {

   if (jQuery().datepicker) {
       $(".date-picker").datepicker({
           rtl : App.isRTL()
       });
   }
}


function inDate() {

   if (jQuery().datepicker) {
       $(".datetimepicker").datepicker({
           rtl : App.isRTL()
       });
   }
}

function getFileSize(sourceId) {
	return	document.getElementById(sourceId).files
							.item(0).size;
	}	 
</script>


<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/zh.png"
					style="vertical-align: text-bottom;" /> 新申请用户管理
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
			<form class="form-search" action="${ctx}/system/merchant">
				<table style="width: 100%">
					<tr>
						<td style="width: 33%"><label class="control-label"
							style="float: left">用户姓名：</label> <input type="text" id="name"
							name="search_LIKE_name" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_name }"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left">用户电话：</label> <input type="text"
							id="telephone" name="search_LIKE_telephone" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_telephone}"></td>
						<td style="width: 33%"><label class="control-label"
							style="float: left">受理状态：</label> <select class="" id="state"
							style="width: 60%; height: 32px;" name="search_EQ_state">
								<option value="0">——选择状态——</option>
								<option value="1"
									<c:if test="${EQ_state==1}" > selected="selected" </c:if>>未受理</option>
								<option value="2"
									<c:if test="${EQ_state==2}" > selected="selected" </c:if>>已受理</option>

						</select></td>
					</tr>
					<tr>

						<td style="width: 33%"><label class="control-label"
							style="float: left">申请时间：</label> <input type="text"
							id="datetimepicker" name="search_LIKE_createtime" maxlength="20"
							style="float: left; width: 60%; height: 32px;" class=""
							value="${LIKE_createtime}"></td>
						
						<td style="width: 33%">&nbsp;</td>
						<td style="width: 33%">
							<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
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

		</div>
		<div class="portlet-body">
			<c:if test="${not empty message}">
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 8%;">序号</th>
						<th style="width: 17%;">用户姓名</th>
						<th style="width: 17%;">用户手机</th>
						<th style="width: 17%;">创建时间</th>
						<th style="width: 10%;">用户状态</th>
						<th style="width: 31%;">用户备注</th>

					</tr>
				</thead>
				<tbody>
					<c:if test="${dvs.totalPages!=0}">
						<c:forEach items="${dvs.content}" var="merchant"
							varStatus="status">
							<tr>
								<td style="vertical-align: middle;">${status.count}</td>
								<td style="vertical-align: middle;">${merchant.name}</td>
								<td style="vertical-align: middle;">${merchant.telephone}</td>
								<td style="vertical-align: middle;">${fn:substring(merchant.createtime, 0, 10)}</td>

								<td style="vertical-align: middle;"><c:if
										test="${merchant.state==1}">未受理</c:if> <c:if
										test="${merchant.state==2}">已受理


					</c:if></td>
								<td style="vertical-align: middle;">${merchant.remark}</td>
								<td style="vertical-align: middle;">${fn:substring(student.createtime, 0, 16)}</td>

								<td><a href="${ctx}/student/update/${student.id}">修改信息</a>&nbsp;
									<a href="${ctx}/student/goto/${student.id}">任课老师</a>&nbsp; <a
									href="javascript:;" onclick="askfordelete(${student.id})">删除</a>&nbsp;

								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${dvs.totalPages==0}">
						<tr class="odd gradeX">
							<td colspan="6" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${dvs}" paginationSize="5" />
		</div>
	</div>

</body>
</html>
