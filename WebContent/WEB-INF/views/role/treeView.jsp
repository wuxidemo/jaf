<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>修改角色权限</title>
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
	
	<form action="${ctx}/system/role/saveRoleRes" id="utilform" style="display: none;">
		<input type="hidden" id="roleId" name="roleId" value="${roleId}" />
		<input type="hidden" id="page" name="page" value="${page}">
	</form>
	<div class="row-fluid">
		<div class="span12" style="margin-top:25px;">
			<h3 class="page-title"><img src="${ctx}/static/images/xtgl.png" style="vertical-align: text-bottom;"/> 
				修改角色权限
			</h3>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="portlet green-meadow box">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-cogs"></i>菜单层级树图
					</div>
					<div class="actions">
						<a href="javascript:;">&nbsp;</a> 
						<a href="javascript:;" class="btn blue" id="addbtn">保存</a>&nbsp;
						<a href="javascript:;" class="btn red"  onclick="history.back()" id="cancelbtn">取消</a> 
					</div>
				</div>
				<div class="portlet-body">
					<div id="tree_show" class="tree-demo" style="height:1800px;">
					</div>
				</div>
			</div>
		</div>
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
	
		var scrollHeight=0;	
	
		function getTree() {
			var str = "{\"id\":\"main\",\"text\":\"所有资源菜单\",\"children\":";
			$.post("${ctx}/system/role/getData",{"roleId":$("#roleId").val()},function(data){
				str = str + data + ",\"state\":{\"opened\":true}"+"}";
				var json = JSON.parse(str);
				$('#tree_show').jstree({
		            'plugins': ["wholerow","checkbox","types"],
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
           window.parent.iFrameHeight();
           
           $("#tree_show").on("click",function(){
        	   	scrollHeight = window.parent.pageYOffset;
        	   	window.parent.scrollTo(0,scrollHeight);
   				//setTimeout('window.parent.iFrameHeight();',100);
   			});
           
           var idstr='';
           
           function sureSave() {
        	   $("#utilform").append('<input name="ids" value="'+idstr.substring(0,idstr.length-1)+'"/>');
    		   $("#utilform").submit(); 
           }
           
           
           $("#addbtn").bind("click",function(){
        	  
        	   var str = "";
        	   $(".jstree-wholerow-clicked").each(function(){
        		   str += $(this).parent().attr("id")+"#";
        	   });
        	   if($.trim(str).length > 0) {
        		   idstr = str;
        		   window.parent.showConfirm("你确定要修改权限吗？",sureSave);
        		   
        	   }else{
        		   window.parent.showAlert("你没有选择任何资源!");
        		   return;
        	   }
           });
        });
	</script>
</body>
</html>
