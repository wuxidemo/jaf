<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	
	<link href="${ctx}/static/mt/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/static/mt/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	
	
	
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/mt/media/js/bootstrap.min.js" type="text/javascript"></script>
	
	<link media="all" href="${ctx}/static/css/weimob-ui-1-1.css" type="text/css" rel="stylesheet">
	<link href="${ctx}/static/css/index2.css" rel="stylesheet" type="text/css" />
	
	<title></title>
	
</head>

<style>
body {
	font-family: "微软雅黑";
}
h1, a{
	font-color:#000;
}

div.head {
	width:100%;
	height:60px;
	position:fixed;
	top:0px;
	left:0px;
	right:0px;
	text-align: center;
	background-color: #cecece;
}

div.searchinputdiv {
	line-height:50px;
	height:30px;
	width:200px;
	margin-top:16px;
	margin-left:12px;
	display:inline-block;
	background-color:#fff;
	-moz-border-radius:50px;
	-webkit-border-radius:50px;
	text-align:left;
}

div.searchinputdiv input {
	height:25px;
	width:150px;
	margin-top:4px;
	border:none;
	background-color: transparent;
	outline:none;
	margin-right:22px;
}

div.searchimg {
	line-height:50px;
	display:inline-block;
	margin-left:5px;
	margin-top:-26px;
}

div.searchimg img{
	line-height:50px;
	display:inline-block;
	margin-left:8px;
	margin-bottom:8px;
}

.clearimg {
	width:15px;
	height:15px;
	background: url("${ctx}/static/images/clearimg.png") no-repeat center;
	cursor: pointer;
	display: none;
}

div.content {
	width:100%;
	padding-top:68px;
	padding-bottom:28px;
}

div.item {
	width:96%;
	height:75px;
	margin: 8px 2%;
}

div.itemimg {
	width:35%;
	float:left;
}

div.itemdetail {
	width:65%;
	float:right;
	margin-top: 2px;
	margin-bottom: 2px;
}

div.itemname {
	width:100%;
	padding-left:15px;
	padding-bottom:3px;
	color:#000;
	font-size:17px;
}

div.itemlabel {
	/* height:12px; */
	line-height:100%;
	/* margin-right:5px; */
	border:1px orange solid;
	color:orange;
	display: inline-block;
	/* padding-top:1px;
	padding-bottom:1px; */
	border-radius:5px;
	position:absolute;
	right:10px;
	z-index:-999;
}

div.itemtelephone, div.itemaddress{
	width: 100%; 
	padding-left:15px;
	color:#595757;
	font-size:12px;
	padding-bottom:5px;
	font-size:16px;
}

div.tel {
	width:18px;
	height:18px;
	background: url('${ctx}/static/images/shdh.png') no-repeat center;
	background-size:15px 15px;
	line-height:100%;
	display: inline-block;
	vertical-align: middle;
	margin-right:5px;
}

div.address {
	width:18px;
	height:18px;
	background: url('${ctx}/static/images/shdd.png') no-repeat center;
	background-size:15px 15px;
	line-height:100%;
	display: inline-block;
	vertical-align: middle;
	margin-right:5px;
}

.cutline {
	width:100%;
}

.cutline hr{
	width:100%;
	border:none;
	height: 1px;
	background-color: #cecece
}

.noresult {
	width:100%;
	height:20px;
	line-height:20px;
	font-size:16px;
	color:red;
	text-align: center;
}
</style>

<script type="text/javascript">
	function Load(src){
		window.location.href=src;
	}
</script>

<script type="text/javascript">

	$(document).ready(function(){
		search();
	});
	
	function showclear() {
		$(".clearimg").css("display","inline-block");
	}
	
	function cleartext() {
		$("#inputtext").val("");
		$(".clearimg").css("display","none");
	}
	
	function setValue(grpid,grpname) {
		if(grpname.length > 5) {
			grpname = grpname.substring(0,5) + ".";
		}
		$("#grpshow").text(grpname);
		$("#groupid").val(grpid);
		search();
	}
	
	var categorystr = '${cvjsonstr}';
	var jsonobj = eval(categorystr);
	
	function search() {
		
		var mername = $("#inputtext").val();
		var groupid = $("#groupid").val();
		
		var url = "${ctx}/wxpage/getmerlist";
		
		$.post(url,{"groupid":groupid,"mername":mername},function(data){
			if(data.result == '1') {
				var items = data.data;
				$(".content").empty();
				for(var i=items.length-1;i>=0;i--) {
					
					var itememail = items[i].email;
					if(itememail == null || itememail == '') {
						continue;
					}
					
					var cvname = "";
					var mercvid = items[i].category;
					for(var j=0;j<jsonobj.length;j++) {
						if(jsonobj[j].id == mercvid) {
							cvname = jsonobj[j].value;
							break;
						}
					}
					if(cvname == '') {
						cvname = '其他';
					}
					
					var itemname = items[i].name;
					if(itemname.length > 8) {
						itemname = itemname.substring(0,8) + "..."
					}
					
					var meraddress = items[i].address;
					var meraddresslen = meraddress.length;
					if(meraddresslen > 11) {
						meraddress = meraddress.substring(0,11) + "...";
					}
					
					$(".content").append('<div class="item" onclick="showdetail('+items[i].id+')">' + 
										 	'<div class="itemimg">' +
										 		'<img src="${ctx}/'+items[i].thumbnailurl+'" alt="" width="150px" height="75px"/>' +
										 	'</div>' +
										 	'<div class="itemdetail">' +
										 		'<div class="itemname">'+itemname+'<div class="itemlabel">'+cvname+'</div></div>' +
										 		'<div class="itemtelephone"><div class="tel"></div>'+items[i].telephone+'</div>' +
										 		'<div class="itemaddress"><div class="address"></div>'+meraddress+'</div>' +
										 	'</div>' +
										 '</div>' +
										 '<div class="cutline">' +
										 	'<hr/>' +
										 '</div>' );
				}
			}else{
				$(".content").empty();
				$(".content").append(
					 '<div class="noresult">' +
					 	'查无结果' +
					 '</div>' );
			}
		});
	}
	
	function showdetail(merid) {
		window.location.href="${ctx}/wxpage/merdetail?id="+ merid +"&token=noshake";
	}

</script>

<body>
	<div class="head">
			<div class="btn-group" style="width:80px;margin-top:-5px;margin-right:10px;margin-left:-15px;">
				<a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="width:80px;border:none;background-color: transparent; border-radius: 0;box-shadow: none;background: none;">
					<p style="display: inline; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" id="grpshow">全部 </p>&nbsp;<i class="icon-angle-down" style=""></i>
				</a>
				<ul class="dropdown-menu" style="overflow-y:scroll;">
					<li><a href="javascript:;" onclick="setValue('0','全部')">全部</a></li>
					<c:forEach items="${group}" var="business">
 						<li><a href="javascript:;" onclick="setValue('${business.id}','${business.name}')">${business.name}</a></li>
 					</c:forEach>
				</ul>
			</div>
		<div class="searchinputdiv"><input type="text" value="" placeholder="请输入关键字" name="" id="inputtext" class="inputtext" onfocus="showclear()" onkeyup="search()" style="box-shadow: none;" /><div class="clearimg" onclick="cleartext()"></div></div>
		
		<div class="searchimg" onclick="search()"><img alt="" src="${ctx}/static/images/searchmer.png" width="24px" height="24px"></div>
	</div>
	
	<div class="content">
	</div>
	
	<div class="top_bar" id="footbar"
		style="-webkit-transform: translate3d(0, 0, 0)">
		<nav>
			<ul id="top_menu" class="top_menu">
				<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/advert/wxindex')"><img
						src="${ctx}/static/index/images/index_1_1.png"><label
						style="color: white; text-shadow: none;">首页</label></a></li>
				<li><a href="javascript:;"
					onclick="Load('${ctx}/wxpage/merlist')"><img
						src="${ctx}/static/index/images/index_2_0.png"><label
						style="color: #2bc5b6; text-shadow: none;">商家</label></a></li>
								<li style="background-color: #2fdac3"><a href="javascript:;"
					onclick="Load('${ctx}/wxcard/cardlist')"><img
						src="${ctx}/static/index/images/index_3_1.png"><label
						style="color: white; text-shadow: none;">优惠</label></a></li>
				<li style="background-color: #2fdac3"><a href="javascript:;" onclick="Load('${ctx}/wxpage/my')"><img
						src="${ctx}/static/index/images/index_4_1.png"><label
						style="color: white; text-shadow: none;">我的</label></a></li>
			</ul>
		</nav>
	</div>
	<input type="hidden" name="groupid" value="" id="groupid" />
	<form action="${ctx}/wxpage/merlist" style="display: none;" method="post" id="searchForm">
		
	</form>
</body>
<script>
    document.title ="商家";
</script>

</html>