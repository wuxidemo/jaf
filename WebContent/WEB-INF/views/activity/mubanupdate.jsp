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
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>修改优惠活动
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form">
				<form action="${ctx}/activity/mubanupdate" id="inputFormThree" class="form-horizontal" method="post" style="margin:0px;">

					<input type="hidden" name="imgthumbnailurl" id="imgthumbnailurlthree" value="${activity.imgthumbnailurl}" /> 
					<input type="hidden" name="imgurl" id="imgurlthree" value="${activity.imgurl}" /> 
					<input type="hidden" name="id" id="idthree" value="${activity.id}" /> 
					
					<div class="control-group">
						<label class="control-label">活动类型:</label>
						<div class="controls">
							<select id="typethree" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="subtype">
								<option value="0" >--选择活动类型--</option>
								<option value="1" <c:if test="${activity.subtype == '1'}">selected="selected"</c:if> >一元抢鸡蛋</option>
							</select>
						</div>
					</div>
					
					<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if>>
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
							<img alt="活动宣传图" src="${ctx}/${activity.imgurl}" id="imgthree">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动时间:</label>
						<c:if test="${action != 'view' }">
							<div class="controls">
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="starttimethree" name="starttime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.starttime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
								</div>
								&nbsp;&nbsp;到&nbsp;&nbsp;
								<div class="input-append date date-picker" data-date="" data-date-format="yyyy-mm-dd" data-date-viewmode="years">
									<input class="m-wrap m-ctrl-medium date-picker" id="endtimethree" name="endtime" readonly size="16" type="text" style="height:34px;" value="${fn:substring(activity.endtime,0,10)}"/><span class="add-on"><i class="icon-calendar"></i></span>
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
							<input type="text" id="titlethree" class="span3 m-wrap" style="width: 40%;" name="title" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.title}" maxlength="30">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">活动简介:</label>
						<div class="controls">
							<textarea id="subtitlethree" class="span3 m-wrap" style="width: 40%;" rows="3" name="subtitle" <c:if test="${action == 'view' }">disabled="disabled"</c:if> maxlength="50">${activity.subtitle}</textarea>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">URL:</label>
						<div class="controls">
							<input type="text" id="urlthree" class="span3 m-wrap" style="width: 40%;" name="url" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.url}" maxlength="200">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">支付额:</label>
						<div class="controls">
							<input type="text" id="paypricethree" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="payprice" value="${payprice}" maxlength="10">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">返还额:</label>
						<div class="controls">
							<input type="text" id="rebatepricethree" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="rebateprice" value="${rebateprice}" maxlength="10">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">总数:</label>
						<div class="controls">
							<input type="text" id="tmpnumthree" class="span3 m-wrap" style="width: 40%;" name="tmpnum" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.tmpnum}" maxlength="15">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">统计链接:</label>
						<div class="controls">
							<input type="text" id="reporturlthree" class="span3 m-wrap" style="width: 40%;" name="reporturl" <c:if test="${action == 'view' }">disabled="disabled"</c:if> value="${activity.reporturl}" maxlength="200">
						</div>
					</div>
					
					
					<div class="form-actions" style="margin-bottom:0px;">
						<c:if test="${action != 'view' }">
							<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmitthree()" />&nbsp; 
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