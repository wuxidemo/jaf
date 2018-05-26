function tagName(tagName) {
	return document.getElementsByTagName(tagName);
}

function addEvent(obj, type, func) {
	if (obj.addEventListener) {
		obj.addEventListener(type, func, false);
	} else if (obj.attachEvent) {
		obj.attachEvent('on' + type, func);
	}
}

// 建立某些参数
var v = {
	eleGroup : null,
	eleTop : null,
	eleHeight : null,
	screenHeight : null,
	visibleHeight : null,
	scrollHeight : null,
	scrolloverHeight : null,
	limitHeight : null
}

// 对数据进行初始化
function lazyinit(element) {
	v.eleGroup = $(element)
	screenHeight = document.documentElement.clientHeight;
	scrolloverHeight = document.body.scrollTop;
	for (var i = 0, j = v.eleGroup.length; i < j; i++) {
		if (v.eleGroup[i].offsetTop <= screenHeight
				&& v.eleGroup[i].getAttribute('asrc')) {
			v.eleGroup[i].setAttribute('src', v.eleGroup[i]
					.getAttribute('asrc'));
			v.eleGroup[i].removeAttribute('asrc')
		}
	}
	addEvent(window, 'scroll', lazyLoad);
}
function lazyLoad() {
	if (document.body.scrollTop == 0) {
		limitHeight = document.documentElement.scrollTop
				+ document.documentElement.clientHeight;
	} else {
		limitHeight = document.body.scrollTop
				+ document.documentElement.clientHeight;
	}
	for (var i = 0, j = v.eleGroup.length; i < j; i++) {
		if (v.eleGroup[i].offsetTop <= limitHeight
				&& v.eleGroup[i].getAttribute('asrc')) {
			v.eleGroup[i].src = v.eleGroup[i].getAttribute('asrc');
			v.eleGroup[i].removeAttribute('asrc')
		}
	}
}