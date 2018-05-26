<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />

<html>
<head>
	<title>上传朗高居家养老系统升级包</title>
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript">
	
		$(document).ready(function(){
			
		});
		
		function showurls() {
			$("#urlsdiv").toggle();
			window.parent.iFrameHeight();
		}
		
		function selectthis(obj) {
			var thisobj = $(obj);
			thisobj.find("input[type='radio']").prop("checked",true);
			var choosenurl = thisobj.find("input[type='radio']").val();
			$("#page_url").val(choosenurl);
		} 
	
	</script>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/gg.png" style="vertical-align: text-bottom;" />添加页面
			</h3>
		</div>
	</div>
	
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption"><i class="icon-reorder"></i>
				添加页面
			</div>
		</div>
		<div class="portlet-body">
				<div class="portlet-body form" id="formwrapdiv">
					<form id="inputForm" action="" method="post" class="form-horizontal">
						
						
						<div class="control-group">
							<label class="control-label">主标题:</label>
							<div class="controls">
								<input type="text" id="title" name="title" class="span m-wrap" maxlength="6" style="width: 60%;" value="${title}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">副标题:</label>
							<div class="controls">
								<input type="text" id="description" name="description" class="span m-wrap" maxlength="7" style="width: 60%;" value="${description}"/>
							</div>
						</div>
						
						<div class="control-group" style="display:none">
							<label class="control-label">备注信息:</label>
							<div class="controls">
								<input type="text" id="comment" name="comment" class="span m-wrap" maxlength="15" style="width: 60%;" value="${comment}"/>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">跳转链接:</label>
							<div class="controls">
								<input type="text" id="page_url" name="page_url" class="span m-wrap" style="width: 60%;" value="${page_url}"/>
								<a id="selectbtn" class="btn blue" href="javascript:;" target="_blank"  onclick="showurls()" >选择跳转链接</a>
							</div>
						</div>
						
						<div class="control-group" style="display: none;" id="urlsdiv">
							<label class="control-label"></label>
							<div class="controls">
								
								<table id="contentTable" class="table table-striped table-bordered table-hover m-wrap" style="width:60%;font-size:12px;">
									<thead>
										<tr>
											<th style="width: 20px;">&nbsp;</th>
											<th style="width: 50px;">标题</th>
											<th style="width: 50px;">详情</th>
											<th style="width: 50px;">访问链接</th>
										</tr>
									</thead>
									<tbody>
											<tr onclick="selectthis(this)">
												<td style="vertical-align: middle;"><input type="radio" name="selecturl" value="${linkurl}"/></td>
												<td style="vertical-align: middle;">${mertitle}</td>
												<td style="vertical-align: middle;"><a href="${viewurl}" target="_blank">点击查看</a></td>
												<td style="vertical-align: middle;"><input text="text" value="${linkurl}" style="width:100%; background-color: transparent;border-width: 0; "/></td>
											</tr>
										<c:forEach items="${artList}" var="article" varStatus="status">
											<tr onclick="selectthis(this)">
												<td style="vertical-align: middle;"><input type="radio" name="selecturl" value="${article.url}"/></td>
												<td style="vertical-align: middle;">${article.title}</td>
												<td style="vertical-align: middle;"><a href="${ctx}/shake/viewactivitydetail?artid=${article.id}" target="_blank">点击查看</a></td>
												<td style="vertical-align: middle;"><input text="text" value="${article.url}" style="width:100%; background-color: transparent;border-width: 0; "/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">上传封面图片:</label>
							<div class="controls">
								<input id="fileToUpload" name="fileToUpload" type="file" onchange="uploadApk()" style="width: 72px; margin-top:8px;"/>
								<span name="easyTip" style="margin-left: 10px; color: red; font-size: 10px;">
								(只支持jpg,jpeg,png,gif格式的图片！建议120-200正方形图)</span>
							</div>
						</div>
						
						<div class="control-group" id="showicon" <c:if test="${action != 'saveupdatepage' }">style="display:none;"</c:if> >
							<label class="control-label"></label>
							<div class="controls">
								<img alt="${title}" src="${icon_url}" width=120 height=120 />
							</div>
						</div>
						
						<div class="control-group">
							<div class="controls" style="float: left">
								<div class="progress progress-striped active" id="showprocess" style="display: none; width: 425px; float: left">
									<div class="bar" style="width: 60%; float: left"></div>
								</div>
							</div>
						</div>
						
						<div class="control-group" style="display:none;" id="showurl">
							<label class="control-label">图片路径:</label>
							<div class="controls">
								<input type="text" value="${icon_url}" id="imgurl"  class="span m-wrap"  style="width: 60%;" disabled="disabled" />
							</div>
						</div>
						
						<input type="hidden" name="pageid" id="pageid" value="${pageid}" />
						
						<div class="form-actions">
							<input id="submit_btn" class="btn blue" type="button" onclick="formsubmit()" value="保存" />&nbsp; 
							<input id="cancel_btn" class="btn" type="button" value="取消" onclick="history.back()" />
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<script type="text/javascript" src="${ctx}/static/demo/js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
		<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
		<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
		<script type="text/javascript">
			function formsubmit() {
				 
				if ($("#title").val() == "") {
					window.parent.showAlert("请填写标题!");
					return;
				}
				
				if ($("#description").val() == "") {
					window.parent.showAlert("填写副标题!");
					return;
				}
				
				if ($("#page_url").val() == "") {
					window.parent.showAlert("请填写跳转链接!");
					return;
				} 
				
				
				if ($("#imgurl").val() == "") {
					window.parent.showAlert("请上传封面图片!");
					return;
				}
				
				$("#saveform").append("<input name='title' value='" + $("#title").val() + "' />");
				$("#saveform").append("<input name='description' value='" + $("#description").val() + "' />");
				$("#saveform").append("<input name='comment' value='"+$("#comment").val()+"' />");
				$("#saveform").append("<input name='page_url' value='" + $("#page_url").val() + "' />");
				$("#saveform").append("<input name='imgurl' value='" + $("#imgurl").val() + "' />");
				$("#saveform").append("<input name='pageid' value='" + $("#pageid").val() + "' />");
				$("#saveform").append("<input name='token' value='token' />");
				$("#saveform").submit();
			}
			
			function uploadApk() {
				
				var size=getFileSize("fileToUpload");
				if(size>4194304)
					{
					  window.parent.showAlert("图片大小不能超过4m");

				         return false;
					}
	
				var filepath = $("#fileToUpload").val();
				
				var extStart = filepath.lastIndexOf(".");
				
				var lastSlash = filepath.lastIndexOf("\\");
				
				var ext = filepath.substring(extStart, filepath.length).toUpperCase();
				
				var first = filepath.substring(lastSlash+1,extStart) ;
				
				var filename = filepath.substring(lastSlash+1,filepath.length);
				
				if (ext != ".JPG" && ext != ".JPEG" && ext != ".PNG" && ext != ".GIF") {
	
					parent.window.showAlert("只支持jpg,jpeg,png,gif格式的图片!");
	
					return false;
	
				}
	
				$.ajaxFileUpload({
					url : '${ctx}/shake/upfile',// 需要链接到服务器地址
					fileElementId : 'fileToUpload',// 文件选择框的id属性
					dataType : 'json',// 服务器返回的格式，可以是json
					success : function(data) {
						if(data.format != null && data.format == 'wrong') {
							window.parent.showAlert("只支持jpg,jpeg,png,gif格式的图片！");
							return;
						/* }else if(data.fwidth < 120 || data.fheight < 120 || data.fwidth != data.fheight || data.fheight > 200 || data.fheight > 200){
							window.parent.showAlert("图片的宽和高应在120到200之间，且图片为正方形图片！");
							return; */
						}else{
							$("#imgurl").val(data.path);
							$("#showurl").css("display","");
							$("#showicon").find("img").attr("src","${ctx}/"+data.path);
							$("#showicon").css("display","");
							window.parent.showAlert("上传成功！");
							
							$("#formwrapdiv").css("min-height","540px")
							setTimeout('window.parent.iFrameHeight();',100);
						}
					},
					error : function(data) {
						processdata = 100;
					}
				});
	
				$('.bar').css({
					'width' : '0%'
				});
				$("#showprocess").css("display", "block");
				processdata = 0;
				doProgressLoop();
			}
			function getProgress() {
				$.ajax({
					type : "post",
					dataType : 'json',// 服务器返回的格式，可以是json
					url : "${ctx}/api/process/getprocess",
					data : "",
					success : function(data) {
						if (data != null) {
							processdata = data.process;
							$('.bar').css({
								'width' : data.process + '%'
							});
						}
					},
					error : function(err) {
						parent.window.showAlert("读取进度失败");
						processdata = 100;
					}
				});
			}
	
			function doProgressLoop() {
				if (processdata < 100) {
					setTimeout("getProgress()", 1000);
					setTimeout("doProgressLoop()", 1000);
	
				}
	
			}
			
			 function getFileSize(sourceId) {
		    		return	document.getElementById(sourceId).files
		    								.item(0).size;
		    		}	 
		</script>
		<form id="saveform" method="post" style="display: none" action="${ctx}/shake/${action}">
		</form>
</body>
</html>
