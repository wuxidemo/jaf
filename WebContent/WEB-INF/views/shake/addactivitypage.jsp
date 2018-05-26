<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>活动页面</title>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/bootstrap-fileupload.css" />
<link href="${ctx}/static/mt/media/css/chosen.css" rel="stylesheet"
	type="text/css" />
<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript" charset="utf-8"
	src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.min.js"></script>



<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>


<script>
	jQuery(document).ready(
			
			function() {
				var ue = UE.getEditor('container', {
					toolbars : [ [ 'undo', 'redo', 'bold', 'italic',
							'underline', 'fontborder', 'strikethrough',
							'superscript', 'subscript', 'removeformat',
							'formatmatch', 'autotypeset', 'blockquote',
							'pasteplain', '|', 'forecolor', 'backcolor',
							'insertorderedlist', 'insertunorderedlist',
							'selectall', 'cleardoc', 'simpleupload', 'insertimage'] ],
					autoHeightEnabled : false,
					autoFloatEnabled : true,
				});
				
				var action ='${action}';
				if(action == 'update') {
					$("#faceimg").attr("src",'${ctx}/${article.yurl}');
					$("#facediv").css("display","");
				}
				
				ue.addListener('contentChange',function(e){
					 window.parent.parent.iFrameHeight();
				 });
				
			});

	function formsubmit() {
		$("#inputForm").submit();
	}

	var processdate = 0;
	function uploadimge() {
		var size=getFileSize("fileToUpload");
		if(size>4194304)
			{
			  window.parent.showAlert("图片大小不能超过4m");

		         return false;
			}
		
		var filepath = $("#fileToUpload").val();
		var extStart = filepath.lastIndexOf(".");
		var ext = filepath.substring(extStart, filepath.length).toUpperCase();
		if (ext != ".PNG" && ext != ".JPG") {
			window.parent.showAlert("只支持jpg,png的图片!");
			return false;
		}
		$.ajaxFileUpload({
			url : '${ctx}/art/upfile', //链接到服务器的地址
			fileElementId : 'fileToUpload', //文件选择框的id属
			dataType : 'json',
			success : function(data) {
				if (data['result'] == 1) {
					/* if (data.width != 720 || data.height != 252) {
						window.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720x252!");
						return;
					} */
					
					$("#url11").val(data.path);
					$("#thumbnailurl11").val(data.thumbnail);
					$("#faceimg").attr("src", "${ctx}/"+data.path);
					$("#faceimg").css("width","720px");
					$("#faceimg").css("height","252px");
					$("#facediv").css("display", "");
				}

				setTimeout('window.parent.iFrameHeight();',100);
			},
			error : function(data) {
				processdata = 100;
				window.parent.showAlert("上传失败");
			}
		});
		processdata = 0;
		doProgressLoop();
	}

	function doProgressLoop() {
		if (processdata < 100) {
			setTimeout("doProgressLoop()", 1000);
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
					style="vertical-align: text-bottom;" /> <a href="#">创建活动页</a>&nbsp;<i
					class="icon-angle-right"></i>&nbsp;新增/编辑活动页面
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>新增/编辑活动页面
			</div>
		</div>

		<div class="portlet-body form">
			<form action="${ctx}/art/${action}" id="inputForm"
				class="form-horizontal" method="post">

				<!-- <div class="row-fluid"> -->
				<div class="control-group">
					<label class="control-label">活动标题:</label>
					<div class="controls">
						<input type="text" id="title" name="title" class="span m-wrap"
							maxlength="15" style="width: 60%;" value="${article.title}" />
					</div>
				</div>
				<!-- </div> -->

				<!-- <div class="control-group">
					<label for="name" class="control-label">上传活动图片：</label>
					<div class="controls">
						<input id="fileToUpload" name="fileToUpload" type="file"
							onchange="uploadimge();" style="width: 72px;"> <span
							name="easyTip" style="color: red; font-size: 10px;">(支持jpg,png格式.大小720x252)</span>
					</div>
				</div>
				<div class="control-group" style="display: none;" id="facediv">
					<div class="controls">
						<div id="imgface" style="float: left;">
							<img src="" alt="" id="faceimg" />
						</div>
					</div>
				</div>

				<br /> <br /> -->

				<div class="control-group">
					<label class="control-label">活动详情:</label>
					<div class="controls">
						<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${article.content}</script>
					</div>
				</div>


				<input type="hidden" name="thumbnailurl" id="thumbnailurl11"
					value="${article.thumbnailurl}" /> <input type="hidden"
					name="yurl" id="url11" value="${article.yurl}" /> <input
					type="hidden" name="id" id="artid" value="${article.id}" />

				<div class="form-actions" style="padding-top: 25px;">
					<input id="submit_btn" class="btn blue" type="button" value="保存"
						onclick="formsubmit()" />&nbsp; <input id="cancel_btn"
						class="btn grey" type="button" value="取消"
						onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
