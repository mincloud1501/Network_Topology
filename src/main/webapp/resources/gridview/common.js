// �곗씠�� �붿껌
function requestData(url) {

	// ajax �붿껌 �� 洹몃━�쒖뿉 濡쒕뜑 �쒖떆
	AUIGrid.showAjaxLoader(myGridID);
	
	// ajax (XMLHttpRequest) 濡� 洹몃━�� �곗씠�� �붿껌
	ajax({
		url : url,
		onSuccess : function(data) {
			
			//console.log(data);
			
			// 洹몃━�쒖뿉 �곗씠�� �명똿
			// data �� JSON �� �뚯떛�� Array-Object �낅땲��.
			AUIGrid.setGridData(myGridID, data);

			// 濡쒕뜑 �쒓굅
			AUIGrid.removeAjaxLoader(myGridID);
		},
		onError : function(status, e) {
			alert("�곗씠�� �붿껌�� �ㅽ뙣�섏��듬땲��.\r status : " + status);
			// 濡쒕뜑 �쒓굅
			AUIGrid.removeAjaxLoader(myGridID);
		}
	});
};

var timerId = null;

// 由ъ궗�댁쫰 �대깽��
window.onresize = function() {
	
	// 200ms 蹂대떎 鍮좊Ⅴ寃� 由ъ궗�댁쭠 �쒕떎硫�..
	if(timerId) {
		clearTimeout(timerId);
	}
	
	timerId = setTimeout(function() {
		
		// 洹몃━�� 由ъ궗�댁쭠
		if(typeof myGridID != "undefined") {
			AUIGrid.resize(myGridID);
		}
		
		if(typeof myGridID2 != "undefined") {
			AUIGrid.resize(myGridID2);
		}	
	}, 200);  // �꾩옱 200ms 誘쇨컧��....�섍꼍�� 留욊쾶 議곗젅�섏꽭��.
};