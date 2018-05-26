<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>明细</title>
<script>
 /*  function getintegralrecord(){
	  $.post("",{"cardnum":},function(data){
		  
	  });
  } */

</script>
</head>
<body>
  <div class="page">
   
			<div style="width:100%; height:50px; background-color: #FAFAFA; margin-top: 10px;">
                 <div style="line-height: 50px;margin-left: 20px;">
                          积分(总):<span style="font-size: 25px;color:#46C9BF">${inuser.point}</span>&nbsp;&nbsp;积分
                 </div>
			</div>
			
			<div style="width: 100%;height: 45px;">
			  <div style="line-height: 45px;margin-left: 20px;">
			        积分明细：
			  </div>
			</div>
			
			<div style="width: 100%;height: auto;margin-top: 0px;background-color: #FAFAFA;">
			  <div style="height: auto;margin-left: 10px;margin-right: 10px;">
			     <table style="width: 100%;height: auto;border-spacing:0">
			          <thead>
			          <tr style="height:40px;">
			             <td style="border-bottom: solid 1px #cecece;padding-left: 20px">日期</td>
			             <td style="border-bottom: solid 1px #cecece;padding-left: 10px">内容</td>
			             <td style="border-bottom: solid 1px #cecece;padding-left: 10px">积分</td>
			          </tr>
			          </thead>
			          <tbody>
			             <c:forEach items="${lists}" var="list" varStatus="status">
			               <tr style="height: 30px;color: #9F9F9F">
			                  <td><fmt:formatDate value="${list.createtime}" pattern="yyyy-MM-dd"/></td>
			                    
			                   <td>${list.cardname}</td>
			                   
			                   <td style="padding-left: 10px">${list.count}</td>
			               </tr>
			             </c:forEach>
			          </tbody>
			     </table>
			  </div>
			</div>
		
  </div>
</body>
</html>