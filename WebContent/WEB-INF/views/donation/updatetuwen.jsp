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

<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>

<script>

	var ue = '';
	jQuery(document).ready(function() {
		
		window.parent.scroll(0,0);
		
		$.getJSON( '${ctx}/wxyt/config', function(data) {
			if (data.result == "1") {
				var sign = data.sign;// "ZkXygoKlOhG1lUq5e6nvDqB8DN1hPTEwMDEzNDE5JmI9bHV5ZnRlc3Qmaz1BS0lERTlqdVZ0REtHSWloQmVzRDhIU3pyODVlNkNNN3ZMcmkmZT0xNDQ5MTMyNDQzJnQ9MTQ0OTEyODg5MiZyPTE1MzkxODE4MjImdT0wJmY9"
				var url = data.url + '?sign=' + encodeURIComponent(sign);
				UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
				UE.Editor.prototype.getActionUrl = function(action) {
				    if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
				        return url;
				    } else if (action == 'uploadvideo') {
				        return 'http://a.b.com/video.php';
				    } else {
				        return this._bkGetActionUrl.call(this, action);
				    }
				}
			}});
		
	    ue = UE.getEditor('container',{
		    toolbars: [
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
		    });
	    
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
		var uecontent = ue.getContent();
		
		$("#context").val(uecontent);
		
		if(picurl == '') {
			window.parent.showAlert("请上传社区广告轮播图");
			return false;
		}else if(title == '') {
			window.parent.showAlert("请填写广告标题");
			return false;
		}else if(uecontent == '') {
			window.parent.showAlert("请填写广告内容详情");
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
						<img alt="广告图片" src="${sqadvert.picurl}" id="introimg" style="width:200px;height:150px;"/>
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" value="${sqadvert.title }" maxlength="50">
					</div>
				</div>
				
				<div class="control-group" id="contentdiv">
					<label class="control-label">详情:</label>
					<div class="controls">
						<script id="container" style="width:100%; height:500px;" type="text/plain">${sqadvert.context }</script>
					</div>
				</div>
				
				<input type="hidden" id="context" name="context" />
				
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
