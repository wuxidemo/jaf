<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
	<title>优惠活动管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
	<script src="${ctx}/static/mt/media/js/form-components.js"></script>
	
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>

	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
	
</head>

<script type="text/javascript">
	jQuery(document).ready(function() {
		initDate();
	});
	
	function initDate() {

        if (jQuery().datepicker) {
            $('.date-picker').datepicker({
                rtl : App.isRTL()
            });
        }
    }
	
	var processdata=0;
	function uploadImage() {
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
		$.ajaxFileUpload( {
			url : '${ctx}/activity/upfile?type=url',
			fileElementId : 'fileToUpload',
			dataType : 'json',
			success : function(data) {
				if (data['result'] == 1){
					/* if(data.width!=720||data.height!=252){
						window.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720x252");
						return;
					} */
					
					$("#bar").css({'width':'0%'});
					$("#showprocess").css("display","block"); 
					$("#imgurl").val(data.path);
					$("#imgthumbnailurl").val(data.thumbnail);
					$("#img").attr("src","${ctx}/"+data.thumbnail);
					$("#img").css("width","720px");
					$("#img").css("height","252px");
				}
				setTimeout('window.parent.iFrameHeight();',100);
			},
			error : function(data) {
				processdata=100;
				window.parent.showAlert("上传失败");
			}
		});
		
		setTimeout('window.parent.iFrameHeight();',100);
	   	processdata=0;
		doProgressLoop();
	}
	function getProgress() {
		$.ajax({
		        type: "post",
		    	dataType : 'json',
		        url: "${ctx}/api/process/getprocess",
		        data: "",
		        success: function (data) { 
		        	if(data!=null){
			        	processdata=data.process;
			        	$("#bar").css({'width':data.process+'%'});
		        	}
		        },
		        error: function (err) {
		        	window.parent.showAlert("读取进度失败");
		        	processdata=100;
		        }
		    });
		}

	function doProgressLoop() { 
	    if (processdata < 100) {
		    setTimeout("getProgress()", 1000);
		    setTimeout("doProgressLoop()", 1000);
	    }
	}
	
	
	function formsubmit(){
		
		var imgurl = $("#imgurl").val();
		var starttime = $("#starttime").val();
		var endtime = $("#endtime").val();
		var title = $("#title").val();
		var subtitle = $("#subtitle").val();
		var url = $("#url").val();
		
		if(imgurl.trim() == '') {
			window.parent.showAlert("你还没有上传活动宣传图片");
			return false;
		}else if(starttime.trim() == '') {
			window.parent.showAlert("你没有选择活动开始时间");
			return false;
		}else if(endtime.trim() == '') {
			window.parent.showAlert("你没有选择活动结束时间");
			return false;
		}else if(starttime > endtime) {
			window.parent.showAlert("活动开始时间不能晚于结束时间");
			return false;
		}else if(title.trim() == '') {
			window.parent.showAlert("你没有填写活动的标题");
			return false;
		}else if(subtitle.trim() == '') {
			window.parent.showAlert("你没有填写活动简介");
			return false;
		}else if(url.trim() == '') {
			window.parent.showAlert("你没有填写活动的url");
			return false;
		}
		
		$("#inputForm").submit();
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
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 优惠活动管理
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>修改优惠活动
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form">
				<form action="${ctx}/activity/urlupdate" id="inputForm" class="form-horizontal" method="post" style="margin:0px;">

					<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurl" value="${activity.imgthumbnailurl}" /> 
					<input type="hidden" name="imgurl" id="imgurl" value="${activity.imgurl}" /> 
					<input type="hidden" name="id" id="id" value="${activity.id}" /> 
							
					<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if> >
						<label for="fileToUpload" class="control-label">活动宣传图:</label>
						<div class="controls" >
							<input id="fileToUpload" name="fileToUpload" type="file" onchange="uploadImage();"  style="width: 72px;"/>
							<span name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.建议尺寸720x252)</span>
						</div>
					</div>
					
					<div class="control-group" id="showprocess" style="display: none;" >
						<div class="controls" style="float: left">
							<div class="progress progress-striped active" style=" width: 300px; float: left">
								<div class="bar" id="bar" style="width: 40%; float: left"></div>
							</div>
						</div>
					</div>
					
					<div class="control-group" id="face">
						<label class="control-label"><c:if test="${action == 'view' }">活动宣传图:</c:if></label>
						<div class="controls">
							<img alt="活动宣传图" src="${ctx}/${activity.imgurl}" id="img">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动时间:</label>
						<c:if test="${action != 'view' }">
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttime" name="starttime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.starttime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
								&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtime" name="endtime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.endtime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
							</div>
						</c:if>
						<c:if test="${action == 'view' }">
							<div class="controls">
								<input class="span3 m-wrap" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.starttime,0,10)}"/>
								<span style="line-height:34px;">&nbsp;&nbsp;到&nbsp;&nbsp;</span>
								<input class="span3 m-wrap" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.endtime,0,10)}"/>
							</div>
						</c:if>
					</div>
					
					<div class="control-group">
						<label class="control-label">标题:</label>
						<div class="controls">
							<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.title}" maxlength="30">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动简介:</label>
						<div class="controls">
							<textarea id="subtitle" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="" maxlength="50">${activity.subtitle}</textarea>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">URL:</label>
						<div class="controls">
							<input type="text" id="url" class="span3 m-wrap" style="width: 40%;" name="url" value="${activity.url}" maxlength="255" <c:if test="${action == 'view' }">disabled="disabled"</c:if> />
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">统计链接:</label>
						<div class="controls">
							<input type="text" id="reporturl" class="span3 m-wrap" style="width: 40%;" name="reporturl" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.reporturl}" maxlength="200">
						</div>
					</div>
					
					<div class="control-group" style="height:50px;">
						<label class="control-label"></label>
						<div class="controls">
							
						</div>
					</div>
					
					<div class="form-actions" style="margin-bottom:0px;">
						<c:if test="${action != 'view' }">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
							<input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
						</c:if>
						
						<c:if test="${action == 'view' }">
							<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
						</c:if>
						
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>