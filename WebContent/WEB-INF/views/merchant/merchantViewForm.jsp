<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>商户管理-查看商户信息</title>
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

	jQuery(document).ready(function() {
		
		window.parent.scroll(0,0);
		 
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
	
	
	function downqrurl(merid) {
		window.location.href="${ctx}/merchant/downqr/"+merid;
	}
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;" /> 
				查看商户信息
			</h3>
		</div>
	</div>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>查看商户信息
			</div>
		</div>
		<div class="portlet-body form">
			<form action="#" id="inputForm" class="form-horizontal" method="post">

				<div class="control-group">
					<label class="control-label">商家名称:</label>
					<div class="controls">
						<input type="text" id="name" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="name" value="${merchant.name}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">姓名:</label>
					<div class="controls">
						<input type="text" id="ownername" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="ownername" value="${merchant.ownername}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">邮箱:</label>
					<div class="controls">
						<input type="text" id="email" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="email" value="${merchant.email}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">区域:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="district" style="width: 40%;" disabled="disabled">
							<c:choose>
								<c:when test="${districtid == null}">
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
					<label class="control-label">电话:</label>
					<div class="controls">
						<input type="text" id="telephone" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="telephone" value="${merchant.telephone}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">地址:</label>
					<div class="controls">
						<input type="text" id="address" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="address" value="${merchant.address}" maxlength="30">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">银行卡号:</label>
					<div class="controls">
						<input type="text" id="bankaccount" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="bankaccount" value="${merchant.bankaccount}" maxlength="30">
					</div>
					<span style="color:red;display:none;" class="controls" id="bankspan">银行卡用于交易结算，请准确核对！</span>
				</div>
				
				<div class="control-group">
					<label class="control-label">商户类型:</label>
					<div class="controls">
						<label class="checkbox">
							<input type="checkbox" id="bmer" name="bmer" disabled="disabled" <c:if test="${merchant.business != null }">checked="checked" value="1"</c:if> <c:if test="${merchant.business == null }">value="0"</c:if> /> 商圈商户
						</label>
						<label class="checkbox">
							<input type="checkbox" id="cmer" name="cmer" disabled="disabled" <c:if test="${merchant.community != null }">checked="checked" value="1"</c:if> <c:if test="${merchant.community == null }">value="0"</c:if> /> 社区商户
						</label>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">分类:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="categorysup" name="pclassify" style="width: 40%;" disabled="disabled">
							<option value="-1">--选择分类--</option>
							<c:forEach items="${pclassify}" var="pclass">
								<option value="${pclass.id }">${pclass.name}</option>
							</c:forEach>
						</select>
						&nbsp;&nbsp;
						<select class="span2 m-wrap required" id="categorysub" name="classify" style="width: 40%;" disabled="disabled">
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">商圈:</label>
					<div class="controls">
						<select class="span2 m-wrap required" id="businessid" style="width: 40%;" disabled="disabled" name="business.id">
							<c:choose>
								<c:when test="${merchant.business == null}">
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
					<label class="control-label">人均消费:</label>
					<div class="controls">
						<input type="text" id="onecost" class="span3 m-wrap" style="width: 40%;" disabled="disabled" name="onecost" value="${merchant.onecost}" maxlength="10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">关键字:</label>
					<div class="controls">
						 <c:forEach items="${keywordlist}" var="keyword" varStatus="keyindex">
						 	<c:set var="onekeyvalue" value=",${keyword.value},"></c:set>
						 	<label class="checkbox">
					 			<input type="checkbox" disabled="disabled" id="input${keyword.id}" <c:if test="${fn:indexOf(merkeywords,onekeyvalue) < 0 }">value="0"</c:if> <c:if test="${fn:indexOf(merkeywords,onekeyvalue) >=0 }">value="1" checked="checked"</c:if> disabled="disabled" />
					 			${keyword.value}
					 			<span style="display:none" class="keyspan" id="k${keyword.id}" value="${keyword.value}"></span>
					 		</label>
						 	<c:if test="${keyindex.count%4 == 0 }"><br /></c:if>
						</c:forEach>
					</div>
				</div>
				
				<input type="hidden" name="keywords" id="keywords" value="" /> 
				
				<div class="control-group" id="commdiv">
					<label class="control-label">社区:</label>
					<div class="controls">
						<select class="span2 m-wrap" id="community" disabled="disabled" style="width: 40%;" name="community">
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
				
				<input type="hidden" name="community" id="community" value="" />
				
				<div class="control-group">
					<label class="control-label">特色菜:</label>
					<div class="controls">
						<textarea rows="5" cols="60" class="span3 m-wrap" style="width: 40%;" disabled="disabled" id="specialcourse" name="specialcourse" maxlength="255">${merchant.specialcourse}</textarea>
					</div>
				</div>
				
				<div class="control-group" id="introface">
					<label class="control-label">缩略图:</label>
					<div class="controls">
						<img alt="商户缩略图" src="${ctx}/static/images/zanwuPic.jpg" id="introimg" />
					</div>
				</div>
				
				<div class="control-group" id="detailface">
					<label class="control-label">详情图:</label>
					<div class="controls">
						<img alt="商户详情图" src="${ctx}/static/images/zanwuPic.jpg" id="detailimg" />
					</div>
				</div>
				
				<div class="control-group" id="qrcodeurl" style="display:none;">
					<label class="control-label">商户二维码:</label>
					<div class="controls">
						<img alt="商户二维码" src="${ctx}/static/images/zanwuPic.jpg" height="200px" width="200px" id="qrurlimg">
						<input id="qrdownbtn" class="btn blue" type="button" value="下载二维码" onclick="downqrurl('${merchant.id}')" />
					</div>
				</div>
				
				<div class="control-group" >
					<label class="control-label">商户详情:</label>
					<div class="controls" style="margin-top:12px;">
						${merchant.content}
					</div>
				</div>
				
				<br />
				<div class="form-actions">
					<input id="cancel_btn" class="btn grey" type="button" value="返回" onclick="history.back()" />
				</div>
			</form>
		</div>
	</div>
</body>
</html>
