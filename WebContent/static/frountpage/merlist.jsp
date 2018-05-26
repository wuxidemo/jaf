<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=640,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=false;">

<title>商家列表</title>

<link href="css/component.css" rel="stylesheet" type="text/css" />
<!-- <link href="css/default.css" rel="stylesheet" type="text/css" /> -->

<link href="web.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/lfjquery.js"></script>
<script type="text/javascript" src="js/lfweb.js"></script>
<script src="plugins/bannerplay/js/main.js" type="text/javascript"
	charset="utf-8"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="plugins/bannerplay/css/main.css" />
</head>

<script type="text/javascript">
	$(document).ready(
			function() {
				var getbusinessurl = "${ctx}/business/getallbusinessgroup";
				$.post(getbusinessurl, function(data) {
					if (data.result == '1') {
						var businessstr = '';
						var dataobj = data.data
						for (var i = 0; i < dataobj.length; i++) {
							businessstr += '<option value="'+dataobj[i].id+'">'
									+ dataobj[i].name + '</option>';
						}
						$("#businessselect").append(businessstr);
					}
				});

				searchMerchant();

			});

	function searchMerchant() {
		var searchurl = "${ctx}/merchant/getallmerchant";
		var group = $("#businessselect").val();
		var name = $("#searname").val();
		$
				.post(
						searchurl,
						{
							"businessgroup" : group,
							"name" : name == 'undefined' ? '' : name
						},
						function(data) {
							if (data.result == '1') {
								alert("hello");
								var merstr = '';
								var dataobj = data.data
								for (var i = 0; i < dataobj.length; i++) {
									$("#mertable")
											.append(
													'<tr>'
															+ '<td height="177" style="">'
															+ '<table width="100%" border="0" cellspacing="0" cellpadding="0">'
															+ '<tr>'
															+ '<td width="200px"><img src="images/nsh/haidilao.png" alt="" width="220px" height="200px" style="margin-top: 20px;margin-bottom: 20px;" /></td>'
															+ '<td width="420px" height="200px" valign="middle" align="right" />'
															+ '<div style="color: #FFF; padding-top: 10px;width:420px;">'
															+ dataobj[i].name
															+ '</div>'
															+ '<div style="color: #FFF; font-size:0.8em;width:420px; ">标签：'
															+ dataobj[i].category
															+ '</div>'
															+ '<div style="color: #FFF; font-size:0.8em;width:420px;">电话：'
															+ dataobj[i].telephone
															+ '</div>'
															+ '<div style="color: #FFF; font-size:0.8em;width:420px;">地址：'
															+ dataobj[i].address
															+ '</div>'
															+ '</td>'
															+ '</tr>'
															+ '</table>'
															+ '</td>'
															+ '</tr>'
															+ '<tr>'
															+ '<td>'
															+ '<hr width="650px" />'
															+ '</td>' + '</tr>'

											);
								}
							}
						});
	}
</script>

<body>
	<div class="page" id="topnav">
		<form id="nl-form" class="nl-form" action="">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr style="background-color: #ccc;">
					<td><select id="businessselect">
							<option value="">全部</option>
					</select></td>
					<td><input type="text" name="name" id="seaname" /> <input
						type="button" value="查找" onclick="searchMerchant()" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="page"
		style="min-height: 777px; overflow: hidden; background-color: #ccc;">
		<div></div>
		<div style="padding: 10px; text-align: center; padding-top: 30px;">
			<table width="640" border="0" align="center" cellpadding="0"
				cellspacing="0" id="mertable">
				<tr>
					<td height="177" style="">
						<table width="100%" border="1" cellspacing="0" cellpadding="0">
							<tr>
								<td width="220px"><img src="images/nsh/haidilao.png" alt=""
									width="220px" height="200px" style="margin-top: 20px;margin-bottom: 20px;" /></td>
								<td width="420px" height="200px" valign="middle" align="left" />
									<div style="color: #FFF; font-size: 1.2em; padding-top: 10px;">肯德基</div>
									<div style="color: #FFF; ">标签：</div>
									<div style="color: #FFF; ">电话：</div>
									<div style="color: #FFF; ">地址：</div>
								</td>
							</tr>
							
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<hr width="650px" />
					</td>
				</tr>
			</table>


		</div>
	</div>
</body>
</html>