<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>后台用户管理</title>
</head>
<%@ include file="../quote.jsp"%>
<script type="text/javascript">

	$(document).ready(function(){
		$("#newpassword1").on("focus", function(){
			$("#passtip").css("display","");
		});
		
		$("#newpassword1").on("blur", function(){
			$("#passtip").css("display","none");
	 	});
	});

	function formsubmit(){
		
		var oldpass = $("#oldpassword").val();
		var newpass1 = $("#newpassword1").val();
		var newpass2 = $("#newpassword2").val();
		
		if(oldpass==null||$.trim(oldpass)==''){
			  window.parent.showAlert("旧密码不能为空");
			  $(this).focus();
			  return false;
		} else if(newpass1==null||$.trim(newpass1)==''){
			window.parent.showAlert("新密码不能为空");
			$(this).focus();
			return false;
		} else if(newpass2==null||$.trim(newpass2)==''){
			window.parent.showAlert("确认密码不能为空");
			$(this).focus();
			return false;	
		} else if(newpass1!=newpass2){
			window.parent.showAlert("两次 密码输入不一致");
			$(this).focus();
			return false;
		} else if(!(/^[a-zA-Z0-9]+[a-zA-Z0-9_]*$/gi.test(newpass1)) || newpass1.length < 6 || newpass1.length > 18){
			window.parent.showAlert("新密码只能为6-18位的字母和数字");
			$(this).focus();
			return false;
		} else{
			  var url="${ctx}/system/user/checkoldpassword";
			  $.post(url,{"oldpassword":oldpass},function(data){
				  if(data.result){
					  $.post("${ctx}/system/user/updatepassword",{"newpassword1":newpass1},function(d){
						  if(d.result == 1) {
							  window.parent.showAlert(d.msg);
							  setTimeout("gohome()",5000);
						  }else {
							  window.parent.showAlert(d.msg);
						  }
					  });
				  }else{
					  window.parent.showAlert(data.msg);
					  return false;
				  }
			  });
		  }
	}
	
	function gohome() {
		window.parent.location.href="${ctx}";
	}
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" />&nbsp;修改密码
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>修改密码
			</div>
		</div>
		<div class="portlet-body form">
			<form id="inputForm" action="${ctx}/system/user/${action}" method="post" class="form-horizontal">
				<div class="control-group">
					<label for="user-password" class="control-label">旧密码:</label>
					<div class="controls">
						<input type="password" id="oldpassword" class="span m-wrap"
							style="height: 32px; width: 30%;" name="password"
							maxlength="20" /><span name="easyTip"></span>
					</div>
				</div>
				
				<div class="control-group">
					<label for="user-password" class="control-label">新密码:</label>
					<div class="controls">
						<input type="password" id="newpassword1" class="span m-wrap"
							style="height: 32px; width: 30%;" name="newpassword1"
							maxlength="20" />
					</div>
					<span style="color:red;display:none;" class="controls" id="passtip">6-18位字母和数字</span>
				</div>
				
				<div class="control-group">
					<label for="user-password" class="control-label">确认密码:</label>
					<div class="controls">
						<input type="password" id="newpassword2" class="span m-wrap"
							style="height: 32px; width: 30%;" name="newpassword2"
							maxlength="20" />
					</div>
				</div>
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" onclick="formsubmit()" value="提交" />&nbsp; 
					<input id="cancel_btn" class="btn" type="button" value="取消" onclick="gohome()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
