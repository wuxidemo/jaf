<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />

<html>
<head>
	<title>查看页面</title>
	<%@ include file="../quote.jsp"%>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/sbgl.png" style="vertical-align: text-bottom;" />&nbsp;查看页面
			</h3>
		</div>
	</div>
	
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption"><i class="icon-reorder"></i>
				查看页面
			</div>
		</div>
		<div class="portlet-body">
				<div class="portlet-body form">
					<form id="inputForm" action="" method="post" class="form-horizontal">
						
						<div class="control-group">
							<label class="control-label">页面id:</label>
							<div class="controls">
								<input type="text" id="page_id" name="page_id" disabled="disabled" class="span m-wrap" maxlength="6" style="width: 60%;" value="${page_id}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">商户名称:</label>
							<div class="controls">
								<input type="text" id="mername" name="mername" disabled="disabled"  class="span m-wrap" maxlength="6" style="width: 60%;" value="${mername}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">主标题:</label>
							<div class="controls">
								<input type="text" id="title" name="title" disabled="disabled"  class="span m-wrap" maxlength="6" style="width: 60%;" value="${title}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">副标题:</label>
							<div class="controls">
								<input type="text" id="description" name="description" disabled="disabled"  class="span m-wrap" maxlength="7" style="width: 60%;" value="${description}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">备注信息:</label>
							<div class="controls">
								<input type="text" id="comment" name="comment" disabled="disabled"  class="span m-wrap" maxlength="15" style="width: 60%;" value="${comment}"/>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">跳转链接:</label>
							<div class="controls">
								<input type="text" id="page_url" name="page_url" disabled="disabled"  class="span m-wrap" style="width: 60%;" value="${page_url}"/>
							</div>
						</div>
						
						
						<div class="control-group">
							<label class="control-label">封面图片</label>
							<div class="controls">
								<img alt="${title}" src="${icon_url}" width=120 height=120 />
							</div>
						</div>
						
						<div class="form-actions">
							<input id="cancel_btn" class="btn" type="button" value="返回" onclick="history.back()" />
						</div>
					</form>
				</div>
			</div>
		</div>
</body>
</html>
