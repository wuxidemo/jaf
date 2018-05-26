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
<title>我的页面</title>

<link href="web.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/lfjquery.js"></script>
<script type="text/javascript" src="js/lfweb.js"></script>
</head>
<body>
<div class="page" id="topnav">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td style="width: 80px;"><a href="index.html"><img src="images/index_02.jpg" width="80" height="77" alt="" /></a></td>
      <td style="height: 77;text-align: center;"bgcolor="2569B2">我的</td>
     
    </tr>
  </table>
</div>
<div class="page" style="height:777px;overflow:hidden; background-image:url(images/newsbg.jpg); background-position:center top;">
 
   <div style="width: 100%;height:20%;background-color: red;margin-top: 0px;background-image: url(images/02.jpg);padding-top: 20px;padding-left: 20px">
   <div style="width:120px; height:120px; border-radius:50%; overflow:hidden;">
        <img src="images/08.png"/> 
   </div> 
    </div>
        
        
     <div style="width: 100%;height: 40px;background-color: #FAFAFA;margin-top: 50px;padding: 10px;border-top:solid 1px #000;border-bottom: solid 1px #000">
        
      <div style="float: left;">
      <table>
      <tr>
      <td>
        <img src="images/15.png" alt=""/>
        </td>
     <td> 
   <a href="">    
            我的订单
            </a>
            </td>
            </tr>
            </table>
         </div>
      <div style="float: right;padding-right: 40px;padding-top: 10px">
        <img src="images/11.png" alt="" />
        
      </div>
      
   </div>
   
   <div style="width: 100%;height: 40px;background-color: #FAFAFA;margin-top: 30px;padding: 10px;border-top:solid 1px #000;border-bottom: solid 1px #000">
      <a href="">   
      <div style="float: left;">
      <table>
      <tr>
      <td>
        <img src="images/05.png" alt="" /></td>
     <td> 
      <a href="">       
            我的红包
            </a>
            </td>
            </tr>
            </table>
         </div>
      <div style="float: right;padding-right: 40px;padding-top: 10px">
        <img src="images/11.png" alt="" />
        
      </div>
    
   </div>
        
</div>

</body>
</html>