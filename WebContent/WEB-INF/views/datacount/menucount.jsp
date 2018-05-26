<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>点击量</title>
<style type="text/css">
body {
	min-height: 400px;
}

.fgdiv {
	width: 100%;
	border-bottom: 1px solid #2c2c2c;
}

.content {
	margin-bottom: 20px;
	width: 100%;
	font-size: 17px;
}

.content .title {
	font-size: 26px;
	height: 40px;
	line-height: 50px;
	margin-left: 10px;
}

.time {
	height: 40px;
	line-height: 40px;
	text-align: center;
	margin-top: 20px;
}

.timechoise {
	
}

.timebtn {
	float: left;
	height: 100%;
	width: 100px;
	border-left: 1px solid #2c2c2c;
	border-top: 1px solid #2c2c2c;
	border-bottom: 1px solid #2c2c2c;
	cursor: pointer;
}

.timebtn:last-child {
	border-right: 1px solid #2c2c2c;
	width: 200px !important;
}

.timename {
	float: left;
	width: 100px;
}

.select {
	background-color: #c2c2c2 !important;
	color: white !important;
}

.stardiv {
	margin-top: -3px;
	margin-right: 5px;
	width: 18px;
	height: 18px;
	float: left;
}

.star0 {
	background: url('${ctx}/static/wxfile/images/star10.png') no-repeat
		center;
}

.star1 {
	background: url('${ctx}/static/wxfile/images/star11.png') no-repeat
		center;
}

.star2 {
	background: url('${ctx}/static/wxfile/images/star12.png') no-repeat
		center;
}

.stars {
	height: 18px;
	margin-left: 100px;
	margin-top: 25px;
}

.starname {
	float: left;
	height: 100%;
	line-height: 18px;
	width: 60px
}

.starpoint {
	float: left;
	height: 100%;
	line-height: 18px;
	width: 60px;
	margin-left: 20px;
}

.pies {
	margin-left: 100px;
	margin-top: 20px;
	overflow: hidden;
	border: 1px solid #e8e8e8;
}

.pie {
	padding: 10px;
	width: 400px;
	float: left;
	height: 400px;
}

.tip {
	width: 100%;
	color: red;
	margin-top: 20px;
	padding-left: 100px;
}

#top10 {
	margin-top: 28px;
	margin-left: 100px;
	border: 1px solid #e8e8e8;
	padding: 10px;
	width: 80%;
	height: 600px;
	text-align: center;
}

#jcpl {
	margin-top: 28px;
	margin-left: 100px;
	border: 1px solid #e8e8e8;
	padding: 10px;
	width: 80%;
	height: 600px;
	text-align: center;
}

#top10zz {
	margin-top: 28px;
	margin-left: 100px;
	border: 1px solid #e8e8e8;
	padding: 10px;
	width: 80%;
	height: 600px;
	text-align: center;
}

#top10kw {
	margin-top: 28px;
	margin-left: 100px;
	border: 1px solid #e8e8e8;
	padding: 10px;
	width: 50%;
	height: 400px;
	text-align: center;
}

.htk {
	width: 100%;
	height: 100px;
	margin-left: 85px;
	margin-top: 20px;
}

.htk .left {
	width: 218px;
	height: 100px;
	float: left;
}

.htk .left .top {
	width: 100%;
	height: 40px;
	float: left;
	position: relative;
}

.htk .left .bottom {
	width: 100%;
	height: 60px;
	float: left;
}

.htk .right {
	margin-left: 30px;
	width: 150px;
	height: 100px;
	float: left;
	position: relative;
}

.greendiv {
	height: 100%;
	background-color: #62c358;
	width: 50%;
	float: left;
}

.bluediv {
	height: 100%;
	background-color: #02dee0;
	width: 50%;
	float: left;
}

.alluser {
	width: 218px;
	height: 60px;
	position: absolute;
	background: url('${ctx}/static/wxfile/images/alluser.png') center;
}

.perdiv {
	background-color: #62c358;
	color: white;
	height: 25px;
	left: 50%;
	line-height: 25px;
	margin-left: -25px;
	position: absolute;
	text-align: center;
	width: 50px;
}

.htk .right .top {
	bottom: 30px;
	position: absolute;
	line-height: 30px;
	width: 100%;
	height: 30px;
}

.htk .right .bottom {
	bottom: 0;
	position: absolute;
	line-height: 30px;
	width: 100%;
	height: 30px;
}

.sgreeen {
	background-color: #62c358;
	float: left;
	height: 20px;
	margin-right: 5px;
	margin-top: 5px;
	width: 20px;
}

.sblue {
	background-color: #02dee0;
	float: left;
	height: 20px;
	margin-right: 5px;
	margin-top: 5px;
	width: 20px;
}

.search {
	border: 1px solid #2c2c2c;
	height: 100px;
	margin-top: 20px;
	width: 100%;
}

.stitle {
	border-bottom: 1px solid #2c2c2c;
	height: 30px;
	line-height: 30px;
	padding-left: 15px;
	width: 100%;
}

.searchs {
	width: 100%;
	padding-top: 20px;
	padding-left: 20px;
}

.searchs input {
	
}
</style>
</head>

<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" media="all"
	href="${ctx}/static/wxfile/js/daterangepicker-bs3.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/static/mt/media/css/select2_metro.css" />
<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">点击量</h3>
		</div>
	</div>
	<div class="fgdiv"></div>
	<c:if test="${mid==null}">
		<div class="search">
			<div class="stitle">查询</div>
			<div class="searchs">
				<input type="hidden" id="select2_sample3"
					style="width: 400px; margin-left: 20px;" class="select2">
			</div>
		</div>
	</c:if>
				
	<div id="allpie" <%-- <c:if test="${mid==null}">style="display:none"</c:if> --%>>
		<div class="content">
			<div class="time">
				<div class="timename">时间</div>
				<div id="time1" class="timechoise">
					<div key="1" class="a timebtn select">今日</div>
					<div key="2" class="a timebtn">最近7天</div>
					<div key="3" class="a timebtn">最近30天</div>
					<div key="4" class="timebtn">
						<input type="text"
							style="width: 100%; height: 40px; border: none; box-shadow: none; cursor: pointer; background-color: white; border-radius: 0px;"
							id="range3" class="form-control" readonly="readonly"
							value="${now}-${end}" />
					</div>
				</div>
			</div>
			<div id="djl"></div>
			
		</div>

		<div class="fgdiv"></div>
		<div class="content">
			<div class="title">回头客比例</div>
			<div class="htk">
				<div class="left">
					<div class="top">
						<div class="perdiv">30%</div>
					</div>
					<div class="bottom">
						<div class="greendiv"></div>
						<div class="bluediv"></div>
						<div class="alluser"></div>
					</div>
				</div>
				<div class="right">
					<div class="top">
						<div class="sgreeen"></div>
						回头客
					</div>
					<div class="bottom">
						<div class="sblue"></div>
						新用户
					</div>
				</div>
			</div>
		</div>

		<div class="fgdiv"></div>
		<div class="content">
			<div class="title">就餐频率</div>
			<div id="jcpl"></div>
		</div>
		<div class="fgdiv"></div>
		<div class="content">
			<div class="title">菜品分类比例</div>
			<div class="time">
				<div class="timename">时间</div>
				<div id="time2" class="timechoise">
					<div key="1" class="a timebtn select">今日</div>
					<div key="2" class="a timebtn">7天</div>
					<div key="3" class="a timebtn">30天</div>
					<div key="4" class="timebtn">
						<input type="text"
							style="width: 100%; height: 40px; border: none; box-shadow: none; cursor: pointer; background-color: white; border-radius: 0px;"
							id="range2" class="form-control" readonly="readonly"
							value="${now}-${end}" />
					</div>
				</div>
			</div>
			<div id="top10zz"></div>
		</div>


		<div class="fgdiv"></div>
		<div class="content">
			<div class="title">口味偏好</div>
			<div class="time">
				<div class="timename">时间</div>
				<div id="time3" class="timechoise">
					<div key="1" class="a timebtn select">今日</div>
					<div key="2" class="a timebtn">7天</div>
					<div key="3" class="a timebtn">30天</div>
					<div key="4" class="timebtn">
						<input type="text"
							style="width: 100%; height: 40px; border: none; box-shadow: none; cursor: pointer; background-color: white; border-radius: 0px;"
							id="range3" class="form-control" readonly="readonly"
							value="${now}-${end}" />
					</div>
				</div>
			</div>
			<div id="top10kw"></div>
		</div>

		<div class="fgdiv"></div>
		<div class="content">
			<div class="title">菜品排名(前十)</div>
			<div class="time">
				<div class="timename">时间</div>
				<div id="time4" class="timechoise">
					<div key="1" class="a timebtn select">今日</div>
					<div key="2" class="a timebtn">7天</div>
					<div key="3" class="a timebtn">30天</div>
					<div key="4" class="timebtn">
						<input type="text"
							style="width: 100%; height: 40px; border: none; box-shadow: none; cursor: pointer; background-color: white; border-radius: 0px;"
							id="range4" class="form-control" readonly="readonly"
							value="${now}-${end}" />
					</div>
				</div>
			</div>
			<div id="top10"></div>
		</div>

	</div>
</body>
<script src="${ctx}/static/jquery/jquery-1.9.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/static/echarts-2.0.0/build/echarts-plain.js"></script>
<script type="text/javascript" src="${ctx}/static/wxfile/js/moment.js">
	
</script>
<script type="text/javascript"
	src="${ctx}/static/wxfile/js/daterangepicker.js">
</script>
<script type="text/javascript"
	src="${ctx}/static/mt/media/js/select2.min.js"></script>
<script type="text/javascript">
	var djl = echarts.init(document.getElementById('djl'));
	//var top10cp = echarts.init(document.getElementById('top10cp'));
	/* var top10kw = echarts.init(document.getElementById('top10kw'));
	var top10 = echarts.init(document.getElementById('top10'));
	var top10zz = echarts.init(document.getElementById('top10zz'));
	var jcpl = echarts.init(document.getElementById('jcpl')); */
	var mid='${mid}';
	$(document).ready(function() {
		$(window.parent.document.body).css("min-width","640px");
		if(mid==""){
			initselect2();
		}else
			{
			initall();
			}
		initdaterange();
		initclick();
	});
	function initselect2()
	{
		 $("#select2_sample3").select2({
	            allowClear: true,
	            minimumInputLength: 1,
	            query: function (query) {
	            	$.post("${ctx}/datacount/getmbyname",{"name":query.term},function(d){
	            		 var data = {
	     	                    results: []
	     	                };
	            		for(var i=0;i<d.length;i++)
	            		{
	            			 data.results.push({
	 	                        id: d[i].id,
	 	                        text: d[i].name
	 	                    });
	            		}
	            		 query.callback(data);
	            	});
	            }
	        });
		 $("#select2_sample3").bind("change",function(d){
			// alert("aa");
			 mid=d.val;
			 initall();
		 });
	}
	function initall()
	{
		$("#allpie").css("display","block");
		var data = {};
			data.today = 1;
		initdjl(data);
		/* //inittop10cp(data);
		inittop10kw(data);
		inittop10zz(data);
		inittop10(data);
		inithtk();
		initdjl(); */
		//cleartimeselect("1");
		//cleartimeselect("2");
		//cleartimeselect("3");
		//cleartimeselect("4");
		window.parent.iFrameHeight();
	}
	//初始化 时间段选择控件
	function initdaterange() {
		$('#range1').daterangepicker({
			format : 'YYYY-MM-DD',
			firstDay : 2,
			locale : {
				applyLabel : '确认',
				cancelLabel : '取消',
				customRangeLabel : 'Custom'
			},startDate:"${now}",endDate:"${end}"
		}, function(start, end, label) {
		});

		$('#range1').on('apply.daterangepicker', function(ev, picker) {
			$(this).addClass("select");
			cleartimeselect("1");
			var data = {};
			data.stime = picker.startDate.format('YYYY-MM-DD');
			data.etime = picker.endDate.format('YYYY-MM-DD');
			initdjl(data);
		});

		/* $('#range2').daterangepicker({
			format : 'YYYY/MM/DD',
			firstDay : 2,
			locale : {
				applyLabel : '确认',
				cancelLabel : '取消',
				customRangeLabel : 'Custom'
			},startDate:"${now}",endDate:"${end}"
		}, function(start, end, label) {
		});

		$('#range2').on('apply.daterangepicker', function(ev, picker) {
			$(this).addClass("select");
			cleartimeselect("2");
			var data = {};
			data.stime = picker.startDate.format('YYYY-MM-DD');
			data.etime = picker.endDate.format('YYYY-MM-DD');
			inittop10zz(data);
		});

		$('#range3').daterangepicker({
			format : 'YYYY/MM/DD',
			firstDay : 2,
			locale : {
				applyLabel : '确认',
				cancelLabel : '取消',
				customRangeLabel : 'Custom'
			},startDate:"${now}",endDate:"${end}"
		}, function(start, end, label) {
		});

		$('#range3').on('apply.daterangepicker', function(ev, picker) {
			$(this).addClass("select");
			cleartimeselect("3");
			var data = {};
			data.stime = picker.startDate.format('YYYY-MM-DD');
			data.etime = picker.endDate.format('YYYY-MM-DD');
			inittop10kw(data);
		});

		$('#range4').daterangepicker({
			format : 'YYYY/MM/DD',
			firstDay : 2,
			locale : {
				applyLabel : '确认',
				cancelLabel : '取消',
				customRangeLabel : 'Custom'
			},startDate:"${now}",endDate:"${end}"
		}, function(start, end, label) {
		});

		$('#range4').on('apply.daterangepicker', function(ev, picker) {
			$(this).addClass("select");
			cleartimeselect("4");
			var data = {};
			data.stime = picker.startDate.format('YYYY-MM-DD');
			data.etime = picker.endDate.format('YYYY-MM-DD');
			inittop10(data);
		});
	} */
	
	//初始化 时间选择DIV 点击时间
	function initclick() {
		$("#time1 .a").bind("click", function() {
			var key = $(this).attr("key");
			changetime(key, "1");
			var data = {};
			if (key == "1") {
				data.today = 1;
			} else if (key == "2") {
				data.day7 = 1;
			} else if (key == "3") {
				data.day30 = 1;
			}
			initdjl(data); 
		});
	}
	
	//清空时间DIV选择状态
	function cleartimeselect(num) {
		$("#time" + num + " .a").each(function() {
			$(this).removeClass("select");
		});
	}
	//更改选中状态
	function changetime(key, num) {
		$('#range' + num).removeClass("select");
		$("#time" + num + " .a").each(function() {
			if ($(this).attr("key") == key) {
				$(this).addClass("select");
			} else {
				$(this).removeClass("select");
			}
		});
	}
	//初始化点评数据
	/* function initpj(data) {
		$.post("${ctx}/datacount/pjcount?mid="+mid, data, function(d) {
			$(".starpoint").html(d.pjzp + "分");
			$(".pjstar").html("");
			for (var i = 0; i < d.end1; i++) {
				$(".pjstar").append('<div class="stardiv star1"></div>');
			}
			if (d.ish == 1) {
				$(".pjstar").append('<div class="stardiv star2"></div>');
			}
			for (var i = d.start2; i <= 5; i++) {
				$(".pjstar").append('<div class="stardiv star0"></div>');
			}

			kwp.dispose();
			kwp = echarts.init(document.getElementById('kwp'));
			piedata.legend = legend;
			piedata.title.text = "口味" + d.kwsum + "分";
			piedata.series[0].name = "口味";
			for (var i = 0; i < d.kwcont.length; i++) {
				piedata.series[0].data[i].value = d.kwcont[i];
			}
			kwp.setOption(piedata);

			piedata.legend = null;
			piedata.title.text = "服务" + d.fwsum + "分";
			piedata.series[0].name = "服务";
			for (var i = 0; i < d.fwcont.length; i++) {
				piedata.series[0].data[i].value = d.fwcont[i];
			}
			fwp.dispose();
			fwp = echarts.init(document.getElementById('fwp'));
			fwp.setOption(piedata);

			piedata.title.text = "环境" + d.hjsum + "分";
			piedata.series[0].name = "环境";
			for (var i = 0; i < d.hjcont.length; i++) {
				piedata.series[0].data[i].value = d.hjcont[i];
			}
			hjp.dispose();
			hjp = echarts.init(document.getElementById('hjp'));
			hjp.setOption(piedata);

		});

	} */
//TODO
	/*  function inittop10cp(data) {
		$.post("${ctx}/datacount/top10cp?mid="+mid, data, function(d) {
			top10cp.dispose();
			top10cp = echarts.init(document.getElementById('top10cp'));
			top10cpdata.legend.data = [];
			top10cpdata.series[0].data = [];
			for (var i = 0; i < d.length; i++) {
				top10cpdata.legend.data[i] = d[i][2];
				var value = {};
				value.name = d[i][2];
				value.value = d[i][0];
				top10cpdata.series[0].data[i] = value;
			}
			top10cp.setOption(top10cpdata);

		});
	}  */
	
	/* function inittop10kw(data) {
		$.post("${ctx}/datacount/top10kw?mid="+mid, data, function(d) {
			top10kw.dispose();
			top10kw = echarts.init(document.getElementById('top10kw'));
			top10cpdata.legend.data = [];
			top10cpdata.series[0].data = [];
			for (var i = 0; i < d.length; i++) {
				top10cpdata.legend.data[i] = d[i][2];
				var value = {};
				value.name = d[i][2];
				value.value = d[i][0];
				top10cpdata.series[0].data[i] = value;
			}
			top10kw.setOption(top10cpdata);

		});
	} */
	
//xxj	
	/* function inittop10zz(data){
		$.post("${ctx}/datacount/top10cp?mid="+mid, data, function(d){
			if (d.length == 0) {
				$("#top10zz").html("暂无数据");
			}else{
			top10zz.dispose();
			top10zz = echarts.init(document.getElementById('top10zz'));
			top10zzdata.yAxis[0].data = [];
			top10zzdata.series[0].data = [];
			for(var i = d.length - 1; i >= 0; i--){
				top10zzdata.yAxis[0].data[d.length - 1 - i] = d[i][2];
				top10zzdata.series[0].data[d.length - 1 - i] = d[i][0];
			}
			top10zz.setOption(top10zzdata); 
			}
		});
	} */
	
	/* var top10count = 0;
	//菜品排名初始化
	function inittop10(data) {
		$.post("${ctx}/datacount/top10?mid="+mid, data, function(d) {
			if (d.length == 0) {
				$("#top10").html("暂无数据");
			} else {
				top10data.yAxis[0].data = [];
				top10data.series[0].data = [];
				top10count = 0;
				for (var i = d.length - 1; i >= 0; i--) {
					top10data.yAxis[0].data[d.length - 1 - i] = d[i][1];
					top10data.series[0].data[d.length - 1 - i] = d[i][0];
					top10count += top10data.series[0].data[d.length - 1 - i];
				}
				top10.dispose();
				top10 = echarts.init(document.getElementById('top10'));
				top10.setOption(top10data);
			}
		});

	}

	function inithtk() {
		$.post("${ctx}/datacount/htk?mid="+mid, function(d) {
			$(".greendiv").css("width", d.per + "%");
			$(".bluediv").css("width", (100 - d.per) + "%");
			$(".perdiv").css("left", d.per + "%");
			$(".perdiv").html(d.per + "%");
			$(".htk .right .top").html('<div class="sgreeen"></div>回头客'+d.old+"人");
			$(".htk .right .bottom").html('<div class="sblue"></div>新用户'+d.new+"人");
		});
	} */
	
	var djlcount = 0;
	function initdjl()
	{
		$.post("${ctx}/wxpage/text1",function(d){
			djldata.series[0].data = [];
			djldata.yAxis[0].data = [];
			djlcount = 0;
			for (var i = 0; i <d.data.length; i++) {
				djldata.series[0].data[i] = d.data[i][1];
				djldata.yAxis[0].data[i] = d.data[i][0];
				djlcount+=d.data[i][1];
			}
			//djldata.title.text="平均消费频率："+d.avg+"次/月";
			djl.dispose();
			djl = echarts.init(document.getElementById('djl'));
			djl.setOption(djldata);
		});
	}
	
	var djldata = {
		    title : {
		        text: '',
		        subtext: ''
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['首页','社区','优惠券','我的']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : ['周一','周二','周三','周四','周五','周六','周日']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'点击量',
		            type:'line',
		            smooth:true,
		            itemStyle: {normal: {areaStyle: {type: 'default'}}},
		            data:[10, 12, 21, 54, 260, 830, 710]
		        }
		]
	}
  }
</script>
</html>