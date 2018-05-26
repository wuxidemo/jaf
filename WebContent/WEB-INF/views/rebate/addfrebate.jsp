<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<title>创建红包</title>
<style type="text/css">
.mynavbar-inner {
	border: 1px solid #e6e6e6;
}

li a {
	text-align: center;
}

.active>a,.active>a:hover,.active>a:focus {
	background-color: #44b549;
	color: white;
}

.linediv {
	margin-top: 10px;
}

.centrediv {
	margin: auto;
	width: 700px;
}

.centrediv div {
	text-align: left;
}

.cover {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	background-color: #333;
	opacity: 0.8;
	z-index: 999;
	display: none;
}

.loadtip {
	color: white;
	font-size: 20px;
	left: 50%;
	margin-left: -90px;
	position: fixed;
	top: 50%;
	width: 180px;
}

.backdiv {
	width: 350px;
	height: 205px;
	border: solid 1px;
	margin: auto;
}

.ps {
	float: left;
	height: 199px;
	width: 100%;
}

.ps p {
	margin-left: 75px;
	margin-top: 50px;
}

.ps p:FIRST-CHILD {
	margin-top: 15px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 250px;
}
</style>
</head>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/datepicker.css" />

<script type="text/javascript"
	src="${ctx}/static/mt/media/js/jquery.bootstrap.wizard.min.js"></script>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('.date-picker').datepicker({
							dateFormat : 'yyyy mm dd',
							rtl : App.isRTL()
						});
						var test = $("input[type=checkbox]:not(.toggle), input[type=radio]:not(.toggle, .star)");
						if (test.size() > 0) {
							test.each(function() {
								if ($(this).parents(".checker").size() == 0) {
									$(this).show();
									$(this).uniform();
								}
							});
						}
						$(".finish2").bind("click", function(d) {
							$("#myform2").submit();
						});
						$("#mustbank2").change(function() {
							if ($(this).attr("checked") == "checked") {
								$(this).val(1);
							} else {
								$(this).val(0);
							}
						});
						initwizard2();
						//$('#rootwizard').bootstrapWizard('show',1);
						var ck="${rff.mustbank}";
						if(ck=="0")
							{
							$("#mustbank2").val(1);
							$("#mustbank2").parent().addClass("checked");
							$("#mustbank2").attr("checked","checked");
							}
						else
							{
							$("#mustbank2").val(0);
							}
					});

	function initwizard2() {
		$('#rootwizard2').bootstrapWizard({
			onNext : function(tab, navigation, index) {
				if (index == 1) {
					var data = getMap($("#myform2").serialize());
					if (data.price.trim() == "") {
						window.parent.showAlert("请输入单个红包金额");
						return false;
					} else {
						if (!testfloat(data.price)) {
							window.parent.showAlert("单个红包金额输入错误");
							return false;
						} else {
							if (Number(data.price) < 1) {
								window.parent.showAlert("单个红包金额不能小于1");
								return false;
							}
							else {
								$("#p1").html("单个红包金额（元）："+data.price);
							}
						}
					}
					if (data.totalnum.trim() == "") {
						window.parent.showAlert("请输入总发放红包数");
						return false;
					} else {
						if (!testzzs(data.totalnum)) {
							window.parent.showAlert("总发放红包数输入错误");
							return false;
						}
						else {
							$("#p2").html("总发放红包数（个）："+data.totalnum);
						}
					}
					if (data.mustbank == "1") {
						$("#p3").html("是否支持非农商行卡：是");
					} else {
						$("#p3").html("是否支持非农商行卡：否");
					}
				}
				return true;
			},
			onPrevious : function(tab, navigation, index) {
				//alert(index);
			},
			onTabShow : function(tab, navigation, index) {
				if (index == 0) {
					$("#ta12").css("background-color", "#44b549");
					$("#ta12").css("color", "white");
					$("#ta22").css("background-color", "");
					$("#ta22").css("color", "");
					$(".finish2").addClass("hidden");
				} else {
					$("#ta22").css("background-color", "#44b549");
					$("#ta22").css("color", "white");
					$("#ta12").css("background-color", "");
					$("#ta12").css("color", "");
					$(".finish2").removeClass("hidden");
				}

				window.parent.iFrameHeight();

				//	var $total = navigation.find('li').length;
				//	var $current = index + 1;
				//	var $percent = ($current / $total) * 100;
			},
			onTabClick : function(tab, navigation, index) {
				// alert('on tab click disabled');
				return false;
			}
		});
	}

	function getMap(queryString) {
		if (null != queryString) {
			parameters = {};
			var parameterArray = queryString.split("&");
			var length = parameterArray.length;
			for (var i = 0; i < length; i++) {
				var parameter = parameterArray[i];
				index = parameter.indexOf("=");
				var key = parameter.substring(0, index);
				var value = parameter.substring(index + 1);
				if (null != key && key.length > 0) {
					parameters[key] = value;
				}
			}
			return parameters;

		}
	}
	function test100(num) {
		var t = /^((?!0)\d{1,2}|100)$/;
		return t.test(num);
	}
	function testzzs(num) {
		var t = /^[0-9]*[1-9][0-9]*$/;
		return t.test(num);
	}
	function testfloat(num) {
		var t = /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/;
		return t.test(num);
	}
	function showcover() {
		$(".cover").show();
	}
</script>
<body>
	<div class="cover">
		<div class="loadtip">数据提交中,请稍后...</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/flhb.png"
					style="vertical-align: text-bottom;" /> 创建红包
			</h3>
		</div>
	</div>


	<div id="rootwizard2">
		<div class="navbar">
			<div class="mynavbar-inner">
				<div class="container">
					<ul style="width: 100%">
						<li style="width: 50%"><a id="ta12" href="#tab12"
							data-toggle="tab">配置红包规则</a></li>
						<li style="width: 50%"><a id="ta22" href="#tab22"
							data-toggle="tab">配置完成</a></li>

					</ul>
				</div>
			</div>
		</div>
		<div class="tab-content">
			<div class="tab-pane" id="tab12" style="text-align: center;">
				<div class="centrediv">
					<form class="form-horizontal " id="myform2" method="post"
						action="${ctx}/rebate/savef">
						<input type="hidden" name="id" value="${rff.id}">
						<div class="control-group ">
							<label for="role-name" class="control-label"><span
								style="color: red">*</span>单个红包金额:</label>
							<div class="controls">
								<input type="text" class="span m-wrap required" maxlength="20"
									style="width: 322px" name="price" value="${rff.yprice}" />
							</div>
						</div>
						<div class="control-group ">
							<label for="role-name" class="control-label"><span
								style="color: red">*</span>总发放红包数:</label>
							<div class="controls">
								<input type="text" class="span m-wrap required" maxlength="20"
									style="width: 322px" name="totalnum" value="${rff.totalnum}"/>
							</div>
						</div>
						<div class="control-group ">
							<label for="role-name" class="control-label">是否支持非农商行卡:</label>
							<div class="controls">
								<label class="checkbox"> <input type="checkbox"
									id="mustbank2" name="mustbank" value=""  />
								</label>
							</div>
							
						</div>
						<div class="control-group ">
							<label for="role-name" class="control-label">说明:</label>
							<div class="controls">
								<textarea rows="" cols="" style="width: 332px; height: 100px"
									name="remark">${rff.remark}</textarea>
							</div>
						</div>

					</form>
				</div>
			</div>
			<div class="tab-pane" id="tab22">
				<div class="centrediv">
					<div class="backdiv">
						<div class="ps">
							<p id="p1" style="margin-top: 15px">单个红包金额（元）：</p>
							<p id="p2">有效日期： 2015-51-19 至 2015-51-19</p>
							<p id="p3">返利比例： 1%</p>
							
						</div>
					</div>
				</div>
			</div>

			<ul class="pager wizard">
				<li class="previous"><a style="margin-left: 10%;"
					onclick="setTimeout('window.parent.iFrameHeight();',50)"
					href="javascript:;">上一步</a></li>
				<li class="next"><a style="margin-right: 10%;"
					onclick="setTimeout('window.parent.iFrameHeight();',50)"
					href="javascript:;">下一步</a></li>
				<li class="finish hidden finish2"><a href="javascript:;">完成</a></li>
			</ul>
		</div>
	</div>
</body>
</html>