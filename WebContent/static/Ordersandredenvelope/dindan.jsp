<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=640,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=true;">

<title>我的订单页面</title>
 <link rel="stylesheet" href="${ctx}/static/jquery.pagination/pagination.css" />
 <script type="text/javascript" src="${ctx}/static/jquery.pagination/jquery.pagination.js"></script>
 
 
<link href="${ctx}/static/mt/media/css/web.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/static/mt/media/js/lfjquery.js"></script>
<script type="text/javascript" src="${ctx}/static/mt/media/js/lfweb.js"></script>

<script>
jQuery(document).ready(function() {
	getuserpv();
});
   function getuserpv(){
	   $.post("${ctx}/order/getcreate",function(d){
		   if(d){
		   $("#page").html(""); 
		  
			   $("#page").append('<div style="padding: 20px;width: 100%;height: auto;background-color: #FAFAFA;margin-top: 30px;">'
			                  +'<table style="width: 100%;">'
			                  +' <tr>'
			                  +'<td style="text-align: left;">'
			                  +'订单号：'+d[i].wxcode
			                  +'</td><td style="text-align: right;vertical-align: bottom;">'+d[i].createtime
			                  +'</td></tr>'
			                  +' <tr style="border-top:1px dashed #000"><td style="border-top:1px dashed #000">'+d[i].merhchantname
			                  +' </td ><td style="border-top:1px dashed #000">'
			                  +'交易金额：'+d[i].price
					          +' </td><td style="border-top:1px dashed #000">'
					          +' 支付金额：'+d[i].payprice
					          +'</td></tr></table></div>'
			   );
		   
		   }
	   });
   } 
</script>
</head>
<body>
<div class="page" id="topnav">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td style="width: 80px;"><a href=""><img src="images/index_02.jpg" width="80" height="77" alt="" /></a></td>
            <td style="height: 77;text-align: center;"bgcolor="2569B2">我的订单</td>
     
    </tr>
  </table>
</div>
<div class="page" id="page" style=" overflow: auto;min-height:777px;overflow:hidden; background-color:#00b8f6; background-image:url(images/newsbg.jpg); background-repeat:no-repeat; background-position:center top;">
   
   
 <!--  <div style="padding: 20px;width: 100%;height: auto;background-color: #FAFAFA;margin-top: 30px;">
        
         <table style="width: 100%;">
           <tr>
            <td style="text-align: left;">
            订单号：
            </td>
            <td style="text-align: right;vertical-align: bottom;">
            时间
            </td>
           </tr>
           <tr style="border-top:1px dashed #000">
             <td style="border-top:1px dashed #000">
             XX商家
             </td >
             <td style="border-top:1px dashed #000">
             交易金额：
             </td>
             <td style="border-top:1px dashed #000">
           支付金额：
             </td>
             
           </tr>
        </table>
   </div> -->
   
   
</div>

</body>
</html>