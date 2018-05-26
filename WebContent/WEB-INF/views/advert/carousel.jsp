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
</head>
<style type="text/css">
#contentTable td{
	WORD-WRAP: break-word;
	text-align: center;
}
</style>
<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>

<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.min.js"></script>

<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>

<script type="text/javascript">
	jQuery(document).ready(function() {
		
		getList();
		dis1();
		window.parent.scroll(0,0);
	    ue = UE.getEditor('container',{
		    toolbars: [
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload', 'insertimage']
		          ],
	        autoHeightEnabled: false,
	        autoFloatEnabled: true,
		    });
	})
	
	function getList(){
		var type='carousel';
		var url="${ctx}/advert/getList";
		$.post(url,{"type":type},function(data){
			if(data.result){
				var advert=data.data;
				var length=advert.length;
				var html='';
				for(var i=0;i<length;i++){
					if(advert[i].position=='1'){
						if(advert[i].title==''){
							html='<td>1</td><td>URL地址</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
						}else{
							html='<td>1</td><td>'+advert[i].title+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
						}
						$("#advert1").html(html);
					}if(advert[i].position=='2'){
						 if(advert[i].title==''){
							 html='<td>2</td><td>URL地址</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
						}else{
							html='<td>2</td><td>'+advert[i].title+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
						 } 
						$("#advert2").html(html);
						
					}if(advert[i].position=='3'){
						if(advert[i].title==''){
							html='<td>3</td><td>URL地址</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
						}else{
							html='<td>3</td><td>'+advert[i].title+'</td><td><a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\',1)">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="show_edit(\''+advert[i].position+'\',\''+advert[i].id+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:;" onclick="deleteAdvert(\''+advert[i].id+'\')">删除</a></td>'
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
				window.location.href = '${ctx}/advert?type=carousel';
			}else{
				
			}
		});  
	}
	
	function show_add(position){
		$("#id").val("");
		ue.setContent("");
		$("#title").val("");
		$("#fileimg").attr("src","${ctx}/static/images/zanwuPic2.jpg");
		$("#position").val(position);
		$("#title").removeAttr("disabled");
		$("#fileToUpload").removeAttr("disabled");
		$("#submit_btn").show();
		$("#form_categorytype").modal('show');
		$("#in1").removeAttr("disabled");
		$("#in2").removeAttr("disabled");
	}
	
	function show_edit(position,id,state){
		$.post("${ctx}/advert/getOne",{"id":id},function(data){
			if(data.result){
				var ad=data.data;
				var value=ad.type2;
				$("input:radio[name=type2][value='"+value+"']").prop( "checked", true );
			     if(value==0){
			    	 $("#ul").css("display","none"); 
			    	 $("#ggname").css("display",""); 
			    	 $("#ggms").css("display",""); 
			     }else{
			    	 $("#ul").css("display",""); 
			    	 $("#ggname").css("display","none"); 
			    	 $("#ggms").css("display","none");  
			     }
				
				$("#url").val(ad.url);
				$("#title").val(ad.title);
				ue.setContent(ad.content);
				if(ad.img.length!=0){
					$("#fileimg").attr("src","${ctx}/"+ad.img);
				}
				$("#img").val(ad.img);
			}
		});
		$("#id").val(id);
		$("#position").val(position);
		if(state==1){
			 
			$("#submit_btn").hide();
			ue.setDisabled('fullscreen');
			$("#title").attr("disabled","disabled");
			$("#fileToUpload").attr("disabled","disabled");
			$("#in1").attr("disabled","disabled");
			$("#in2").attr("disabled","disabled");
		}else{
			ue.setEnabled();
		 	$("#submit_btn").show();
			$("#title").removeAttr("disabled");
			$("#fileToUpload").removeAttr("disabled");
			$("#in1").removeAttr("disabled");
			$("#in2").removeAttr("disabled");
		}
		$("#form_categorytype").modal('show');
	}
	
	function Check_Submit(){
		var a1='';
		var obj = document.getElementsByName("type2");
		for(var i=0; i<obj.length; i ++){
	        if(obj[i].checked){
	            var a1=obj[i].value;
	        }
	    }
		var url=$("#url").val();
		
		var id=$("#id").val();
		var title=$("#title").val();
		var img=$("#img").val();
		if(a1!=1 && $.trim(title).length == 0) {
			window.parent.parent.showAlert("广告名称不能为空！");
			return false;
		}
	 	if(a1!=0 && $.trim(url).length == 0) {
			window.parent.parent.showAlert("url不能为空！");
			return false;
		}  
		if($.trim(img).length == 0){
			window.parent.parent.showAlert("广告图片不能为空！");
			return false;
		}
		$("#inputForm").submit();	
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
	  $.ajaxFileUpload({
		  url:'${ctx}/advert/upfile', //链接到服务器的地址
		  fileElementId:'fileToUpload',  //文件选择框的id属性
		  dataType:'json',
		  success:function(data){
			  if(data['result']==1){
				 /* if(data.width!=720||data.height!=252){
					 window.parent.parent.showAlert("图片尺寸不正确,请确保图片尺寸为720*252!");
						return;
				 }  */
			  }
			  //$("#imgshow").html("");
			  $("#fileimg").attr("src","${ctx}/"+data.path);
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
	
	
	function dis1(){
		 $("#in1").prop( "checked", true );
		 $("#ul").css("display","none"); 
		 $("#ggname").css("display",""); 
		 $("#ggms").css("display",""); 
	}
	
	function dis2(){
		 $("#ul").css("display",""); 
		 $("#ggname").css("display","none"); 
		 $("#ggms").css("display","none"); 
		
		 
	}
</script>
<body>
	<div class="portlet box grey">
		<div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>列表
			</div>
		</div>
		<div class="portlet-body"  style="height: 500px;">
			<table id="contentTable" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 5%;text-align: center;">序号</th>
						<th style="text-align: center;width: 45%">广告标题</th>
						<th style="text-align: center;width: 50%">操作</th>
					</tr>
				</thead>
				<tbody id="tbody" >
					<tr id="advert1">
						<td>1</td>
						<td>(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(1)"><i class=""></i>上传</a></td>
					</tr>
					<tr id="advert2">
						<td>2</td>
						<td>(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(2)"><i class=""></i>上传</a></td>
					</tr>
					<tr id="advert3">
						<td>3</td>
						<td>(空)</td>
						<td><a href="javascript:;" class="" onclick="show_add(3)"><i class=""></i>上传</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="modal hide fade" id="form_categorytype" tabindex="-1"  role="dialog" style="z-index:129; top: 10%;width: 50%; left: 40%;">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"></button>
				<h3 id="myModalLabel">
					<span id="form_title">新增/修改广告</span>
				</h3>
			</div>
			<div id="" class="modal-body" style="font-size: 35; ">
				<form action="${ctx}/advert/create" method="post" id="inputForm"  class="form-horizontal">
					<div class="control-group">
						<label class="control-label">广告图片</label>
						<div class="controls">
						<input id="fileToUpload" name="fileToUpload" type="file"onchange="uploadimge();" style="display: none"/>
				 			 <span name="easyTip"style="color: red; font-size: 10px;">(支持jpg,png格式.建议大小720*252)</span>
				 			 </br>
					 		 <div id="imgshow" class="hello" style="float: left;" >
	                        	  <div class="span3" style="height:120px;width:360px; margin: 0px 0px;">
                               			<div class="item">
                         					 <a href="javascript:;" onclick="javascript:fileToUpload.click();">
												<img id="fileimg" src="${ctx}/static/images/zanwuPic2.jpg" onerror="this.src='${ctx}/static/images/zanwuPic2.jpg'"style="width: 200px;height: 200px"/>
						  					 </a>
                         	   			</div>
                       			  </div>
	                   		</div>   
						</div>
					</div>
					<!--    单选处 -->
					 <div class="control-group" style="margin-top: 100px; margin-left: 180px">
					    <table>
					       <tr>
					       		<td><input type="radio" name="type2" value="0" onclick="dis1()" id="in1"></td>
					       		<td style="width: 60%;"><font>图文链接</font></td>
					        	<td><input type="radio" name="type2" value="1" onclick="dis2()" id="in2"></td>
					       		<td><font>URL</font></td>
					       </tr>
					    </table>
					 </div>
					
					<div class="control-group" id="ul">
						<label class="control-label">URL:</label>
						<div class="controls">
							<input type="text" id="url"  name="url"   style="width:60% ;height: 32px" class="title required" />
						</div>
					</div>
					
					<div class="control-group" id="ggname">
						<label class="control-label">广告名称:</label>
						<div class="controls">
							<input type="text" id="title"  name="title"  maxlength="20" style="width:60% ;height: 32px" class="title required" />
						</div>
					</div>
					
					<div class="control-group"style="margin-top: 20px;"id="ggms">
						<label class="control-label">广告描述:</label>
						<div class="controls">
							<script id="container" name="content" style="width:78%;height:150px;" type="text/plain"></script>
							<input type="hidden" id="id" name="id" value="">
					    	<input type="hidden" id="type" name="type" value="carousel">
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
