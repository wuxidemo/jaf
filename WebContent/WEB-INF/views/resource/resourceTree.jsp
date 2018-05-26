<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>菜单资源管理</title>
	<link href="${ctx}/static/tree/css/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${ctx}/static/tree/css/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css">
	<link href="${ctx}/static/tree/css/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${ctx}/static/tree/css/uniform/css/uniform.default.css" rel="stylesheet" type="text/css">
	<link href="${ctx}/static/tree/css/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/tree/css/jstree/dist/themes/default/style.min.css"/>
	<link href="${ctx}/static/tree/css/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/tree/css/css/plugins.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/tree/css/css/layout.css" rel="stylesheet" type="text/css"/>
	<link id="style_color" href="${ctx}/static/tree/css/css/default.css" rel="stylesheet" type="text/css"/>
	<link href="${ctx}/static/tree/css/css/custom.css" rel="stylesheet" type="text/css"/>
	
</head>

<body>
	
	<form action="" id="utilform" style="display: none;">
		<input type="hidden" id="setId" value="" />
	</form>
	<div class="row-fluid">
		<div class="span12" style="margin-top:25px;">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				资源管理
			</h3>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6">
			<div class="portlet green-meadow box">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-cogs"></i>菜单层级树图
					</div>
					<div class="actions">
						<a href="javascript:;">&nbsp;</a> 
						<a href="javascript:;" class="btn blue" id="addbtn">新增</a>&nbsp;
						<a href="javascript:;" class="btn yellow" id="updatebtn">修改</a> &nbsp;
						<a href="javascript:;" class="btn red" id="deletebtn">删除</a> 
					</div>
				</div>
				<div class="portlet-body">
					<div id="tree_show" class="tree-demo" style="height:3000px;">
					</div>
				</div>
			</div>
		</div>
		
		<!-- <div class="col-md-8">
			<div class="portlet green-meadow box">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-cogs"></i>菜单层级树图
					</div>
					<div class="actions">
						<a href="javascript:;">&nbsp;</a> 
						<a href="javascript:;" class="btn blue" id="addbtn">新增</a>&nbsp;
						<a href="javascript:;" class="btn yellow" id="updatebtn">修改</a> &nbsp;
						<a href="javascript:;" class="btn red" id="deletebtn">删除</a> 
					</div>
				</div>
				<div class="portlet-body">
					<div id="tree_show2" class="tree-demo" style="height:auto;">
					</div>
				</div>
			</div>
		</div> -->
		
		
	</div>
	<script src="${ctx}/static/tree/js/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/jquery-migrate.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="${ctx}/static/tree/js/jquery-ui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/jquery.cokie.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/jquery.uniform.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/bootstrap-switch.min.js" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="${ctx}/static/tree/js/jstree.min.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	<script src="${ctx}/static/tree/js/ui-tree.js"></script>
	<script src="${ctx}/static/tree/js/metronic.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/layout.js" type="text/javascript"></script>
	<script src="${ctx}/static/tree/js/demo.js" type="text/javascript"></script>
	
	<script>
		function getTree() {
			var str = "{\"id\":\"main\",\"text\":\"所有资源菜单\"";
			$.post("${ctx}/system/resource/getData",function(data){
				
				if(data.length > 0) {
					str = str + ",\"children\":" + data + ",\"state\":{\"opened\":true}"+"}";
				}else{
					str = str + "}";
				}
				
				
				
				var json = JSON.parse(str);
				$('#tree_show').jstree({
		            'plugins': ["wholerow","types"],
		            'core': {
		                "themes" : {
		                    "responsive": false
		                },
		                'data': json
		            }
		        });
			});
		}
		
		
		
        jQuery(document).ready(function() {       
           UITree.init();
           getTree();
           
           var msg = "${msg}";
           if(msg == null || msg == '' || msg == undefined) {
        	   
           }else{
        	   window.parent.showAlert(msg);
           }
           
           $("#tree_show").on("click",function(){
           		var iss = $(".jstree-wholerow-clicked").parent().attr("id");
   				$("#setId").val(iss);
   				setTimeout('window.parent.iFrameHeight();',100);
   			});
           
           
           $("#addbtn").bind("click",function(){
        	   
        	   var addId = $("#setId").val();
        	   if(addId == null || addId == undefined || addId == '0' || addId == '' || $.trim(addId).length == 0) {
        		   window.parent.showAlert("请选择一个菜单!");
        		   return;
        	   }else if($(".jstree-wholerow-clicked").length > 1) {
        		   window.parent.showAlert("不能同时添加多个!");
        		   return;
        	   }else{
        		   window.location.href="${ctx}/system/resource/create2?pid="+addId;
        	   }
           });
           
           $("#updatebtn").bind("click",function(){
        	   
        	   var selectLen = $(".jstree-wholerow-clicked").length;
        	   if(selectLen > 1) {
        		   window.parent.showAlert("为了安全起见,暂不支持批量修改!");
        		   return;
        	   }
        	   
        	   var addId = $("#setId").val();
        	   if(addId == null || addId == undefined || addId == '0' || addId == '' || $.trim(addId).length == 0) {
        		   window.parent.showAlert("请选择要修改的菜单!");
        		   return;
        	   }else if(addId == 'main'){
        		   window.parent.showAlert("默认根菜单不能修改，请确认!");
        		   return;
        	   }else{
        		   window.location.href="${ctx}/system/resource/update2?reid="+addId;
        	   }
           });
           
           function sureDel() {
        	   var urlget = "${ctx}/system/resource/delete2";
    		   $.post(urlget,{"reId":$("#setId").val()},function(data){
    			   if(data) {
    				   if(data.result == '1') {
    					   window.parent.showAlert(data.msg);
    					   window.location.href="${ctx}/system/resource/tree"; 
    				   }else{
    					   window.parent.showAlert(data.msg);
    					   window.location.href="${ctx}/system/resource/tree"; 
    				   }
    			   }else{
    				   window.parent.showAlert("删除失败，请重试!");
    				   window.location.href="${ctx}/system/resource/tree"; 
    			   }
    		   });
           }
           
           $("#deletebtn").bind("click",function(){
        	   
        	   var selectLen = $(".jstree-wholerow-clicked").length;
        	   if(selectLen > 1) {
        		   window.parent.showAlert("为了安全起见,暂不支持批量删除!");
        		   return;
        	   }
        	           	   
        	   var addId = $("#setId").val();
        	   if(addId == null || addId == undefined || addId == '0' || addId == '' || $.trim(addId).length == 0) {
        		   window.parent.showAlert("请选择要删除的菜单!");
        		   return;
        	   }else if(addId == 'main'){
        		   window.parent.showAlert("默认根菜单不能删除，请确认!");
        		   return;
        	   }else{
        		   var reName = $("#"+addId+" > a").last().text();
        		   window.parent.showConfirm("你确定要删除菜单&nbsp;&nbsp;<span style=\"color:red;font-size:1.5em;\">"+reName+"</span>&nbsp;&nbsp;吗?",sureDel);
        	   }
           });
           
        });
	</script>
</body>
</html>
