function padleft(ret, padChar, width) {
	// var ret = this;
	while (ret.length < width) {
		if (ret.length + padChar.length < width) {
			ret = padChar + ret;
		} else {
			ret = padChar.substring(0, width - ret.length) + ret;
		}
	}
	return ret;
};
String.prototype.padRight = function(padChar, width) {
	var ret = this;
	while (ret.length < width) {
		if (ret.length + padChar.length < width) {
			ret += padChar;
		} else {
			ret += padChar.substring(0, width - ret.length);
		}
	}
	return ret;
};
String.prototype.trim = function() {
	return this.replace(/^\s+/, '').replace(/\s+$/, '');
};
String.prototype.trimLeft = function() {
	return this.replace(/^\s+/, '');
};
String.prototype.trimRight = function() {
	return this.replace(/\s+$/, '');
};
String.prototype.caption = function() {
	if (this) {
		return this.charAt(0).toUpperCase() + this.substr(1);
	}
	return this;
};
String.prototype.reverse = function() {
	var ret = '';
	for ( var i = this.length - 1; i >= 0; i--) {
		ret += this.charAt(i);
	}
	return ret;
};
String.prototype.startWith = function(compareValue, ignoreCase) {
	if (ignoreCase) {
		return this.toLowerCase().indexOf(compareValue.toLowerCase()) == 0;
	}
	return this.indexOf(compareValue) == 0
};
String.prototype.endWith = function(compareValue, ignoreCase) {
	if (ignoreCase) {
		return this.toLowerCase().lastIndexOf(compareValue.toLowerCase()) == this.length
				- compareValue.length;
	}
	return this.lastIndexOf(compareValue) == this.length - compareValue.length;
};
//checkbox全选方法
function init_checkbox(class_all,class_item){
	$(class_all).live("click", function() {
		if (this.checked) {
			$(class_item).attr("checked", true);
		} else {
			$(class_item).attr("checked", false);
		}
	});
	$(class_item).live("click", function() {
		var flag = true;
		;
		$(class_item).each(function() {
			if (!this.checked) {
				flag = false;
			}
		});
		$(class_all).attr("checked", flag);
	});
}
//获取全选id生成字符串
function getIds(class_item) {
	var ids = "";
	var cbs = $(class_item);
	for ( var i = 0; i < cbs.length; i++) {
		if (cbs[i].checked) {
			ids += ("|" + cbs[i].value);
		}
	}
	return ids.substr(1);
}
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};
//时间长整型换成日期格式
function getLocalTime(nS) {     
	   // return new Date(parseInt(nS)).toLocaleString().substr(0,19);  
	    return new Date(nS).format("yyyy-MM-dd hh:mm");      
}

//xxx=xxx&xxx=xxx&aaa=111 转成对象
function getMap(queryString)
	{
		if(null!=queryString){  
		       parameters = {};  
		       var parameterArray = queryString.split("&");  
		       var length = parameterArray.length;  
		       for(var i=0;i<length;i++){  
		       var parameter = parameterArray[i];  
		       index =  parameter.indexOf("=");  
		       var key = parameter.substring(0,index);  
		       var value = parameter.substring(index+1);  
		       if(null!=key && key.length>0){  
		    	   parameters[key]=value;
		      }  
		     }
		       return parameters;
		       
		    }
	}
	
//是否是金额
function isprice(num) {
		var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
		if (exp.test(num)) {
			return true;
		} else {
			return false;
		}
	}	
	//是否正整数
	function testzzs(num) {
		var t = /^[0-9]*[1-9][0-9]*$/;
		return t.test(num);
	}
	function testzs(num)
	{
		var t=/^[1-9]\d*|0$/;
		return t.test(num);
	}