<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<script type="text/javascript" src="../jquery/jquery-1.9.1.min.js"></script>

<style>
.list {
background: #fff;
border-radius: 15px;
border: 1px solid #f5f5f5;
box-shadow: 1px 2px 3px #666;
margin: 15px 10px;
padding: 5px;
}
.list-img img {
max-height: 891px;
width: 100% !important;
}
</style>

<script type="text/javascript">
jQuery(document).ready(function() {
	getdftc();
});

function getdftc(){
	jQuery.get('${ctx}/api/dftc?clientid=00:40:63:f7:84:01',function(data){
		var arr = data.data;
		var html="";
		if(arr != null){
			for(var i=0;i<arr.length;i++){
				var obj = arr[i];
				html +='<div class="list">'+
					'<a href="'+ obj[1] + '">'+
					'<div class="list-img"><img src="'+obj[0]+'"></div>'+
					'</a>'+
				'</div>';
			}
		}
		
		$("#bdts-id").html(html);
	});  
}
</script>
<title>地方特产</title>
        
</head>
		<body>
	       <div class="weimob-content" id="bdts-id">
				
			</div>
		</body>
</html>