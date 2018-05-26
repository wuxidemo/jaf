<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">

<title>我的银行卡</title>
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script>
  jQuery(document).ready(function() {
	  
  });
</script>

<style type="text/css">
body {
	margin:0px;
	padding:0px;
	background-color: #efefef;
}
.content {
	margin:0px;
	padding:0px;
	width:100%;
}

.item {
	margin:20px 0px;
	background-color: white;
	height:70px;
}

.banklogo {
	height:70px;
	float:left;
	width:30%;
	margin:0px;
	padding:0px;
	text-align:center;
}

.banklogoimg {
	border-radius: 50%;
	margin:10px 0px;
	width:50px;
	height:50px;
}

.bankcarddetail {
	width:68%;
	float:left;
	margin:0px;
	padding:0px;
	height:70px;
}

.bankname {
	width:100%;
	height:50%;
	line-height:35px;
	font-size:18px;
}

.bankcardtype {
	width:30%;
	height:50%;
	float:left;
	line-height:35px;
	color:#575759;
}

.bankcardnum {
	height:50%;
	float:right;
	line-height:30px;
	margin-right:20px;
	color:#575759;
}

.addbankcard {
	width:100%;
	height:60px;
	background-color:white;
}

.addplus {
	width:30%;
	height:100%;
	float:left;
	text-align:center;
}

.addimg {
	margin:18px 0;
	width:24px;
	height:24px;
}

.addlabel {
	width:40%;
	line-height:60px;
	float:left;
	color:#575759;
	font-size:24px;
}

.addarrow {
	float:right;
	margin-right:30px;
	height:100%;
	float:right;
	
}

.addrightarrow {
	margin:19px 0;
	
	width:10px;
	height:22px;
}

</style>

</head>
<body>
<div class="content">

     <%-- <div class="item" onclick="getDetail()">
	 	<div class="banklogo">
	 		<img alt="" src="${ctx}/static/wxfile/images/nshlogo.png" class="banklogoimg" />
	 	</div>
	 	<div class="bankcarddetail">
	 		<div class="bankname">无锡农村商业银行</div>
	 		<div class="bankcardtype">储蓄卡</div>
	 		<div class="bankcardnum">000000000000000</div>
	 	</div>
	 </div> --%>

	 <c:forEach items="${cardlist}" var="card">
	 	<div class="item" onclick="getDetail('${card.phone}')">
		 	<div class="banklogo">
		 		<img alt="" src="${ctx}/static/wxfile/images/nshlogo.png" class="banklogoimg" />
		 	</div>
		 	<div class="bankcarddetail">
		 		<div class="bankname">无锡农村商业银行</div>
		 		<div class="bankcardtype">储蓄卡</div>
		 		<div class="bankcardnum">${card.cardnum}</div>
		 	</div>
		 </div>
	 </c:forEach>
	 
	 <div class="addbankcard" onclick="addaccount()">
	 	<div class="addplus">
	 		<img alt="" src="${ctx}/static/wxfile/images/addplus.png" class="addimg" />
	 	</div>
	 	<div class="addlabel">添加银行卡</div>
	 	<div class="addarrow">
	 		<img alt="" src="${ctx}/static/wxfile/images/rightarrow.png" class="addrightarrow" />
		</div>
	 </div>
</div>

<script type="text/javascript">
	function addaccount() {
		window.location.href="${ctx}/wxpage/bindbankcard"
	}
	
	function getDetail(cardnum) {
		window.location.href="${ctx}/wxpage/detail?cardnum="+cardnum;
	}
</script>

</body>
</html>