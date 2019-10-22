// ajax �붿껌 �꾩뿭 �⑥닔...湲곕낯�곸쑝濡� XMLHttpRequest 瑜� �ъ슜�섎ŉ
// IE�� 寃쎌슦 ��踰꾩쟾(XMLHttpRequest 吏��먰븯吏� �딅뒗 釉뚮씪�곗�) 泥댄겕�섏뿬 XMLHTTP 濡� �붿껌�섎뒗 紐⑤뱢�낅땲��.
// jQuery�� 媛숈씠 AUIGrid 瑜� �ъ슜�쒕떎硫� 援녹씠 �� �⑥닔 �ъ슜�� �꾩슂 �놁뒿�덈떎. jQuery �� ajax 媛� �덉쑝�� 洹멸구 �ъ슜�섏꽭��.
function ajax(props) {
    var target = props.target ? props.target : null;
    var currentTarget = props.currentTarget ? props.currentTarget : null;
    var isLocal =  location.href.indexOf("http") >= 0  && location.href.indexOf("http") <= 3 ? false : true;
    props = {
        type: props.type || "GET", // �붿껌 硫붿냼��(get or post)
	    url: props.url || "", // �붿껌 URL
	    timeout: props.timeout || 30000, // �묐떟 ���꾩븘��
	    onError: props.onError || function() {}, // �먮윭 �몃뱾��
	    onSuccess: props.onSuccess || function() {}, // �깃났 �몃뱾��
	    data: props.data || "" // �붿껌 �� 蹂대궪 �곗씠��(�뚮씪硫뷀꽣)
    };
    var i, xhr, activeXObjects = ["MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP", "Microsoft.XMLHTTP"];
    if ("ActiveXObject" in window) {
        if (isLocal) {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    if (!xhr) {
        try {
            xhr = new XMLHttpRequest();
        } catch (e) {
            for (i = 0; i < activeXObjects.length; i++) {
                try {
                    xhr = new ActiveXObject(activeXObjects[i]);
                    break;
                } catch (e) {}
            }
        }
    }
    var timeout = props.timeout;
    var isTimeout = false;
    setTimeout(function() {
        isTimeout = true;
    }, timeout);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && !isTimeout) {
            var e = {};
            if (target) {
                e.target = target;
            }
            if (currentTarget) {
                e.currentTarget = currentTarget;
            }
            if (isSuccess(xhr)) {
                var contentType = xhr.getResponseHeader("content-type");
                var resultData = null;
                if( contentType && contentType.indexOf("xml") >= 0 ) {
                    resultData = xhr.responseXML;
                } else if(xhr.responseText){
                    resultData = parseJSON(xhr.responseText);
                }
                props.onSuccess.call(xhr, resultData, e);
            } else {
                props.onError.call(xhr, xhr.status, e);
            }
            xhr = null;
        }
    };
    try {
        xhr.open(props.type, props.url, true);
        xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xhr.send(props.data);
    } catch (e) {
        props.onError(e.message);
    }

    function isSuccess(xhr) {
        try {
            return !xhr.status && isLocal || (xhr.status >= 200 && xhr.status < 300) || xhr.status == 304 || navigator.userAgent.indexOf("Safari") >= 0 && Cs(xhr.status);
        } catch (e) {}
        return false;
    };
    
    function parseJSON(data) {
    	var obj;
		if ( window.JSON && window.JSON.parse ) {
			try {
				obj = window.JSON.parse( data + "" );
			} catch(e) {
				obj = data;
			}
		} else {
			try {
				obj = (function() { return eval(data); })();
			} catch (e) {
				obj = data;
			}
		}
    	return obj;
	};
};
