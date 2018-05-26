<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
	<title>广告管理</title>
	<link href="${ctx}/static/wxyt/loaders.min.css" rel="stylesheet" type="text/css">
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/wxyt/wxyt.js"></script>
	<script type="text/javascript" src="${ctx}/static/wxyt/jquery.form.min.js"></script>
</head>
<style type="text/css">
tbody > tr > td {
	word-wrap:break-word;
	word-break:break-all;
}
</style>

<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/static/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>

<script type="text/javascript">
	window.UEDITOR_HOME_URL = "${ctx}";
</script>

<script type="text/javascript">

	var ue = '';
	jQuery(document).ready(function() {
		window.parent.scrollTo(0,0);
		getLunBo();
		getHuoDong();
		getQiangGou();
		
		$.getJSON( '${ctx}/wxyt/config', function(data) {
			if (data.result == "1") {
				var sign = data.sign;// "ZkXygoKlOhG1lUq5e6nvDqB8DN1hPTEwMDEzNDE5JmI9bHV5ZnRlc3Qmaz1BS0lERTlqdVZ0REtHSWloQmVzRDhIU3pyODVlNkNNN3ZMcmkmZT0xNDQ5MTMyNDQzJnQ9MTQ0OTEyODg5MiZyPTE1MzkxODE4MjImdT0wJmY9"
				var url = data.url + '?sign=' + encodeURIComponent(sign);
				UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
				UE.Editor.prototype.getActionUrl = function(action) {
				    if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
				        return url;
				    } else if (action == 'uploadvideo') {
				        return 'http://a.b.com/video.php';
				    } else {
				        return this._bkGetActionUrl.call(this, action);
				    }
				}
			}
		});
		
	    ue = UE.getEditor('container',{
		    toolbars: [
		               ['undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch',
		               'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload']
		          ],
            autoHeightEnabled: false,
            autoFloatEnabled: true,
		    });
	    
	    wxyt({
			div : "uplunboic" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议大小238*264)",
			maxsize : 4194304,
			sucess : function(download_url, fileid, url) {
				$("#advertimg").val(download_url);
				
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				$("#adimg").attr("src",download_url+'?imageView2/2/w/258/h/170/q/85');
				
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
	    
	    wxyt({
			div : "upshanghupic" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议尺寸187*135)",
			maxsize : 4194304,
			sucess : function(download_url, fileid, url) {
				$("#advertimg").val(download_url);
				
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				$("#adimg").attr("src",download_url+'?imageView2/2/w/258/h/170/q/85');
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
		
	    wxyt({
			div : "upyouhuipic" ,
			baseurl : "${ctx}",
			tip : "(支持jpg,png格式.建议大小720*320)",
			maxsize : 4194304,
			sucess : function(download_url, fileid, url) {
				$("#advertimg").val(download_url);
				
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				$("#adimg").attr("src",download_url+'?imageView2/2/w/258/h/170/q/85');
				
				setTimeout('window.parent.iFrameHeight();',100);
			},
			fail : function(d) {
				alert(d);
			}
		});
	    
	    $("input:radio[name='type2']").change(function(){
	    	var revalue = $(this).val();
	    	if(revalue == 0) {
	    		$("#addnamediv").show();
	    		$("#adcontentdiv").show();
	    		$("#adurldiv").hide();
	    	}else{
	    		$("#addnamediv").hide();
	    		$("#adcontentdiv").hide();
	    		$("#adurldiv").show();
	    	}
	    });
		
	});
	
	function getLunBo() {
		var lunbourl = "${ctx}/advert/getadbytype"
		$.post(lunbourl,{"type":"commlunbo"},function(data){
			if(data != null && data.length > 0) {
				for(var i=0;i<data.length;i++){
					
					var lunboid = data[i].id;
					var lunbotitle = data[i].title;
					var lunbopos = data[i].position; 
					
					var index1obj = $("#lunbo"+lunbopos).children().eq(1);
					if(lunbotitle == '') {
						index1obj.html("URL地址");
					}else{
						index1obj.html(lunbotitle);
					}
					
					$("#lunbo"+lunbopos).children().eq(2).html('<a href="javascript:;" onclick="showLunBo(\''+lunboid+'\')">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;'
															  + '<a href="javascript:;" onclick="editLunBo(\''+lunboid+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;'
															  + '<a href="javascript:;" onclick="deladvert(\''+lunboid+'\',\'commlunbo\')">删除</a>');
				}
				window.parent.iFrameHeight();
			
			}else{
				
			}

		});
	}
	
	function getHuoDong() {
		var huodongurl = "${ctx}/advert/getadbytype"
		$.post(huodongurl,{"type":"commhuodong"},function(data){
			if(data != null && data.length > 0) {
				for(var i=0;i<data.length;i++){
					
					var houdongid = data[i].id;
					var huodongtitle = data[i].title;
					var huodongimg = data[i].img;
					
					if(huodongimg.indexOf("http://") >= 0) {
						
					}else{
						huodongimg = '${ctx}/' + huodongimg;
					}
					
					var huodongcontent = data[i].content;
					var huodongpos = data[i].position;

					var huodongtype2 = data[i].type2;
					var huodongurl = data[i].url;
					
					var huodongobj = $("#huodong"+huodongpos);
					
					var instr = '<td style="width:10%;">'+huodongpos+'</td>'
					          + '<td style="width:20%;">'+(huodongtitle == '' ? "URL" : huodongtitle)+'</td>'
					          + '<td style="width:20%;"><img src="'+huodongimg+'" style="width:100px; height:70px;" /></td>'
					          + '<td style="width:30%;">'+(huodongtype2 == 1 ? huodongurl : "(空)")+'</td>'
					          + '<td style="width:20%;">'
					          +     '<a href="javascript:;" onclick="showHuoDong(\''+houdongid+'\')">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;'
					          +     '<a href="javascript:;" onclick="editHuoDong(\''+houdongid+'\')">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;'
					          +     '<a href="javascript:;" onclick="deladvert(\''+houdongid+'\',\'commhuodong\')">删除</a>'
					          + '</td>';
					
					$("#huodong"+huodongpos).empty();
					$("#huodong"+huodongpos).html(instr);
				}
				
				window.parent.iFrameHeight();
			
			}else{
				
			}

		});
	}
	
	function getQiangGou() {
		var qianggouurl = "${ctx}/advert/getquickbuylist"
		$.post(qianggouurl,{"type":"preferential"},function(data){
			if(data != null && data.length > 0) {
				for(var i=0;i<data.length;i++){
					
					var qianggouid = data[i].id;
					var qianggouposition = data[i].position;
					var qianggoutitle = data[i].title;
					var qianggouimgurl = data[i].imgurl;
					var qianggoustarttime = formattime(data[i].starttime);
					var qianggouendtime = formattime(data[i].endtime);
					var qianggousoldamount = data[i].soldamount;
					var qianggoustate = data[i].state;
					
					var statestr = '';
					var dostr = '';
					if(qianggoustate == 1) {
						statestr = '未开始';
						dostr = '<a href="${ctx}/advert/updateqianggou/'+qianggouid+'" >修改</a>&nbsp;&nbsp;'
						       +'<a href="javascript:;" onclick="offlineQiangGou(\''+qianggouid+'\')">下线</a>&nbsp;&nbsp;'; 
					}else if(qianggoustate == 2) {
						statestr = '进行中';
						dostr = '<a href="${ctx}/advert/updateqianggou/'+qianggouid+'" >修改</a>&nbsp;&nbsp;'
						       +'<a href="javascript:;" onclick="offlineQiangGou(\''+qianggouid+'\')">下线</a>&nbsp;&nbsp;';
					}else if(qianggoustate == 3) {
						statestr = '已抢完';
						dostr = '<a href="javascript:;" onclick="offlineQiangGou(\''+qianggouid+'\')">下线</a>&nbsp;&nbsp;';
					}else if(qianggoustate == 4) {
						statestr = '已下线';
						dostr = '<a href="${ctx}/advert/updateqianggou/'+qianggouid+'" >修改</a>&nbsp;&nbsp;'
						       +'<a href="javascript:;" onclick="onlineQiangGou(\''+qianggouid+'\')">上线</a>&nbsp;&nbsp;';
					}else if(qianggoustate == 5) {
						statestr = '已结束';
					}
					
					$("#qianggou"+qianggouposition).children().eq(1).html('&nbsp;'+qianggoustarttime+'<br/>-'+qianggouendtime);
					$("#qianggou"+qianggouposition).children().eq(2).html(qianggoutitle);
					$("#qianggou"+qianggouposition).children().eq(3).html('<img src="'+qianggouimgurl+'" alt="'+qianggoutitle+'" style="width:100px;height:60px;" />');
					$("#qianggou"+qianggouposition).children().eq(4).html(qianggousoldamount);
					$("#qianggou"+qianggouposition).children().eq(5).html(statestr);
					$("#qianggou"+qianggouposition).children().eq(6).html(
						'<a href="${ctx}/advert/viewqianggou/'+qianggouid+'" >查看</a>&nbsp;&nbsp;'
						+dostr
						+'<a href="javascript:;" onclick="deleteQiangGou(\''+qianggouid+'\',\''+qianggouposition+'\')">删除</a>&nbsp;&nbsp;'
						);
			          
				}
				window.parent.iFrameHeight();
				
			}else{
				
			}

		});
	}
	
	function formattime(timestr) {
		var date = new Date(timestr);
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var dd = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();
		
		if(month < 10) {
			month = "0"+month;
		}
		if(dd < 10) {
			dd = "0" + dd;
		}
		if(hour < 10) {
			hour = "0" + hour;
		}
		if(minute < 10) {
			minute = "0" + minute;
		}
		if(second < 10) {
			second = "0" + second;
		} 
		
		return year+"-"+month+"-"+dd+" "+hour+":"+minute;
	}
	
	function cancel() {
		$("#admodal").modal("hide");
	}
	
	function hideall() {
		$("#adtyperadiodiv").hide();
		$("#addnamediv").hide();
		$("#adlunbopicdiv").hide();
		$("#adshanghupicdiv").hide();
		$("#adyouhuipicdiv").hide();
		$("#imgfacediv").hide();
		$("#adcontentdiv").hide();
		$("#adcontentlinkdiv").hide();
		$("#adcontentdescdiv").hide();
		$("#adurldiv").hide();
	}
	
	function clearAllData() {
		$("input:radio[name='type2'][value='0']").prop("checked",true);
		$("input:radio[name='type2']").removeAttr("disabled","disabled");
		$("#name").val("");
		$("#name").removeAttr("disabled","disabled");
		
		$("#adimg").attr("src","${ctx}/static/images/zanwuPic.jpg");
		$("#adimg").css("width","300px");
		$("#adimg").attr("height","200px");
		
		ue.setContent("");
		ue.setEnabled();
		
		$("#adcontentlink").val("");
		$("#adcontentlink").removeAttr("disabled","disabled");
		
		$("#adcontentdesc").val("");
		$("#adcontentdesc").removeAttr("disabled","disabled");
		
		$("#urldiv").html("URL：");
		
		$("#adurl").val("");
		$("#adurl").removeAttr("disabled","disabled");
		
		$("#id").val("");
		$("#advertimg").val("");
		$("#adtype").val("");
		$("#adpos").val("");
		
	}
	
	function addLunBo(pos) {
		hideall();
		clearAllData();
		$("#adpos").val(pos);
		$("#adtype").val("commlunbo");
		
		$("#adtyperadiodiv").show();
		$("#addnamediv").show();
		$("#adlunbopicdiv").show();
		$("#imgfacediv").show();
		$("#adcontentdiv").show();
		
		$("#cancel_btn").val("取消");
		$("#cancel_btn").show();
		$("#submit_btn").show();
		
		$("#admodal").modal("show");
	}
	
	function showLunBo(adid) {
		
		var showoneurl = '${ctx}/advert/getadbyid';
		$.post(showoneurl,{"id":adid},function(dd){
			if(dd.result == '1') {
				hideall();
				clearAllData();
				
				var data = dd.data;
				
				var retype2 = data.type2;
				
				if(retype2 == 0) {
					$("input:radio[name='type2'][value='0']").prop("checked",true);
					$("input:radio[name='type2'][value='0']").attr("disabled","disabled");
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("input:radio[name='type2'][value='1']").prop("checked",true);
					$("input:radio[name='type2'][value='1']").attr("disabled","disabled");
				}
				
				
				
				var adimgurl = data.img;
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				if(adimgurl.indexOf("http://") >= 0) {
					$("#adimg").attr("src",adimgurl);
				}else{
					$("#adimg").attr("src","${ctx}/"+adimgurl);
				}
				$("#imgfacediv").show();
				
				if(retype2 == 0) {
					$("#name").val(data.title);
					$("#name").attr("disabled","disabled");
					$("#addnamediv").show();
					
					ue.setContent(data.content);
					ue.setDisabled('fullscreen');
					$("#adcontentdiv").show();
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("#adurl").val(data.url);
					$("#adurl").attr("disabled","disabled");
					$("#adurldiv").show();
				}
				
				$("#cancel_btn").val("确定");
				$("#submit_btn").hide();
				
				$("#admodal").modal("show");
				
			}else{
				
			}
		});
		
	}
	
	function editLunBo(adid) {
		
		var editoneurl = '${ctx}/advert/getadbyid';
		$.post(editoneurl,{"id":adid},function(dd){
			if(dd.result == '1') {
				hideall();
				clearAllData();
				
				var data = dd.data;
				
				var retype2 = data.type2;
				if(retype2 == 0) {
					$("input:radio[name='type2'][value='0']").prop("checked",true);
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("input:radio[name='type2'][value='1']").prop("checked",true);
				}
				$("#adtyperadiodiv").show();
				
				$("#adlunbopicdiv").show();
				
				var adimgurl = data.img;
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				if(adimgurl.indexOf("http://") >= 0) {
					$("#adimg").attr("src",adimgurl);
				}else{
					$("#adimg").attr("src","${ctx}/"+adimgurl);
				}
				$("#imgfacediv").show();
				
				$("#id").val(data.id);
				$("#advertimg").val(data.img);
				$("#adtype").val(data.type);
				$("#adpos").val(data.position);
				
				if(retype2 == 0) {
					$("#name").val(data.title);
					$("#addnamediv").show();
					
					ue.setContent(data.content);
					//ue.setDisabled('fullscreen');
					$("#adcontentdiv").show();
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("#adurl").val(data.url);
					$("#adurldiv").show();
				}
				
				$("#cancel_btn").val("取消");
				$("#cancel_btn").show();
				$("#submit_btn").show();
				
				$("#admodal").modal("show");
				
			}else{
				
			}
		});
		
	}
	
	function addHuoDong(pos) {
		hideall();
		clearAllData();
		$("#adpos").val(pos);
		$("#adtype").val("commhuodong");
		
		$("#urldiv").html("活动链接：");
		
		$("#adtyperadiodiv").show();
		$("#addnamediv").show();
		$("#adlunbopicdiv").show();
		$("#imgfacediv").show();
		$("#adcontentdiv").show();
		
		$("#cancel_btn").val("取消");
		$("#cancel_btn").show();
		$("#submit_btn").show();
		
		$("#admodal").modal("show");
	}
	
	function showHuoDong(adid) {
		
		var showoneurl = '${ctx}/advert/getadbyid';
		$.post(showoneurl,{"id":adid},function(dd){
			if(dd.result == '1') {
				hideall();
				clearAllData();
				
				var data = dd.data;
				
				var retype2 = data.type2;
				
				if(retype2 == 0) {
					$("input:radio[name='type2'][value='0']").prop("checked",true);
					$("input:radio[name='type2'][value='0']").attr("disabled","disabled");
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("input:radio[name='type2'][value='1']").prop("checked",true);
					$("input:radio[name='type2'][value='1']").attr("disabled","disabled");
				}
				
				
				
				var adimgurl = data.img;
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				if(adimgurl.indexOf("http://") >= 0) {
					$("#adimg").attr("src",adimgurl);
				}else{
					$("#adimg").attr("src","${ctx}/"+adimgurl);
				}
				$("#imgfacediv").show();
				
				if(retype2 == 0) {
					$("#name").val(data.title);
					$("#name").attr("disabled","disabled");
					$("#addnamediv").show();
					
					ue.setContent(data.content);
					ue.setDisabled('fullscreen');
					$("#adcontentdiv").show();
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("#adurl").val(data.url);
					$("#adurl").attr("disabled","disabled");
					$("#adurldiv").show();
				}
				
				$("#cancel_btn").val("确定");
				$("#submit_btn").hide();
				
				$("#admodal").modal("show");
				
			}else{
				
			}
		});
		
	}
	
	function editHuoDong(adid) {
		
		var editoneurl = '${ctx}/advert/getadbyid';
		$.post(editoneurl,{"id":adid},function(dd){
			if(dd.result == '1') {
				hideall();
				clearAllData();
				
				var data = dd.data;
				
				var retype2 = data.type2;
				if(retype2 == 0) {
					$("input:radio[name='type2'][value='0']").prop("checked",true);
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("input:radio[name='type2'][value='1']").prop("checked",true);
				}
				$("#adtyperadiodiv").show();
				
				$("#adlunbopicdiv").show();
				
				var adimgurl = data.img;
				$("#adimg").css("width","300px");
				$("#adimg").css("height","200px");
				if(adimgurl.indexOf("http://") >= 0) {
					$("#adimg").attr("src",adimgurl);
				}else{
					$("#adimg").attr("src","${ctx}/"+adimgurl);
				}
				$("#imgfacediv").show();
				
				$("#id").val(data.id);
				$("#advertimg").val(data.img);
				$("#adtype").val(data.type);
				$("#adpos").val(data.position);
				
				if(retype2 == 0) {
					$("#name").val(data.title);
					$("#addnamediv").show();
					
					ue.setContent(data.content);
					//ue.setDisabled('fullscreen');
					$("#adcontentdiv").show();
				}else if(retype2 == '' || retype2 == null || retype2 == 1){
					$("#adurl").val(data.url);
					$("#adurldiv").show();
				}
				
				$("#cancel_btn").val("取消");
				$("#cancel_btn").show();
				$("#submit_btn").show();
				
				$("#admodal").modal("show");
				
			}else{
				
			}
		});
		
	}
	
	
	
	function deladvert(advid,type) {
		var delurl = "${ctx}/advert/deladv";
		$.post(delurl,{"advid":advid},function(data){
			var pos = data.pos;
			if(type == 'commlunbo') {
				
				var index1obj = $("#lunbo"+pos).children().eq(1);
				index1obj.html("(空)");
				$("#lunbo"+pos).children().eq(2).html('<a href="javascript:;" onclick="addLunBo('+pos+')">上传</a>');
				
			}else if(type == 'commhuodong') {
				var delinstr = '<td>'+pos+'</td>'
		          + '<td colspan="3">(空)</td>'
		          + '<td>'
		          +     '<a href="javascript:;" onclick="addHuoDong('+pos+')">上传</a>'
		          + '</td>';
		
				$("#huodong"+pos).empty();
				$("#huodong"+pos).html(delinstr);
			}
		});
	}
	
	function formsubmit() {
		var radiova = $("input:radio[name='type2']:checked").val();
		var adtitle = $("#name").val();
		var adpicurl = $("#advertimg").val();
		var content = ue.getContent();
		var contentlink = $("#adcontentlink").val();
		var contentdesc = $("#adcontentdesc").val();
		var adlinkurl = $("#adurl").val();
		var adid = $("#id").val();
		var adtype = $("#adtype").val();
		var adpos = $("#adpos").val();
		
		if(adtype == 'commlunbo') {
			if(radiova == 0) {
				if(adtitle == '') {
					window.parent.showAlert("你没有填写社区广告名称！");
					return ;
				}
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传社区轮播图图片！");
					return ;
				}
			}else{
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传社区轮播图图片！");
					return ;
				}
				if(adlinkurl == '') {
					window.parent.showAlert("你没有填写轮播图跳转URL！");
					return ;
				}
				if(adlinkurl.indexOf('http://') == 0 || adlinkurl.indexOf('https://') == 0) {
					
				}else{
					window.parent.showAlert("轮播图跳转URL必须以http://或者https://开头！");
					return ;
				}
			}	
		}else if(adtype == 'commhuodong') {
			if(radiova == 0) {
				if(adtitle == '') {
					window.parent.showAlert("你没有填写优惠活动名称！");
					return ;
				}
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传优惠活动展示图片！");
					return ;
				}
			}else{
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传优惠活动展示图片！");
					return ;
				}
				if(adlinkurl == '') {
					window.parent.showAlert("你没有填写优惠活动跳转链接");
					return ;
				}
				if(adlinkurl.indexOf('http://') == 0 || adlinkurl.indexOf('https://') == 0) {
					
				}else{
					window.parent.showAlert("优惠活动跳转链接必须以http://或者https://开头！");
					return ;
				}
			}
		}else if(adtype == 'commqianggou') {
			if(radiova == 0) {
				if(adtitle == '') {
					window.parent.showAlert("你没有填写广告名称！");
					return ;
				}
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传轮播图图片！");
					return ;
				}
			}else{
				if(adpicurl == '') {
					window.parent.showAlert("你没有上传轮播图图片！");
					return ;
				}
				if(adlinkurl == '') {
					window.parent.showAlert("你没有填写广告URL！");
					return ;
				}
				if(adpicurl.indexOf('http://') == 0 || adpicurl.indexOf('https://') == 0) {
					
				}else{
					window.parent.showAlert("广告URL必须以http://或者https://开头！");
					return ;
				}
			}
		}else{
			if(adtitle == '') {
				window.parent.showAlert("你没有填写广告名称！");
				return ;
			}
			if(adpicurl == '') {
				window.parent.showAlert("你没有上传优惠活动图片！");
				return ;
			}
			if(contentdesc == '') {
				window.parent.showAlert("你没有填写广告描述！");
				return ;
			}
		}
		
		var saveurl = '${ctx}/advert/saveorupdate'
		
		$.post(saveurl,{"type2":radiova,"name":adtitle,"content":content,"adcontentlink":contentlink,"adcontentdesc":contentdesc,"adurl":adlinkurl,"id":adid,"advertimg":adpicurl,"adtype":adtype,"adpos":adpos},function(data){
			if(data.result == '1') {
				cancel();
				if(adtype == 'commlunbo') {
					getLunBo();
				}else if(adtype == 'commhuodong') {
					getHuoDong();
				}
			}
		});
		
	}
	
	var sendqgid = '';
	var qgpos = '';
	function onlineQiangGou(qgid) {
		sendqgid = qgid;
		window.parent.showConfirm("你确定要上线该活动吗？", sureOnline);
	}
	
	function sureOnline() {
		var onlineurl = '${ctx}/advert/online/'+sendqgid;
		$.get(onlineurl,function(data){
			getQiangGou();
			window.parent.showAlert(data.msg);
		});
	}
	
	function offlineQiangGou(qgid) {
		sendqgid = qgid;
		window.parent.showConfirm("你确定要下线该活动吗？", sureOffline);
	}
	
	function sureOffline() {
		var offlineurl = '${ctx}/advert/offline/'+sendqgid;
		$.get(offlineurl,function(data){
			getQiangGou();
			window.parent.showAlert(data.msg);
		});
	}
	
	function deleteQiangGou(qgid,pos) {
		sendqgid = qgid;
		qgpos = pos;
		window.parent.showConfirm("你确定要删除该活动吗？", sureDeleteQiangGou);
	}
	
	function sureDeleteQiangGou() {
		var deleteqgurl = '${ctx}/advert/deleteqg/'+sendqgid;
		$.get(deleteqgurl,function(data){
			$("#qianggou"+qgpos).children().eq(1).html(qgpos);
			$("#qianggou"+qgpos).children().eq(1).html('(空)');
			$("#qianggou"+qgpos).children().eq(2).html('(空)');
			$("#qianggou"+qgpos).children().eq(3).html('(空)');
			$("#qianggou"+qgpos).children().eq(4).html('(空)');
			$("#qianggou"+qgpos).children().eq(5).html('<a href="${ctx}/advert/addqianggou/'+qgpos+'">上传</a>');
			window.parent.showAlert(data.msg);
		});
	}
	
	
</script>

<body>
	<div class="row-fluid">
		<div class="span12">
			<h3 class="page-title">
				<img src="${ctx}/static/images/xtgl.png"
					style="vertical-align: text-bottom;" /> 广告管理
			</h3>
		</div>
	</div>
	<div class="tabbable tabbable-custom">

		<ul class="nav nav-tabs">

			<li <c:if test="${acttab == null }">class="active"</c:if>><a style="font-size: 16px"  data-toggle="tab" href="#tab_1_1"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">社区轮播图管理</a></li>

			<li><a style="font-size: 16px" data-toggle="tab" href="#tab_1_2"
				onclick="setTimeout('window.parent.iFrameHeight();',50)">优惠活动</a></li>
				
			<li <c:if test="${acttab == 'qianggou' }">class="active"</c:if> ><a style="font-size: 16px" data-toggle="tab" href="#tab_1_3"
			onclick="setTimeout('window.parent.iFrameHeight();',50)">抢购</a></li>
			
		</ul>

		<div class="tab-content" style="min-height: 780px;">

			<div id="tab_1_1" class="tab-pane <c:if test="${acttab == null }">active</c:if>">
				<div class="portlet box grey">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-globe"></i>列表
						</div>
					</div>
					 <div class="portlet-body">
						<table id="contentTable" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th style="width: 20%;">序号</th>
									<th style="width: 40%;">标题</th>
									<th style="width: 40%;">操作</th>
								</tr>
							</thead>
							<tbody id="lunbo">
								<tr id="lunbo1">
									<td>1</td>
									<td>(空)</td>
									<td><a href="javascript:;" onclick="addLunBo(1)">上传</a></td>
								</tr>
								<tr id="lunbo2">
									<td>2</td>
									<td>(空)</td>
									<td><a href="javascript:;" onclick="addLunBo(2)">上传</a></td>
								</tr>
								<tr id="lunbo3">
									<td>3</td>
									<td>(空)</td>
									<td><a href="javascript:;" onclick="addLunBo(3)">上传</a></td>
								</tr>
								<tr id="lunbo4">
									<td>4</td>
									<td>(空)</td>
									<td><a href="javascript:;" onclick="addLunBo(4)">上传</a></td>
								</tr>
								<tr id="lunbo5">
									<td>5</td>
									<td>(空)</td>
									<td><a href="javascript:;" onclick="addLunBo(5)">上传</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
	
			<div id="tab_1_2" class="tab-pane">
				<div class="portlet box grey">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-globe"></i>列表
						</div>
					</div>
					 <div class="portlet-body">
						<table id="contentTable" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th style="width: 10%;">序号</th>
									<th style="width: 20%;">标题</th>
									<th style="width: 20%;">图片</th>
									<th style="width: 30%;">链接</th>
									<th style="width: 20%;">操作</th>
								</tr>
							</thead>
							<tbody id="huodong">
								<tr id="huodong1">
									<td>1</td>
									<td colspan="3" >(空)</td>
									<td><a href="javascript:;" onclick="addHuoDong(1)">上传</a></td>
								</tr>
								<tr id="huodong2">
									<td>2</td>
									<td colspan="3" >(空)</td>
									<td><a href="javascript:;" onclick="addHuoDong(2)">上传</a></td>
								</tr>
								<tr id="huodong3">
									<td>3</td>
									<td colspan="3" >(空)</td>
									<td><a href="javascript:;" onclick="addHuoDong(3)">上传</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			
			<div id="tab_1_3" class="tab-pane <c:if test="${acttab == 'qianggou' }">active</c:if> ">
				<div class="portlet box grey">
					<div class="portlet-title">
						<div class="caption">
							<i class="icon-globe"></i>列表
						</div>
						<div class="actions" id="addyhbtn">
							<a href="javascript:;">&nbsp;</a>
						</div>
					</div>
					 <div class="portlet-body">
						<table id="contentTable" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th style="width: 10%;">序号</th>
									<th style="width: 20%;">活动日期</th>
									<th style="width: 20%;">标题</th>
									<th style="width: 10%;">活动封面图</th>
									<th style="width: 10%;">已售数量</th>
									<th style="width: 10%;">状态</th>
									<th style="width: 20%;">操作</th>
								</tr>
							</thead>
							<tbody id="qianggou">
								<tr id="qianggou1">
									<td>1</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td><a href="${ctx}/advert/addqianggou/1">上传</a></td>
								</tr>
								<tr id="qianggou2">
									<td>2</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td><a href="${ctx}/advert/addqianggou/2">上传</a></td>
								</tr>
								<tr id="qianggou3">
									<td>3</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td><a href="${ctx}/advert/addqianggou/3">上传</a></td>
								</tr>
								<tr id="qianggou4">
									<td>4</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td><a href="${ctx}/advert/addqianggou/4">上传</a></td>
								</tr>
								<tr id="qianggou5">
									<td>5</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td>(空)</td>
									<td><a href="${ctx}/advert/addqianggou/5">上传</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	
	
	<div class="modal hide fade" id="admodal" tabindex="-1" role="dialog" style="top: 10%;width: 80%; left: 35%;">
		<div class="modal-header">
			<button class="close" type="button" data-dismiss="modal"></button>
			<h3 id="myModalLabel">
				<span id="adtitle">广告管理</span>
			</h3>
		</div>
		<div id="" class="modal-body" style="font-size: 35; max-height: 1200px !important; ">
			<form action="#" method="post" id="inputForm"  class="form-horizontal">
			
				<div class="control-group" id="adtyperadiodiv">
					<label class="control-label" id="adname">选择类型:</label>
					<div class="controls" style="margin-top:4px;">
					    <table>
					       <tr>
					       		<td><input type="radio" name="type2" value="0" id="in1" checked="checked"></td>
					       		<td style="width: 60%;"><font>图文链接</font></td>
					        	<td><input type="radio" name="type2" value="1" id="in2"></td>
					       		<td><font>URL</font></td>
					       </tr>
					    </table>
					 </div>
				 </div>
			
				<div class="control-group" id="addnamediv">
					<label class="control-label" id="adname">广告名称:</label>
					<div class="controls">
						<input type="text" id="name"  name="name"  maxlength="8" style="width:60% ;height: 32px" class="title required" />
					</div>
				</div>
				
				<div class="control-group" id="adlunbopicdiv">
					<label class="control-label">轮播图片:</label>
					<div class="controls" id="uplunboic"></div>
				</div>
				
				<div class="control-group" id="adshanghupicdiv">
					<label class="control-label">热门商户图片:</label>
					<div class="controls" id="upshanghupic"></div>
				</div>
				
				<div class="control-group" id="adyouhuipicdiv">
					<label class="control-label">优惠广告图片:</label>
					<div class="controls" id="upyouhuipic"></div>
				</div>
				
				<div class="control-group" id="imgfacediv">
					<label class="control-label">&nbsp;</label>
					<div class="controls">
						<img src="${ctx}/static/images/zanwuPic.jpg" id="adimg" />
					</div>
				</div>
				
				<div class="control-group" id="adcontentdiv">
					<label class="control-label">广告内容：</label>
					<div class="controls" id="contentinner">
						<script id="container" name="content" style="width:95%;height:150px;" type="text/plain"></script>
					</div>
				</div>
				
				<div class="control-group" id="adcontentlinkdiv">
					<label class="control-label">广告链接：</label>
					<div class="controls">
						<textarea rows="3" cols="20" style="width:60%;" name="adcontentlink" id="adcontentlink"></textarea>
					</div>
				</div>
				
				<div class="control-group" id="adcontentdescdiv">
					<label class="control-label">广告描述：</label>
					<div class="controls">
						<textarea rows="3" cols="20" style="width:60%;" name="adcontentdesc" id="adcontentdesc"></textarea>
					</div>
				</div>
				
				<div class="control-group" id="adurldiv">
					<label class="control-label" id="urldiv">URL:</label>
					<div class="controls">
						<input type="text" id="adurl" name="adurl"  maxlength="254" style="width:60% ;height: 32px" />
					</div>
				</div>
				
				<input type="hidden" id="id" name="id" value="">
				<input type="hidden" id="advertimg" name="advertimg" value="">
				<input type="hidden" id="adtype" name="adtype" value="">
				<input type="hidden" id="adpos" name="adpos" value="">
				
			</form>
		</div>
		<div class="modal-footer">
			<input id="submit_btn" class="btn btn-primary green" type="button" onclick="formsubmit()" value="保存" />&nbsp; 
			<input id="cancel_btn" class="btn btn-primary grey" type="button" onclick="cancel()" value="取消" />&nbsp; 
		</div>
	</div>
	
</body>
</html>