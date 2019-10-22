<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>

<script type="text/javascript" src="../../resources/chat/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="../../resources/chat/sockjs-0.3.4.js" ></script>

<script type="text/javascript">

   var websocket;

    
    function init() {
        output = document.getElementById("output");
    }

    function send_message() {
    	websocket = new SockJS("<c:url value="/echo"/>");
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

        writeToScreen("Connected to Endpoint!");
        doSend(textID.value);
    }

    function onMessage(evt) {
        writeToScreen("Message Received: " + evt.data);
    }

    function onError(evt) {
        writeToScreen('ERROR: ' + evt.data);
    }

    function doSend(message) {
        writeToScreen("Message Sent: " + message);
        websocket.send(message);
        //websocket.close();
    }

    function writeToScreen(message) {
        var pre = document.createElement("p");
        pre.style.wordWrap = "break-word";
        pre.innerHTML = message;
        output.appendChild(pre);
    }

    window.addEventListener("load", init, false);

</script>

<h1 style="text-align: center;">Hello World WebSocket Client</h1>

<br>

<div style="text-align: center;">

    <form action="">
        <input onclick="send_message()" value="Send" type="button">
        <input id="textID" name="message" value="Hello WebSocket!" type="text"><br>

    </form>

</div>

<div id="output"></div>

</body>
</html>