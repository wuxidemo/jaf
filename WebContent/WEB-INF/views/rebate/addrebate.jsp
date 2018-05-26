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
						$(".finish1").bind("click", function(d) {
							$("#myform").submit();
						});
						$("#mustbank").change(function() {
							if ($(this).attr("checked") == "checked") {
								$(this).val(1);
							} else {
								$(this).val(0);
							}
						});
						initwizard();
						//$('#rootwizard').bootstrapWizard('show',1);
					});
	function initwizard() {
		$('#rootwizard')
				.bootstrapWizard(
						{
							onNext : function(tab, navigation, index) {
								if (index == 1) {
									var data = getMap($("#myform").serialize());
									if (data.name.trim() == "") {
										window.parent.showAlert("请输入活动名称");
										return false;
									} else {
										$("#p1")
												.html(
														"活动名称： "
																+ decodeURIComponent(data.name));
									}
									if (data.mystarttime == "") {
										window.parent.showAlert("请选择有效日期");
										return false;
									}
									if (data.myendtime == "") {
										window.parent.showAlert("请选择有效日期");

										return false;
									}
									if (data.myendtime != ""
											&& data.mystarttime != "") {
										if(new Date().format("yyyy-MM-dd")>data.mystarttime)
											{
											window.parent
											.showAlert("开始时间不能小于当前时间");
										return false;
											}
										
										if (data.mystarttime > data.myendtime) {
											window.parent
													.showAlert("开始时间必须小于结束时间");
											return false;
										} else {
											$("#p2").html(
													"有效日期： " + data.mystarttime
															+ " 至 "
															+ data.myendtime);
										}

									}
									if (data.proportion == "") {
										window.parent.showAlert("请选择返利比例");
										return false;
									} else {
										if (!test100(data.proportion)) {
											window.parent.showAlert("返利比例输入错误");
											return false;
										} else {
											$("#p3").html(
													"返利比例： " + data.proportion
															+ "%");
										}
									}
									if (data.maxordernum != "") {
										if (!testzzs(data.maxordernum)) {
											window.parent
													.showAlert("每天交易数量上限输入错误");
											return false;
										} else {
											$("#p4").html(
													"每天交易数量上限（笔）："
															+ data.maxordernum);
										}
									} else {
										$("#p4").html("每天交易数量上限（笔）：无上限");
									}

									if (data.maxprice != "") {
										if (!testfloat(data.maxprice)) {
											window.parent
													.showAlert("每单返利金额上限输入错误");
											return false;
										} else {
											$("#p5").html(
													"每单返利金额上限（元）："
															+ data.maxprice);
										}

									} else {
										$("#p5").html("每单返利金额上限（元）：无上限");
									}
									if (data.mustbank == "1") {
										$("#p6").html("是否支持非农商行卡：是");
									} else {
										$("#p6").html("是否支持非农商行卡：否");
									}
									$(".cover").show();
									$
											.post(
													"${ctx}/rebate/checktime",
													{
														"stime" : data.mystarttime,
														"etime" : data.myendtime
													},
													function(d) {
														$(".cover").hide();
														if (d == "1") {
															$('#rootwizard')
																	.bootstrapWizard(
																			'show',
																			1);
															window.parent.document.documentElement.scrollTop = window.parent.document.body.scrollTop = 0;

														} else {
															window.parent
																	.showAlert("选择日期有误，已有非过期红包含有该日期");
														}
													});
								}
								return false;
							},
							onPrevious : function(tab, navigation, index) {
								//alert(index);
							},
							onTabShow : function(tab, navigation, index) {
								if (index == 0) {
									$("#ta1")
											.css("background-color", "#44b549");
									$("#ta1").css("color", "white");
									$("#ta2").css("background-color", "");
									$("#ta2").css("color", "");
									$(".finish1").addClass("hidden");
								} else {
									$("#ta2")
											.css("background-color", "#44b549");
									$("#ta2").css("color", "white");
									$("#ta1").css("background-color", "");
									$("#ta1").css("color", "");
									$(".finish1").removeClass("hidden");
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
					style="vertical-align: text-bottom;" /> 创建返利红包
			</h3>
		</div>
	</div>
				<div id="rootwizard">
					<div class="navbar">
						<div class="mynavbar-inner">
							<div class="container">
								<ul style="width: 100%">
									<li style="width: 50%"><a id="ta1" href="#tab1"
										data-toggle="tab">配置红包规则</a></li>
									<li style="width: 50%"><a id="ta2" href="#tab2"
										data-toggle="tab">配置完成</a></li>

								</ul>
							</div>
						</div>
					</div>
					<div class="tab-content">
						<div class="tab-pane" id="tab1" style="text-align: center;">
							<div class="centrediv">
								<form class="form-horizontal " id="myform" method="post"
									action="${ctx}/rebate/save">


									<div class="control-group ">
										<label for="role-name" class="control-label"><span
											style="color: red">*</span>活动名称:</label>
										<div class="controls">
											<input type="text" class="span m-wrap required"
												maxlength="20" style="width: 322px" name="name" />
										</div>
									</div>
									<div class="control-group ">
										<label for="role-name" class="control-label"><span
											style="color: red">*</span>有效日期:</label>
										<div class="controls">
											<input class="m-wrap m-ctrl-medium date-picker" readonly
												size="16" type="text" value="" name="mystarttime"
												style="height: 34px; width: 150px" /> <span
												class="text-inline"> 到 </span> <input
												style="height: 34px; width: 150px" name="myendtime"
												class="m-wrap m-ctrl-medium date-picker" readonly size="16"
												type="text" value="" />
										</div>
									</div>
									<div class="control-group ">
										<label for="role-name" class="control-label"><span
											style="color: red">*</span>返利比例:</label>
										<div class="controls">
											<input type="text" id="role-name" name="proportion"
												style="height: 32px; width: 150px;" value=""
												class="span m-wrap required" maxlength="3" />%
										</div>
									</div>
									<div class="control-group ">
										<label for="role-name" class="control-label">返利限制:</label>
										<div class="controls">
											<div class="line linediv">
												每天交易数量上限 (笔) : <input type="text" id="role-name"
													name="maxordernum" style="height: 32px; width: 150px;"
													value="" class="span m-wrap required " maxlength="20" />
											</div>
											<div class="line linediv">
												每单返利金额上限 (元) : <input type="text" id="role-name"
													name="maxprice" style="height: 32px; width: 150px;"
													value="" class="span m-wrap required " maxlength="20" />
											</div>
											<div class="line linediv">
												<p>说明：为避免商户非法交易套取返利，设置如上限制规则。</p>
											</div>
											<div class="line linediv">
												<p>用于限制用户每人每天交易数量上限和每单返利金额上限。</p>
											</div>
										</div>
									</div>
									<div class="control-group ">
										<label for="role-name" class="control-label">是否支持非农商行卡:</label>
										<div class="controls">
											<label class="checkbox"> <input type="checkbox"
												id="mustbank" name="mustbank" value="0" />
											</label>
										</div>
									</div>
									<div class="control-group ">
										<label for="role-name" class="control-label">说明:</label>
										<div class="controls">
											<textarea rows="" cols="" style="width: 332px; height: 100px"
												name="remark"></textarea>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="tab-pane" id="tab2">
							<div class="centrediv">
								<div class="backdiv">
									<div class="ps">
										<p id="p1" style="margin-top: 15px">活动名称: sdasd</p>
										<p id="p2">有效日期： 2015-51-19 至 2015-51-19</p>
										<p id="p3">返利比例： 1%</p>
										<p id="p4">每天交易数量上限（笔）： 1</p>
										<p id="p5">每单返利金额上限（元）：0.01</p>
										<p id="p6">是否支持非农商行卡：否</p>
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
							<li class="finish hidden finish1"><a href="javascript:;">完成</a></li>
						</ul>
					</div>

			</div>

</body>
</html>