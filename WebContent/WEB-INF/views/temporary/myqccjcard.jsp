<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<link rel="stylesheet"
	href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">

<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css"
	type="text/css" rel="stylesheet">
<link href="${ctx}/static/css/index.css" rel="stylesheet"
	type="text/css" />

<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>



<title>我的</title>
<script type="text/javascript">
	function Load(src) {
		window.location.href = src;
	}
</script>

</head>
<body>
	<div class="page">

		<div
			style="width: 100%;margin-top: 0px;background-image: url(${ctx}/static/images/02.jpg);background-size:100% 200px; padding-top: 20px;padding-bottom: 20px;">
			<div
				style="width: 90px; height: 90px; border-radius: 50%; overflow: hidden;margin-left: 20px;">
				<img src="${url}" />
			</div>
			<div
				style="position: absolute; left: 120px; width: auto; height: auto; top: 90px;">
				<font style="color:3e3a39"> ${name}
			</div>
		</div>


		<a href="${ctx}/wxpage/ord" class="">
			<div
				style="width: 94.5%; height: 30px; background-color: #FAFAFA; margin-top: 10px; padding: 10px; border-top: solid 1px #cecece; border-bottom: solid 1px #cecece">

				<div style="float: left; margin-top: -2px; margin-bottom: 5px;">
					<table>
						<tr>
							<td
								style="text-align: center; vertical-align: middle; padding-top: 3px;"><img
								src="${ctx}/static/images/15.png" alt=""
								style="width: 25px; height: 25px;" /></td>
							<td><font style="color: black;"> &nbsp;&nbsp;我的订单</font></td>
						</tr>
					</table>
				</div>
				<div style="float: right; padding-right: 5px; margin-top: 8px">
					<img src="${ctx}/static/images/11.png" alt=""
						style="width: 10px; height: 15px;" />
				</div>

			</div>
		</a> <a href="${ctx}/wxpage/red" class="">
			<div
				style="width: 94.5%; height: 30px; background-color: #FAFAFA; margin-top: 5px; padding: 10px; border-top: solid 1px #cecece; border-bottom: solid 1px #cecece;">

				<div style="float: left; margin-top: -2px; margin-bottom: 5px;">
					<table>
						<tr>
							<td
								style="text-align: center; vertical-align: middle; padding-top: 3px;"><img
								src="${ctx}/static/images/05.png" alt=""
								style="width: 25px; height: 25px;" /></td>
							<td><font style="color: black;">&nbsp;&nbsp;我的红包</font></td>
						</tr>
					</table>
				</div>
				<div style="float: right; padding-right: 5px; padding-top: 8px">
					<img src="${ctx}/static/images/11.png" alt=""
						style="width: 10px; height: 15px;" />

				</div>
			</div>
		</a>
         
         <a href="${ctx}/wxurl/redirect?url=wxcard/mycardlist" class="">
			<div
				style="width: 94.5%; height: 30px; background-color: #FAFAFA; margin-top: 5px; padding: 10px; border-top: solid 1px #cecece; border-bottom: solid 1px #cecece;">

				<div style="float: left; margin-top: -2px; margin-bottom: 5px;">
					<table>
						<tr>
							<td
								style="text-align: center; vertical-align: middle; padding-top: 3px;"><img
								src="${ctx}/static/images/my_15.png" alt=""
								style="width: 25px; height: 25px;" /></td>
							<td><font style="color: black;">&nbsp;&nbsp;我的优惠券</font></td>
						</tr>
					</table>
				</div>
				<div style="float: right; padding-right: 5px; padding-top: 8px">
					<img src="${ctx}/static/images/11.png" alt=""
						style="width: 10px; height: 15px;" />

				</div>
			</div>
		</a>
		
		<%-- <a href="${ctx}/wxurl/redirect?url=wxcard/mybankcard" class="">
			<div
				style="width: 94.5%; height: 30px; background-color: #FAFAFA; margin-top: 5px; padding: 10px; border-top: solid 1px #cecece; border-bottom: solid 1px #cecece;">

				<div style="float: left; margin-top: -2px; margin-bottom: 5px;">
					<table>
						<tr>
							<td
								style="text-align: center; vertical-align: middle; padding-top: 3px;"><img
								src="${ctx}/static/images/my_16.png" alt=""
								style="width: 25px; height: 25px;" /></td>
							<td><font style="color: black;">&nbsp;&nbsp;我的银行卡</font></td>
						</tr>
					</table>
				</div>
				<div style="float: right; padding-right: 5px; padding-top: 8px">
					<img src="${ctx}/static/images/11.png" alt=""
						style="width: 10px; height: 15px;" />

				</div>
			</div>
		</a>
		
		<c:if test="${mgs==true}">
		<a href="${ctx}/wxurl/redirect?url=wxcard/jflist" class="">
			<div
				style="width: 94.5%; height: 30px; background-color: #FAFAFA; margin-top: 5px; padding: 10px; border-top: solid 1px #cecece; border-bottom: solid 1px #cecece;">

				<div style="float: left; margin-top: -2px; margin-bottom: 5px;">
					<table>
						<tr>
							<td
								style="text-align: center; vertical-align: middle; padding-top: 3px;"><img
								src="${ctx}/static/images/my_17.png" alt=""
								style="width: 25px; height: 25px;" /></td>
							<td><font style="color: black;">&nbsp;&nbsp;积分兑换</font></td>
						</tr>
					</table>
				</div>
				<div style="float: right; padding-right: 5px; padding-top: 8px">
					<img src="${ctx}/static/images/11.png" alt=""
						style="width: 10px; height: 15px;" />

				</div>
			</div>
		</a> --%>
		<%-- </c:if> --%>
	</div>

	<div class="top_bar" style="-webkit-transform: translate3d(0, 0, 0)">
		<nav>
			<ul id="top_menu" class="top_menu">
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/advert/wxindex')"><img
						src="${ctx}/static/index/images/index_1_1.png"><label
						style="color: white; text-shadow: none;">首页</label></a></li>
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxpage/merlist')"><img
						src="${ctx}/static/index/images/index_2_1.png"><label
						style="color: white; text-shadow: none;">商家</label></a></li>
			<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxcard/cardlist')"><img
						src="${ctx}/static/index/images/index_3_1.png"><label
						style="color: white; text-shadow: none;">优惠</label></a></li>
				<li><a href="javascript:;" onclick="Load('${ctx}/wxurl/redirect?url=wxpage/my')"><img
						src="${ctx}/static/index/images/index_4_0.png"><label
						style="color: #2bc5b6; text-shadow: none;">我的</label></a></li>
			</ul>
		</nav>
	</div>
</body>
</html>