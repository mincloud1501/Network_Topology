<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="../../resources/dist/js/vis.js"></script>
<link rel="stylesheet" href="../../resources/dist/css/vis-network.min.css"/>

<html>
<head>
  <title>Network | Circular images</title>

  <style type="text/css">
  div {
        width: 100%;
        height: 900px;
        font: 10pt arial;
    }
    div.left {
        width: 75%;
        float: left;
        box-sizing: border-box;
        border: 1px solid lightgray;
      	background-color:#FFFFFFF;
    }
    div.right {
        width: 25%;
        float: right;
        box-sizing: border-box;
        background: #FFFFFFF;
    }
  }
  </style>

  <script type="text/javascript"> 
    //var DIR = 'img/soft-scraps-icons/';
  
    var nodes = null;
    var edges = null;
    var network = null;
    
    // Called when the Visualization API is loaded.
    function draw() {

      // create people.
      // value corresponds with the age of the person
      var DIR = '../../resources/dist/img/';
      nodes = [
    	{id: 200,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"DOJ_CR1", level:"6", group:"DOJCR"},
    	{id: 201,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"DOJ_CR2", level:"6", group:"DOJCR"},
    	{id: 202,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"DOJ_CR3", level:"6", group:"DOJCR"},
    	{id: 203,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"DOJ_CR4", level:"6", group:"DOJCR"},
    	
    	{id: 210,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"NGN_CR1", level:"6", group:"NGNCR"},
    	//{id: 211,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"NGN_CR2", level:"6", group:"NGNCR"},
    	{id: 212,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"NGN_CR3", level:"6", group:"NGNCR"},
    	
    	{id: 100,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"CPL Core2", level:"5", size:40, group:"Ring"},
    	{id: 101,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"OM5200", level:"5", size:40, group:"Ring"},
    	{id: 102,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"Dongwon 10G", level:"5", size:40, group:"Ring"},
    	{id: 103,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"Dongwon DWDM", level:"5", size:40, group:"Ring"},
    	{id: 104,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"Nokia 1830", level:"5", size:40, group:"Ring"},
    	{id: 105,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"Coweaver CWDM", level:"5", size:25, group:"Ring"},
    	{id: 106,  shape: 'circularImage', image: DIR + 'Ring.jpg', label:"WooriNet CWDM", level:"5", size:25, group:"Ring"},
    	    	
        {id: 1,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"ICNAD_DS1", level:"4", size:30, group:"ICNAD", font: '14px verdana blue'},
        {id: 2,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"ICNAD_DS2", level:"4", size:30, group:"ICNAD", font: '14px verdana blue'},
        
        {id: 0,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"KGILS_DS1", level:"4", group:"KGILS"},
        {id: 13,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"KGILS_DS2", level:"4", group:"KGILS"},
        {id: 14,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"ICGYE_DS1", level:"4", group:"ICGYE", font: '14px verdana blue'},
        {id: 15,  shape: 'circularImage', image: DIR + 'CRouter.jpg', label:"ICGYE_DS2", level:"4", group:"ICGYE", font: '14px verdana blue'},
        
        {id: 3,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_AR1", level:"3", group:"ICNAD"},
        {id: 4,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_AR2", level:"3", group:"ICNAD"},
        {id: 5,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_AR3", level:"3", group:"ICNAD"},
        {id: 6,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_AR4", level:"3", group:"ICNAD"},
        {id: 7,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_FBS1", level:"3", group:"ICNAD"},
        {id: 8,  shape: 'circularImage', image: DIR + 'router.png', label:"ICNAD_FBS2", level:"3", group:"ICNAD"},
        
        {id: 9,  shape: 'circularImage', image: DIR + 'router.png', label:"ICPUC_AR3", level:"3", group:"ICPUC"},
        {id: 10,  shape: 'circularImage', image: DIR + 'router.png', label:"ICPUC_AR4", level:"3", group:"ICPUC"},
        
        {id: 11,  shape: 'circularImage', image: DIR + 'router.png', label:"ICYNS_AR1", level:"3", group:"ICYNS"},
        {id: 12,  shape: 'circularImage', image: DIR + 'router.png', label:"ICYNS_AR2", level:"3", group:"ICYNS"},
        
        //{id: 51,  shape: 'circularImage', image: DIR + 'CO.jpg', label:"ICNAD_FCO01", level:"2", group:"ICNAD_CO"},
        //{id: 61,  shape: 'circularImage', image: DIR + 'CO.jpg', label:"ICNAD_GCO01", level:"2", group:"ICNAD_CO"},
        //{id: 71,  shape: 'circularImage', image: DIR + 'CO.jpg', label:"ICNAD_VCO01", level:"2", group:"ICNAD_CO"},

        {id: 21,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT01\n <b>(79)</b>", level:"2", group:"OLT"},
        {id: 22,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT02\n <b>(45)</b>", level:"2", group:"OLT"},
        {id: 23,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT03\n <b>(34)</b>", level:"2", group:"OLT"},
        {id: 24,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT04\n <b>(91)</b>", level:"2", group:"OLT"},
        {id: 25,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT05\n <b>(56)</b>", level:"2", group:"OLT"},
        {id: 26,  shape: 'circularImage', image: DIR + 'OLT.jpg', font: { multi: true }, size:10, label:"ICNAD_OLT06\n <b>(85)</b>", level:"2", group:"OLT"}
        //{id: 31,  shape: 'circularImage', image: DIR + 'WCMTS.jpg', label:"W-CMTS01(69)", level:"2", group:"CMTS"},
        //{id: 41,  shape: 'circularImage', image: DIR + 'CO.jpg', label:"ICNAD_HCO10", level:"2", group:"ICNAD_CO"},
        
        //{id: 91,  shape: 'circularImage', image: DIR + 'Internet.jpg', label:"Internet", level:"1", group:"Customer"},
        //{id: 92,  shape: 'circularImage', image: DIR + 'Phone.jpg', label:"7/0", level:"1", group:"Customer"},
        //{id: 93,  shape: 'circularImage', image: DIR + 'BTV.jpg', label:"67/13", level:"1", group:"Customer"},
        //{id: 94,  shape: 'circularImage', image: DIR + 'Giga.jpg', label:"13/28", level:"1", group:"Customer"},
        
        //{id: 95,  shape: 'image', image: DIR + 'cust_info1.jpg', label:"프리밴", title:"프리밴 가입자", level:"1", group:"Customer"},
        //{id: 96,  shape: 'image', image: DIR + 'cust_info2.jpg', label:"VPN", level:"1", group:"Customer", shapeProperties:{borderDashes:[5,5]}}

      ];

      // 79/1 (77/1, 7/0, 67/13, 13/28)
      // create connections between people
      // value corresponds with the amount of contact between two people
      edges = [
    	{from: 100, to: 200},
    	{from: 100, to: 203},
    	{from: 100, to: 210},
    	{from: 100, to: 212},
    	{from: 101, to: 201},
    	{from: 101, to: 203},
    	{from: 101, to: 210},
    	{from: 101, to: 212},
    	{from: 102, to: 201},
    	{from: 102, to: 203},
    	{from: 102, to: 210},
    	{from: 103, to: 201},
    	{from: 103, to: 202},
    	{from: 103, to: 203},
    	{from: 103, to: 210},
    	{from: 104, to: 203},
    	{from: 104, to: 210},
    	{from: 104, to: 212},
    	{from: 0, to: 100},
    	{from: 1, to: 100},
    	{from: 1, to: 101},
    	{from: 1, to: 102},
    	{from: 1, to: 103},
    	{from: 1, to: 104},    	
    	{from: 1, to: 105},
    	{from: 1, to: 106},
    	{from: 2, to: 100},
    	{from: 2, to: 101},
    	{from: 2, to: 102},
    	{from: 2, to: 103},
    	{from: 2, to: 104},
    	{from: 2, to: 105},
    	{from: 2, to: 106},
    	{from: 13, to: 104},
    	{from: 9, to: 105},
    	{from: 10, to: 105},
    	{from: 11, to: 106},
    	{from: 12, to: 106},
    	{from: 14, to: 105},
    	{from: 15, to: 105},
    	{from: 2, to: 1},
        {from: 3, to: 1, value: 1, font: { multi: true }, label: "<b>4</b>"},
        {from: 4, to: 1, value: 2, font: { multi: true }, label: "<b>6</b>"},
        {from: 5, to: 1, value: 3, font: { multi: true }, label: "<b>8</b>"},
        {from: 6, to: 1},
        {from: 3, to: 2},
        
        {from: 3, to: 21},
        {from: 3, to: 22},
        {from: 3, to: 23},
        {from: 3, to: 24},
        {from: 3, to: 25},
        {from: 3, to: 26},
        //{from: 3, to: 31},
        //{from: 3, to: 41},
        
        {from: 4, to: 2},
        {from: 5, to: 2},
        {from: 6, to: 2},
        {from: 7, to: 1},
        {from: 8, to: 1},
        {from: 7, to: 2},
        {from: 8, to: 2}
        
        //{from: 51, to: 7},
        //{from: 51, to: 95},
        //{from: 61, to: 7},
        //{from: 71, to: 7},
        //{from: 71, to: 96, arrows:'to, from', dashes:true},
        //{from: 91, to: 21, label: '77/1', font: {background: 'yellow'}},
        //{from: 92, to: 21, font: { multi: true }, label: "<b>7/0</b>"},
        //{from: 93, to: 21},
        //{from: 94, to: 21}        

      ];

      // create a network
      var container = document.getElementById('mynetwork');
      var data = {
        nodes: nodes,
        edges: edges
      };
      var options = {
        interaction:{hover:true},
  		manipulation: {
  			enabled: true
  		},
        nodes: {
          borderWidth:2,
          size:25,
          shadow:true,
	      color: {
            border: '#222222',
            background: '#666666'
          },
          font:{color:'#000000'}
        },
        edges: {
          color: 'lightgray',
          shadow:true
        },
        layout: {
    	    randomSeed: {randomSeed:2}, // undefined
    	    improvedLayout:true,
    	    
    	    hierarchical: {
    	      enabled:true,
    	      levelSeparation: 150,
    	      nodeSpacing: 100,
    	      treeSpacing: 200,
    	      blockShifting: true,
    	      edgeMinimization: true,
    	      parentCentralization: true,
    	      direction: 'DU',        // UD, DU, LR, RL
    	      sortMethod: 'hubsize'   // hubsize (The node with the most connections (the largest hub) is drawn at the top of the tree), directed
    	    }
    	  }
      };

      network = new vis.Network(container, data, options);
      
      network.on("click", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
          console.log('click event, getNodeAt returns: ' + this.getNodeAt(params.pointer.DOM));
      });
      network.on("doubleClick", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '<h2>doubleClick event:</h2>' + JSON.stringify(params, null, 4);
      });
      network.on("oncontext", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '<h2>oncontext (right click) event:</h2>' + JSON.stringify(params, null, 4);
      });
      network.on("dragStart", function (params) {
          // There's no point in displaying this event on screen, it gets immediately overwritten
          params.event = "[original event]";
          console.log('dragStart Event:', params);
          console.log('dragStart event, getNodeAt returns: ' + this.getNodeAt(params.pointer.DOM));
      });
      network.on("dragging", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '<h2>dragging event:</h2>' + JSON.stringify(params, null, 4);
      });
      network.on("dragEnd", function (params) {
          params.event = "[original event]";
          document.getElementById('eventSpan').innerHTML = '<h2>dragEnd event:</h2>' + JSON.stringify(params, null, 4);
          console.log('dragEnd Event:', params);
          console.log('dragEnd event, getNodeAt returns: ' + this.getNodeAt(params.pointer.DOM));
      });
      network.on("zoom", function (params) {
          document.getElementById('eventSpan').innerHTML = '<h2>zoom event:</h2>' + JSON.stringify(params, null, 4);
      });
      network.on("showPopup", function (params) {
          document.getElementById('eventSpan').innerHTML = '<h2>showPopup event: </h2>' + JSON.stringify(params, null, 4);
      });
      network.on("hidePopup", function () {
          console.log('hidePopup Event');
      });
      network.on("select", function (params) {
          console.log('select Event:', params);
      });
      network.on("selectNode", function (params) {
          console.log('selectNode Event:', params);
      });
      network.on("selectEdge", function (params) {
          console.log('selectEdge Event:', params);
      });
      network.on("deselectNode", function (params) {
          console.log('deselectNode Event:', params);
      });
      network.on("deselectEdge", function (params) {
          console.log('deselectEdge Event:', params);
      });
      network.on("hoverNode", function (params) {
          console.log('hoverNode Event:', params);
      });
      network.on("hoverEdge", function (params) {
          console.log('hoverEdge Event:', params);
      });
      network.on("blurNode", function (params) {
          console.log('blurNode Event:', params);
      });
      network.on("blurEdge", function (params) {
          console.log('blurEdge Event:', params);
      });

    }
  </script>
  
</head>

<body onload="draw()">

<div>
    <div class="left", id="mynetwork"></div>
    <div class="right"><pre id="eventSpan"></pre></div>
</div>

</body>
</html>