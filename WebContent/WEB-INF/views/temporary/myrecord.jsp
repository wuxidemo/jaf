<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<title>我的获奖记录</title>
<style type="text/css">
.loadcover {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index:100;
	display:none;
}
</style>


</head>
<body style="margin: 0px;background-color:#fdd462 ">
<div class="loadcover"></div>
        <!-- 顶部 -->
       <div  style="width: 100%; height:270px;background: url('${ctx}/static/11act/images/my.jpg');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;padding-top: 40px;">
            <div style="width: 90px;height: 90px;margin-left: 33px;border-radius:50%; overflow: hidden;">
                 <img src="${url}" style="height: 100%" onerror="this.src='${ctx}/static/images/zanwuPic.jpg'"/>
            </div>
            <div style="margin-left:130px;margin-top: -20px">
				<font size="4" color="#555555">${name}</font>
			</div>
       </div>
       
                   <!--    下部 -->
       <div style="width: 100%;height: auto;">
          <c:forEach items="${cards}" var="actcardrecord"  varStatus="status">
             <div style="width:90%;height:50px;background: url('${ctx}/static/11act/images/my2.jpg');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;margin-top: 20px;margin-bottom: 0px;margin-left: auto;margin-right: auto;"onclick="open1('${actcardrecord.name }','${actcardrecord.state }','${actcardrecord.url}')">
                  <%--  <div style="width: 20%;line-height: 50px;float: left;background-color: red;">
                   
                   </div>
                  <div style="width:50%;line-height: 50px;float: left;">
                    ${actcardrecord.starttime}
                  </div>
                  <div style="width: 20%;height: 50px;float: right; -webkit-border-radius: 0 20px 20px 0;margin-right: 1%" onclick="open1('${actcardrecord.mername }','${actcardrecord.state }','${actcardrecord.url}')">
                      <font style="line-height: 50px;color: red"size="6">></font>
                  </div> --%>
                  <table style="width:93%;height: 100%">
                     <tr>
                       <td style="width: 33%;text-align: center;">
                       <c:if test="${actcardrecord.winname==1}">
                                                一等奖
                        </c:if>
                          <c:if test="${actcardrecord.winname==2}">
                                                二等奖
                        </c:if>
                          <c:if test="${actcardrecord.winname==3}">
                                               三等奖
                        </c:if>
                         <c:if test="${actcardrecord.winname==4}">
                                               幸运奖
                        </c:if>
                         <c:if test="${actcardrecord.winname==5}">
                                             脱光奖
                        </c:if>
                       </td>
                       <td style="width: 50%;text-align: center;">
                       <%-- <fmt:formatDate value="${actcardrecord.}" pattern="yyyy-MM-dd"/> --%>
                       ${fn:substring(actcardrecord.wintime,0,10)}
                       </td>
                       
                       <td style="width: 16%;color: red;text-align:right;">
                         <font> ></font>
                       </td>
                     </tr>
                  </table>
                  
             </div>
              </c:forEach>
			  <c:if test="${fn:length(cards)==0}">
                 <div style="width: 100%;height: auto;text-align: center;">
                                                            暂无记录
                  </div>
              </c:if>
       <%--       <div style="width:90%;height:50px;background: url('${ctx}/static/11act/images/my2.jpg');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;margin-top: 20px;margin-bottom: 0px;margin-left: auto;margin-right: auto;">
                   <div style="width:70%;line-height: 50px;float: left;margin-left: 9%">
                  一等奖  2015.07.17
                  </div>
                  <div style="width: 20%;height: 50px;float: right;background-color: red;-webkit-border-radius: 0 20px 20px 0;margin-right: 1%">
                  
                  </div>
             </div>
             
             <div style="width:90%;height:50px;background: url('${ctx}/static/11act/images/my2.jpg');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;margin-top: 20px;margin-bottom: 0px;margin-left: auto;margin-right: auto;">
                  <div style="width:70%;line-height: 50px;float: left;margin-left: 9%">
                  一等奖  2015.07.17
                  </div>
                  <div style="width: 20%;height: 50px;float: right;background-color: red;-webkit-border-radius: 0 20px 20px 0;margin-right: 1%">
                  
                  </div>
             </div> --%>
       </div> 
       
       
            <!-- 底部 -->
         <div style="width: 100%;height: auto;margin-top: 10px;">
               <div style="width: 90%;height: auto;margin-left: auto;margin-right: auto;">
                   <font>使用规则：</font>
                      <table style="width: 100%">
                          <tr>
                            <td style="vertical-align: top;">1.</td>
                            <td>该现金抵用券可在金阿福e服务平台内所有商家使用；</td>
                          </tr>
                           <tr>
                            <td style="vertical-align: top;">2.</td>
                            <td>结算时可直接抵用现金，刷无锡农村商业银行卡可享受更多优惠；</td>
                          </tr>
                          <tr>
                            <td style="vertical-align: top;">3.</td>
                            <td>抵用券可叠加使用，一次使用不找零；</td>
                          </tr>
                           <tr>
                            <td style="vertical-align: top;">4.</td>
                            <td>使用截止日期2015年11月30日。</td>
                          </tr>
                      </table>
               </div>
         </div>
         <div style="width: 100%;height: 30px;">
         
         </div>
                          
                          
                                                    <!--      弹出框 -->
         <div style="width:80%;height:300px;position: absolute;z-index: 1000;top:30%;margin-top: -50px;left: 10%;display: none"id="phonetip">
             <div style="width: 100%;height:100px;background: url('${ctx}/static/11act/images/my3.png');filter:'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale ')';-moz-background-size: 100% 100%;background-size: 100% 100%;">
                    <div style="width:35px;height:35px;margin-left: 80%;margin-top: 0px;"id="close">
                        <img src="${ctx}/static/11act/images/my4.jpg" style="width: 100%;height: 100%">
                    </div>
                    <div style="width:90%;height:65px;color: #ffffff;margin-left: auto;margin-right: auto;text-align: center;">
                       <font size="5" id="fo1"><!-- 300元抵用卷 --> </font>
                    </div>
             </div>
             <div style="width: 100%;height:200px;background-color:#f3efbd ">
                  <div style="width: 40%;height:110px;margin-left: auto;margin-right: auto;padding-top: 20px;">
                      <img src="" style="width: 100%;height: 100%" id="im1">
                  </div>
                                                                            <!--   使用 -->
                   <div style="width:100px;height: 80px;position: absolute;azimuth: 1000;top: 110px;left:40px;display: none;"id="one">
                     <img src="${ctx}/static/11act/images/my5.png"style="width: 100%;height: 100%">
                   </div>
                                                    <!-- 结束 -->
                    <div style="width:100px;height: 80px;position: absolute;azimuth: 1000;top: 110px;left:40px;display: none"id="two">
                     <img src="${ctx}/static/11act/images/my6.png"style="width: 100%;height: 100%">
                   </div>
                  
                  <div style="width: 70%;margin-left: auto;margin-right: auto;padding-top:10px;text-align: center;">
                     <!--  <font size="5">2012-2012-1511-1515</font> -->
                  </div>
                  
                 <div style="width: 70%;margin-left: auto;margin-right: auto;padding-top:10px;text-align: center;">
                      <font size="3"color="#64624E">到店出示卡券核销使用</font>
                 </div>
             </div>
         </div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#close").bind("click", function() {
			$("#phonetip").css("display", "none");
			$(".loadcover").css("display", "none");
		});	
	});
	
	function open1(name,state,url){
		$("#phonetip").css("display", "block");
		$(".loadcover").css("display", "block");
		$("#fo1").text(name);
		if(state==1){
			$("#one").css("display", "none");
			$("#two").css("display", "none");
		}else if(state==2){
			 $("#one").css("display", "block");
		 }else if(state==3){
			 $("#two").css("display", "block");
		 }
		 
	    $("#im1").attr("src","${ctx}/"+url);
		
	}
	</script>
</html>