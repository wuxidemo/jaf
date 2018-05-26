<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
	<title>查看抢购活动</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
</head>

<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/timepicker.css" />
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.inputmask.bundle.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		var title = '${sqg.title}';
		var subtitle = '${sqg.subtitle}';
		var content = '${sqg.content}';
		var buttontext = '${sqg.buttontext}';
		var preurl = '${ctx}/tmpart/viewqrcode';
		$.post(preurl,{"title":title,"subtitle":subtitle,"content":content,"btnname":buttontext},function(data){
			if(data != '') {
				$("#preimg").attr("src","data:image/jpg;base64,"+data);
				$("#preimg").css("height","200px");
				$("#preimg").css("width","200px");
				$("#prediv").css("display","block");
			}
			window.parent.iFrameHeight();
		});
	});

</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				查看抢购活动
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>查看抢购活动
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/advert/savequickbuy" id="inputForm" class="form-horizontal" method="post">
			
				<div class="control-group" id="imgfacediv">
					<label class="control-label">&nbsp;活动封面图:</label>
					<div class="controls">
						<img src="${sqg.imgurl }" id="adimg"  style="width:300px;height:200px;" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">活动开始时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="startdate"
								name="startdate" readonly size="16" type="text"
								style="height: 34px; cursor: pointer;" value="${startdate}" 
								<c:if test="${sqg.state !=1 }">disabled="disabled"</c:if> /><span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
						&nbsp;&nbsp;到&nbsp;&nbsp;
						<div class="input-append bootstrap-timepicker-component">

							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="ustime" name="stime" value="${stime }" 
								<c:if test="${sqg.state !=1 }">disabled="disabled"</c:if> /> <span class="add-on"><i
								class="icon-time"></i></span>

						</div>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">活动结束时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="enddate"
								name="enddate" readonly size="16" type="text"
								style="height: 34px; cursor: pointer;" value="${enddate }" 
								disabled="disabled"/><span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
						&nbsp;&nbsp;到&nbsp;&nbsp;
						<div class="input-append bootstrap-timepicker-component">
							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="uetime" name="etime" value="${etime }" 
								disabled="disabled" /> <span class="add-on"><i
								class="icon-time"></i></span>
						</div>
					</div>
				</div>
				
			
				<div class="control-group">
					<label class="control-label">&nbsp;支付金额:</label>
					<div class="controls">
						<input type="text" id="paymoney" class="span3 m-wrap" style="width: 40%;" name="paymoney" disabled="disabled" value="${sqg.paymoney/100.0 }" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;商品总数:</label>
					<div class="controls">
						<input type="text" id="amount" class="span3 m-wrap" style="width: 40%;" name="amount" disabled="disabled" value="${sqg.amount }" maxlength="10" >
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 40%;" name="title" disabled="disabled" value="${sqg.title }" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;副标题:</label>
					<div class="controls">
						<input type="text" id="subtitle" class="span3 m-wrap" style="width: 40%;" name="subtitle" disabled="disabled" value="${sqg.subtitle }" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;抢购按钮名:</label>
					<div class="controls">
						<input type="text" id="buttontext" class="span3 m-wrap" style="width: 40%;" name="buttontext" disabled="disabled" value="${sqg.buttontext }" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">卡券编号:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="cardid" style="width: 40%;" name="cardid" disabled="disabled" >
							<option value="0">--选择卡券--</option>
							<c:forEach items="${cardlist}" var="card">
								<option value="${card.id}" <c:if test="${card.id == sqg.cardid }">selected="selected"</c:if> >${card.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group" >
					<label class="control-label">&nbsp;详情:</label>
					<div class="controls" style="margin-top:8px;width:40%;">
						${sqg.content }
					</div>
				</div>
				
				<br />
				
				<div class="control-group" id="prediv" style="display:none;">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						<img alt="" src="" id="preimg">
						<span>（扫此二维码可在手机端预览效果）</span>
					</div>
				</div>
				
				<div class="form-actions">
					<a id="edit_btn" class="btn blue" type="button" href="${ctx}/advert/updateqianggou/${sqg.id}" >编辑</a>
				    <a id="cancel_btn" class="btn grey" type="button" href="${ctx}/advert/goback" >返回</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>