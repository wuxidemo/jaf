<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>金融信息-新增/修改金融信息</title>
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
	var scrollHeight = '';
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
		               ['undo', 'redo', 'bold', 'italic', 'underline','link','fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
            thumb:"?imageView2/2/w/300"
		    }); 
	    
	    wxyt({
			div : "detailup",
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸682x264)",
			maxsize : 1048576,
			sucess : function(download_url, fileid, url) {
				
				$("#url").val(download_url);
				$("#thumburl").val(download_url+'?imageView2/2/w/258/h/170/q/85');
				$("#introimg").attr("src",download_url);
				
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
		 
		 
		 var action = "${action}"; 
		 if(action == 'update' || action == 'view') {
			 
			var intrurl = '${finance.thumburl}';
			
			if(intrurl != '') {
				
				if(intrurl.indexOf("http://") >=0) {
					$("#introimg").attr("src","${finance.thumburl}");
				}else{
					$("#introimg").attr("src","${ctx}/${finance.thumburl}");
				}
				
				
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
				$("#introface").css("display","");
			}
			
		 }
		 
	});

	
	
	function formsubmit() {
		
		var title = $("#title").val();
		var url = $("#url").val();
		var uecontent = ue.getContent(); 
		
		if($.trim(title) == '') {
			window.parent.showAlert("你没有填写信息标题");
			return false;
		}else if($.trim(url) == '') {
			window.parent.showAlert("你没有上传信息图片");
			return false;
		}else if($.trim(uecontent) == '') {
			window.parent.showAlert("你没有填写金融信息详情");
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
				新增/修改金融信息
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>新增/修改金融信息
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/financeinfo/${action}" id="inputForm" class="form-horizontal" method="post">

				<input type="hidden" name="id" value="${finance.id}" /> 
				<input type="hidden" name="thumburl" id="thumburl" value="${finance.thumburl}" /> 
				<input type="hidden" name="url" id="url" value="${finance.url}" /> 
						
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 60%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="title" value="${finance.title}" maxlength="30" onkeydown="if(event.keyCode==13) return false;" >
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if>>
					<label for="fileToUploadintro" class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>缩略图:</label>
					<div class="controls" id="detailup" >
						
					</div>
				</div>
				
				<div class="control-group" id="introface">
					<label class="control-label"><c:if test="${action == 'view' }">缩略图:</c:if></label>
					<div class="controls">
						<img alt="缩略图" src="${ctx}/static/images/zanwuPic.jpg"   id="introimg">
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if> >
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>详情介绍:</label>
					<div class="controls" style="">
						<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${finance.content}</script>
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action != 'view' }">style="display:none;"</c:if> >
					<label class="control-label">详情介绍:</label>
					<div class="controls" style="margin-top:8px;">
						${finance.content}
					</div>
				</div>
				
				
				
				<br />
				<div class="form-actions">
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
</body>
</html>
