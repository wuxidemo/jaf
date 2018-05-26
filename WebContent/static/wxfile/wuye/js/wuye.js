//自适应高度js
var widthBili = 720;//原设计图宽度
var doc = document;//赋值document变量加快浏览器速度
var width = doc.body.offsetWidth;//获取body宽度，以便后面计算
/*
 * id 需要自适应高度模块的id
 * oldHeight 原设计图模块高度
 * return 返回不同手机上的模块显示高度以适应各电脑屏幕
 */
function setHeight(id, oldHeight) {
	$(id).css("height",
			parseFloat((oldHeight / widthBili) * width) + "px");
}
/*
 * id 需要自适应高度模块的id
 * oldHeight 原设计图模块高度
 * return 返回不同手机上的模块显示高度居中以适应各电脑屏幕
 */
function setLineHeight(id,oldHeight){
	$(id).css("line-height",
			parseFloat((oldHeight / widthBili) * width) + "px");
}
function setBottom(id,oldHeight){
	$(id).css("bottom",
			parseFloat((oldHeight / widthBili) * width) + "px");
}
//给页面模块高度赋值
setHeight("#head", 81);//头部
setHeight("#footer", 81);//尾部
setLineHeight("#footer", 81);
setHeight("#ko", 81);//报修记录 内容区撑底部空间
/*报修记录页面*/
setHeight("#state", 81);//状态选择
setLineHeight("#state", 81);//状态选择垂直居中
setHeight("#chos_states li", 81);//状态选择
setLineHeight("#chos_states li", 81);//状态选择
setBottom("#chos_states",80);
// 错误提示js
/*
	显示提示框
	htm 提示区域要显示的文本内容
 */
function showHint(htm) {
	$("#weui_dialog_bd").html(htm);
	$("#weui_al").show(300);
	$("#onetishi").show(300);
	$("#onetishi2").show(300);
}
/*
	隐藏提示框
 */
function closeHint() {
	$("#weui_al").hide(100);
	$("#onetishi").hide(100);
	$("#onetishi2").hide(100);
}
/*
	显示提示框2
	htm 提示区域要显示的文本内容
 */
function showHint_2(htm) {
	$("#weui_dialog_bd_2").html(htm);
	$("#weui_al_2").show(300);
	$("#onetishi_2").show(300);
	$("#onetishi2_2").show(300);
}
/*
	隐藏提示框2
 */
function closeHint_2() {
	$("#weui_al_2").hide(100);
	$("#onetishi_2").hide(100);
	$("#onetishi2_2").hide(100);
}
var raClass = {};
/*
	移除class显示错误提示
 */
raClass.remove = function(e) {
	$(e).parent().parent().removeClass("weui_cells_form");
}
/*
	移除错误提示添加class
 */
raClass.add = function(e) {
	$(e).parent().parent().addClass("weui_cells_form");
}
/*
	i 变量判断现在判断的是否是电话
	0、是起
	1、textarea判断显示提示框
	2、是电话判断(电话要判断空和电话匹配)
	检查input或textarea文本输入框内容是否为空
 */
function checkClear(e, i, htm) {
	if (i == 0) {
		if ("" == $(e).val()) {
			raClass.remove(e);
		} else {
			raClass.add(e);
		}
	} else if (i == 1) {
		if ("" == $(e).val()) {
			showHint(htm);
		} else {
			closeHint();
		}
	} else if (i == 2) {
		var phone = $("#phone").val();
		if ("" == phone.trim()) {
			showHint(htm);
		} else {
			var reg = !!phone.match(/^(0|86|17951)?(13[0-9]|15[012356789]|17[0123456789]|18[0-9]|14[57])[0-9]{8}$/);//匹配电话号码是否符合规范
			if(reg==false){//不符合规范
				showHint(htm);
			}else{//符合规范
				closeHint();
				return true;
			}
		}
	}
}
/*
	监听键盘
 */
function onchangeClear(e) {
	if ("" == $(e).val()) {
		raClass.remove(e);
		//showHint(htm);
	} else {
		raClass.add(e);
	}
}

/*
 *获取验证码间隔时间
 */
function timeInterval(){
	var yzmBtn = $("#getbtn");//获取验证码div对象
	var time = 60;
	var timeHtml = setInterval(function(){
		$("#getbtn").html(time+"s后重新获取");
		$("#getbtn").addClass("onn");
		time -= 1;
		if(timeHtml){
			if(time==0){
				clearInterval(timeHtml);
				$("#getbtn").html("获取验证码");
				$("#getbtn").removeClass("onn");
				$("#yzm_num").val("0");
			}
		}
	}, 1000);
}

//获取cookie的值
function getCookie(name) {
	var cookieArray = document.cookie.split("; "); //得到分割的cookie名值对    
	var cookie = new Object();
	for (var i = 0; i < cookieArray.length; i++) {
		var arr = cookieArray[i].split("="); //将名和值分开    
		if (arr[0] == name)
			return unescape(arr[1]); //如果是指定的cookie，则返回它的值    
	}
	return "";
}

//毫秒时间转正常显示时间
/*
 * miltime 传入毫秒时间
 * return 返回一个date类型时间 对象（通过对象.getFullYear等方法可以获取正常时间）
 */
function milTodate(miltime){
	return new Date(miltime);
}

/*获取时间区*/
function getYear(miltime){//年
	return milTodate(miltime).getFullYear();
}
function getMonth(miltime){//月是（0-11）
	var month = milTodate(miltime).getMonth();
	var months=new Array(0,1,2,3,4,5,6,7,8,9,10,11);
	var monthsEx=new Array("01","02","03","04","05","06","07","08","09","10","11","12");
	for(var i = 0 ; i < months.length ; i++){
		if(month==months[i]){
			var mon = monthsEx[i];
		}
	}
	return mon;
}
function getDay(miltime){//日
	var sysday = new Array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31); 
	var sysdays = new Array("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
	for(var i = 0 ; i < sysday.length ; i++){
		if(milTodate(miltime).getDate()==sysday[i]){
			var day = sysdays[i];
		}
	}
	return day;
}
/*
 * 年月日规格拼接
 */
function timeSelectD(miltime){
	 return getYear(miltime)+"-"+getMonth(miltime)+"-"+getDay(miltime);
}
/*
 * 加载中显示
 */
 function loading_ts(){
	var load_time = setTimeout(function(){
		$("#loadingToast").css("display","block");
	}, 500);
}



