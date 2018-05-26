<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<title>优惠活动</title>
	
</head>

<style>

body {
	margin:0px;
}

.content {
	width:100%;
	margin:0px;
}

.actimgdiv {
	width:100%;
	/* height:252px; */
}

.actimg {
	width:100%;
	/* height:100%; */
}

.myucard {
	width: 100%;
	text-align: center;
}

.cardborder {
	margin: auto;
	border: 1px solid #c9caca;
	height: 100px;
	width: 90%;
	margin-top: 20px;
	border-radius: 5px;
}

.top {
	width: 100%;
	height: 70px;
}

.bottom {
	width: 100%;
	height: 30px;
	color: white;
	line-height: 30px;
	text-align: left;
	line-height: 30px;
}

.bottom p {
	margin: 0 0 0 20px;
}

.greendiv {
	background-color: #2cc4b7;
	border-bottom-left-radius:3px;
	border-bottom-right-radius:3px;
}

.left {
	float: left;
	width: 29%;
	text-align: center;
	border-right: 1px solid #c9caca;
	height: 60px;
	margin-top: 6px;
}

.right {
	float: left;
	width: 70%;
	height: 60px;
	margin-top: 6px;
	position: relative;
}

.logodiv {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	overflow: hidden;
	margin: auto;
}

.logodiv img {
	width: 60px;
	height: 60px;
}

.right p {
	margin: 0 0 0 10%;
	text-align: left;
}

.cname {
	font-size: 22px;
	height: 35px;
	line-height: 35px;
}

.uname {
	color: #2cc4b7;
}

.sname {
	color: #727171;
	font-size: 15px;
	height: 20px;
	line-height: 20px;
}

.fail p {
	
}

.right img {
	position: absolute;
	top: -5px;
	width: 69px;
	right: 2%;
}

.nocard {
	margin: 10% auto auto;
	width: 114px;
	height: 186px;
}

.nocard p {
	color: #727171;
}

.cardloading {
	width: 100%;
	margin-top: 10%;
	text-align: center;
}



.hrdiv {
	width:100%;
	margin-top:20px;
}

.actdetaildiv {
	width:100%;
}

.actdetail {
	width:90%;
	margin:10px 5%;
	
}

.acttitle {
	width:100%;
	padding:5px 0px;
	font-size:20px;
	color:#575759;
}

.actcontent {
	width:100%;
	padding:5px 0;
	color:#575759;
}

.actcontent img{
	width:100%;
}

</style>
<body>
	<!-- <div class="content"> -->
		<div class="actimgdiv">
			<img src="${ctx}/${activity.imgurl}" class="actimg"/>
		</div>
		
		<%-- <div class="myucard">
			<c:if test="${datasize!=0}">
				<div class="cardloading">数据加载中...</div>
			</c:if>
			<div id="cards" style="display: none">
				<c:forEach items="${data}" var="card">
					<div onclick="showcard('${card[7]}','${card[6]}')"
						class="cardborder">
						<div class="top">
							<div class="left">
								<div class="logodiv">
									<img alt=""
										<c:if test="${card[1]==1}">src="${ctx}/${card[2]}"</c:if>
										<c:if test="${card[1]!=1}">src="${ctx}/static/images/headimg.jpg"</c:if>>
								</div>
							</div>
							<div class="right">
								<p class="cname uname">${card[0]}</p>
								<p class="sname">${card[3]}</p>
							</div>
						</div>
						<div class="bottom greendiv">
							<p>有效日期:${fn:substring(card[4], 0, 10)}到${fn:substring(card[5], 0, 10)}</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${datasize==0}">
				<div class="nocard">
					<img alt="" src="${ctx}/static/wxfile/images/nocard.png">
					<p>还没优惠券...</p>
				</div>
	
			</c:if>
		</div> --%>
		
		<%-- <div class="myucard">
			<div id="cards">
				<div onclick="showcard()" class="cardborder">
					<div class="top">
						<div class="left">
							<div class="logodiv">
								<img alt="" src="${ctx}/static/images/headimg.jpg" />
							</div>
						</div>
						<div class="right">
							<p class="cname uname">满1000减200</p>
							<p class="sname">咖啡人餐厅</p>
						</div>
					</div>
					<div class="bottom greendiv">
						<p>有效日期:2015-07-30到2015-08-31</p>
					</div>
				</div>
			</div>
		</div> --%>
		
		<!-- <div class="hrdiv">
			<hr style="border: none; height: 1px; background-color: #cecece" />
		</div> -->
		
		<div class="actdetaildiv">
			<div class="actdetail">
				<div class="acttitle">${activity.title}</div>
				<div class="actcontent">${activity.content}</div>
			</div>
		</div>
		
	<!-- </div> -->
</body>
</html>