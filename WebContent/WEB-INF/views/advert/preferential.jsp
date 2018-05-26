<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>首页轮播图管理</title>
	<%@ include file="../quote.jsp"%>
	
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>

</head>
<style type="text/css">
#contentTable td{
WORD-WRAP: break-word;
text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	init_checkbox('.check_all','.check_item');
});

function deleteAdvert(id) {
	var ids=getIds('.check_item');
	if(ids.length == 0) {
		parent.parent.window.showAlert("请选择一条记录！");
		return;
	}
	parent.parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
}
function sureDel() {
	var ids=getIds('.check_item');
	 $.post('${ctx}/advert/deletePreferential',{"ids":ids},function(data){
		if(data.result){
			window.parent.parent.showAlert("删除成功");
			window.location.href = '${ctx}/advert?type=preferential';
		}else{
		}
	});  
}
function show_add(position){
	$("#id").val('');
	$("#content").val('');
	$("#img").val('');
	$("#fileimg").attr("src","${ctx}/");
	$("#title").val('');
	$("#position").val(position);
	$("#form_categorytype").modal('show');
}
function show_edit(id,title,content,img){
	$("#id").val(id);
	$("#content").val(content);
	if(img.length!=0){
		$("#fileimg").attr("src","${ctx}/"+img);
	}
	$("#img").val(img);
	$("#title").val(title);
	$("#form_categorytype").modal('show');
}
function Check_Submit(){
	var id=$("#id").val();
	var title=$("#title").val();
	var img=$("#img").val();
	if($.trim(title).length == 0) {
		window.parent.parent.showAlert("广告名称不能为空！");
		return false;
	}
	if($.trim(img).length == 0){
		window.parent.parent.showAlert("广告图片不能为空！");
		return false;
	}
	else{
		$("#inputForm").submit();
	}	
}
function uploadimge(){
	var size=getFileSize("fileToUpload");
	if(size>4194304)
		{
		  window.parent.showAlert("图片大小不能超过4m");

	         return false;
		}
	var filepath=$("#fileToUpload").val();
	var extStart=filepath.lastIndexOf(".");
	var ext=filepath.substring(extStart,filepath.length).toUpperCase();
	if(ext!=".PNG"&&ext!=".JPG"){
	window.parent.parent.showAlert("只支持jpg,png的图片!");
	return false;
	}
  $.ajaxFileUpload({
	  url:'${ctx}/advert/upfile', //链接到服务器的地址
	  fileElementId:'fileToUpload',  //文件选择框的id属性
	  dataType:'json',
	  success:function(data){
		  if(data['result']==1){
			 /* if(data.width!=720||data.height!=320){
				 window.parent.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720*320!");
					return;
			 }  */
		  }
		  $("#imgshow").html("");
		  $("#imgshow").html("<div class=\"span3\" style=\"width:200px;height:200px;margin:0px 0px\"><div class=\"item\"><a href=\"javascript:;\" onclick=\"javascript:fileToUpload.click();\"><img  src=\"${ctx}/"+data.path+"\" /></a></div></div>");
	      $("#img").val(data.path);
	  },
	  error : function(data) {
			window.parent.parent.showAlert("上传失败");
		}
  });
}

function getFileSize(sourceId) {
	return	document.getElementById(sourceId).files
							.item(0).size;
	}	 
</script>
<body>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
			 <div class="actions">
				<c:if test="${adverts.totalPages==0}"><a href="javascript:;" class="btn blue" onclick="show_add()"><i class=""></i> 新增</a></c:if> 
				<a href="javascript:;" class="btn red" onclick="deleteAdvert()"><i class=""></i>删除</a>
			</div> 
		</div>
		<div class="portlet-body"  style="height: 500px;">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead><tr>
				<th style="width: 5%;text-align: center;">序号</th>
				<th style="text-align: center;">广告标题</th>
				<!-- <th style="text-align: center;">广告图片</th>
				 --><th style="text-align: center;">变更人</th>
				<th style="text-align: center;">变更时间</th>
				<th style="text-align: center;">操作</th>
				</tr>
				</thead>
				<tbody id="tbody" >
				<c:if test="${adverts.totalPages!=0}">
						<c:forEach items="${adverts.content}" var="advert" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${advert.title}</td>
						<%-- <td><img class="fileimg" style="height:80px;" src="${ctx}/${advert.img}" onerror="this.src='${ctx}/static/images/zanwuPic2.jpg'"/></td>
						 --%><td>${advert.user.realname}</td>
						<td>${fn:substring(advert.createtime, 0, 16)}</td>
						<td>
						<a href="javascript:;" onclick="show_edit('${advert.id}','${advert.title}','${advert.content}','${advert.img}')">修改</a>
						</td>
					</tr>
					</c:forEach>
					</c:if>
				<c:if test="${adverts.totalPages==0}">
						<tr class="odd gradeX">
						<td colspan="10" style="text-align: center;">无记录</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<%-- <tags:pagination page="${adverts}" paginationSize="5"/> --%>
		</div>
	</div>
	<div class="modal hide fade" id="form_categorytype" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel"><span id="form_title">
			<img src="${ctx}/static/images/xtgl.png" style="vertical-align: baseline;" /> 
				<i class="icon-angle-right"></i>
				新增/修改广告</span></h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
			<form action="${ctx}/advert/create" method="post" id="inputForm"  class="form-horizontal">
			<div class="control-group">
				<label class="control-label">广告名称:</label>
				<div class="controls">
					<input type="text" id="title"  name="title"  maxlength="20" style="width:60% ;height: 32px" 
						class="title required" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">广告图片</label>
				<div class="controls">
				 <input id="fileToUpload" name="fileToUpload" type="file"onchange="uploadimge();" style="display: none"/>
					 			  <span name="easyTip"style="color: red; font-size: 10px;">(支持jpg,png格式.建议大小720*320)</span>
					 			  </br>
				  <div id="imgshow" class="hello" style="float: left;" >
                        	   		<div class="span3" style="height:160px;width:360px; margin: 0px 0px;">
                               			<div class="item">
                         					 <a href="javascript:;" onclick="javascript:fileToUpload.click();">
												<img id="fileimg" src="${ctx}/static/images/zanwuPic2.jpg" onerror="this.src='${ctx}/static/images/zanwuPic2.jpg'"/>
						  					 </a>
                         	   			</div>
                       			  </div>
                   			</div>   
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">广告描述:</label>
				<div class="controls">
					<textarea id="content" name="content" rows="4" cols="2" style="width:60% ;" maxlength="300" ></textarea>
					<input type="hidden" id="id" name="id" value="">
			    	<input type="hidden" id="type" name="type" value="preferential">
			    	<input type="hidden" id="img" name="img" value="">
			    	<input type="hidden" id="position" name="position" value="">
				</div>
			</div>
		</form>
		</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()"
					value="保存" />&nbsp; 
			<!--	<a class="btn green" onclick="">保存</a>-->
			<!-- <a class="btn" onclick="closeLonding()">取消</a> -->
		</div>
	</div>
</body>
</html>
