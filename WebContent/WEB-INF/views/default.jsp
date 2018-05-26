<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.yjy.entity.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
	User user1 = (User)request.getSession().getAttribute("user");
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8" />
<link rel="shortcut icon" href="${ctx}/static/images/headimg.jpg" type="image/x-icon" />
<title>金阿福e服务 综合服务管理平台</title>
<style type="text/css">
.show_message_none div ul li:HOVER{
	cursor: pointer;
}
.show_message_none div ul li:LINK{
	color:#ff00ff;
}
.show_message_none div ul li:AFTER{
	color:#ff00ff;
}
.show_message_none div ul li{
	height: 15px; 
	line-height: 15px; 
	padding-bottom: 3px; 
	border-bottom: 1px solid #000;
	margin-bottom: 5px;
	display:inline-block;
}
</style>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<meta content="度维,金阿福e服务" name="keywords">
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${ctx}/static/mt/media/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/bootstrap-responsive.min.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/static/mt/media/css/style-responsive.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet"
	type="text/css" id="style_color" />
<link href="${ctx}/static/mt/media/css/uniform.default.css"
	rel="stylesheet" type="text/css" />
<link href="${ctx}/static/css/phonebox.css" rel="stylesheet"
	type="text/css" />

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/mt/media/js/jquery-migrate-1.2.1.min.js"
	type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="${ctx}/static/mt/media/js/jquery-ui-1.10.1.custom.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/mt/media/js/bootstrap.min.js"
	type="text/javascript"></script>
<!--[if lt IE 9]>
	<script src="${ctx}/static/mt/media/js/excanvas.min.js"></script>
	<script src="static/mt/media/js/respond.min.js"></script>  
	<![endif]-->
<script src="${ctx}/static/mt/media/js/jquery.slimscroll.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/mt/media/js/jquery.blockui.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/mt/media/js/jquery.cookie.min.js"
	type="text/javascript"></script>
<script src="${ctx}/static/mt/media/js/jquery.uniform.min.js"
	type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<script src="${ctx}/static/mt/media/js/app.js"></script>
<script src="${ctx}/static/phonebox/myuboxweb.js"></script>
<!-- websocket -->
<script type="text/javascript" src="${ctx}/static/wxfile/wuye/js/sockjs-1.1.0.min.js"></script>
<script>
	jQuery(document).ready(function() {
		App.init();
		setAct();
		//checkNotice();
		<%
			if(user1.getRole() != null) {
				if(user1.getRole().getId() == -10){
		%>
					show_message_yw();
					connect();//websocket初始化
		<%
				}
			}
		%>
	});


	function setAct(hash) {
		if (hash == "" || hash == null) {
			hash = window.location.hash;
		}
		$("#menu li").each(
				function() {
					$(this).attr("class", "");
					if ($(this).children("a").children('img').next().next()
							.attr("class") == "arrow open") {
						$(this).children("a").children('img').next().next()
								.attr("class", "arrow");
					}

				});
		$("#menu ul").each(function() {
			$(this).css("display", "none");

		});
		$("#menu li a").each(function() {
			if (hash == $(this).attr("href")) {
				//$(this).append("<span class=\"selected\"></span>");
				$(this).parent().attr("class", "active");
			}
		});

		$("#menu li ul li a").each(
				function() {
					if (hash == $(this).attr("href")) {
						//$(this).parent().parent().parent().each(function(){
						//	$(this).attr("class","active");
						//});
						$(this).parent().parent().parent().attr("class",
								"active");
						$(this).parent().parent().prev().children('img').next()
								.next().attr("class", "arrow open");
						$(this).parent().parent().css("display", "");
					}

				});
	}
	//将页面显示在工作区
	function loadframe(pageName, hash) {
		window.parent.window.document.getElementById('workArea').src = pageName;
		setAct(hash);
	}

	function iFrameHeight() {
		var down = "workArea";
		var pTar = null;
		if (document.getElementById) {
			pTar = document.getElementById(down);
		} else {
			eval('pTar = ' + down + ';');
		}
		pTar.height = 500;
		if (pTar && !window.opera) {
			//begin resizing iframe
			pTar.style.display = "block";
			if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight) {
				//ns6 syntax
				pTar.height = pTar.contentDocument.body.offsetHeight + 30;
				//	pTar.width = pTar.contentDocument.body.scrollWidth+20;
			} else if (pTar.Document && pTar.Document.body.scrollHeight) {
				//ie5+ syntax
				pTar.height = pTar.Document.body.scrollHeight + 30;
				//pTar.width = pTar.Document.body.scrollWidth;
			}
		}
	}

	function iFramescrollHeight(height) {
		var down = "workArea";
		var pTar = null;
		if (document.getElementById) {
			pTar = document.getElementById(down);
		} else {
			eval('pTar = ' + down + ';');
		}
		pTar.height = height;

	}

	function showAlert(alertMsg) {
		$("#alertContent").html(alertMsg);
		$('#myModalAlert').modal('show');
	}
	function closeAlert() {
		$('#myModalAlert').modal('hide');
	}
	var fntemp = '';
	function showConfirm(confirmMsg, fn) {
		$("#confirmContent").html(confirmMsg);
		$('#myModalConfirm').modal('show');
		$("#surebtn").attr("onclick", "callChild(" + fn + ")");
		fntemp = fn;
	}

	function callChild(fn) {
		/* window.frames["workArea"].deleteSelected(); */
		fntemp();
	}

	/* function backtochild() {
		callChild();
	} */

	function showcheck(id, url, type, which, mediatype, newid) {
		if (mediatype == "1") {
			$("#checkcotent")
					.html("<div><img src=\"${ctx}\/"+url+"\" /></div>");

		} else {
			$("#checkcotent")
					.html(
							"<div class=\"video-js-box\"><video id=\"example_video_1\" class=\"video-js\" width=\"500\" height=\"500\" controls=\"controls\" preload=\"auto\" ><source src=\""+url+"\" type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"' /></video></div>");

			//s VideoJS.setupAllWhenReady();
		}
		//$('#checkshow').css("left",((document.documentElement.clientWidth-225)/3+225)+"px");
		//$('#checkshow').css("top","600px");
		$("#passbtn").attr(
				"onclick",
				"window.frames[\"workArea\"].docheck(" + id + "," + type + ",'"
						+ which + "',1," + newid + ")");
		$("#unpassbtn").attr(
				"onclick",
				"window.frames[\"workArea\"].docheck(" + id + "," + type + ",'"
						+ which + "',0," + newid + ")");
		if (newid) {
			$("#unpassbtn").css("display", "");
		} else {
			$("#unpassbtn").css("display", "none");
		}
		$('#checkshow').modal('show');

	}
	function closcheck() {
		$('#checkshow').modal('hide');
		$("#checkcotent").html("");
	}
	function closeLonding() {
		$('#loadingshow').modal('hide');
		//$("#checkcotent").html("");
	}
	function showLonding() {
		$('#loadingshow').modal('show');
	}
	
	function addChildAlert(obj,id)
	{
		 var tt = obj.clone(true); 
		$(document.body).append(tt);
		$("#"+id).modal('show');
	}
	function removeChildAlert(id)
	{
		$("#"+id).modal('hide');
		$("#"+id).remove();
		//$(this).append(obj);
	}
	/*********消息提示框***********/
	function show_message_yw(){
		$("#show_detail_mes_yw").delegate("li","click",function(){
			loadframe('/nsh/pensionapply','#/pensionapply');
			$("#show_message").css("display","none");
		});
		$("#show_message").delegate("img","click",function(){
			$("#show_message").css("display","none");
			$("#show_message_num").html("0");
		});
	}
	var websocket;
	var url='ws://ts.do-wi.cn:8180/dwsocket/websocket';
	function connect(){
		if ('WebSocket' in window) {
			websocket = new WebSocket(url);
		} else if ('MozWebSocket' in window) {
			websocket = new MozWebSocket(url);
		} else {
			websocket = new SockJS(url);
		}
		websocket.onopen = function (evnt) {//主动连接服务器端
		};
		websocket.onmessage = function (evnt) {//接受服务器端返回的信息
			on_log();
		};
		websocket.onerror = function (evnt) {//断开连接或连接超时等异常
		};
		websocket.onclose = function (evnt) {//服务器端关闭连接或断开连接的操作
		}
	} 
	function on_log() {
		show_audio();
		$("#show_message").css("display","block");
		var num = $("#show_message_num").html();
		$("#show_message_num").html(parseInt(num,10)+1);
	}
	function show_audio(){
		document.getElementById("nn").play();	
	}
</script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed"
	style="background-color: #eee !important;">
	<%@ include file="header.jsp"%>

	<div id="myModalAlert" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalAlertLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>
			<h3 id="myModalAlertLabel">提示</h3>
		</div>
		<div id="alertContent" class="modal-body"></div>
		<div class="modal-footer">
			<button data-dismiss="modal" class="btn blue">确定</button>
		</div>
	</div>
	<div id="myModalConfirm" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalConfirmLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true"></button>
			<h3 id="myModalConfirmLabel">确认</h3>
		</div>
		<div id="confirmContent" class="modal-body"></div>
		<div class="modal-footer">
			<button data-dismiss="modal" class="btn blue" id="surebtn" onclick="">确定</button>
			<button class="btn" data-dismiss="modal" aria-hidden="true"
				id="cancelbtn">取消</button>
		</div>
	</div>



	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<div class="page-sidebar nav-collapse collapse"
			style="background-color: #f9f9f9; height: auto">
			<!-- BEGIN SIDEBAR MENU -->
			<ul id="menu" class="page-sidebar-menu" style="height: auto">
				<li>
					<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					<div class="sidebar-toggler hidden-phone"></div>
				</li>

				<%-- <li class=""><a href="#index"
					onclick="loadframe('${ctx}/report','#index');"><img src="${ctx}/static/images/sy.png"/> 
						<span class="title">首页</span> <span class="selected"></span>
				</a></li>
				<li><a href="#"> <img src="${ctx}/static/images/pz.png"/>  
				<span class="title">系统管理</span> <span class="arrow "></span> <span class="selected"></span></a>
				<ul class="sub-menu">
						<li><a href="#system/categorytype"
							onclick="loadframe('${ctx}/system/categorytype','#system/categorytype');">
								字典项管理 </a></li>
					<li><a href="#system/categoryvalue"
							onclick="loadframe('${ctx}/system/categoryvalue','#system/categoryvalue');">
								字典值管理</a></li>
					<li><a href="#system/user"
							onclick="loadframe('${ctx}/system/user','#system/user');">
								用户管理</a></li>
					<li><a href="#system/role"
							onclick="loadframe('${ctx}/system/role','#system/role');">
								角色管理</a></li>
					<li><a href="#system/resource/tree"
							onclick="loadframe('${ctx}/system/resource/tree','#system/resource/tree');">
								资源管理</a></li>
					
				</ul></li> --%>

				<c:forEach items="${menuList}" var="one">
					<c:forEach items="${one }" var="entry">
						<li class=""><c:if test="${fn:length(entry.value) != 0}">
								<a href="#"> <img
									src="${ctx}/static/images/${entry.key.logo}" /> <span
									class="title">${entry.key.name}</span> <span class="arrow "></span>
									<span class="selected"></span>
								</a>
								<ul class="sub-menu">
									<c:forEach items="${entry.value}" var="two">
										<li><a href="#${two.url}"
											onclick="loadframe('${ctx}${two.url }','#${two.url}');">${two.name}</a>
										</li>
									</c:forEach>
								</ul>
							</c:if> <c:if test="${fn:length(entry.value) == 0}">
								<a href="#${entry.key.url}"
									onclick="loadframe('${ctx}${entry.key.url }','#${entry.key.url}');">
									<img src="${ctx}/static/images/${entry.key.logo}" /> <span
									class="title">${entry.key.name}</span> <span class="selected"></span>
								</a>
							</c:if></li>
					</c:forEach>
				</c:forEach>


				<%-- <li class=""><a href="#user"
					onclick="loadframe('${ctx}/user','#user');"> <img src="${ctx}/static/images/zh.png"/> 
					<span class="title">用户管理</span> <span
						class="selected"></span>
				</a></li>
				 --%>

			</ul>
			<!-- END SIDEBAR MENU -->
		</div>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>portlet Settings</h3>
				</div>
				<div class="modal-body">
					<p>Here will be a configuration form</p>
				</div>
			</div>
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<iframe id="workArea" name="workArea" allowtransparency="true"
					style="width: 100%; border: 0px; background-color: #fff;"
					frameborder="0" marginheight="0" marginwidth="0" frameborder="0"
					scrolling="no" width="100%" onLoad="javascript:iFrameHeight();"
					src="${ctx}/report"></iframe>
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>

	<!-- END CONTAINER -->
	<%-- <%@ include file="footer.jsp"%> --%>
	<!-- showMessager -->
	<div id="show_message" class="show_message_none"
		style="position: fixed; bottom: 20px; right: 0px; width: 200px; border: 1px #000 solid; background-color: #fff; display: none;">
		<img alt="" src="${ctx}/static/wxfile/images/close.png" style="position: absolute; top:4px; right: 4px; background-color: #ff0000; width: 13px; height: 13px;">
		<div id="show_message_cont" style="text-align: center; margin-top: 20px; padding:0px 10%;">
			<ul style="list-style: none; margin: 0px;" id="show_detail_mes_yw">
				<li>有新的养老申请需要处理!</li>
			</ul>
		</div>
		<div style="text-align: right; margin-right: 10px;">
			<p><b style="color: #ff00ff;" id="show_message_num">0</b>条消息</p>
			<audio controls="controls" id="nn" style="display: none;">
		  		<source src="${ctx}/static/wxfile/wuye/mp3/ces.mp3" type="audio/mpeg">
			</audio>
		</div>
	</div>
</body>
</html>