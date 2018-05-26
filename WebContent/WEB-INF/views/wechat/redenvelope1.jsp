<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<title>我的红包</title>

	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>
	
	
<script>
 jQuery(document).ready(function() {
	getuserpv();
});
   function getuserpv(){
	   $.post("${ctx}/wxorder/myrebaterecordlist",function(d){
		   if(d.length>0 && d!=null){
			 $(".one").css("background-color","#efefef");
			 $("#content").html("");
			 for(var i=0;d.length;i++){
				   
				/* 	var date = new Date(d[i].createdate);
					var dateStr = date.getFullYear()
							+ "-"
							+ (parseInt(date.getMonth()) + 1)
							+ "-" + date.getDate() + " "
							+ date.getHours() + ":"
							+ date.getMinutes(); */ /* + ":" */
							/* + date.getSeconds(); */
	              var date = new Date(d[i].createdate);
				  var year=date.getFullYear();
				  var month=(parseInt(date.getMonth()) + 1);
				  if(month<10){
					  month="0"+month;
				  }
				  var day=date.getDate();
				  if(day<10){
					  day="0"+day;
				  }
				  var hours=date.getHours();
				  if(hours<10){
					  hours="0"+hours;
				  }
				  var mi= date.getMinutes();
				  if(mi<10){
					  mi="0"+mi;
				  }		
					var dateStr=year+"-"+month+"-"+day+" "+hours+":"+mi;
					
				   $("#content").append('<div style="padding-top:10px;padding-left:10px;padding-bottom:5px;width: 100%;height: auto;margin-top:10px; background-color:#fff;">'
						             +'<table style="width: 100%;">'
						             +'<tr>'
						             +'<td rowspan="2"style="width: 20px;"><img src="${ctx}/static/images/031.png"style="width:40px;height:50px"/>'
				                     +' </td><td style="width:40%;padding-left:10px;padding-top:3px;" ><b>红包金额：</b><font style="color: red;">'+(d[i].price)/100
				                     +'</font></td></tr>'
				                     +'<tr><td style="width:47%;padding-left:10px;padding-top:5px;">'
				                     +d[i].rebatename
				                     +' </td><td style="text-align: left;width:53%;padding-top:5px;">'
				                     +dateStr
				                     +'</td></tr></table></div>'
       
				   );
		   }
			
		   }
		   else{
			   $(".one").css("background-color","#ffffff");
			   $("#content").html(
       				'<div class="nodatadiv"> <img src="${ctx}/static/wxfile/main1601/image/nodata.png"><div class="loadp">暂无记录</div></div>')
		   }
	   });
   }  

</script>
<style type="text/css">
.nodatadiv {
    position: fixed;
    width: 150px;
    height: 150px;
    top: 50%;
    margin-top: -75px;
    margin-left: -75px;
    left: 50%;
    text-align: center;
}

.nodatadiv img {
	width: 120px;
}

.loadp {
	color: #727171;
	margin-top: -28px;
}
</style>
</head>
<body style="margin: 0;padding: 0;" class="one">
 	
	<div class="page" id="content" style="overflow: auto; height:auto;overflow:hidden; background-repeat:no-repeat; background-position:center top;">
    	<!-- <div style="text-align: center;font-size:1.2em;mergin-top:40px;">暂无红包</div> -->
    	<%-- <div style="padding-top:10px;padding-left:10px;padding-bottom:5px;width: 100%;height: auto;margin-top:0px;border-bottom:3px solid #2bc4b6;">
			<table style="width: 100%;">
				<tr>
				  <td rowspan="2"style="width: 20px;">
				     <img src="${ctx}/static/images/031.png"style="width:40px;height:50px"/>
				  </td>
				  <td style="width:40%;padding-left:10px;padding-top:3px;" >
				         <b>红包金额：</b><font style="color: red;">100</font> 
				    </td>
				  </tr>
				  <tr>
				     <td style="width:47%;padding-left:10px;padding-top:5px;">111111111
				  </td>
				   <td style="text-align: left;width:53%;padding-top:5px;">
				         17-52-51
				   </td>
				  </tr>
			</table>
		</div> --%>
	</div>


</body>
</html>