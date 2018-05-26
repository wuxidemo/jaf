<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%

	String name=""; 
	if(request.getParameter("search_LIKE_name")!=null) {
		name=new String (request.getParameter("search_LIKE_name").getBytes("ISO-8859-1"),"UTF-8");
	}
	
%>


<html>
<head>
	<title>商户管理</title>
	<%@ include file="../quote.jsp"%>
</head>

<script type="text/javascript">

	$(document).ready(function(){
		init_checkbox('.check_all','.check_item');
		
		var pclassid = $("#pclassify").val();
		var classifyid = '${EQ_classify}';
		if(pclassid == '-1') {
			$("#classify").html('<option value="-1">--选择二级分类--</option>');
		}else{
			var suburl = '${ctx}/classify/getsubbypid';
			$.post(suburl,{"pid":pclassid},function(data){
				if(data.result == '1') {
					var subhtml = '<option value="-1">--选择二级分类--</option>';
					for(var i=0;i<data.data.length;i++) {
						subhtml += '<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
					}
					$("#classify").html(subhtml);
					if(classifyid != '') {
						$("#classify").val(classifyid);
					}else{
						$("#classify").val("-1");
					}
				}
			});
		}
		
		$("#pclassify").change(function(){
			$("#classify").empty();
			var pval = $(this).val();
			if(pval == '-1') {
				$("#classify").html('<option value="-1">--选择二级分类--</option>');
			}else{
				var suburl = '${ctx}/classify/getsubbypid';
				$.post(suburl,{"pid":pval},function(data){
					if(data.result == '1') {
						var subhtml = '<option value="-1">--选择二级分类--</option>';
						for(var i=0;i<data.data.length;i++) {
							subhtml += '<option value="'+data.data[i].id+'">'+data.data[i].name+'</option>';
						}
						$("#classify").html(subhtml);
					}
				});
			}
		});
		
		
	});
	
	function askforupdate() {
		parent.window.showConfirm("你确定要更新数据?",updatetable);
	}
	
	function updatetable() {
		var url = "${ctx}/merchant/updatemertable"
		$.post(url,function(data){
			if(data) {
				window.parent.showAlert(data.msg);
				window.location.href="${ctx}/merchant"
			}
		})
	}
	
	function guanlian(merid) {
		var url ="${ctx}/merchant/checkmerchant/"+merid;
		$.get(url,function(data){
			if(data == 'noupdate') {
				window.parent.showAlert("请先完善商户信息");
				window.location.href="${ctx}/merchant/update/"+merid;
				return false;
			}else{
				window.location.href="${ctx}/merchant/bindaccount/"+merid;
			}
		});
	}
	
	function resetAll() {
		$("#name").val("");
		$("#pclassify").val("-1");
		$("#classify").val("-1");
		$("#community").val("-1");
	}

	function openaccount(merid) {
		$("#merchantid").val(merid);
		$("#phoneno").val("");
		$("#uname").val("");
		$("#errormsg").html("");
		$("#openaccount").modal("show");
	}
	
	function hidemodal() {
		$("#openaccount").modal("hide");
	}
	
	function bindNum(merid) {
		$("#merchantID").val(merid);
		$("#paytype").val("");
		$("#countNum").val("");
		
		$("#bindNum").modal("show");
	}
	
	function hideBindNum() {
		$("#bindNum").modal("hide");
	}
	
	function checkmercomment(merid) {
		
		var url ="${ctx}/mercomment/mercommenturl?merid="+merid;
		$.get(url,function(data){
			if(!data.result) {
				window.parent.showAlert("当前商户暂无评价！");
			}else{
				window.location.href="${ctx}/mercomment/url?merid="+merid;
			}
		});
	}
	
	
</script>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title"><img src="${ctx}/static/images/shgl.png" style="vertical-align: text-bottom;"/> 
				商户管理
			</h3>
		</div>
	</div>

	 <div class="portlet box grey" style="margin-bottom:0px;height:auto;">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-search"></i>查询条件
			</div>
		</div>
		<div class="portlet-body" style="padding-top:25px;">
			<form class="form-search" action="${ctx}/merchant" method="post">
			<table style="width: 100%">
				<tr>
					<td style="width:33%;">
						<label class="control-label" style="float:left">名&emsp;&emsp;称：</label> 
						<input type="text" id="name" name="search_LIKE_name" maxlength="20" style="float:left;width: 60%; height: 32px;" value="${LIKE_name }"> 
					</td>
					<td style="width:33%;">
						<label class="control-label" style="float:left">一级分类：</label> 
						<select id="pclassify" style="width:60%; height: 32px;" name="search_EQ_pclassify">
							<c:choose>
								<c:when test="${EQ_pclassify == '-1'}">
									<option value="-1" selected="selected">--选择一级分类--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择一级分类--</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${pclassifys}" var="pclassify">
								<c:choose>
									<c:when test="${pclassify.id == EQ_pclassify}">
										<option selected="selected" value="${pclassify.id}">${pclassify.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${pclassify.id}">${pclassify.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td style="width:33%;">
						<label class="control-label" style="float:left">二级分类：</label> 
						<select id="classify" style="width:60%; height: 32px;" name="search_EQ_classify">
						</select>
					</td>
				</tr>
				<tr>
					<td style="width:33%;">
						<label class="control-label" style="float:left">选择社区：</label> 
						<select id="community" style="width:60%; height: 32px;" name="search_EQ_community">
							<c:choose>
								<c:when test="${EQ_community == '-1'}">
									<option value="-1" selected="selected">--选择社区--</option>
								</c:when>
								<c:otherwise>
									<option value="-1">--选择社区--</option>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${EQ_community == '0'}">
									<option value="0" selected="selected">所有社区</option>
								</c:when>
								<c:otherwise>
									<option value="0">所有社区</option>
								</c:otherwise>
							</c:choose>
							<c:forEach items="${communitys}" var="community">
								<c:choose>
									<c:when test="${community.id == EQ_community}">
										<option selected="selected" value="${community.id}">${community.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${community.id}">${community.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
					<td style="width:33%;">
						<button type="submit" class="btn blue" id="search_btn">查询</button>&nbsp;&nbsp;
						<button type="button" class="btn" id="reset_btn" onclick="resetAll()">重置</button>
					</td>
				</tr>
			</table>
		    </form>
	    </div>
    </div>
    
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			<div class="actions">
				<a href="javascript:;">&nbsp;</a> 
				<a href="javascript:;" class="btn red" onclick="askforupdate()">更新数据</a>
			</div>
		</div>
		 <div class="portlet-body">
			<c:if test="${not empty message}" >
				<div id="message" class="alert alert-success">
					<button data-dismiss="alert" class="close">×</button>${message}</div>
			</c:if>
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 3%;"><input type="checkbox" id="check_all" value="" class="check_all"></th>
						<th style="width: 7%;">序号</th>
						<th style="width: 20%;">名称</th>
						<th style="width: 10%;">一级分类</th>
						<th style="width: 10%;">二级分类</th>
						<th style="width: 10%;">所属社区</th>
						<th style="width: 10%;">微信商户号</th>
						<th style="width: 10%;">支付宝商户号</th>
						<th style="width: 20%;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${merchants.totalPages!=0}">
					<c:forEach items="${merchants.content}" var="mer" varStatus="status">
						<tr>
							<td><input type="checkbox" id="check_item" value="${mer.id}" class="check_item"></td>
							<td style="vertical-align: middle;">${status.count}</td>
							<td style="vertical-align: middle;"><c:if test="${mer.name != null}">${mer.name}</c:if> &nbsp;</td>
							<td style="vertical-align: middle;">
								<c:forEach items="${pclassifys }" var="pclass">
									<c:if test="${mer.pclassify == pclass.id}">${pclass.name}</c:if>
								</c:forEach>
							</td>
							<td style="vertical-align: middle;">
								<c:forEach items="${subclass }" var="sub">
									<c:if test="${mer.classify == sub.id}">${sub.name}</c:if>
								</c:forEach>
							</td>
							<td style="vertical-align: middle;">
								<c:forEach items="${communitys }" var="community">
									<c:if test="${mer.community == community.id}">${community.name}</c:if>
								</c:forEach>
							</td>
							<td style="vertical-align: middle;">${mer.wxpaynum}</td>
							<td style="vertical-align: middle;">${mer.alipaynum}</td>
							<td style="vertical-align: middle;">
								<c:if test="${mer.email != null }">
									<a href="${ctx}/merchant/view/${mer.id}" >查看</a>&nbsp;
								</c:if>
								<c:if test="${mer.update_status == 0 }">
									<a href="${ctx}/merchant/update/${mer.id}">修改</a>&nbsp;
								</c:if>
								<c:if test="${mer.binduser == null || mer.binduser == 0 }">
									<a href="javascript:;" onclick="openaccount('${mer.id}')">创建账号</a>&nbsp;
								</c:if>
								
								<a href="javascript:;" onclick="bindNum('${mer.id}')">绑定商户号</a>&nbsp;
								<a href="javascript:;" onclick="checkmercomment('${mer.id}')">评论详情</a>&nbsp;
							</td>
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${merchants.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="9" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<tags:pagination page="${merchants}" paginationSize="5"/>
		</div> 
	</div>
	
	<div class="modal hide fade" id="openaccount" tabindex="-2" role="dialog" style="top: 10%;width:800px;left:40%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">金阿福商户开账号</h3>
		</div>
		<div id="" class="modal-body">
			<form action="${ctx}/merchant/openaccount" method="post" id="opencountform" class="form-horizontal">
			
				<input type="hidden" name="merchantid" id="merchantid"  value=""/>
				
				<div class="control-group">
					<label for="phoneno" class="control-label">手机号码:</label>
					<div class="controls">
						<input type="text" id="phoneno" class="span m-wrap" style="height: 32px; width: 60%;" name="phoneno" maxlength="15" />
						<span style="color:#cecece;height:32px;line-height:32px;">用于登录系统的账号，请确保真实有效</span>
					</div>
				</div>
				
				<div class="control-group">
					<label for="uname" class="control-label">用户姓名:</label>
					<div class="controls">
						<input type="text" id="uname" name="uname" style="height: 32px; width: 60%;" class="span m-wrap" maxlength="20" />
						<span style="color:#cecece;height:32px;line-height:32px;">登录后用于显示的用户名字</span>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls" id="errormsg" style="color:red;">
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary green" type="button" onclick="submitform()" value="确定" />&nbsp; 
			<input class="btn btn-primary grey" type="button" onclick="hidemodal()" value="取消" />
		</div>
	</div>
	
	<div class="modal hide fade" id="bindNum" tabindex="-2" role="dialog" style="top: 10%;width:800px;left:40%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="selecttitle">商户绑定商户号</h3>
		</div>
		<div id="" class="modal-body">
			<form action="${ctx}/merchant/bindNum" method="post" id=bindNumform class="form-horizontal">
			
				<input type="hidden" name="merchantid" id="merchantID"  value=""/>
				
				<div class="control-group">
					<label class="control-label">支付方式:</label>
					<div class="controls">
						<select id="paytype" name="paytype" style="float:left;width: 60%;height: 32px;" class="">
							<option value="-1">--请选择--</option>
							<option value="wx">微信支付</option>
							<option value="ali">支付宝支付</option>
						</select> 
					</div>
				</div>
				
				<div class="control-group">
					<label for="countNum" class="control-label">商户号:</label>
					<div class="controls">
						<input type="text" id="countNum" name="countNum" style="height: 32px; width: 60%;" class="span m-wrap" maxlength="20" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">&nbsp;</label>
					<div class="controls" id="errorMSG" style="color:red;">
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<input class="btn btn-primary green" type="button" onclick="submitBindNumform('${mer.id}')" value="确定" />&nbsp; 
			<input class="btn btn-primary grey" type="button" onclick="hideBindNum()" value="取消" />
		</div>
	</div>
	
	<script type="text/javascript">
		function submitform(){
			
			$("#errormsg").empty();
			
			var merchantid = $("#merchantid").val();
			var phoneno = $("#phoneno").val();
			var uname = $("#uname").val();
				
			if(phoneno.trim() == '') {
				$("#errormsg").html("用户姓名不能为空！");
				$(this).focus();
				return false;
			}else if(!(/^(13[0-9]{9})|(15[0-9][0-9]{8})|(17[0-9][0-9]{8})|(18[0-9][0-9]{8})$/.test(phoneno))) {
				$("#errormsg").html("手机号码格式不对！");
				$(this).focus();
				return false;
			}else if(uname.trim() == '') {
				$("#errormsg").html("用户姓名不能为空！");
				$(this).focus();
				return false;
			}else{
				var checkurl = "${ctx}/system/user/checkTelephone?telephone="+phoneno;
				$.get(checkurl,function(data){
					if(data == 'false') {
						$("#errormsg").html("该手机号已被占用");
						$("#phoneno").focus();
						return false;
					}else{
						$("#opencountform").submit();
					}
				});
			}
		}
		
		function submitBindNumform(){
			$("#errorMSG").empty();
			var paytype = $("#paytype").val();
			if(paytype == null || paytype.trim() == '-1') {
				$("#errorMSG").html("请选择支付方式!");
				$(this).focus();
				return false;
			}
			$("#bindNumform").submit();
		}
	</script>
	
</body>
</html>