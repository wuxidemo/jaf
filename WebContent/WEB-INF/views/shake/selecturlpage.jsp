<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>选择页面url</title>
<%@ include file="../quote.jsp"%>
</head>
<script>
	function copytext(artid) {
		$("#url"+artid).select(); // 选择对象
		document.execCommand("Copy"); // 执行浏览器复制命令
		alert("已复制好，可贴粘。");
	}

</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/sbgl.png" style="vertical-align: text-bottom;" /> 选择页面url
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-body">
			<table id="contentTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 5%;">序号</th>
						<th style="width: 25%;">标题</th>
						<th style="width: 10%">详情(点击链接可查看)</th>
						<th style="width: 40%">访问链接</th>
						<th style="width: 20%;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(artList)!=0}">
						<c:forEach items="${artList}" var="article" varStatus="status">
							<tr>
								<td style="vertical-align: middle;">${status.count}</td>
								<td style="vertical-align: middle;">${article.title}</td>
								<td style="vertical-align: middle;"><a href="${ctx}/shake/viewactivitydetail?artid=${article.id}" target="_blank">点击查看</a></td>
								<td style="vertical-align: middle;"><input text="text" id="url${article.id}" value="${article.url}" style="width:80%; background-color: transparent;border-width: 0; "/></td>
								<td style="vertical-align: middle;"><a href="javascript:;" onclick="copytext('${article.id}')" id="${article.id}" class="btn blue hello">点击复制链接</a><span style="color:red;">&nbsp;(如果没有效果，请手动复制！)</span></td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(artList)==0}">
						<tr class="odd gradeX">
							<td colspan="7" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>