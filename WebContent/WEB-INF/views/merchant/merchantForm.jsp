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
				var htmlstr = '<option value="-1">--选择商圈--</option>';
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
					var htmlstrchange = '<option value="-1">--选择商圈--</option>';
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
		 
		 var test = $("input[type=checkbox]:not(.toggle), input[type=radio]:not(.toggle, .star)");
			if (test.size() > 0) {
				test.each(function() {
					if ($(this).parents(".checker").size() == 0) {
						$(this).show();
						$(this).uniform();
	
						$(this).bind("change", function() {
							if ($(this).val() == "1") {
								var thisname = $(this).attr("name");
								if(thisname == 'bmer') {
									var cmerval = $("#cmer").val();
									$("#community").removeAttr("disabled");
								}else if(thisname == 'cmer') {
									var bmerval = $("#bmer").val();
									if(bmerval == '1') {
										$("#community").val("-1");
										$("#community").attr("disabled","disabled");
									}
								}
								$(this).val("0");
							} else {
								var thisname = $(this).attr("name");
								if(thisname == 'bmer') {
									var cmerval = $("#cmer").val();
									if(cmerval == '1') {
										
									}else{
										$("#community").val("-1");
										$("#community").attr("disabled","disabled");
									}
								}else if(thisname == 'cmer') {
									$("#community").removeAttr("disabled");
								}
								
								$(this).val("1");
							}
						})
					}
				});
			}
	});
	
	function formsubmit() {
		
		var name = $("#name").val();
		var ownername = $("#ownername").val();
		var email = $("#email").val();
		var district = $("#district").val();
		var telephone = $("#telephone").val();
		var address = $("#address").val();
		var bankaccount = $("#bankaccount").val();
		
		var bmerv = $("#bmer").val();
		var cmerv = $("#cmer").val();
		
		var categorysup = $("#categorysup").val();
		var categorysub = $("#categorysub").val();
		
		var business = $("#businessid").val();
		var onecost = $("#onecost").val();
		
		var keystr = '';
		$(".keyspan").each(function(){
			var keywordid = $(this).attr("id").substring(1);
			if($("#input"+keywordid).val() == '1') {
				keystr += ',' + $(this).attr("value");
			}
		});
		
		var community = $("#community").val();
		var specialcourse = $("#specialcourse").val();
		
		var thumbnailurl = $("#thumbnailurl").val();
		var detailurl = $("#detailurl").val();
		
		var uecontent = ue.getContent();
		
		if($.trim(name) == '') {
			window.parent.showAlert("商户名称不能为空！");
			return false;
		}
		
		if($.trim(ownername) == '') {
			window.parent.showAlert("店家姓名不能为空！");
			return false;
		}
		
		if($.trim(email) == '') {
			window.parent.showAlert("商户邮箱不能为空！");
			return false;
		}
		
		if(email.search(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/) == -1) {
			window.parent.showAlert("商户邮箱格式不对！");
			return false;
		}
		
		if($.trim(district) == '-1') {
			window.parent.showAlert("没有选择商家所属区域");
			return false;
		}
		
		if($.trim(telephone) == '') {
			window.parent.showAlert("商户联系电话不能为空！");
			return false;
		}
		
		if(telephone.search(/^((1[34578][0-9]{1})+\d{8})$/) == -1
					&& telephone.search(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/) == -1) {
			window.parent.showAlert("商户联系电话格式不对！");
			return false;
		}
		
		if($.trim(address) == '') {
			window.parent.showAlert("商户地址不能为空！");
			return false;
		}
		
		if($.trim(bankaccount) == '') {
			window.parent.showAlert("你没有填写商户预留的银行卡账号！");
			return false;
		}
		
		if(bankaccount.search(/^(\d{16}|\d{19})$/) == -1) {
			window.parent.showAlert("银行卡账号应该为16位或者19位！");
			return false;
		}
		
		if($.trim(bmerv) == '0' && $.trim(cmerv) == '0' ) {
			window.parent.showAlert("你没有选择商户的类型！");
			return false;
		}
		
		if($.trim(categorysup) =='-1') {
			window.parent.showAlert("你没有选择商户的主分类！");
			return false;
		}
		
		if($.trim(categorysub) =='-1') {
			window.parent.showAlert("你没有选择商户的二级分类！");
			return false;
		}
		
		if($.trim(bmerv) == '1' && $.trim(business) =='-1') {
			window.parent.showAlert("你没有选择商户所属的商圈！");
			return false;
		}
		
		if($.trim(bmerv) == '1' && ($.trim(onecost) == '' || !onecost.trim().match(/^[0-9]{0,5}([.][0-9]{1,2})?$/))) {
			window.parent.showAlert("人均消费金额应该为数字，且小数部分不能超过两位，整数部分不能超过5位");
			return false;
		}
		
		if($.trim(keystr) == '') {
			window.parent.showAlert("商户关键字没有填写");
			return false;
		}else{
			var keywords = keystr.substring(1);
			$("#keywords").val(keywords);
		}
		
		if($.trim(cmerv) == '1' && $.trim(community) == '-1') {
			window.parent.showAlert("请选择社区商户所述的社区");
			return false;
		}
		
		/* if($.trim(specialcourse) == '') {
			window.parent.showAlert("请填写商户的特色菜");
			return false;
		} */
		
		if($.trim(thumbnailurl) == '') {
			window.parent.showAlert("你没有上传缩略图！");
			return false;
		}
		
		if($.trim(detailurl) == '') {
			window.parent.showAlert("你没有上传商户详情图！");
			return false;
		}
		
		if(uecontent == null || $.trim(uecontent) =='') {
			window.parent.showAlert("你没有填写商户的详情介绍！");
			return false;
		}
		
		$("#inputForm").submit();
	}
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				新增/修改商户
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>新增/修改商户
			</div>
		</div>
		<div class="portlet-body form">
			<form action="${ctx}/merchant/update" id="inputForm" class="form-horizontal" method="post">

				<input type="hidden" name="id" value="${merchant.id}" /> 
				<input type="hidden" name="thumbnailurl" id="thumbnailurl" value="${merchant.thumbnailurl}" /> 
				<input type="hidden" name="introduceurl" id="introduceurl" value="${merchant.introduceurl}" /> 
				<input type="hidden" name="detailurl" id="detailurl" value="${merchant.detailurl}" /> 
						
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;商家名称:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap" style="width: 40%;" name="name" value="${merchant.name}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;姓名:</label>
					<div class="controls">
						<input type="text" id="ownername" class="span3 m-wrap" style="width: 40%;" name="ownername" value="${merchant.ownername}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;邮箱:</label>
					<div class="controls">
						<input type="text" id="email" class="span3 m-wrap" style="width: 40%;" name="email" value="${merchant.email}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;区域:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="district" style="width: 40%;">
							<option value="-1">--选择区域--</option>
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
					<label class="control-label"><span style="color:red">*</span>&nbsp;电话:</label>
					<div class="controls">
						<input type="text" id="telephone" class="span3 m-wrap" style="width: 40%;" name="telephone" value="${merchant.telephone}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;地址:</label>
					<div class="controls">
						<input type="text" id="address" class="span3 m-wrap" style="width: 40%;" name="address" value="${merchant.address}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;银行卡号:</label>
					<div class="controls">
						<input type="text" id="bankaccount" class="span3 m-wrap" style="width: 40%;" name="bankaccount" value="${merchant.bankaccount}" maxlength="30">
					</div>
					<span style="color:red;display:none;" class="controls" id="bankspan">银行卡用于交易结算，请准确核对！</span>
				</div>
				
				<div class="control-group">
					<label class="control-label"><span style="color:red">*</span>&nbsp;商户类型:</label>
					<div class="controls">
						<label class="checkbox">
							<input type="checkbox" id="bmer" name="bmer" <c:if test="${merchant.business != null }">checked="checked" value="1"</c:if> <c:if test="${merchant.business == null }">value="0"</c:if> /> 商圈商户
						</label>
						<label class="checkbox">
							<input type="checkbox" id="cmer" name="cmer" <c:if test="${merchant.community != null }">checked="checked" value="1"</c:if> <c:if test="${merchant.community == null }">value="0"</c:if> /> 社区商户
						</label>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">分类:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="categorysup" name="pclassify" style="width: 40%;">
							<option value="-1">--选择分类--</option>
							<c:forEach items="${pclassify}" var="pclass">
								<option value="${pclass.id }">${pclass.name}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select class="span2 m-wrap required" id="categorysub" name="classify" style="width: 40%;">
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商圈:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="businessid" style="width: 40%;" name="business.id">
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">人均消费:</label>
					<div class="controls">
						<input type="text" id="onecost" class="span3 m-wrap" style="width: 40%;" name="onecost" value="${merchant.onecost}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label"><c:if test="${action != 'view' }"><span style="color:red">*</span>&nbsp;</c:if>关键字:</label>
					<div class="controls">
						 <c:forEach items="${keywordlist}" var="keyword" varStatus="keyindex">
						 	<c:set var="onekeyvalue" value=",${keyword.value},"></c:set>
						 	<label class="checkbox">
					 			<input type="checkbox" id="input${keyword.id}" <c:if test="${fn:indexOf(merkeywords,onekeyvalue) < 0 }">value="0"</c:if> <c:if test="${fn:indexOf(merkeywords,onekeyvalue) >=0 }">value="1" checked="checked"</c:if> <c:if test="${action == 'view' }">disabled="disabled"</c:if> />
					 			${keyword.value}
					 			<span style="display:none" class="keyspan" id="k${keyword.id}" value="${keyword.value}"></span>
					 		</label>
						 	<c:if test="${keyindex.count%4 == 0 }"><br /></c:if>
						</c:forEach>
					</div>
				</div>
				
				<input type="hidden" name="keywords" id="keywords" value="" /> 
				
				<div class="control-group" id="commdiv" >
					<label class="control-label">社区:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="community" style="width: 40%;" name="community" <c:if test="${merchant.community == null}">disabled="disabled"</c:if> >
							<c:choose>
								<c:when test="${merchant.community == null}">
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
				
				<div class="control-group">
					<label class="control-label">&nbsp;特色菜:</label>
					<div class="controls">
						<textarea rows="5" cols="60" class="span3 m-wrap" style="width: 40%;" id="specialcourse" name="specialcourse" maxlength="255">${merchant.specialcourse}</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label for="fileToUploadintro" class="control-label"><span style="color:red">*</span>&nbsp;缩略图:</label>
					<div class="controls" id="introup"></div>
				</div>
				
				<div class="control-group" id="introface">
					<label class="control-label"></label>
					<div class="controls">
						<img alt="商户缩略图" src="${ctx}/static/images/zanwuPic.jpg" id="introimg" />
					</div>
				</div>
				
				<div class="control-group" >
					<label for="fileToUploaddetail" class="control-label"><span style="color:red">*</span>&nbsp;详情图:</label>
					<div class="controls" id="detailup"></div>
				</div>
				
				<div class="control-group" id="detailface">
					<label class="control-label"></label>
					<div class="controls">
						<img alt="商户详情图" src="${ctx}/static/images/zanwuPic.jpg" id="detailimg" />
					</div>
				</div>
				
				<div class="control-group" >
					<label class="control-label"><span style="color:red">*</span>&nbsp;商户详情:</label>
					<div class="controls" style="">
						<script id="container" name="content" style="width:100%;height:500px;" type="text/plain">${merchant.content}</script>
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<input id="submit_btn" class="btn blue" type="button" value="保存" onclick="formsubmit()" />&nbsp; 
				    <input id="cancel_btn" class="btn grey" type="button" value="取消" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
