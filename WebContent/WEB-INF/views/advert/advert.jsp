<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<title></title>
<%@ include file="../quote.jsp"%>
</head>
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/sy1.png"
					style="vertical-align: text-bottom;" /> <span class="title">广告管理</span>
			</h3>
		</div>
	</div>
	<div class="tabbable tabbable-custom">
		<ul class="nav nav-tabs">
			<li id="tagdata" class="active"><a data-toggle="tab"
				href="#tab_1_1">首页轮播图管理</a></li>
			<li id="tagbig" class=""><a data-toggle="tab" href="#tab_1_2">热门商户管理</a></li>
			<li id="tagtop" class=""><a data-toggle="tab" href="#tab_1_3">首页优惠广告管理</a></li>
		</ul>
		<div class="tab-content">
			<div id="tab_1_1" class="tab-pane  active"
				style="width: 100%; height: 100%; margin: 0;">
				<div
					style="width: 100%; height: 750px; overflow: hidden; margin: 0;"
					id="mymap">
					<iframe id="workArea1" name="workArea" allowtransparency="true"
						style="width: 100%; border: 0px; background-color: #fff;"
						frameborder="0" marginheight="0" marginwidth="0" frameborder="0"
						scrolling="no" height="100%" onLoad="javascript:;"
						src="${ctx}/advert?type=carousel"></iframe>
				</div>
			</div>
			<div id="tab_1_2" class="tab-pane"
				style="width: 100%; height: 100%; margin: 0;">
				<div
					style="width: 100%; height: 750px; overflow: hidden; margin: 0;"
					id="mymap">
					<iframe id="workArea2" name="workArea" allowtransparency="true"
						style="width: 100%; border: 0px; background-color: #fff;"
						frameborder="0" marginheight="0" marginwidth="0" frameborder="0"
						scrolling="no" height="100%" onLoad="javascript:;"
						src="${ctx}/advert?type=nominate"></iframe>
				</div>
			</div>
			<div id="tab_1_3" class="tab-pane"
				style="width: 100%; height: 100%; margin: 0;">
				<div
					style="width: 100%; height: 600px; overflow: hidden; margin: 0;"
					id="mymap">
					<iframe id="workArea3" name="workArea" allowtransparency="true"
						style="width: 100%; border: 0px; background-color: #fff;"
						frameborder="0" marginheight="0" marginwidth="0" frameborder="0"
						scrolling="no" height="100%" onLoad="javascript:;"
						src="${ctx}/advert?type=preferential"></iframe>
				</div>
			</div>
		</div>
	</div>
</body>
</html>