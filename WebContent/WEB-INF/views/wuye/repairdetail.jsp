<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>报修详情</title>
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
	
	var
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
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
		    }); 
	    
	    wxyt({
			div : "detailup",
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸720*312)",
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
	
	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
			var hour = date.getHours();
			var minute = date.getMinutes();
			var second = date.getSeconds();
		
		if(month < 10) {
			month = "0"+month;
		}
		if(dd < 10) {
			dd = "0" + dd;
		}
			if(hour < 10) {
				hour = "0" + hour;
			}
			if(minute < 10) {
				minute = "0" + minute;
			}
			if(second < 10) {
				second = "0" + second;
			} 
		
		return year+"-"+month+"-"+dd;
	}

</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				报修详情
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>报修详情
			</div>
		</div>
		<div class="portlet-body form">
			<form action="" id="inputForm" class="form-horizontal" method="post">
			
				<input type="hidden" name="id" value="${repair.id }" /> <br>
			
				<input type="hidden" name="id" id="id"  value="15" /> 		
				<div class="control-group">
					<label class="control-label">报修人：</label>
					<c:if test="${repair.state == 1 }">
						<label class="control-label label label-important" style="width:40px; float:right;  margin-right: 50%;">未解决</label>
					</c:if>
					<c:if test="${repair.state == 2 }">
						<label class="control-label label label-warning" style="width:40px; float:right; margin-right: 50%">处理中</label>
					</c:if>
					<c:if test="${repair.state == 3 }">
						<label class="control-label label label-default" style="width:40px; float:right; margin-right: 50%">暂不解决</label>
					</c:if>
					<c:if test="${repair.state == 4 }">
						<label class="control-label label label-success" style="width:40px; float:right; margin-right: 50%">已解决</label>
					</c:if>
					<div class="controls">
						<input type="text" readonly="readonly" id="name"  name="name" class="span3 m-wrap" style="width: 40%;" value="${repair.name}" maxlength="10">
						
					</div>
					
					
				
				</div>
				
				<input type="hidden" name="id" id="id"  value="15" /> 		
				<div class="control-group">
					<label class="control-label">所属社区：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="comname"  name="comname"  class="span3 m-wrap" style="width: 40%;" value="${repair.community.name}" maxlength="10">
					</div>
				</div>
				
				<input type="hidden" name="id" id="id"  value="15" /> 		
				<div class="control-group">
					<label class="control-label">联系方式：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="telephone"  name="telephone"  class="span3 m-wrap" style="width: 40%;" value="${repair.telephone}" maxlength="10">
					</div>
				</div>
				
				<input type="hidden" name="id" id="id"  value="15" /> 		
				<div class="control-group">
					<label class="control-label">地点：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="address"  name="address"  class="span3 m-wrap" style="width: 40%;" value="${repair.address}" maxlength="10">
					</div>
				</div>
				
				<input type="hidden" name="id" id="id"  value="15" /> 		
				<div class="control-group">
					<label class="control-label">报修时间：</label>
					<div class="controls">
						<input type="text" readonly="readonly" id="createtime"  name="createtime"  class="span3 m-wrap" style="width: 40%;" value="${fn:substring(repair.createtime,0,10)}" maxlength="10">
					</div>
				</div >
				
				<div class="control-group">
					<label class="control-label"></label>&nbsp;&nbsp;&nbsp;&nbsp;
					<textarea readonly="readonly" class="span3 m-wrap" rows="8" style="width: 36%;" >${repair.content }</textarea>
				</div>
				
				
				
				<div class="control-group" id="info">
					
					<!--
					<p>报修人：<span>${repair.name }</span></p>
					<p>所属社区：<span>${repair.community.name }</span></p>
					<p>联系方式：<span>${repair.telephone }</span></p>
					<p>地点：<span>${repair.address }</span></p>
					<p>报修时间：<span id=>${repair.createtime }</span></p>
					
					<br>
					<p>${repair.content }</p>
					-->
				</div>
			
				
				
				<div class="control-group" id="introface">
					
					<div class="controls">
					<c:if test="${repair.infourl!=null }">
						<img alt="缩略图" src="${ctx}/static/images/${repair.infourl}"   id="introimg">
					</c:if>
					<%-- <c:if test="${repair.infourl==null }">
						<img alt="缩略图" src="${ctx}/static/images/zanwuPic.jpg"   id="introimg">
					</c:if> --%>
					
						
					</div>
				</div>
				
				<br />
				<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
				<br />
			</form>
		</div>
	</div>
</body>
</html>
