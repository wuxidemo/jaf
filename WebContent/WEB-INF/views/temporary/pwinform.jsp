<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>人气值活动</title>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
</head>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png"
					style="vertical-align: text-bottom;" />人气值活动
			</h3>
		</div>
	</div>

	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>
			</div>
		</div>
		<div class="portlet-body">

			<form action="" id="inputForm" class="form-horizontal" method="post"
				style="margin: 0px;">



				<div class="control-group">
					<label class="control-label">一等奖:</label>
					<div class="controls">
						<c:if test="${p1!=null}">
							<c:if test="${p1.state==null }">
								<a href="javascript:void(0);" onclick="send1(${p1.id})"
									id="cja1" class="btn blue">发送通知</a>
							</c:if>
							<c:if test="${p1.state!=null }">已发送</c:if>
						</c:if>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<table id="contentTable"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>昵称</th>
									<th>编号</th>
									<th>分数</th>
								</tr>
							</thead>
							<tbody id="jp1">
								<c:if test="${p1!=null}">
									<tr>
										<td>${p1.name}</td>
										<td>${p1.openid}</td>
										<td>${p1.totalscore}</td>
									</tr>
								</c:if>
								<c:if test="${p1==null}">
									<tr class="odd gradeX">
										<td colspan="3" style="text-align: center;">无记录</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">二等奖:</label>
					<div class="controls">
						<c:if test="${p2!=null}">

							<c:if test="${p2.state==null}">
								<a href="javascript:void(0);" onclick="send2(${p2.id})"
									id="cja1" class="btn blue">发送通知</a>
							</c:if>
							<c:if test="${p2.state!=null}">已发送</c:if>
						</c:if>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<table id="contentTable"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>昵称</th>
									<th>编号</th>
									<th>分数</th>
								</tr>
							</thead>
							<tbody id="jp2">
								<c:if test="${p2!=null}">
									<tr>
										<td>${p2.name}</td>
										<td>${p2.openid}</td>
										<td>${p2.totalscore}</td>
									</tr>
								</c:if>
								<c:if test="${p2==null}">
									<tr class="odd gradeX">
										<td colspan="3" style="text-align: center;">无记录</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>



				<div class="control-group">
					<label class="control-label">三等奖:</label>
					<div class="controls">
						<c:if test="${count1000>0}">
							<a href="javascript:void(0);" onclick="send3()" id="cja1"
								class="btn blue">发送通知</a>
						</c:if>

					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<c:if test="${count1000>0}">总共${count1000}条记录符合条件.</c:if>
						<c:if test="${count1000<=0}">暂无记录符合条件.</c:if>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">四等奖:</label>
					<div class="controls">
						<c:if test="${count>0}">
							<a href="javascript:void(0);" onclick="send4()" id="cja1"
								class="btn blue">发送通知</a>
						</c:if>

					</div>
				</div>
				<div class="control-group">
					<label class="control-label"></label>
					<div class="controls">
						<c:if test="${count>0}">总共${count}条记录符合条件.</c:if>
						<c:if test="${count<=0}">暂无记录符合条件.</c:if>
					</div>
				</div>

			</form>
		</div>
	</div>

</body>
<script type="text/javascript">
	function send1(id)
	{
		$.post("${ctx}/popularity/sendwin?sort=1&id="+id,function(d){
			if(d=="1")
				{
					window.parent.showAlert("操作成功");
					 location.reload(true);
				}
		});
	}
	function send2(id)
	{
		$.post("${ctx}/popularity/sendwin?sort=2&id="+id,function(d){
			if(d=="1")
				{
					window.parent.showAlert("操作成功");
					 location.reload(true);
				}
		});
	}
	function send3()
	{
		$.post("${ctx}/popularity/sendwin?sort=3",function(d){
			if(d=="1")
				{
					window.parent.showAlert("操作成功");
					 location.reload(true);
				}
		});
	}
	function send4()
	{
		$.post("${ctx}/popularity/sendwin?sort=4",function(d){
			if(d=="1")
				{
					window.parent.showAlert("操作成功");
					 location.reload(true);
				}
		});
	}
</script>
</html>