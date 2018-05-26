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
	
	
	 
	<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.min.js"></script>
	
	<script type="text/javascript">
		window.UEDITOR_HOME_URL = "${ctx}";
	</script>

</head>

<script type="text/javascript">
	jQuery(document).ready(function() {
		ue = UE.getEditor('container',{
		    toolbars: [
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload', 'insertimage']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
		    });
		
		initDate();
	});
	
	function initDate() {

        if (jQuery().datepicker) {
            $('.date-picker').datepicker({
                rtl : App.isRTL()
            });
        }
    }
	
	var processdatatwo=0;
	function uploadImageTwo() {
		var size=getFileSize("fileToUploadTwo");
		if(size>4194304)
			{
			  window.parent.showAlert("图片大小不能超过4m");

		         return false;
			}
		var filepath=$("#fileToUploadTwo").val();
        var extStart=filepath.lastIndexOf(".");
        var ext=filepath.substring(extStart,filepath.length).toUpperCase();
        if(ext!=".PNG"&&ext!=".JPG"){
        	window.parent.showAlert("只支持jpg,png的图片!");
            return false;
        }
		$.ajaxFileUpload( {
			url : '${ctx}/activity/upfile?type=tuwen',
			fileElementId : 'fileToUploadTwo',
			dataType : 'json',
			success : function(data) {
				if (data['result'] == 1){
					/* if(data.width!=720||data.height!=252){
						window.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720x252");
						return;
					} */
					
					$("#bartwo").css({'width':'0%'});
					$("#showprocesstwo").css("display","block"); 
					$("#imgurltwo").val(data.path);
					$("#imgthumbnailurltwo").val(data.thumbnail);
					$("#imgtwo").attr("src","${ctx}/"+data.thumbnail);
					$("#imgtwo").css("width","720px");
					$("#imgtwo").css("height","252px");
				}
				setTimeout('window.parent.iFrameHeight();',100);
			},
			error : function(data) {
				processdatatwo=100;
				window.parent.showAlert("上传失败");
			}
		});
		
		setTimeout('window.parent.iFrameHeight();',100);
	   	processdatatwo=0;
		doProgressLoopTwo();
	}
	function getProgressTwo() {
		$.ajax({
		        type: "post",
		    	dataType : 'json',
		        url: "${ctx}/api/process/getprocess",
		        data: "",
		        success: function (data) { 
		        	if(data!=null){
			        	processdatatwo=data.process;
			        	$("#bartwo").css({'width':data.process+'%'});
		        	}
		        },
		        error: function (err) {
		        	window.parent.showAlert("读取进度失败");
		        	processdatatwo=100;
		        }
		    });
		}

	function doProgressLoopTwo() { 
	    if (processdatatwo < 100) {
		    setTimeout("getProgressTwo()", 1000);
		    setTimeout("doProgressLoopTwo()", 1000);
	    }
	}
	
	function formsubmittwo(){
		
		var uecontent = ue.getContent();
		
		var imgurltwo = $("#imgurltwo").val();
		var titletwo = $("#titletwo").val();
		var subtitletwo = $("#subtitletwo").val();
		var starttimetwo = $("#starttimetwo").val();
		var endtimetwo = $("#endtimetwo").val();
		
		if(imgurltwo.trim() == '') {
			window.parent.showAlert("你还没有上传活动宣传图片");
			return false;
		}else if(starttimetwo.trim() == '') {
			window.parent.showAlert("你没有选择活动开始时间");
			return false;
		}else if(endtimetwo.trim() == '') {
			window.parent.showAlert("你没有选择活动结束时间");
			return false;
		}else if(starttimetwo > endtimetwo) {
			window.parent.showAlert("活动开始时间不能晚于结束时间");
			return false;
		}else if(titletwo.trim() == '') {
			window.parent.showAlert("活动标题不能为空");
			return false;
		}else if(subtitletwo.trim() == '') {
			window.parent.showAlert("活动简介不能为空");
			return false;
		}else if(uecontent.trim() == '') {
			window.parent.showAlert("你没有填写活动的图文详情介绍");
			return false;
		}
		
		$("#inputFormTwo").submit();
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
				<form action="${ctx}/activity/tuwenupdate" id="inputFormTwo" class="form-horizontal" method="post" style="margin:0px;">
	
					<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurltwo" value="${activity.imgthumbnailurl}" /> 
					<input type="hidden" name="imgurl" id="imgurltwo" value="${activity.imgurl}" /> 
					<input type="hidden" name="id" id="id" value="${activity.id}" /> 
					
					<div class="control-group"  <c:if test="${action == 'view' }">style="display:none;"</c:if>>
						<label for="fileToUploadTwo" class="control-label">活动宣传图:</label>
						<div class="controls" >
							<input id="fileToUploadTwo" name="fileToUploadTwo" type="file" onchange="uploadImageTwo();"  style="width: 72px;"/>
							<span name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.建议尺寸720x252)</span>
						</div>
					</div>
					
					<div class="control-group" id="showprocesstwo" style="display: none;" >
						<div class="controls" style="float: left">
							<div class="progress progress-striped active" style=" width: 300px; float: left">
								<div class="bar" id="bartwo" style="width: 40%; float: left"></div>
							</div>
						</div>
					</div>
					
					<div class="control-group" id="facetwo">
						<label class="control-label"><c:if test="${action == 'view' }">活动宣传图:</c:if></label>
						<div class="controls">
							<img alt="活动宣传图" src="${ctx}/${activity.imgurl}"  id="imgtwo">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动时间:</label>
						<c:if test="${action != 'view' }">
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttimetwo" name="starttime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.starttime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
								&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtimetwo" name="endtime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.endtime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
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
							<input type="text" id="titletwo" class="span3 m-wrap" style="width: 40%;" name="title" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.title}" maxlength="30">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动简介:</label>
						<div class="controls">
							<textarea id="subtitletwo" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="" maxlength="50">${activity.subtitle}</textarea>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">统计链接:</label>
						<div class="controls">
							<input type="text" id="reporturltwo" class="span3 m-wrap" style="width: 40%;" name="reporturl" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.reporturl}" maxlength="200">
						</div>
					</div>
					
					<div class="control-group"  <c:if test="${action == 'view' }">style="display:none;"</c:if> >
						<label class="control-label">详情:</label>
						<div class="controls" style="">
							<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${activity.content}</script>
						</div>
					</div>
					
					<div class="control-group"  <c:if test="${action != 'view' }">style="display:none;"</c:if> >
						<label class="control-label">详情:</label>
						<div class="controls" style="margin-top:20px;">
							<div>${activity.content}</div>
						</div>
					</div>
					
					<div class="form-actions" style="margin-bottom:0px;">
						<c:if test="${action != 'view' }">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmittwo()" />&nbsp; 
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