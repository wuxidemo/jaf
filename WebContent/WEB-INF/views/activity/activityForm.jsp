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
	
	
	var processdatathree=0;
	function uploadImageThree() {
		var size=getFileSize("fileToUploadThree");
		if(size>4194304)
			{
			  window.parent.showAlert("图片大小不能超过4m");

		         return false;
			}
		var filepath=$("#fileToUploadThree").val();
        var extStart=filepath.lastIndexOf(".");
        var ext=filepath.substring(extStart,filepath.length).toUpperCase();
        if(ext!=".PNG"&&ext!=".JPG"){
        	window.parent.showAlert("只支持jpg,png的图片!");
            return false;
        }
		$.ajaxFileUpload( {
			url : '${ctx}/activity/upfile?type=muban',
			fileElementId : 'fileToUploadThree',
			dataType : 'json',
			success : function(data) {
				if (data['result'] == 1){
					/* if(data.width!=720||data.height!=252){
						window.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720x252");
						return;
					} */
					
					$("#barthree").css({'width':'0%'});
					$("#showprocessthree").css("display","block"); 
					$("#imgurlthree").val(data.path);
					$("#imgthumbnailurlthree").val(data.thumbnail);
					$("#imgthree").attr("src","${ctx}/"+data.thumbnail);
					$("#imgthree").css("width","720px");
					$("#imgthree").css("height","252px");
				}
				setTimeout('window.parent.iFrameHeight();',100);
			},
			error : function(data) {
				processdatathree=100;
				window.parent.showAlert("上传失败");
			}
		});
		
		setTimeout('window.parent.iFrameHeight();',100);
	   	processdatathree=0;
		doProgressLoopThree();
	}
	function getProgressThree() {
		$.ajax({
		        type: "post",
		    	dataType : 'json',
		        url: "${ctx}/api/process/getprocess",
		        data: "",
		        success: function (data) { 
		        	if(data!=null){
			        	processdatathree=data.process;
			        	$("#barthree").css({'width':data.process+'%'});
		        	}
		        },
		        error: function (err) {
		        	window.parent.showAlert("读取进度失败");
		        	processdatathree=100;
		        }
		    });
		}

	function doProgressLoopThree() { 
	    if (processdatathree < 100) {
		    setTimeout("getProgressThree()", 1000);
		    setTimeout("doProgressLoopThree()", 1000);
	    }
	}
	
	
	function formsubmit(){
		
		var nowdate = new Date().format("yyyy-MM-dd");
		
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
		}else if(nowdate > starttime) {
			window.parent.showAlert("活动开始时间不能晚于今天");
			return false;
		}else if(starttime > endtime) {
			window.parent.showAlert("活动开始时间不能晚于结束时间");
			return false;
		}else if(title.trim() == '') {
			window.parent.showAlert("活动标题不能为空");
			return false;
		}else if(subtitle.trim() == '') {
			window.parent.showAlert("活动简介不能为空");
			return false;
		}else if(url.trim() == '') {
			window.parent.showAlert("你没有填写活动的url");
			return false;
		}
		
		$("#inputForm").submit();
	}
	
	function formsubmittwo(){
		
		var nowdatetwo = new Date().format("yyyy-MM-dd");
		
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
		}else if(nowdatetwo > starttimetwo) {
			window.parent.showAlert("活动开始时间不能晚于今天");
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
	
	function isprice(num) {
		var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
		if (exp.test(num)) {
			return true;
		} else {
			return false;
		}
	}
	
	function formsubmitthree(){
		
		var nowdatethree = new Date().format("yyyy-MM-dd");
		
		var typethree = $("#typethree").val();
		var imgurlthree = $("#imgurlthree").val();
		var titlethree = $("#titlethree").val();
		var subtitlethree = $("#subtitlethree").val();
		var urlthree = $("#urlthree").val();
		var paypricethree = $("#paypricethree").val();
		var rebatepricethree = $("#rebatepricethree").val();
		var tmpnumthree = $("#tmpnumthree").val();
		var reporturlthree = $("#reporturlthree").val();
		var starttimethree = $("#starttimethree").val();
		var endtimethree = $("#endtimethree").val();
		
		if(imgurlthree.trim() == '') {
			window.parent.showAlert("你还没有上传活动宣传图片");
			return false;
		}else if(typethree.trim() == '') {
			window.parent.showAlert("你没有选择活动类型");
			return false;
		}else if(starttimethree.trim() == '') {
			window.parent.showAlert("你没有选择活动开始时间");
			return false;
		}else if(endtimethree.trim() == '') {
			window.parent.showAlert("你没有选择活动结束时间");
			return false;
		}else if(nowdatethree > starttimethree) {
			window.parent.showAlert("活动开始时间不能晚于今天");
			return false;
		}else if(starttimethree > endtimethree) {
			window.parent.showAlert("活动开始时间不能晚于结束时间");
			return false;
		}else if(titlethree.trim() == '') {
			window.parent.showAlert("活动标题不能为空");
			return false;
		}else if(subtitlethree.trim() == '') {
			window.parent.showAlert("活动简介不能为空");
			return false;
		}else if(urlthree.trim() == '') {
			window.parent.showAlert("你没有填写活动的url");
			return false;
		}else if(paypricethree.trim() == '') {
			window.parent.showAlert("你没有填写活动的单次支付额");
			return false;
		}else if(!isprice(paypricethree.trim())) {
			window.parent.showAlert("单次支付金额是正数");
			return false;
		}else if(rebatepricethree.trim() == '') {
			window.parent.showAlert("你没有填写活动的单次返还额");
			return false;
		}else if(!isprice(rebatepricethree.trim())) {
			window.parent.showAlert("单次返还额是正数");
			return false;
		}else if(tmpnumthree.trim() == '') {
			window.parent.showAlert("你没有填写活动的总数");
			return false;
		}else if(!tmpnumthree.match(/^\d+$/)) {
			window.parent.showAlert("活动的总数是正整数");
			return false;
		} 
		
		$("#inputFormThree").submit();
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
	<div class="tabbable tabbable-custom">

		<ul class="nav nav-tabs">

			<li class="active"><a style="font-size: 16px"  data-toggle="tab" href="#tab_1_1"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">URL</a></li>

			<li><a style="font-size: 16px" data-toggle="tab" href="#tab_1_2"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">图文</a></li>
				
			<li><a style="font-size: 16px" data-toggle="tab" href="#tab_1_3"
			onclick="setTimeout('window.parent.iFrameHeight();',50)">模板活动</a></li>


		</ul>

		<div class="tab-content">

			<div id="tab_1_1" class="tab-pane active">
				<div class="portlet-body form">
					<form action="${ctx}/activity/urlcreate" id="inputForm" class="form-horizontal" method="post" style="margin:0px;">
	
						<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurl" value="" /> 
						<input type="hidden" name="imgurl" id="imgurl" value="" /> 
						<input type="hidden" name="type" id="type" value="url" /> 
								
						<div class="control-group">
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
							<label class="control-label"></label>
							<div class="controls">
								<img alt="活动宣传图" src="${ctx}/static/images/zanwuPic.jpg" id="img">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动时间:</label>
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttime" name="starttime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtime" name="endtime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">标题:</label>
							<div class="controls">
								<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" value="" maxlength="30">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动简介:</label>
							<div class="controls">
								<textarea id="subtitle" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" value="" maxlength="50"></textarea>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">URL:</label>
							<div class="controls">
								<input type="text" id="url" class="span3 m-wrap" style="width: 40%;" name="url" value="" maxlength="200">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">统计链接:</label>
							<div class="controls">
								<input type="text" id="reporturl" class="span3 m-wrap" style="width: 40%;" name="reporturl" value="" maxlength="200">
							</div>
						</div>
						
						<div class="form-actions" style="margin-bottom:0px;">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
							<input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
						</div>
					</form>
				</div>
			</div>

			<div id="tab_1_2" class="tab-pane">
				<div class="portlet-body form">
					<form action="${ctx}/activity/tuwencreate" id="inputFormTwo" class="form-horizontal" method="post" style="margin:0px;">
	
						<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurltwo" value="" /> 
						<input type="hidden" name="imgurl" id="imgurltwo" value="" /> 
						<input type="hidden" name="type" id="type" value="tuwen" /> 
						
						<div class="control-group">
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
							<label class="control-label"></label>
							<div class="controls">
								<img alt="活动宣传图" src="${ctx}/static/images/zanwuPic.jpg" id="imgtwo">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动时间:</label>
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttimetwo" name="starttime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtimetwo" name="endtime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">标题:</label>
							<div class="controls">
								<input type="text" id="titletwo" class="span3 m-wrap" style="width: 40%;" name="title" value="" maxlength="30">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动简介:</label>
							<div class="controls">
								<textarea id="subtitletwo" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" value="" maxlength="50"></textarea>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">统计链接:</label>
							<div class="controls">
								<input type="text" id="reporturltwo" class="span3 m-wrap" style="width: 40%;" name="reporturl" value="" maxlength="200">
							</div>
						</div>
						
						<div class="control-group"  >
							<label class="control-label">详情:</label>
							<div class="controls" style="">
								<script id="container" name="content" style="width:100%;height:500px;" type="text/plain"></script>
							</div>
						</div>
						
						<div class="form-actions" style="margin-bottom:0px;">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmittwo()" />&nbsp; 
							<input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
						</div>
					</form>
				</div>
			</div>
			
			<div id="tab_1_3" class="tab-pane">
				<div class="portlet-body form">
					<form action="${ctx}/activity/mubancreate" id="inputFormThree" class="form-horizontal" method="post" style="margin:0px;">
	
						<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurlthree" value="" /> 
						<input type="hidden" name="imgurl" id="imgurlthree" value="" /> 
						<input type="hidden" name="type" id="type" value="muban" /> 
						
						<div class="control-group">
							<label class="control-label">活动类型:</label>
							<div class="controls">
								<select id="typethree" class="span3 m-wrap" style="width: 40%;" name="subtype">
									<option value="0">--选择活动类型--</option>
									<option value="1">一元抢鸡蛋</option>
								</select>
							</div>
						</div>
						
						<div class="control-group">
							<label for="fileToUploadThree" class="control-label">活动宣传图:</label>
							<div class="controls" >
								<input id="fileToUploadThree" name="fileToUploadThree" type="file" onchange="uploadImageThree();"  style="width: 72px;"/>
								<span name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.建议尺寸720x252)</span>
							</div>
						</div>
						
						<div class="control-group" id="showprocessthree" style="display: none;" >
							<div class="controls" style="float: left">
								<div class="progress progress-striped active" style=" width: 300px; float: left">
									<div class="bar" id="barthree" style="width: 40%; float: left"></div>
								</div>
							</div>
						</div>
						
						<div class="control-group" id="facethree">
							<label class="control-label"></label>
							<div class="controls">
								<img alt="活动宣传图" src="${ctx}/static/images/zanwuPic.jpg" id="imgthree">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动时间:</label>
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttimethree" name="starttime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtimethree" name="endtime" readonly size="16" type="text" style="height:34px;" value=""/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">标题:</label>
							<div class="controls">
								<input type="text" id="titlethree" class="span3 m-wrap" style="width: 40%;" name="title" value="" maxlength="30">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">活动简介:</label>
							<div class="controls">
								<textarea id="subtitlethree" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" value="" maxlength="50"></textarea>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">URL:</label>
							<div class="controls">
								<input type="text" id="urlthree" class="span3 m-wrap" style="width: 40%;" name="url" value="" maxlength="200">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">支付额:</label>
							<div class="controls">
								<input type="text" id="paypricethree" class="span3 m-wrap" style="width: 40%;" name="payprice" value="" maxlength="10">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">返还额:</label>
							<div class="controls">
								<input type="text" id="rebatepricethree" class="span3 m-wrap" style="width: 40%;" name="rebateprice" value="" maxlength="10">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">总数:</label>
							<div class="controls">
								<input type="text" id="tmpnumthree" class="span3 m-wrap" style="width: 40%;" name="tmpnum" value="" maxlength="15">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">统计链接:</label>
							<div class="controls">
								<input type="text" id="reporturlthree" class="span3 m-wrap" style="width: 40%;" name="reporturl" value="" maxlength="200">
							</div>
						</div>
						
						
						<div class="form-actions" style="margin-bottom:0px;">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmitthree()" />&nbsp; 
							<input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>