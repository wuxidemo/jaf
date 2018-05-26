<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<title>管理红包</title>
<style type="text/css">
.backdiv {
	width: 350px;
	height: 250px;
	float: left;
	border: solid 1px;
	margin-left: 20px;
	margin-top: 20px;
	text-align: left;
}

.fbackdiv {
	width: 350px;
	height: 150px;
	float: left;
	border: solid 1px;
	margin-left: 20px;
	margin-top: 20px;
	text-align: left;
}

.ps {
	float: left;
	height: 199px;
	width: 100%;
}

.ps p {
	margin-left: 75px;
}

.fps {
	float: left;
	height: 100px;
	width: 100%;
}

.fps p {
	margin-left: 75px;
}

.ps p:FIRST-CHILD {
	margin-top: 15px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 250px;
}

.fps p:FIRST-CHILD {
	margin-top: 15px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 250px;
}

.btndiv {
	border-top: 1px dashed;
	float: left;
	text-align: center;
	width: 100%;
}

.jhbtn {
	background-color: #44b549;
	border: none;
	box-shadow: none;
	color: white;
	height: 25px;
	margin-top: 10px;
	width: 150px;
}

.tzbtn {
	background-color: #d54036;
	border: none;
	box-shadow: none;
	color: white;
	height: 25px;
	margin-top: 10px;
	width: 150px;
}

.fbtn {
	background-color: #d54036;
	border: none;
	box-shadow: none;
	color: white;
	height: 25px;
	margin-top: 10px;
	width: 150px;
}

.febtn {
	margin-left: 20px;
	background-color: #e6e6e6;
	border: none;
	box-shadow: none;
	color: black;
	height: 25px;
	margin-top: 10px;
	width: 150px;
}

.gq {
	background-color: #e8e8e8;
}

.gqdiv {
	border-top: 1px dashed;
	font-size: 20px;
	line-height: 40px;
	text-align: center;
	line-height: 40px;
	float: left;
	width: 100%;
}

.nodata {
	font-size: 20px;
	line-height: 100px;
	text-align: center;
}
</style>
</head>
<%@ include file="../quote.jsp"%>
<link rel="stylesheet"
	href="${ctx}/static/jquery.pagination/pagination.css" />
<script type="text/javascript"
	src="${ctx}/static/jquery.pagination/jquery.pagination.js"></script>
<script type="text/javascript">
	var pagesize;
	var totalnum = parseInt('${rcount}');
	$(document).ready(function() {

		pagesize = parseInt(($(".tab-content").width() - 20) / 350) * 2;
		//alert(document.documentElement.clientWidth);
		initPagination();
		//	$("#Pagination").insertBefore("asad");

	});
	function initPagination() {
		$("#Pagination").pagination(totalnum, {
			num_edge_entries : 1, //边缘页数
			num_display_entries : 4, //主体页数
			callback : pageselectCallback,
			items_per_page : pagesize, //每页显示1项
			prev_text : "前一页",
			next_text : "后一页",
			link_to : "javascript:void(0);"
		});
	}
	function pageselectCallback(index, jq) {
		getrebate(index + 1);
	}

	function getrebate(index) {
		$
				.post(
						"${ctx}/rebate/data?pageSize=" + pagesize
								+ "&pageIndex=" + index,
						function(d) {
							$("#con1").html("");
							if (d) {
								for (var i = 0; i < d.length; i++) //programverify/view?pvid=134
								{
									var btnhtml = "";
									if (d[i].state == 1) {
										btnhtml = '<div class="btndiv"><button onclick="updatestate('
												+ d[i].id
												+ ',0)" class="tzbtn">停止</button></div>';
									} else if (d[i].state == 0) {
										btnhtml = '<div class="btndiv"><button onclick="updatestate('
												+ d[i].id
												+ ',1)" class="jhbtn">激活</button></div>';
									} else {
										btnhtml = '<div class="gqdiv">已过期</div>';
									}
									$("#con1")
											.append(
													'<div class="backdiv'
															+ (d[i].state == 2 ? ' gq'
																	: '')
															+ '"><div class="ps"><p style="margin-top: 15px">活动名称: '
															+ d[i].name
															+ '</p><p>有效日期： '
															+ getStringDate(new Date(
																	d[i].starttime))
															+ ' 至 '
															+ getStringDate(new Date(
																	d[i].endtime))
															+ '</p><p>返利比例： '
															+ d[i].proportion
															+ '%</p><p>每天交易数量上限（笔）： '
															+ ((d[i].maxordernum == null||d[i].maxordernum == 0 )? '无上限'
																	: d[i].maxordernum)
															+ '</p><p>每单返利金额上限（元）：'
															+ ((d[i].maxprice == null||d[i].maxprice == 0) ? '无上限'
																	: d[i].maxprice / 100)
															+ '</p><p>是否支持非农商行卡：'
															+ (d[i].mustbank == 1 ? '否'
																	: '是')
															+ '</p></div>'
															+ btnhtml
															+ '</div>');
								}
								window.parent.document.documentElement.scrollTop = window.parent.document.body.scrollTop = 0;
								window.parent.iFrameHeight();
							}
						});
	}
	function updatestate(id, state) {
		$("#id").val(id);
		$("#state").val(state);
		$("#myform").attr("action", "${ctx}/rebate/updatestate");
		$("#myform").submit();
	}
	function updatefstate(id, state) {
		$("#id").val(id);
		$("#state").val(state);
		$("#myform").attr("action", "${ctx}/rebate/updatefstate");
		$("#myform").submit();
	}
	function getStringDate(date) {
		return date.getFullYear() + "-" + (date.getMonth() + 1) + "-"
				+ date.getDate();
	}
</script>
<body>
	<form id="myform" action="${ctx}/rebate/updatestate" hidden="hidden">
		<input id="id" name="id"> <input id="state" name="state">
	</form>

	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/flhb.png"
					style="vertical-align: text-bottom;" /> 红包管理
			</h3>
		</div>
	</div>
	<div class="tabbable tabbable-custom">

		<ul class="nav nav-tabs">

			<li <c:if test="${url==null}"> class="active"</c:if> ><a style="font-size: 16px"  data-toggle="tab" href="#tab_1_1"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">返利红包</a></li>

			<li <c:if test="${url!=null}"> class="active"</c:if> ><a style="font-size: 16px" data-toggle="tab" href="#tab_1_2"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">首次红包</a></li>


		</ul>

		<div class="tab-content">

			<div id="tab_1_1" class="tab-pane <c:if test="${url==null}">active</c:if>">
				<div id="con1"></div>
				<div id="Pagination" class="pagination"
					style="width: 100%; float: left; margin: 20px 10px 0 19px;"></div>
			</div>

			<div id="tab_1_2" class="tab-pane <c:if test="${url!=null}">active</c:if>">
				<c:if test="${rf==null}">
					<div class="fbackdiv">
						<div class="fps nodata">暂无数据</div>
						<div class="btndiv">
							<button class="jhbtn"
								onclick="window.location.href='${ctx}/rebate/createf'">创建</button>
						</div>
					</div>
				</c:if>
				<c:if test="${rf!=null}">
					<div class="fbackdiv">
						<div class="fps">
							<p>单个红包金额（元）: ${rf.yprice}</p>
							<p>总发放红包数（个）： ${rf.totalnum}</p>
							<p>
								是否支持非农商行卡：
								<c:if test="${rf.mustbank==1}">否</c:if>
								<c:if test="${rf.mustbank==0}">是</c:if>
							</p>
						</div>
						<div class="btndiv">
							<c:if test="${rf.state==1}">
								<button class="fbtn" onclick="updatefstate(${rf.id},0)">暂停</button>
							</c:if>
							<c:if test="${rf.state==0}">
								<button class="jhbtn" onclick="updatefstate(${rf.id},1)">激活</button>
								<button class="febtn"
									onclick="window.location.href='${ctx}/rebate/updatefform?id=${rf.id}'">修改</button>
							</c:if>
						</div>
					</div>
				</c:if>




			</div>


		</div>

	</div>
</body>
</html>