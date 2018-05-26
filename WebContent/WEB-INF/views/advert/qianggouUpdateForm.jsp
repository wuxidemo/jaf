<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
	<title>抢购活动管理</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>
</head>

<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/timepicker.css" />
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/jquery.inputmask.bundle.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>

<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>



<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>

<script type="text/javascript">
	
	var ue = '';
	var todaydate = getFormatedToday();
	var lastdayofthismonth = getFormatedLastDayOfThisMonth();
	jQuery(document).ready(function() {
		
		var canedit = '${canedit}';
		if(canedit == '1') {
			initDate();	
		}
		
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
			}
		});
		
	    ue = UE.getEditor('container',{
		    toolbars: [
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
		    });
	    
	    wxyt({
			div : "coverpagediv" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议大小678x220)",
			maxsize : 4194304,
			sucess : function(download_url, fileid, url) {
				$("#imgurl").val(download_url);
				
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				$("#adimg").attr("src",download_url+'?imageView2/2/w/258/h/170/q/85');
				
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
		
		$("#startdate").val('${startdate}');
		$("#enddate").val('${enddate}');

		$("#ustime").val('${stime}');
		$("#uetime").val('${etime}');
		
	});
	
	function initDate() {
		if (jQuery().datepicker) {
			$('.date-picker').datepicker({
				rtl : App.isRTL()
			});
		}

		$('.timepicker-default').timepicker({
			showSeconds : false,
			showMeridian : false
		});
	}
	
	/*获取格式化的今天的日期*/
	function getFormatedToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		return year + "-" + month + "-" + dd;
	}

	/*获取格式化的本月的最后一天的日期*/
	function getFormatedLastDayOfThisMonth() {
		var current = new Date();
		var currentMonth = current.getMonth();
		var nextMonth = ++currentMonth;
		var nextMonthDayOne = new Date(current.getFullYear(), nextMonth, 1);
		var minusDate = 1000 * 60 * 60 * 24;
		var date = new Date(nextMonthDayOne.getTime() - minusDate);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (dd < 10) {
			dd = "0" + dd;
		}
		return year + "-" + month + "-" + dd;
	}
	
	function preview() {
		var imgurl = $("#imgurl").val();
		var startdate = $("#startdate").val();
		var stime = $("#ustime").val();
		var enddate = $("#enddate").val();
		var etime = $("#uetime").val();
		
		var paymoney = $("#paymoney").val();
		var amount = $("#amount").val();
		var title = $("#title").val();
		var subtitle = $("#subtitle").val();
		var buttontext = $("#buttontext").val();
		var cardid = $("#cardid").val();
		
		var uecontent = ue.getContent();
		
		if($.trim(imgurl) == '') {
			window.parent.showAlert("你没有上传抢购活动的展示图片");
			return false;
		}else if($.trim(startdate) == '') {
			window.parent.showAlert("你没有选择抢购活动的开始日期");
			return false;
		}else if($.trim(stime) == '') {
			window.parent.showAlert("你没有选择抢购活动的开始时间");
			return false;
		}else if($.trim(enddate) == '') {
			window.parent.showAlert("你没有选择抢购活动的结束日期");
			return false;
		}else if($.trim(etime) == '') {
			window.parent.showAlert("你没有选择抢购活动的结束时间");
			return false;
		}else if(startdate > enddate) {
			window.parent.showAlert("结束时间不能早于开始时间");
			return false;
		}else if(startdate == enddate && stime > etime) {
			window.parent.showAlert("结束时间不能早于开始时间");
			return false;
		}else if($.trim(paymoney) == '') {
			window.parent.showAlert("你没有填写抢购活动的支付金额");
			return false;
		}else if(!paymoney.trim().match(/^[0-9]+([.][0-9]{1,2})?$/)) {
			window.parent.showAlert("抢购活动的支付金额数目只能是数字，且小数部分不能超过两位");
			return false;
		}else if (parseFloat(paymoney.trim()) < 0.01) {
			window.parent.showAlert("抢购活动的支付金额数目只能是大于0.01的数字");
			return false;
		}else if($.trim(amount) == '') {
			window.parent.showAlert("你没有选择抢购活动的总次数");
			return false;
		}else if(!isInt(amount)) {
			window.parent.showAlert("抢购活动的总次数必须是个整数");
			return false;
		}else if($.trim(title) == '') {
			window.parent.showAlert("你没有填写抢购活动的标题");
			return false;
		}
		
		/* if($.trim(subtitle) == '') {
			window.parent.showAlert("你没有填写抢购活动的副标题");
			return false;
		} */
		
		else if($.trim(buttontext) == '') {
			window.parent.showAlert("你没有填写抢购活动按钮名称");
			return false;
		}
		
		if($.trim(cardid) == '0') {
			window.parent.showAlert("你没有选择活动卡券");
			return false;
		}
		
		if($.trim(uecontent) == '') {
			window.parent.showAlert("你没有设置活动详情");
			return false;
		}
		
		else {
			var preurl = '${ctx}/tmpart/viewqrcode';
			$.post(preurl,{"title":title,"subtitle":subtitle,"content":uecontent,"btnname":buttontext},function(data){
				if(data != '') {
					$("#preimg").attr("src","data:image/jpg;base64,"+data);
					$("#preimg").css("height","200px");
					$("#preimg").css("width","200px");
					$("#prediv").css("display","block");
				}
				window.parent.iFrameHeight();
				window.parent.scrollTo(0,2000); 
			});
		}
	}
	
	function formsubmit() {
		
		var imgurl = $("#imgurl").val();
		var startdate = $("#startdate").val();
		var stime = $("#ustime").val();
		var enddate = $("#enddate").val();
		var etime = $("#uetime").val();
		
		var paymoney = $("#paymoney").val();
		var amount = $("#amount").val();
		var title = $("#title").val();
		var subtitle = $("#subtitle").val();
		var buttontext = $("#buttontext");
		var cardid = $("#cardid").val();
		
		var uecontent = ue.getContent();
		
		if($.trim(imgurl) == '') {
			window.parent.showAlert("你没有上传抢购活动的展示图片");
			return false;
		}
		
		if($.trim(startdate) == '') {
			window.parent.showAlert("你没有选择抢购活动的开始日期");
			return false;
		}
		
		if($.trim(stime) == '') {
			window.parent.showAlert("你没有选择抢购活动的开始时间");
			return false;
		}
		
		if($.trim(enddate) == '') {
			window.parent.showAlert("你没有选择抢购活动的结束日期");
			return false;
		}
		
		if($.trim(etime) == '') {
			window.parent.showAlert("你没有选择抢购活动的结束时间");
			return false;
		}
		
		if(startdate > enddate) {
			window.parent.showAlert("结束时间不能早于开始时间");
			return false;
		}
		
		if(startdate == enddate && stime > etime) {
			window.parent.showAlert("结束时间不能早于开始时间");
			return false;
		}
		
		if($.trim(paymoney) == '') {
			window.parent.showAlert("你没有选择抢购活动的支付金额");
			return false;
		}
		
		if(!paymoney.trim().match(/^[0-9]+([.][0-9]{1,2})?$/)) {
			window.parent.showAlert("抢购活动的支付金额数目只能是数字，且小数部分不能超过两位");
			return false;
		}
		
		if (parseFloat(paymoney.trim()) < 0.01) {
			window.parent.showAlert("抢购活动的支付金额数目只能是大于0.01的数字");
			return false;
		}
		
		if($.trim(amount) == '') {
			window.parent.showAlert("你没有选择抢购活动的总次数");
			return false;
		}
		
		if(!isInt(amount)) {
			window.parent.showAlert("抢购活动的总次数必须是个整数");
			return false;
		}
		
		if($.trim(title) == '') {
			window.parent.showAlert("你没有填写抢购活动的标题");
			return false;
		}
		
		/* if($.trim(subtitle) == '') {
			window.parent.showAlert("你没有填写抢购活动的副标题");
			return false;
		} */
		
		if($.trim(buttontext) == '') {
			window.parent.showAlert("你没有填写抢购活动按钮名称");
			return false;
		}
		
		if($.trim(cardid) == '0') {
			window.parent.showAlert("你没有选择活动卡券");
			return false;
		}
		
		if($.trim(uecontent) == '') {
			window.parent.showAlert("你没有设置活动详情");
			return false;
		}
		
		$("#inputForm").submit();
		
	}
	
	function isInt(num) {
		var reg = new RegExp("^[1-9][0-9]*$");
		return reg.test(num);
	}
	
	
</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				修改抢购活动
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>修改抢购活动
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/advert/savaupdateqg" id="inputForm" class="form-horizontal" method="post">
			
				<input type="hidden" id="id" name="id" value="${sqg.id}" />
				<input type="hidden" id="position" name="position" value="${sqg.position}" />
				<input type="hidden" id="imgurl" name="imgurl" value="${sqg.imgurl}" />
				
				<div class="control-group">
					<label for="fileToUploadintro" class="control-label"><span style="color:red">*</span>&nbsp;活动封面图:</label>
					<div class="controls" id="coverpagediv"></div>
				</div>
				
				<div class="control-group" id="imgfacediv">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						<img src="${sqg.imgurl}" id="adimg"  style="width:300px;height:200px;"  />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;活动开始时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="startdate"
								name="startdate" readonly size="16" type="text"
								style="height: 34px; cursor: pointer;" value="${startdate}" 
								 /><span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="input-append bootstrap-timepicker-component">

							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="ustime" name="stime" value="${stime }" 
								/> <span class="add-on"><i
								class="icon-time"></i></span>

						</div>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;活动结束时间:</label>
					<div class="controls">
						<div class="input-append date date-picker" data-date=""
							data-date-format="yyyy-mm-dd" data-date-viewmode="years">
							<input class="m-wrap m-ctrl-medium date-picker" id="enddate"
								name="enddate" readonly size="16" type="text"
								style="height: 34px; cursor: pointer;" value="${enddate }" 
								/><span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<div class="input-append bootstrap-timepicker-component">
							<input style="height: 34px; width: 207px; text-align: left;"
								readonly="readonly"
								class="m-wrap m-ctrl-small timepicker-default add-on"
								type="text" id="uetime" name="etime" value="${etime }" 
								 /> <span class="add-on"><i
								class="icon-time"></i></span>
						</div>
					</div>
				</div>
				
			
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;支付金额:</label>
					<div class="controls">
						<input type="text" id="paymoney" class="span3 m-wrap" style="width: 60%;" name="paymoney2" value="${sqg.paymoney/100.0 }" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;商品总数:</label>
					<div class="controls">
						<input type="text" id="amount" class="span3 m-wrap" style="width: 60%;" name="amount" value="${sqg.amount }" maxlength="10" <c:if test="${canedit ==0 }">disabled="disabled"</c:if> >
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;标题:</label>
					<div class="controls">
						<input type="text" id="title" class="span3 m-wrap" style="width: 60%;" name="title" value="${sqg.title }" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;副标题:</label>
					<div class="controls">
						<input type="text" id="subtitle" class="span3 m-wrap" style="width: 60%;" name="subtitle" value="${sqg.subtitle }" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;抢购按钮名:</label>
					<div class="controls">
						<input type="text" id="buttontext" class="span3 m-wrap" style="width: 60%;" name="buttontext" value="${sqg.buttontext }" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">卡券编号:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="cardid" style="width: 60%;" name="cardid" <c:if test="${canedit ==0 }">disabled="disabled"</c:if> >
							<option value="0">--选择卡券--</option>
							<c:forEach items="${cardlist}" var="card">
								<option value="${card.id}" <c:if test="${card.id == sqg.cardid }">selected="selected"</c:if> >${card.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group" >
					<label class="control-label"><span style="color:red">*</span>&nbsp;详情:</label>
					<div class="controls">
						<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${sqg.content }</script>
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
					<input id="submit_btn" class="btn green" type="button" value="预览" onclick="preview()" />&nbsp; 
					<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
				    <a id="cancel_btn" class="btn grey" type="button" href="${ctx}/advert/goback">取消</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>