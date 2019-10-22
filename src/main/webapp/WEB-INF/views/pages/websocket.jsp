<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Your First WebSocket!</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- css block -->
    <link rel="stylesheet" type="text/css" href="../../resources/axgrid/AXJ.min.css">

    <!-- js block -->
    <script type="text/javascript" src="../../resources/axgrid/AXJ.min.js"></script>
  

	<script type="text/javascript">
	var myGrid = new AXGrid(); // 그리드 변수를 초기화 합니다.
	var fnObj = {
	    pageStart: function(){
	        myGrid.setConfig({
	            targetID : "AXGridTarget",
	            height:"auto", // 너비에 자동 맞춤
		        
	            // 브라우저 사이즈에 따른 changeGridView 설정
                mediaQuery: {
                    mx:{min:0, max:600}, dx:{min:600}
                },

	            colGroup : [
	            	{key:"no", label:"checkbox", width:"30", align:"center", formatter:"checkbox", 
                        disabled:function(){
                            return false;
                            return (this.index % 2 != 0);
                        }
                    },
	                {key:"no", label:"번호", width:"80", align:"center"},
	                {key:"title", label:"제목", width:"600"},
	                {key:"writer", label:"작성자", width:"100"},
	                {key:"regDate", label:"작성일", width:"*"},
	                //{key:"price", label:"가격", width:"100", align:"right", formatter:"money"},
	                //{key:"amount", label:"수량", width:"80", align:"right", formatter:"money"},
	                //{key:"cost", label:"금액", width:"100", align:"right", formatter:function(){
	                //    return (this.item.price.number() * this.item.amount.number()).money();
	                //}},
	                //{key:"desc", label:"비고", width:"*"}
	            ],
	            body : {
	                onclick: function(){
	                	//toast.push(Object.toJSON({index:this.index, r:this.r, c:this.c, item:this.item}));
	                    toast.push(Object.toJSON(this.item));
	                    myGrid.checkedColSeq(0, null, this.index); // 바디를 클릭했을때 0번째 체크박스 토글체크처리
	                },
	        		ondblclick: function(){
                		toast.push("더블클릭");
	        		},
	                addClass: function(){
                        // red, green, blue, yellow, white, gray
                        if(this.index % 2 == 0) {
                            return "blue";
                        } else{
                            return "white";
                        }
                    }
	            },
	        
		        page: {
	                display: false,
	                paging: false
	            }
	        }); //myGrid.setConfig
	    }  // pageStart: function()

	}; //var fnObj
	$(document).ready(fnObj.pageStart);
	</script>
	

</head>

<body>

<script type="text/javascript">
   
    var wsUri = "ws://localhost:8080/websocket/echo.do";
   
    function init() {
        output = document.getElementById("output");
        
        attributes_log = document.getElementById("attributes_log");
        
        if (browserSupportsWebSockets() === false) {
            writeToScreen("Sorry! your web browser does not support WebSockets. Try using Google Chrome or Firefox Latest Versions");

            var element = document.getElementById("websocketelements");
            element.parentNode.removeChild(element);

            return;
        }
    }
    
    function send_message() {
        websocket = new WebSocket(wsUri);
        websocket.onopen = function(evt) {
            onOpen(evt)
        };
        websocket.onmessage = function(evt) {
            onMessage(evt)
        };
        websocket.onerror = function(evt) {
            onError(evt)
        };
    }

    function onOpen(evt) {
        //writeToScreen("Connected to Endpoint!");
        doSend(textID.value);
    }
    
    function onMessage(evt) {
    	var grade = evt.data.substring(0, 3);

    	if(grade=="Cri") {
	    	writeToScreen('<a href="#" class="list-group-item list-group-item-danger">RESPONSE: ' + getCurrentDate() + ',' + evt.data + '</a>');
	    	
    	} else if(grade=="Maj") {
	    	writeToScreen('<a href="#" class="list-group-item list-group-item-warning">RESPONSE: ' + getCurrentDate() + ',' + evt.data + '</a>');
	    	
    	} else if(grade=="Min") {
	    	writeToScreen('<a href="#" class="list-group-item list-group-item-info">RESPONSE: ' + getCurrentDate() + ',' + evt.data + '</a>');
    	} else {
    		writeToScreen('<a href="#" class="list-group-item list-group-item-info">RESPONSE: ' + getCurrentDate() + ',' + evt.data + '</a>');
    	}

    	//writeAttributeValues('onMessage Event Fired');
    }
    
    function onError(evt) {
    	writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
        //writeAttributeValues('onError Event Fired');
    }
    
    function doSend(message) {
        websocket.send(message);
        //writeToScreen("Message Sent: " + message);
        //writeAttributeValues('onSend Event Fired');
        //websocket.close();
    }
    
    function writeAttributeValues(prefix) {
        var pre = document.createElement("p");
        pre.style.wordWrap = "break-word";
        pre.innerHTML = "INFO " + getCurrentDate() + " " + prefix + "<b> readyState: " + websocket.readyState + " bufferedAmount: " + websocket.bufferedAmount + "</b>";
        attributes_log.appendChild(pre);
    }
    
    var listnum=0;
    var checkedList;
    
    function writeToScreen(message) {

    	var list = [
            { 
            	no:listnum,
            	title:message,
            	writer:"minCloud",
            	regDate:getCurrentDate()}, 
        ];

        myGrid.pushList(list,0); //AXGrid.pushList(pushItem, insertIndex)-삽입위치 인덱스 Index of Insert 
        //myGrid.setDataSet({});
        //trace(myGrid.getSortParam());

        if(myGrid.list.length >= 20){
    		var removeList = [{index:myGrid.list.length-1}];
        	myGrid.removeListIndex(removeList);
        }
        
        listnum++;
        
        // 하단 자동스크롤
        document.body.scrollTop = document.body.scrollHeight;
        myGrid.setFocus(myGrid.list.length - 1);
       
        //var pre = document.createElement("p");

        //pre.style.wordWrap = "break-word";
        //pre.innerHTML = message;
        
        //output.appendChild(pre);
        //output.scrollTop = output.scrollHight;
    }
    
    function getCurrentDate() {
        var now = new Date();
        var datetime = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate();
        datetime += ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();

        return datetime;
    }
    
    function browserSupportsWebSockets() {
        if ("WebSocket" in window) {
            return true;
        } else {
            return false;
        }
    }
    
    function onClose() {
        websocket.close();
        //writeAttributeValues('onClose Event Fired');
        writeToScreen("DISCONNECTED");
    }
    window.addEventListener("load", init, false);
    
</script>

 <script>
    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript    : AXJ.js, AXModal.js
     * CSS            : AXJ.css
     */
    var pageID = "AXModal";
    var myModal = new AXModal();
    var fnObj = {
        pageStart: function () {
            myModal.setConfig({
                windowID: "myModalCT", width: 740,
                mediaQuery: {
                    mx: {min: 0, max: 767}, dx: {min: 767}
                },
                displayLoading: true,
                scrollLock: true,
                onclose: function () {
                    toast.push("모달 close");
                }
            });
        },
        modalOpen: function () {
            myModal.open({
                url: "modal.html",
                //url:"/samples/AXgrid/index.html",
                pars: "a=1&b=2&c=3".queryToObject(),
                top: 100,
                closeByEscKey: true
            });
        },
        modalOpenDiv: function () {
            myModal.openDiv({
                modalID: "modalDiv01",
                targetID: "modalContent",
                width: 300,
                top: 100
            });
        },
        modalOpenDiv2: function () {
            myModal.openDiv({
                modalID: "modalDiv02",
                targetID: "modalContent2",
                width: 300,
                top: 100,
                closeByEscKey: true
            });
        },
        newOpen: function () {
            myModal.openNew({
                url: "/samples/AXGrid/index.html",
                pars: "a=1&b=2&c=3".queryToObject(),
                name: "mymodal_new",
                options: "width=600,height=400,resizable=yes"
            });
        }
    };
    jQuery(document.body).ready(function () {
        fnObj.pageStart()
    });
</script>


	<div data-role="header" data-position="fixed">
        <h1 style="text-align: center;">minCloud WebSocket Client</h1>
        <br>

        <form style="text-align: center;" action="">
            <input type="button" value="Send" class="AXButton" onclick="send_message()">
            <input type="text" value="Hello WebSocket!" class="AXInput" id="textID" name="message" >
            <input type="button" value="창열기" class="AXButton" onclick="fnObj.modalOpen();">
        	<input type="button" value="새창열기" class="AXButton" onclick="fnObj.newOpen();">
        </form>
	</div>

	<div data-role="main" class="ui-content" id="AXGridTarget" style="height:400px;overflow: auto;"></div>

	<div data-role="footer" data-position="fixed">
		<form style="text-align: center;" action="">
            <input type="button" value="Close" class="AXButton" onclick="onClose()">
            <button id="clear" class="AXButton">Clear Log</button>
            <input type="button" value="Select All" class="AXButton Blue" onclick="myGrid.checkedColSeq(0, true);">
            <input type="button" value="Unselect All" class="AXButton Blue" onclick="myGrid.checkedColSeq(0, false);">
            <input type="button" value="삭제하기" class="AXButton Red" onclick="fnObj.removeList();">
           
        </form>
        
	</div>

</body>
</html>