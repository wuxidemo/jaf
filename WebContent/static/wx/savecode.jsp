<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String code = request.getParameter("code");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>跳转中...</title>
</head>
<body>

</body>
<script src="<%=basePath%>static/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.post("<%=basePath%>wxurl/getopenid?code=<%=code%>",function(d){
		if(d.result=="1")
			{
				window.location.href="<%=basePath%>"+d.url;
			}
		else
			{
			detectWeixinApi(close);
			}
	});
	
});

function close()
{WeixinJSBridge.call('closeWindow');}
/**
 * 检测微信JsAPI
 * @param callback
 */
function detectWeixinApi(callback){
    if(typeof window.WeixinJSBridge == 'undefined' || typeof window.WeixinJSBridge.invoke == 'undefined'){
        setTimeout(function(){
            detectWeixinApi(callback);
        },200);
    }else{
     callback();
    }
}
</script>
</html>