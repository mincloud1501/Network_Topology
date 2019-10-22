// Mozilla, Opera, Webkit 
if ( document.addEventListener ) {
  document.addEventListener( "DOMContentLoaded", function(){
    document.removeEventListener( "DOMContentLoaded", arguments.callee, false);
    initDemo(); //�곕え瑜� �꾪븳 �ㅽ겕由쏀듃
    try{
    	documentReady();
    	loadScroll();
    }catch(e) {};
    	loadScroll();
  }, false );

// If IE event model is used
} else if ( document.attachEvent ) {
  // ensure firing before onload
  document.attachEvent("onreadystatechange", function(){
    if ( document.readyState === "complete" ) {
      document.detachEvent( "onreadystatechange", arguments.callee );
      initDemo(); //�곕え瑜� �꾪븳 �ㅽ겕由쏀듃
      try{
      	documentReady();
      	loadScroll();
      }catch(e) {};
      	loadScroll();
    }
  });
}

function setCookie(name, value, expires, path, domain, secure) {
	var curCookie = name + "=" + escape(value)
			+ ((expires) ? "; expires=" + expires.toGMTString() : "")
			+ ((path) ? "; path=" + path : "")
			+ ((domain) ? "; domain=" + domain : "")
			+ ((secure) ? "; secure" : "");
	document.cookie = curCookie;
}

function getCookie(name) {
	var dc = document.cookie;
	var prefix = name + "=";
	var begin = dc.indexOf("; " + prefix);
	if (begin == -1) {
		begin = dc.indexOf(prefix);
		if (begin != 0)
			return null;
	} else {
		begin += 2;
	}
	var end = document.cookie.indexOf(";", begin);
	if (end == -1)
		end = dc.length;
	return unescape(dc.substring(begin + prefix.length, end));
}

function saveScroll(scrollPos) {
	var now = new Date();
	var scrollTop;
	if(typeof scrollPos == "undefined") {
		var navWrapper = document.getElementById("nav-wrapper");
		if(!navWrapper)
			return;
		scrollTop =  navWrapper.scrollTop || 0;
	} else {
		scrollTop = scrollPos;
	}
	now.setTime(now.getTime() + 10 * 60 * 1000);
	setCookie("_scrollTop", scrollTop, now);
}

function loadScroll() {
	var scrollTop  = getCookie("_scrollTop");
	if (!scrollTop)
		return;
	var navWrapper = document.getElementById("nav-wrapper");
	if(!navWrapper)
		return;
		
	navWrapper.scrollTop = Number(scrollTop);
}

// 紐⑤컮�� �붾㈃�� 寃쎌슦 硫붾돱 異쒕젰
var menuDisplayed = false;
function mobileBtnClick() {
	if(!menuDisplayed) {
		menuDisplayed = true;
		document.getElementById("nav-wrapper").style.display = "block";
	} else {
		menuDisplayed = false;
		document.getElementById("nav-wrapper").style.display = "none";
	}
};
	
// �곕え 硫붾돱 �≫떚釉� �ㅽ��� 留뚮뱾湲�
function initDemo() {
	var url = location.href;
	var idx = url.indexOf("?");
	var lastIdx = url.indexOf("&");
	var menuItem;
	if(idx > 0) {
		var link = url.substring(idx+1, lastIdx);
		if(link && link.length > 2) {
			menuItem = document.getElementById(link);
			if(menuItem) {
				menuItem.className = menuItem.className + " active";
			}
		}
	}
	
	// theme ���됲듃 �좏깮
	var select = document.getElementById("themeSelect");
	if(!select)
		return;
	
	switch(theme) {
	case "dark":
		select.selectedIndex = 1;
		break;
	case "blue":
		select.selectedIndex = 2;
		break;
	case "modern":
		select.selectedIndex = 3;
		break;
	case "classic":	
		select.selectedIndex = 4;
		break;
	case "default":
	default:
		select.selectedIndex = 0;
	}
};

function changeLocation(href, scrollPos) {
	saveScroll(scrollPos);
	location.href = href + "&theme=" + theme;
}

function themeSelectHandler(event) {
	var select = document.getElementById("themeSelect");
	theme = select.value;
	
	var url = location.href;
	var idx = url.indexOf("&");
	var link = url.substring(0, idx);
	
	changeLocation(link);
}
/*
window.onresize = function() {
	if(window.innerWidth >= 960) {
		document.getElementById("nav-wrapper").style.display = "block";
	} else {
		document.getElementById("nav-wrapper").style.display = "none";
	}
};
*/
/*if (document.all && !document.querySelector) {
	alert("Internet Explorer �� 寃쎌슦 7 �댄븯 踰꾩쟾�� 吏��먰븯吏� �딆뒿�덈떎.");
	$("#main").html("Internet Explorer �� 寃쎌슦 7 �댄븯 踰꾩쟾�� 吏��먰븯吏� �딆뒿�덈떎. <br> 8 �댁긽�쇰줈 �낃렇�덉씠�쒓� �꾩슂�⑸땲��.");
	return;
}*/
