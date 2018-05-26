<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<a href="#" onclick="addWxContact('gh_2e3d6cc2dc84')">hahhahaha</a>
		<a href="#" onclick="addsr()">hahhahaha</a>
		 <img src="${ctx}/static/cc.jpg" style="width:100%">
</body>
<script type="text/javascript"
src="http://zb.weixin.qq.com/nearbycgi/addcontact/BeaconAddContactJsBridge.js">
</script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	wx.config({
		debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId : '${appId}', // 必填，公众号的唯一标识
		timestamp : '${timestamp}', // 必填，生成签名的时间戳
		nonceStr : '${nonceStr}', // 必填，生成签名的随机串
		signature : '${signature}',// 必填，签名，见附录1
		jsApiList :[ 'scanQRCode','add_Contact' ]
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});
	wx.ready(function(){

		alert("ready");
		});
	wx.error(function(res) {
		alert("加载错误:" + res, 1000);
	});
	function addsr() {
		alert("aaa");
		wx.scanQRCode({
			needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
			success : function(res) {
				var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
				alert(result);
			}
		});
		return false;
	}
	document.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
	var addWxContact = function(wxid, cb) {
		if (typeof WeixinJSBridge == 'undefined')
			return false;
		WeixinJSBridge.invoke('addContact', {
			webtype : '1',
			username : 'gh_2e3d6cc2dc84'
		}, function(d) {
			alert(d.err_msg);
			// 返回d.err_msg取值，d还有一个属性是err_desc
			// add_contact:cancel 用户取消
			// add_contact:fail　关注失败
			// add_contact:ok 关注成功
			// add_contact:added 已经关注
			//WeixinJSBridge.log(d.err_msg);
			//cb && cb(d.err_msg);
		});
	};
	
	BeaconAddContactJsBridge.ready(function(){
		//判断是否关注
		BeaconAddContactJsBridge.invoke('checkAddContactStatus',{} ,function(apiResult){
			if(apiResult.err_code == 0){
				var status = apiResult.data;
				if(status == 1){
					alert('已关注');
				}else{
					alert('未关注');
					//跳转到关注页
				  BeaconAddContactJsBridge.invoke('jumpAddContact');
				}
			}else{
				alert(apiResult.err_msg)
			}
		});
 	});
</script>
</html>