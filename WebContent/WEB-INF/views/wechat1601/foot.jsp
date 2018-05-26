
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>页面底部</title>
</head>
<style>
body {
	margin: 0;
	font-family: Microsoft YaHei;
}

.foot {
	margin: 0;
	position: fixed;
	width: 100%;
	height: 50px;
	bottom: 0;
	z-index: 99;
	background-color: white;
	border-top: 1px solid #e1e3e1;
	display: table;
}

.menudiv {
	text-align: center;
	position: relative;
	height: 50px;
	text-decoration: none;
	display: table-cell;
}

.menudiv1:LINK, .menudiv2:LINK, .menudiv3:LINK, .menudiv4:LINK {
	color: #f8ba1e;
	text-decoration: none;
}


.menudiv i {
	height: 28px;
    left: 50%;
    margin-left: -17px;
    margin-top: 2px;
    position: absolute;
    width: 33px;
}

.menudiv p {
	margin: 27px 0 0 0px;
	color: #7a7070;
	font-size: 11px;
	font-family: "Microsoft YaHei" ! important;
}



.shouyei {
	background: url('${ctx}/static/wxfile/main1601/image/shouye1.png')
		no-repeat /*灰色的房子*/ 
		 center/22px;
}

.shouyeis {
	background: url('${ctx}/static/wxfile/main1601/image/shouye2.png')
		no-repeat /*黄色的房子*/ 
		 center/22px !important;
}

.shequi {
	background: url('${ctx}/static/wxfile/main1601/image/shequ1.png')
		no-repeat /*灰色的社区*/ 
		 center/22px;
}

.shequis {
	background: url('${ctx}/static/wxfile/main1601/image/shequ2.png')
		no-repeat /*黄色的社区*/ 
		 center/22px !important;
}

.youhuii {
	background: url('${ctx}/static/wxfile/main1601/image/youhui1.png')
		no-repeat /*灰色的券*/ 
		 center/22px;
}

.youhuiis {
	background: url('${ctx}/static/wxfile/main1601/image/youhui2.png')
		no-repeat /*黄色的券*/ 
		 center/22px !important;
}

.wodei {
	background: url('${ctx}/static/wxfile/main1601/image/wode1.png')
		no-repeat /*灰色的我的*/ 
		 center/22px;
}

.wodeis {
	background: url('${ctx}/static/wxfile/main1601/image/wode2.png')
		no-repeat /*黄色的我的*/ 
		 center/22px !important;
}

.selectp {
	color: #f8ba1e !important;
}
</style>
<body>
	<div class="foot">
		<a class="menudiv menudiv2"
			onclick="javascript:window.location.href='${ctx}/wxpage/community?tmp=${date}'">
			<i class="shequi <c:if test="${type==2}">shequis</c:if>"></i>
			<p class="shequp <c:if test="${type==2}">selectp</c:if>">社区</p>
		</a> <a class="menudiv menudiv1"
			onclick="javascript:window.location.href='${ctx}/wxpage/index?tmp=${date}'">
			<i class="shouyei <c:if test="${type==1}">shouyeis</c:if>"></i>
			<p class="shouyep <c:if test="${type==1}">selectp</c:if>">商圈</p>
		</a> <a class="menudiv menudiv3"
			onclick="javascript:window.location.href='${ctx}/wxpage/coupon?tmp=${date}'">
			<i class="youhuii <c:if test="${type==3}">youhuiis</c:if>"></i>
			<p class="youhuip <c:if test="${type==3}">selectp</c:if>">优惠</p>
		</a> <a class="menudiv menudiv4" style="border-right: none;"
			onclick="javascript:window.location.href='${ctx}/wxurl/redirect?url=wxpage/my'">
			<i class="wodei <c:if test="${type==4}">wodeis</c:if>"></i>
			<p class="wodep <c:if test="${type==4}">selectp</c:if>">我的</p>
		</a>
	</div>
</body>
</html>