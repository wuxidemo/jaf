<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>热门商户管理</title>
	<%@ include file="../quote.jsp"%>
	

</head>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
<style type="text/css">
#contentTable td{
	WORD-WRAP: break-word;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(function(){
		getList();
	});
	function getList(){
		var type='nominate';
		var url="${ctx}/advert/getList";
		$.post(url,{"type":type},function(data){
			if(data.result){
				var advert=data.data;
				var length=advert.length;
				var html='';
				for(var i=0;i<length;i++){
					if(advert[i].position=='1'){
						if(advert[i].title==''){
							html='<td>1</td><td colspan="3" >(空)</td><td><a href="javascript:;" class="" onclick="show_add(\''+advert[i].position+'\',\''+advert[i].id+'\')"><i class=""></i>上传</a></td>';
						}else{
							html='<td>1</td><td>'+advert[i].title+'</td><td><div><img style="width:100px; height:70px;" src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/zanwuPic2.jpg\'"></div></td><td>'+advert[i].content+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\',1)"><i class=""></i>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\')"><i class=""></i>编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')"><i class=""></i>删除</a></td>';
						}
						$("#advert1").html(html);
					}else if(advert[i].position=='2'){
						if(advert[i].title==''){
							html='<td>2</td><td colspan="3" >(空)</td><td><a href="javascript:;" class="" onclick="show_add(\''+advert[i].position+'\',\''+advert[i].id+'\')"><i class=""></i>上传</a></td>';
						}else{
							html='<td>2</td><td>'+advert[i].title+'</td><td><div><img style="width:100px; height:70px;" src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/zanwuPic2.jpg\'"></div></td><td>'+advert[i].content+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\',1)"><i class=""></i>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\')"><i class=""></i>编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')"><i class=""></i>删除</a></td>';
						}
						$("#advert2").html(html);
						
					}else if(advert[i].position=='3'){
						if(advert[i].title==''){
							html='<td>3</td><td colspan="3" >(空)</td><td><a href="javascript:;" class="" onclick="show_add(\''+advert[i].position+'\',\''+advert[i].id+'\')"><i class=""></i>上传</a></td>';
						}else{
							html='<td>3</td><td>'+advert[i].title+'</td><td><div><img style="width:100px; height:70px;" src="${ctx}/'+advert[i].img+'" onerror="this.src=\'${ctx}/static/images/zanwuPic2.jpg\'"></div></td><td>'+advert[i].content+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\',1)"><i class=""></i>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',\''+advert[i].title+'\',\''+advert[i].img+'\',\''+advert[i].content+'\')"><i class=""></i>编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')"><i class=""></i>删除</a></td>';
						}
						$("#advert3").html(html);
						
					}
				}
			}
		});
	}
	var tid='1';
	function deleteAdvert(id) {
		tid=id;
		parent.parent.window.showConfirm("确定要将选中的数据删除吗?",sureDel);
	}
	
	function sureDel() {
		 $.post('${ctx}/advert/delete',{"id":tid},function(data){
			if(data.result){
				window.location.href = '${ctx}/advert?type=nominate';
			}else{
				
			}
		});  
	}
	function show_add(position,id){
		$("#id").val(id);
		$("#content").val('');
		$("#img").val('');
		$("#title").val('');
		$("#fileimg").attr("src","${ctx}/");
		$("#position").val(position);
	 	$("#content").removeAttr("disabled");
		$("#title").removeAttr("disabled");
		$("#fileToUpload").removeAttr("disabled");
		$("#submit_btn").show();
		if(position==1){
			$("#easyTip").html('(支持jpg,png格式.建议大小280*280)');
		}
		if(position==2){
			$("#easyTip").html('(支持jpg,png格式.建议大小440*140)');
		}
		if(position==3){
			$("#easyTip").html('(支持jpg,png格式.建议大小 440*140)');
		}
		$("#form_categorytype").modal('show');
	}
	function show_edit(position,id,title,img,content,state){
		$("#id").val(id);
		$("#content").val(content);
		if(img.length!=0){
			$("#fileimg").attr("src","${ctx}/"+img);
		}
		$("#img").val(img);
		$("#title").val(title);
		$("#position").val(position);
		if(state==1){
			$("#submit_btn").hide();
			$("#content").attr("disabled","disabled");
			$("#title").attr("disabled","disabled");
			$("#fileToUpload").attr("disabled","disabled");
		}else{
		 	$("#submit_btn").show();
		 	$("#content").removeAttr("disabled");
			$("#title").removeAttr("disabled");
			$("#fileToUpload").removeAttr("disabled");
			
		}
		if(position==1){
			$("#easyTip").html('(支持jpg,png格式.建议大小280*280)');
		}
		if(position==2){
			$("#easyTip").html('(支持jpg,png格式.建议大小440*140)');
		}
		if(position==3){
			$("#easyTip").html('(支持jpg,png格式.建议大小 440*140)');
		}
		$("#form_categorytype").modal('show');
	}
	function Check_Submit(){
		var id=$("#id").val();
		var title=$("#title").val();
		var img=$("#img").val();
		var content=$("#content").val();
		var f1 = content.indexOf("http://");
		var f2 = content.indexOf("https://");
		if($.trim(title).length == 0) {
			window.parent.parent.showAlert("广告名称不能为空！");
			return false;
		}
		if($.trim(img).length == 0){
			window.parent.parent.showAlert("广告图片不能为空！");
			return false;
		}
		if($.trim(content).length != 0){
		//	window.parent.parent.showAlert("广告链接不能为空！");
		//	return false;
			if(f1==0||f2==0){
				$("#inputForm").submit();
			}else{
				window.parent.parent.showAlert("广告链接必须以htts://或http://开头");
				return false;
			}
		}
		else{
			$("#inputForm").submit();
		}	
	}
	function uploadimge(){
		var size=getFileSize("fileToUpload");
		if(size>4194304){
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
		var position=$("#position").val();
	  $.ajaxFileUpload({
		  url:'${ctx}/advert/upfile', //链接到服务器的地址
		  fileElementId:'fileToUpload',  //文件选择框的id属性
		  dataType:'json',
		  success:function(data){
			  if(data['result']==1){
				  if(position==1){
					  /* if(data.width!=280||data.height!=280){
							 window.parent.parent.showAlert("图片尺寸不正确,请确保图片尺寸为280x280!");
								return;
						 }  */
					}
					if(position==2){
						/* if(data.width!=440||data.height!=140){
							 window.parent.parent.showAlert("图片尺寸不正确,请确保图片尺寸为440x140!");
								return;
						 }  */
					}
					if(position==3){
						/* if(data.width!=440||data.height!=140){
							 window.parent.parent.showAlert("图片尺寸不正确,请确保图片尺寸为440x140!");
								return;
						 }  */
					}
				 
			  }
			  $("#fileimg").attr("src","${ctx}/"+data.path);
			  //$("#imgshow").html("");
			  //$("#imgshow").html("<div class=\"span3\" style=\"width:200px;height:200px;margin:0px 0px\"><div class=\"item\"><a href=\"javascript:;\" onclick=\"javascript:fileToUpload.click();\"><img id='fileimg'  src=\"${ctx}/"+data.path+"\" /></a></div></div>");
		      $("#img").val(data.path);
		  },
		  error : function(data) {
				window.parent.parent.showAlert("上传失败");
			}
	  });
	}
	
	function getFileSize(sourceId) {
		return	document.getElementById(sourceId).files.item(0).size;
	}	 
</script>
<body>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
		</div>
		<div class="portlet-body">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 5%;text-align: center;">序号</th>
						<th style="text-align: center;width: 30%;">标题</th>
						<th style="text-align: center;width: 25%;">图片</th>
						<th style="text-align: center;width: 25%;">链接</th>
						<th style="text-align: center;width: 15%;">操作</th>
					</tr>
				</thead>
				<tbody id="tbody" >
					<tr id="advert1">
						<td>1</td>
						<td colspan="3" >(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(1)"><i class=""></i>上传</a></td>
					</tr>
					<tr id="advert2">
						<td>2</td>
						<td colspan="3" >(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(2)"><i class=""></i>上传</a></td>
					</tr>
					<tr id="advert3">
						<td>3</td>
						<td colspan="3" >(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(3)"><i class=""></i>上传</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="modal hide fade" id="form_categorytype" tabindex="-1" role="dialog" style="top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"></button>
				<h3 id="myModalLabel">
					<span id="form_title">
						新增/修改广告
					</span>
				</h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
				<form action="${ctx}/advert/create" method="post" id="inputForm"  class="form-horizontal">
					<div class="control-group">
						<label class="control-label">广告名称:</label>
						<div class="controls">
							<input type="text" id="title"  name="title"  maxlength="20" style="width:60% ;height: 32px" class="title required" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">广告图片</label>
						<div class="controls">
						<input id="fileToUpload" name="fileToUpload" type="file" onchange="uploadimge();" style="display: none"/>
			 			  	<span id="easyTip" name="easyTip"style="color: red; font-size: 10px;">(支持jpg,png格式.建议大小150x150)</span>
			 			  	</br>
		 				 	<div id="imgshow" class="hello" style="float: left;" >
                      	   		<div class="span3"style=" height:250px;width:360px;margin: 0px 0px;">
                           			<div class="item">
                      					 <a href="javascript:;" onclick="javascript:fileToUpload.click();">
											<img id="fileimg" src="${ctx}/static/images/zanwuPic2.jpg" onerror="this.src='${ctx}/static/images/zanwuPic2.jpg'"style="width: 200px;height: 200px;"/>
			  					 		</a>
                      	   			</div>
                     			</div>
                 			</div>   
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">广告链接:</label>
						<div class="controls">
							<textarea id="content" name="content" rows="4" cols="2" style="width:60%;" maxlength="100" ></textarea>
							<input type="hidden" id="id" name="id" value="">
					    	<input type="hidden" id="type" name="type" value="nominate">
					    	<input type="hidden" id="img" name="img" value="">
					    	<input type="hidden" id="position" name="position" value="">
						</div>
					</div>
			</form>
		</div>
		<div class="modal-footer">
			 <input id="submit_btn" class="btn btn-primary green" type="button" onclick="Check_Submit()" value="保存" />&nbsp; 
		</div>
	</div>
</body>
</html>
