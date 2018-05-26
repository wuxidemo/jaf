<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE>
<html>
<head>
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">

<link rel="stylesheet" href="jquery mobile/jquery.mobile-1.4.5.min.css">
<title>Insert title here</title>
</head>
<body>
	<div data-role="page" id="table1">
		<div data-role="header" data-position="fixed">
		  <h1>评估1</h1>
		   <a href="#" data-role="button" class="ui-btn-right" >提交</a>
		</div>
		<div data-role="content">
			<fieldset data-role="controlgroup">
				<legend>单选:</legend>
				<input type="radio" name="radio-choice-v-2" id="radio-choice-v-2a"
					value="on" checked="checked"> <label
					for="radio-choice-v-2a">One</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2b" value="off">
				<label for="radio-choice-v-2b">Two</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2c" value="other">
				<label for="radio-choice-v-2c">Three</label>
			</fieldset>

			<fieldset data-role="controlgroup">
				<legend>多选:</legend>
				<input type="checkbox" name="checkbox-v-2a" id="checkbox-v-2a">
				<label for="checkbox-v-2a">One</label> <input type="checkbox"
					name="checkbox-v-2b" id="checkbox-v-2b"> <label
					for="checkbox-v-2b">Two</label> <input type="checkbox"
					name="checkbox-v-2c" id="checkbox-v-2c"> <label
					for="checkbox-v-2c">Three</label>
			</fieldset>


			<label for="text-3">Text input: data-clear-btn="true"</label> <input
				type="text" data-clear-btn="true" name="text-3" id="text-3" value="" />

			<label for="textarea-1">Textarea:</label>
			<textarea name="textarea-1" id="textarea-1"></textarea>




			<label for="file-2">文件上传</label> <input type="file"
				data-clear-btn="true" name="file-2" id="file-2" value=""> <a
				href="#sign">签字</a> <img id="signimg"
				style="border: 1px solid red; width: 100%">
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#table3" id="" data-icon="check">上一个评估</a></li>
					<li><a href="#" id="saveall" data-icon="check">保存</a></li>
					<li><a href="#table2" id="" data-icon="check">下一个评估</a></li>
				</ul>
			</div>


		</div>
	</div>
	
	<div data-role="page" id="table2">
		<div data-role="header" data-position="fixed">
		  <h1>评估2</h1>
		   <a href="#" data-role="button" class="ui-btn-right" >提交</a>
		</div>
		<div data-role="content">
			<fieldset data-role="controlgroup">
				<legend>单选:</legend>
				<input type="radio" name="radio-choice-v-2" id="radio-choice-v-2a"
					value="on" checked="checked"> <label
					for="radio-choice-v-2a">One</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2b" value="off">
				<label for="radio-choice-v-2b">Two</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2c" value="other">
				<label for="radio-choice-v-2c">Three</label>
			</fieldset>

			<fieldset data-role="controlgroup">
				<legend>多选:</legend>
				<input type="checkbox" name="checkbox-v-2a" id="checkbox-v-2a">
				<label for="checkbox-v-2a">One</label> <input type="checkbox"
					name="checkbox-v-2b" id="checkbox-v-2b"> <label
					for="checkbox-v-2b">Two</label> <input type="checkbox"
					name="checkbox-v-2c" id="checkbox-v-2c"> <label
					for="checkbox-v-2c">Three</label>
			</fieldset>


			<label for="text-3">Text input: data-clear-btn="true"</label> <input
				type="text" data-clear-btn="true" name="text-3" id="text-3" value="" />

			<label for="textarea-1">Textarea:</label>
			<textarea name="textarea-1" id="textarea-1"></textarea>




			<label for="file-2">文件上传</label> <input type="file"
				data-clear-btn="true" name="file-2" id="file-2" value=""> <a
				href="#sign">签字</a> <img id="signimg"
				style="border: 1px solid red; width: 100%">
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#table1" id="" data-icon="check">上一个评估</a></li>
					<li><a href="#" id="" data-icon="check">保存</a></li>
					<li><a href="#table3" id="" data-icon="check">下一个评估</a></li>
				</ul>
			</div>


		</div>
	</div>
	
	
	<div data-role="page" id="table3">
		<div data-role="header" data-position="fixed">
		  <h1>评估3</h1>
		   <a href="#" data-role="button" class="ui-btn-right" >提交</a>
		</div>
		<div data-role="content">
			<fieldset data-role="controlgroup">
				<legend>单选:</legend>
				<input type="radio" name="radio-choice-v-2" id="radio-choice-v-2a"
					value="on" checked="checked"> <label
					for="radio-choice-v-2a">One</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2b" value="off">
				<label for="radio-choice-v-2b">Two</label> <input type="radio"
					name="radio-choice-v-2" id="radio-choice-v-2c" value="other">
				<label for="radio-choice-v-2c">Three</label>
			</fieldset>

			<fieldset data-role="controlgroup">
				<legend>多选:</legend>
				<input type="checkbox" name="checkbox-v-2a" id="checkbox-v-2a">
				<label for="checkbox-v-2a">One</label> <input type="checkbox"
					name="checkbox-v-2b" id="checkbox-v-2b"> <label
					for="checkbox-v-2b">Two</label> <input type="checkbox"
					name="checkbox-v-2c" id="checkbox-v-2c"> <label
					for="checkbox-v-2c">Three</label>
			</fieldset>


			<label for="text-3">Text input: data-clear-btn="true"</label> <input
				type="text" data-clear-btn="true" name="text-3" id="text-3" value="" />

			<label for="textarea-1">Textarea:</label>
			<textarea name="textarea-1" id="textarea-1"></textarea>




			<label for="file-2">文件上传</label> <input type="file"
				data-clear-btn="true" name="file-2" id="file-2" value=""> <a
				href="#sign">签字</a> <img id="signimg"
				style="border: 1px solid red; width: 100%">
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#table2" id="" data-icon="check">上一个评估</a></li>
					<li><a href="#" id="" data-icon="check">保存</a></li>
					<li><a href="#table1" id="" data-icon="check">下一个评估</a></li>
				</ul>
			</div>


		</div>
	</div>
	
	
	<div id="sign" data-role="page" data-title="客户签名">
		<div data-role="content" style="padding: 0;">
			<canvas id="simple" style="width: 100%; height: 100%;">浏览器不支持canvas</canvas>
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="javascript:void(0)" id="clear"
						data-icon="refresh">清空</a></li>
					<li><a href="#" id="savesign" data-icon="check">保存</a></li>


				</ul>
			</div>

		</div>

	</div>
</body>
<script src="mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script src="jquery mobile/jquery.mobile-1.4.5.min.js"></script>
<script>
	var canvas = null, context = null;
	function resetCanvas() {
		canvas = document.getElementById('simple');
		context = canvas.getContext('2d');
	}
	$("#saveall").on("click", function() {
		$.post("${ctx}/mapi/saveimg", {
			"data" : data
		}, function(d) {
			if (d && d.result == "1") {
				alert(d.url);
			}
		});
	});
	$(window).bind("orientationchange", function(event) {
		setTimeout(function() {
			$("#simple").attr("width", $("#simple").width());
			$("#simple").attr("height", $("#simple").height()); // 延迟300ms，才能得到正确屏宽  
		}, 300);
		//if(event.orientation){ 
		//     if(event.orientation == 'portrait'){ //竖屏 
		//    } 
		//    else if(event.orientation == 'landscape') { //横评 
		//   } 
		//  } 
	});

	var data = "";
	$(document).on("pageinit", "#sign", function() {
		$("#sign").on("pageshow", function() {
			$("#simple").attr("width", $("#simple").width());
			$("#simple").attr("height", $("#simple").height());
		});

		$("#clear").on("click", function() {
			canvas.width = canvas.width;
		});

		$("#savesign").on("click", function() {
			data = canvas.toDataURL("image/png");
			$("#signimg").attr("src", data);
			$.mobile.changePage("#table1", "slideup");
		});

		resetCanvas();
		canvas.addEventListener('touchstart', function(evt) {
			evt.preventDefault();
			context.beginPath();
			context.moveTo(evt.touches[0].pageX, evt.touches[0].pageY);
		}, false);
		canvas.addEventListener('touchmove', function(evt) {
			context.lineTo(evt.touches[0].pageX, evt.touches[0].pageY);
			context.stroke();
		}, false);
		canvas.addEventListener('touchend', function(evt) {
		}, false);
	});
</script>
</html>