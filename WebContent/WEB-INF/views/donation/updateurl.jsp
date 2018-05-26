<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>修改义仓广告轮播图</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
	<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
</head>

<script>

	jQuery(document).ready(function() {
		
	    wxyt({
			div : "introup" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议大小720*252)",
			maxsize : 1048576,
			sucess : function(download_url, fileid, url) {
				$("#picurl").val(download_url);
				$("#introimg").attr("src",download_url);
				
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
	    
	});

	
	
	function formsubmit() {
		var picurl = $("#picurl").val();
		var title = $("#title").val();
		var url = $("#url").val();
		
		if(picurl == '') {
			window.parent.showAlert("请上传社区广告轮播图");
			return false;
		}else if(title == '') {
			window.parent.showAlert("请填写广告标题");
			return false;
		}else if(url == '') {
			window.parent.showAlert("请填写广告跳转链接");
			return false;
		}else{
			$("#inputForm").submit();
		}
	}
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				修改广告轮播图
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>修改广告轮播图
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/sqadvert/update" id="inputForm" class="form-horizontal" method="post">

				<input type="hidden" name="picurl" id="picurl" value="${sqadvert.picurl }" /> 
				<input type="hidden" name="id" id="advid" value="${sqadvert.id }" /> 
				
				<div class="control-group">
					<label for="fileToUploadintro" class="control-label">广告条:</label>
					<div class="controls" id="introup"></div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						<img alt="广告图片" src="${sqadvert.picurl }" id="introimg"  style="width:200px;height:150px;"/>
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" value="${sqadvert.title }" maxlength="50">
					</div>
				</div>
				
				<div class="control-group" id="urldiv">
					<label class="control-label">URL:</label>
					<div class="controls">
						<input type="text" id="url" class="span3 m-wrap" style="width: 40%;" name="url" value="${sqadvert.url }" maxlength="255">
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
					<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
