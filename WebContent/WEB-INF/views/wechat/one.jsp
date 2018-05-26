<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<title>我的订单</title>

	<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="${ctx}/static/jsutils/util.js"></script>


<script>
  jQuery(document).ready(function() {
		getuserpv();
	});
     
	function getuserpv() {
		 $.post("${ctx}/wxorder/myorderlist",function(d) {
				if (d.length>0 && d!=null) {
					 $("#content").html("");
					   for(var i=0;d.length;i++){
								
					  var date = new Date(d[i].createtime);
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
						$("bodyi").css({"background-color": "#efefef" })       
						$("#content").append('<div style="padding-left:0px;width: 100%;height: auto;background-color: #ffffff;margin-top: 10px;border-top:1px solid  #cbcbcb;border-bottom:1px solid  #cbcbcb;">'
											+'<table style="width: 100%;height: auto;margin-top:3px;margin-bottom:3px;">'
											+' <tr><td style="text-align: left;text-overflow:ellipsis;height:10px;"><label style="line-height:5px;margin-left: 20px;color:424242;">总金额：'
											+(d[i].price)/100
											+'</label></td><td style="height:10px;text-align: left"><label style="line-height:5px;color:424242;padding-left:40px;">支付金额:'
											+(d[i].payprice)/100
											+'</label></td></tr><tr><td style="border-bottom:1px dashed #cecece;height:10px;"><label style="line-height:5px;margin-left: 20px;color:424242;">'
											+d[i].merhchantname
											+'</label> </td> <td style=" border-bottom:1px dashed #cecece;height:10px;text-align: left"><label style="line-height:5px;color:424242;padding-left:40px;">'
											+dateStr
											+'</label></td></tr><tr><td style="padding-left:20px;height:10px;"colspan="2"><label style="line-height:5px;color:424242;">  订单号：'
						                    +d[i].code
						                    +'</label></td></tr></table></div>'
						);
				  }  
			
							}
				else{
					$("bodyi").css({"background-color": "#ffffff" });
					$("#content").append('<div style="position: absolute;top: 200px;left: 70px;">' 
					                     +'<img src="${ctx}/static/images/3333.png"style="width: 50px;height: 70px;">'
					                     +'<div style="z-index: 3445; position:absolute;top:10px;left: 70px;width: 180px;color:#A5A5A5 ">' 
					                     +'<h3><b> 还没有订单哦。。。<b></h3>'
					                     +'</div>'
					                     +'</div>');
				}
						 }); 
	} 
</script>

<style type="text/css">

body{
	margin:0;
	padding:0;
}

.item {
	width:100%;
	text-align: center;
}

.orderno {
	width:100%;
	height:25px;
	text-align: left;
	margin:10px 0;
	line-height:25px;
}

.mer {
	width:100%;
	height:50px;
	margin:10px 0;
	
}

.merlogo {
	width:25%;
	float:left;
}

.logoimg {
	/* margin-left:20px; */
}

.merdetail {
	width:70%;
	float:left;
}

.mername {
	width:100%;
	line-height:25px;
	margin:0;
	text-align: left;
	font-size:20px;
}

.ordertime {
	width:100%;
	line-height:25px;
	margin:0;
	text-align: left;
	color:#898989;
}

.money {
	width:100%;
	height:25px;
	margin:10px 0;
	line-height:25px;
}

.trademoney {
	width:50%;
	float:left;
	text-align: left;
}

.paymoney {
	width:50%;
	float:right;
	text-align: right;
}

</style>

</head>
<body>
	<div class="item">
		<div class="orderno"><span style="color:#898989;margin-left:20px;">订单号：</span><span>20150000000000000000</span></div>
		
		<div>
			<hr style="border: none; height: 1px; background-color: #cecece; width: 98%;"/>
		</div>
		
		<div class="mer">
			<div class="merlogo">
				<img src="${ctx}/static/images/03.png" width="50px" height="50px" class="logoimg"/>
			</div>
			<div class="merdetail">
				<div class="mername">测试商户</div>
				<div class="ordertime">2015-08-10 10:23:55</div>
			</div>
		</div>
		
		<div>
			<hr style="border: none; height: 1px; background-color: #cecece; width: 98%;" />
		</div>
		
		<div class="money">
			<div class="trademoney"><span style="color:#898989;margin-left:20px;">交易金额：</span>100</div>
			<div class="paymoney"><span style="color:#898989;">支付金额：</span><span style="color:red;margin-right:20px;">80</span></div>
		</div>
	</div>
	
	<div>
		<hr style="border: none; height: 5px; background-color: green;width:100%;margin:0;" />
	</div>         
</body>
</html>