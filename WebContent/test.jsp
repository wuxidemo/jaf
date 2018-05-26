<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="static/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="static/js/sort.js"></script>
<style type="text/css">
.sortable div {
	width: 200px;
	height: 300px;
	border: #F00 1px solid;
	float: left;
	margin-left: 10px;
	margin-top: 10px;
}
</style>
<script>
	$(function() {
		$("img").each(function(n) {
			$(this).bind("click", function() {
				if ($("#ck" + n).is(":hidden")) {
					$("#ck" + n).prop("checked", true);
					$("#ck" + n).show();
				} else {
					$("#ck" + n).prop("checked", false);
					$("#ck" + n).hide();
				}
			});
		});
		$(".sortable").sortable();
		
		alert(new Date().getTime());
		
		var time = 1438068993150;
		
		formattime(time);
		
	});
	function show(){
		var count=0;
		$(".ck").each(function(n){
			if($(this).prop("checked")){
				count++;
			}else{
				count--;
			}
		});
	}
	
	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		
		if(month < 10) {
			month = "0"+month;
		}
		if(dd < 10) {
			dd = "0" + dd;
		}
		
		alert(year+"-"+month+"-"+dd);
	}
	
</script>
</head>
<body>
	<div class="sortable">
		<div id="div1" >
			<input type="checkbox" class="ck" id="ck0" style="display: none"> <img
				class="div1" alt="" src="static/images/sh.png">
		</div>
		<div id="div2">
			<input type="checkbox" class="ck" id="ck1" style="display: none"> <img
				class="div1" alt="" src="static/images/sk1.png">
		</div>
		<div id="div3">
			<input type="checkbox" class="ck" id="ck2" style="display: none"> <img
				class="div1" alt="" src="static/images/sy1.png">
		</div>
		<div id="div4">
			<input type="checkbox" class="ck"  id="ck3" style="display: none"> <img
				class="div1" alt="" src="static/images/gg.png">
		</div>
		<div id="div5">
			<input type="checkbox" class="ck" id="ck4" style="display: none"> <img
				class="div1" alt="" src="static/images/xw.png">
		</div>
		<div id="div6">
			<input type="checkbox" class="ck" id="ck5" style="display: none"> <img
				class="div1" alt="" src="static/images/sh.png">
		</div>
		<div id="div7">
			<input type="checkbox" class="ck" id="ck6" style="display: none"> <img
				class="div1" alt="" src="static/images/sk1.png">
		</div>
		<div id="div8">
			<input type="checkbox" class="ck" id="ck7" style="display: none"> <img
				class="div1" alt="" src="static/images/sy1.png">
		</div>
		<div id="div9">
			<input type="checkbox" class="ck" id="ck8" style="display: none"> <img
				class="div1" alt="" src="static/images/gg.png">
		</div>
		<div id="div10">
			<input type="checkbox" class="ck" id="ck9" style="display: none"> <img
				class="div1" alt="" src="static/images/xw.png">
		</div>
	</div>
</body>
</html>