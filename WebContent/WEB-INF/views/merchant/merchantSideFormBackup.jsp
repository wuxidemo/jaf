<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>商户管理-新增/修改商户信息</title>
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

	var ue = '';
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
			 thumb:"?imageView2/2/w/300"
		    });
	    
	    wxyt({
			div : "introup" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸187*135)",
			maxsize : 1048576,
			sucess : function(download_url, fileid, url) {
				$("#introduceurl").val(download_url);
				$("#thumbnailurl").val(download_url+'?imageView2/2/w/258/h/170/q/85');
				
				$("#introimg").attr("src",download_url);
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
	 
	 	wxyt({
			div : "detailup",
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸720*312)",
			maxsize : 1048576,
			sucess : function(download_url, fileid, url) {
				$("#detailurl").val(download_url);
				
				$("#detailimg").attr("src",download_url);
				$("#detailimg").css("width","400px");
				$("#detailimg").css("height","250px");
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
		 
		 
		 var disid = $("#district").val();
		 if(disid == '-1') {
			 $("#businessid").empty();
			 $("#businessid").append('<option value="-1">--选择商圈--</option>');
		 }else{
			 var busiurl = "${ctx}/business/getbusinessbydisid";
			 $.post(busiurl,{"disid":disid},function(data){
				 var htmlstr = '';
				 if(data != null && data.length > 0) {
					 $("#businessid").empty();
					 for(var i=0;i<data.length;i++) {
						 htmlstr += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
					 }
					 $("#businessid").html(htmlstr);
					 $("#businessid").val("${merchant.business.id}");
				 }else{
					 $(businessid).html(htmlstr);
				 }
			 });
		 }
		 
		 $("#district").change(function(){
			var distid = $(this).val();
			if(distid == '-1') {
				$("#businessid").empty();
				$("#businessid").append('<option value="-1">--选择商圈--</option>');
			}else{
				var busurl = "${ctx}/business/getbusinessbydisid";
				$.post(busurl,{"disid":distid},function(data){
					var htmlstrchange = '';
					if(data != null && data.length > 0) {
						$("#businessid").empty();
						for(var i=0;i<data.length;i++) {
							htmlstrchange += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
						}
						$("#businessid").html(htmlstrchange);
					}else{
						$("#businessid").html(htmlstrchange);
					}
				});
			}
			
		});
		 
		 var pclaid = '${merchant.pclassify}';
		 var cateid = '${merchant.classify}';
		 if(pclaid == '' || pclaid == '-1') {
			 $("#categorysub").html('<option value="-1">--选择子类目--</option>');
		 }else{
			 $("#categorysup").val(pclaid);
			 var suburl = '${ctx}/classify/getsubbypid';
			 $.post(suburl,{"pid":pclaid}, function(data){
				 var classhtml = '<option value="-1">--选择子类目--</option>';
				 if(data.result == '1') {
					 for(var i=0;i<data.data.length;i++) {
						 classhtml += '<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
					 }
				 }
				 $("#categorysub").html(classhtml);
				 $("#categorysub").val(cateid);
			 });
		 }
		 
		 $("#categorysup").change(function(){
			 $("#categorysub").empty();
			 var pid = $(this).val();
			 
			 if(pid == '-1') {
				 $("#categorysub").html('<option value="-1">--选择子类目--</option>');
			 }else{
				 var changeurl = '${ctx}/classify/getsubbypid';
				 $.post(changeurl,{"pid":pid}, function(data){
					 var subchangehtml = '<option value="-1">--选择子类目--</option>';
					 if(data.result == '1') {
						 for(var i=0;i<data.data.length;i++) {
							 subchangehtml += '<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
						 }
					 }
					 $("#categorysub").html(subchangehtml);
				 });
			 }
		 });
		 
		 $("#bankaccount").on("focus", function(){
				$("#bankspan").css("display","");
		 });
		 
		 $("#bankaccount").on("blur", function(){
				$("#bankspan").css("display","none");
		 });
		 
		 
		 var action = "${action}"; 
		 if(action == 'mersideupdate') {
			/* $("#thumbimg").attr("src","${ctx}/${merchant.thumbnailurl}");
			$("#thumbface").css("display",""); */
			
			var intrurl = '${merchant.introduceurl}';
			var deurl = '${merchant.detailurl}';
			var qrurl = '${merchant.qrurl}';
			
			if(intrurl != '') {
				if(intrurl.indexOf("http://") >=0) {
					$("#introimg").attr("src","${merchant.introduceurl}");
				}else{
					$("#introimg").attr("src","${ctx}/${merchant.introduceurl}");
				}
				$("#introimg").css("width","400px");
				$("#introimg").css("height","250px");
			}
			
			if(deurl != '') {
				if(deurl.indexOf("http://") >=0) {
					$("#detailimg").attr("src","${merchant.detailurl}");
				}else{
					$("#detailimg").attr("src","${ctx}/${merchant.detailurl}");
				}
				$("#detailimg").css("width","400px");
				$("#detailimg").css("height","250px");
			}
			
			if(qrurl != '') {
				$("#qrurlimg").attr("src","${merchant.qrurl}");
				$("#qrcodeurl").css("display","");
			}else{
				$("#qrdownbtn").css("display","none");
			}
				
		 }
		 
		 ue.addListener('contentChange',function(e){
			 window.parent.parent.iFrameHeight();
		 });
		 
		 var message = '${message}';
		 if($.trim(message).length > 0) {
			 window.parent.showAlert(message);
		 }
		 
	});
	
	function downqrurl(merid) {
		window.location.href="${ctx}/merchant/downqr/"+merid;
	}
	
	var comm = '${merchant.community}';
	
	function formsubmit() {
		
		var name = $("#name").val();
		var ownername = $("#ownername").val();
		var email = $("#email").val();
		//var category = $("#category").val();
		
		var categorysup = $("#categorysup").val();
		var categorysub = $("#categorysub").val();
		
		var district = $("#district").val();
		var business = $("#businessid").val();
		var telephone = $("#telephone").val();
		var address = $("#address").val();
		var bankaccount = $("#bankaccount").val();
		var onecost = $("#onecost").val();
		
		var keystr = '';
		$("input:checkbox[name='keywords']").each(function(){
			var thisval = $(this).prop("checked");
			if(thisval) {
				keystr += ","+ $(this).val();
			}
		});
		var keywords = keystr.substring(1);
		
		var mercomm = '${merchant.community}';
		var commval = $("#community").val();
		
		var thumbnailurl = $("#thumbnailurl").val();
		var detailurl = $("#detailurl").val();
		
		var uecontent = ue.getContent();
		
		if($.trim(name) == '') {
			window.parent.showAlert("商户名称不能为空！");
			$(this).focus();
			return false;
		}else if($.trim(name) == '') {
			window.parent.showAlert("店家姓名不能为空！");
			$(this).focus();
			return false;
		}else if($.trim(name) == '') {
			window.parent.showAlert("商户邮箱不能为空！");
			$(this).focus();
			return false;
		}else if(email.search(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/) == -1) {
			window.parent.showAlert("商户邮箱格式不对！");
			$(this).focus();
			return false;
		}else if($.trim(categorysup) =='-1') {
			window.parent.showAlert("你没有选择商户的主分类！");
			$(this).focus();
			return false;
		}else if($.trim(categorysub) =='-1') {
			window.parent.showAlert("你没有选择商户的二级分类！");
			$(this).focus();
			return false;
		}else if($.trim(district) =='-1') {
			window.parent.showAlert("你没有选择商户所在的行政区域！");
			$(this).focus();
			return false;
		}else if($.trim(business) =='') {
			window.parent.showAlert("你没有选择商户所属的商圈！");
			$(this).focus();
			return false;
		}else if($.trim(telephone) == '') {
			window.parent.showAlert("商户联系电话不能为空！");
			$(this).focus();
			return false;
		}else if(telephone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1
					&& telephone.search(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/) == -1) {
			window.parent.showAlert("商户联系电话格式不对！");
			$(this).focus();
			return false;
		}else if($.trim(address) == '') {
			window.parent.showAlert("商户的详细地址不能为空！");
			$(this).focus();
			return false;
		}else if($.trim(bankaccount) == '') {
			window.parent.showAlert("你没有填写商户预留的银行卡账号！");
			$(this).focus();
			return false;
		}else if(bankaccount.search(/^(\d{16}|\d{19})$/) == -1) {
			window.parent.showAlert("银行卡账号应该为16位或者19位！");
			$(this).focus();
			return false;
		}else if(comm == ''&& $.trim(onecost) == '') {
			window.parent.showAlert("你没有填写商户的人均消费金额！");
			$(this).focus();
			return false;
		}else if($.trim(onecost) == '' && onecost.search(/^\d+(\.\d+)?$/) == -1) {
			window.parent.showAlert("人均消费金额应该为数字");
			$(this).focus();
			return false;
		}else if($.trim(keywords) == '') {
			window.parent.showAlert("商户关键字没有填写");
			$(this).focus();
			return false;
		}else if($.trim(mercomm) != '' && commval == '-1') {
			window.parent.showAlert("你没有选择社区");
			$(this).focus();
			return false;
		}else if($.trim(thumbnailurl) == '') {
			window.parent.showAlert("你没有上传缩略图！");
			$(this).focus();
			return false;
		}else if($.trim(detailurl) == '') {
			window.parent.showAlert("你没有上传商户详情图！");
			$(this).focus();
			return false;
		}else if(uecontent == null || $.trim(uecontent) =='') {
			window.parent.showAlert("你没有填写商户的详情介绍！");
			$(this).focus();
			return false;
		}
		
		$("#inputForm").submit();
	}
	
	
	function getFileSize(sourceId) {
 		return	document.getElementById(sourceId).files.item(0).size;
 	}	 
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				&nbsp;商户信息   
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>商户信息
			</div>
		</div>
		<div class="portlet-body form" style="min-height: 1500px;height: auto;">
			<form action="${ctx}/merchant/${action}" id="inputForm" class="form-horizontal" method="post">

				<input type="hidden" name="id" value="${merchant.id}" /> 
				<input type="hidden" name="thumbnailurl" id="thumbnailurl" value="${merchant.thumbnailurl}" /> 
				<input type="hidden" name="introduceurl" id="introduceurl" value="${merchant.introduceurl}" /> 
				<input type="hidden" name="detailurl" id="detailurl" value="${merchant.detailurl}" /> 
						
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>商家名称:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="name" value="${merchant.name}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>姓名:</label>
					<div class="controls">
						<input type="text" id="ownername" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="ownername" value="${merchant.ownername}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>邮箱:</label>
					<div class="controls">
						<input type="text" id="email" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="email" value="${merchant.email}" maxlength="30">
					</div>
				</div>
				
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>分类:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="categorysup" name="pclassify" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if>>
							<option value="-1">--选择分类--</option>
							<c:forEach items="${pclassify}" var="pclass">
								<option value="${pclass.id }">${pclass.name}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select class="span2 m-wrap required" id="categorysub" name="classify" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if>>
							
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>区域:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="district" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if>>
							<c:choose>
								<c:when test="${districtid == '-1' || districtid == ''}">
									<option value="-1" selected="selected">--选择区域--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择区域--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${districtlist}" var="dis">
								<c:choose>
									<c:when test="${dis.id == districtid}">
										<option value="${dis.id }" selected="selected">${dis.value}</option>
									</c:when>
									<c:otherwise>
										<option value="${dis.id }">${dis.value}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>商圈:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="businessid" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="business.id">
							<c:choose>
								<c:when test="${merchant.business.id == null || merchant.business.id == '-1' || merchant.business.id == ''}">
									<option value="-1" selected="selected">--选择商圈--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择商圈--</option>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>电话:</label>
					<div class="controls">
						<input type="text" id="telephone" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="telephone" value="${merchant.telephone}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>地址:</label>
					<div class="controls">
						<input type="text" id="address" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="address" value="${merchant.address}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>银行卡号:</label>
					<div class="controls">
						<input type="text" id="bankaccount" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="bankaccount" value="${merchant.bankaccount}" maxlength="30">
					</div>
					<span style="color:red;display:none;" class="controls" id="bankspan">银行卡用于交易结算，请准确核对！</span>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' && merchant.community == null }"><span style="color:red">*</span>&nbsp;</c:if>人均消费:</label>
					<div class="controls">
						<input type="text" id="onecost" class="span3 m-wrap" style="width: 40%;" <c:if test="${action == 'view' }">disabled="disabled"</c:if> name="onecost" value="${merchant.onecost}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>关键字：</label>
					<div class="controls">
						
						<table class="" style="font-size:16px !important;width:40%;">
							 <c:forEach items="${keywordlist}" var="keyword" varStatus="keyindex">
							 	<c:if test="${keyindex.count%4 == 1 }">
							 		<tr style="height:40px;">
							 	</c:if>
						 		<td style="width:25%;text-align:left !important;">
						 			<input type="checkbox" name="keywords" value="${keyword.value}" <c:if test="${fn:indexOf(merchant.keywords,keyword.value) >=0 }">checked="checked"</c:if> <c:if test="${action == 'view' }">disabled="disabled"</c:if> />
						 			<span>${keyword.value}</span>
						 		</td>
							 	<c:if test="${keyindex.count%4 == 0 }"></tr></c:if>
							 	<c:set var = "keyindex_count" value = "${keyindex.count}" /> 
							</c:forEach>
							
							<c:if test = "${keyindex_count%4==1}"> 
								 <td style="width:25%;"></td> 
								 <td style="width:25%;"></td>
								 <td style="width:25%;"></td>  
							 	</tr > 
							 </c:if > 
							 <c:if test = "${keyindex_count%4==2}"> 
							 	<td style="width:25%;"></td>
							 	<td style="width:25%;"></td>  
							 	</tr> 
							 </c:if>
							 <c:if test = "${keyindex_count%4==3}"> 
							 	<td style="width:25%;"></td> 
							 	</tr> 
							 </c:if>
						</table>
					</div>
				</div>
				
				<div class="control-group" id="commdiv" <c:if test="${merchant.community == null}">style="display:none;" disabled="disabled"</c:if>>
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>社区:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="community" <c:if test="${action == 'view' }">disabled="disabled"</c:if> style="width: 40%;" name="community">
							<c:choose>
								<c:when test="${merchant.community == null || merchant.community == '-1' || merchant.community == ''}">
									<option value="-1" selected="selected">--请选择社区--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--请选择社区--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${communitys}" var="community">
								<c:choose>
									<c:when test="${merchant.community == community.id}">
										<option value="${community.id }" selected="selected">${community.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${community.id }">${community.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
				
				
				
				
				<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if>>
					<label for="fileToUploadintro" class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>商户缩略图:</label>
					<div class="controls" id="introup"></div>
				</div>
				
				
				<div class="control-group" id="introface">
					<label class="control-label"><c:if test="${action == 'view' }">商户缩略图:</c:if></label>
					<div class="controls">
						<img alt="商户缩略图" src="${ctx}/static/images/zanwuPic.jpg" id="introimg">
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if>>
					<label for="fileToUploaddetail" class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>商户详情图:</label>
					<div class="controls" id="detailup"></div>
				</div>
				
				<div class="control-group" id="detailface">
					<label class="control-label"><c:if test="${action == 'view' }">商户详情图:</c:if></label>
					<div class="controls">
						<img alt="商户详情图" src="${ctx}/static/images/zanwuPic.jpg" id="detailimg">
					</div>
				</div>
				
				<div class="control-group" id="qrcodeurl" style="display:none;">
					<label class="control-label"><c:if test="${action == 'view' }">商户二维码:</c:if></label>
					<div class="controls">
						<img alt="商户二维码" src="${ctx}/static/images/zanwuPic.jpg" height="200px" width="200px" id="qrurlimg">
						<input id="qrdownbtn" class="btn blue" type="button" value="下载二维码" onclick="downqrurl('${merchant.id}')" />
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action == 'view' }">style="display:none;"</c:if> >
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>商户详情:</label>
					<div class="controls" style="width:1200px;height:auto;min-height: 500px;">
						<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${merchant.content}</script>
					</div>
				</div>
				
				<div class="control-group" <c:if test="${action != 'view' }">style="display:none;"</c:if> >
					<label class="control-label">商户详情:</label>
					<div class="controls">
						${merchant.content}
					</div>
				</div>
				
				
				
				<br />
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
				</div>
			</form>
		</div>
	</div>
</body>
</html>
