<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>jsTree</title>
	<meta name="viewport" content="width=device-width" />
	<!--[if lt IE 9]><script src="./assets/html5.js"></script><![endif]-->
	
	<meta name="robots" content="index,follow" />
	<link rel="stylesheet" href="${ctx}/static/assets/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${ctx}/static/assets/dist/themes/default/style.min.css" />
	<link rel="stylesheet" href="${ctx}/static/assets/docs.css" />
	<!--[if lt IE 9]><script src="./assets/respond.js"></script><![endif]-->
	
	<link rel="icon" href="${ctx}/static/assets/favicon.ico" type="image/x-icon" />
	<link rel="apple-touch-icon-precomposed" href="./assets/apple-touch-icon-precomposed.png" />
	<script>window.$q=[];window.$=window.jQuery=function(a){window.$q.push(a);};</script>
	<script src="${ctx}/static/assets/jquery-1.10.2.min.js"></script>
	<script src="${ctx}/static/assets/jquery.address-1.6.js"></script>
	<script src="${ctx}/static/assets/vakata.js"></script>
	<script src="${ctx}/static/assets/dist/jstree.min.js"></script>
<%-- 	<script src="${ctx}/static/assets/docs.js"></script> --%>
	<script>$.each($q,function(i,f){$(f)});$q=null;</script>
</head>
<body>
<div class="row page" id="demo" style="display: block; min-height: 2597px;"">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-4 col-sm-8 col-xs-8">
						<button type="button" class="btn btn-success btn-sm" onclick="demo_create();"><i class="glyphicon glyphicon-asterisk"></i> Create</button>
						<button type="button" class="btn btn-warning btn-sm" onclick="demo_rename();"><i class="glyphicon glyphicon-pencil"></i> Rename</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="demo_delete();"><i class="glyphicon glyphicon-remove"></i> Delete</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="demo_show();"><i class="glyphicon glyphicon-remove"></i>Show</button>
					</div>
					<!-- <div class="col-md-2 col-sm-4 col-xs-4" style="text-align:right;">
						<input type="text" value="" style="box-shadow:inset 0 0 4px #eee; width:120px; margin:0; padding:6px 12px; border-radius:4px; border:1px solid silver; font-size:1.1em;" id="demo_q" placeholder="Search" />
					</div> -->
				</div>
				<div class="row">
					<div class="col-md-6">
						<div id="jstree_demo" class="demo" style="margin-top:1em; min-height:400px;"></div>
						<script>
						function demo_create() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							sel = sel[0];
							sel = ref.create_node(sel, {"type":"file"});
							if(sel) {
								ref.edit(sel);
							}
						};
						function demo_rename() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							sel = sel[0];
							ref.edit(sel);
						};
						function demo_delete() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							ref.delete_node(sel);
						};
						$(function () {
							var to = false;
							$('#demo_q').keyup(function () {
								if(to) { clearTimeout(to); }
								to = setTimeout(function () {
									var v = $('#demo_q').val();
									$('#jstree_demo').jstree(true).search(v);
								}, 250);
							});
							$('#jstree_demo')
								.jstree({
									"core" : {
										"animation" : 0,
										"check_callback" : true,
										"themes" : { "stripes" : true },
										'data' : {
											'url' :  '${ctx}/static/assets/ajax_demo_children.json',
											 'data' : function (node) {
												return {'id' : node.id }
									
											 }
										}
									},
									"types" : {
										"#" : { "max_children" : 2, "max_depth" : 4, "valid_children" : ["root"] },
										"root" : { "icon" : "${ctx}/static/assets/images/tree_icon.png", "valid_children" : ["default"] },
										"default" : { "valid_children" : ["default","file"] },
										"file" : { "icon" : "glyphicon glyphicon-file", "valid_children" : [] }
									},
									"plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow", "checkbox" ]
								});
						});
							 $('#jstree_demo').bind("select_node.jstree", function(e, data) {
								var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
								//alert(sel);
							}); 
							 function demo_show(){
							 //使用get_checked方法 
								var ref = $('#jstree_demo').jstree(true),
								 sel = ref.get_selected();
							    alert(sel);
							 }
						</script>
					</div>
					</div>
					</div>
					</div>
</body>
</html>