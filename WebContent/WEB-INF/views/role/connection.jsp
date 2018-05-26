<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${ctx}/static/mt/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="${ctx}/static/mt/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	
	<link rel="stylesheet" href="${ctx}/static/mt/media/css/DT_bootstrap.css" />
</head>
<body>

	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> <a href="${ctx}/system/role">角色资源分配管理</a>
			</h3>
		</div>
	</div>

	<div class="row-fluid">

		<div class="span6">

			<div class="portlet box green">

				<div class="portlet-title">

					<div class="caption"><i class="icon-cogs"></i>已经获得权限的资源</div>

				</div>

				<div class="portlet-body">

					<table class="table table-hover">

						<thead>

							<tr>

								<th style="width:10%">资源编号</th>

								<th style="width:20%">资源名称</th>

								<th style="width:40%">资源链接</th>
								
								<th style="width:20%">父级资源</th>

								<th style="width:10%" >移除权限</th>

							</tr>

						</thead>

						<tbody id="selfRes">
							<c:forEach items="${hasList}" var="has">
								<tr id="res${has.id}">
	
									<td>${has.id}</td>
	
									<td>${has.name}</td>
	
									<td>${has.url}</td>
									
									<td><c:if test="${has.resource.name != null}"> ${has.resource.name}</c:if></td>
	
									<td style="text-align: right"><a href="javascript:;" onclick="removeRes(${has.id})"><i class="m-icon-swapright m-icon-red"></i></a></td>
	
								</tr>
							</c:forEach>

						</tbody>

					</table>

				</div>

			</div>

			<!-- END SAMPLE TABLE PORTLET-->

		</div>

		<div class="span6">

			<div class="portlet box red">

				<div class="portlet-title">

					<div class="caption"><i class="icon-coffee"></i>还未获得权限的资源</div>

				</div>

				<div class="portlet-body">

					<!-- <table class="table table-bordered table-hover"> -->
					<table class="table table-hover">

						<thead>

							<tr>
							
								<th style="width:10%">加入权限</th>
	
								<th style="width:10%">资源编号</th>

								<th style="width:20%">资源名称</th>

								<th style="width:40%">资源链接</th>
								
								<th style="width:20%">父级资源</th>

							</tr>

						</thead>

						<tbody id="otherRes">

							<c:forEach items="${hasnotList}" var="hasnot">
								<tr id="res${hasnot.id}">
									
									<td><a href="javascript:;" onclick="addRes(${hasnot.id})"><i class="m-icon-swapleft m-icon-red"></i></a></td>
	
									<td>${hasnot.id}</td>
	
									<td>${hasnot.name}</td>
	
									<td>${hasnot.url}</td>
									
									<td><c:if test="${hasnot.resource.name != null}">${hasnot.resource.name}</c:if></td>
	
								</tr>
							</c:forEach>

						</tbody>

					</table>

				</div>

			</div>

		</div>

	</div>
	
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="${ctx}/static/mt/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="${ctx}/static/mt/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="${ctx}/static/mt/media/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>

	<script src="${ctx}/static/mt/media/js/excanvas.min.js"></script>

	<script src="${ctx}/static/mt/media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="${ctx}/static/mt/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="${ctx}/static/mt/media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="${ctx}/static/mt/media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="${ctx}/static/mt/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<script src="${ctx}/static/mt/media/js/app.js"></script>      

	<script>

		jQuery(document).ready(function() {     
			
			window.parent.scroll(0,0);

		   App.init();
		   
		});
		
		var roleId="${roleId}";
		function removeRes(resId){
			var trId="#res"+resId;
			$.post("${ctx}/system/resource/removeRes",
					{"roleId":roleId,"resId":resId},
					function(data){	
						if(data.result=="1"){
							$(trId).remove();
							var res=data.res;
							var parName = res.resource;
							if(parName == null || parName == '') {
								parName = '&nbsp;';
							}else{
								parName = parName.name;
							}
							var tr="<tr id=\"res"+res.id+"\">";
							tr+="<td><a href=\"javascript:;\" onclick=\"addRes("+res.id+")\"><i class=\"m-icon-swapleft m-icon-red\"></i></a></td>";
							tr+="<td>"+res.id+"</td>";
							tr+="<td>"+res.name +"</td>";
							tr+="<td>"+res.url+"</td>";
							tr+="<td>"+parName+"</td>";
							tr+="</tr>";
							$("#otherRes").append(tr);		
						}
					});
		
		}
		
		function addRes(resId){
			var trId="#res"+resId;
			$.post("${ctx}/system/resource/addRes",
					{"roleId":roleId,"resId":resId},
					function(data){	
						if(data.result=="1"){
							$(trId).remove();
							var res=data.res;
							var parName = res.resource;
							if(parName == null || parName == '') {
								parName = '&nbsp;';
							}else{
								parName = parName.name;
							}
							var tr="<tr id=\"res"+res.id+"\" >";
							tr+="<td>"+res.id +"</td>";
							tr+="<td>"+res.name +"</td>";
							tr+="<td>"+res.url +"</td>";
							tr+="<td>"+parName +"</td>";
							tr+="<td style=\"text-align: right;\"><a href=\"javascript:;\" onclick=\"removeRes("+res.id+")\"><i class=\"m-icon-swapright m-icon-red\"></i></a></td>";
							tr+="</tr>";
							$("#selfRes").append(tr);	
						}
					});
		}
		
		
	</script>
</body>
</html>