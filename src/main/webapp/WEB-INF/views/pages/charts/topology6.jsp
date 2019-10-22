<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
  <title>Network Topology by minCloud</title>
  
<script src="../../resources/dist/js/exampleUtil.js"></script>
<script src="../../resources/dist/js/vis.js"></script>
<link rel="stylesheet" href="../../resources/dist/css/vis-network.min.css"/>

  <style type="text/css">
  	 #mynetwork {
      width: 1300px;
      height: 800px;
      border: 1px solid lightgray;
    }

    div.nodeContent {
      position: relative;
      border: 1px solid lightgray;
      width: 480px;
      height: 780px;
      margin-top: -802px;
      margin-left: 1310px;
      padding: 10px;
    }

    pre {
      padding: 5px;
      margin: 5px;
    }

    .string {
      color: green;
    }

    .number {
      color: darkorange;
    }

    .boolean {
      color: blue;
    }

    .null {
      color: magenta;
    }

    .key {
      color: red;
    }
  </style>
  
</head>

<body onload="draw()">

<p>
  <label><input type="checkbox" id="fixed" checked="checked"/> Fix in place after import.</label><br>
  <label><input type="checkbox" id="parseColor"/> Parse the color instead of copy (adds borders, highlights etc.)</label> 
  <input type="button" onclick="changeOptions()" value="change options"> <br />
</p>

<div id="mynetwork"></div>
<div class="nodeContent"><h4>Node/Edge Contents:</h4>
  <pre id="nodeContent"></pre>
</div>

  <script type="text/javascript">
  
    var network = null;
    var allNodes;
    var highlightActive = false;
    var shadowState;
    var options;
    var changedOptions = false;
    var DIR = '../../resources/dist/img/';
    
    var startOptions = {
     		interaction: {
     			dragNodes:true,
     		    dragView: true,
     		    hideEdgesOnDrag: true,
     		    hideNodesOnDrag: false,
     		    
     		    hover: true,
     		    hoverConnectedEdges: true,
     		    
     		    keyboard: {
     		      enabled: false,
     		      speed: {x: 10, y: 10, zoom: 0.02},
     		      bindToWindow: true
     		    },
     		    multiselect: false,
     		    navigationButtons: false,
     		    selectable: true,
     		    selectConnectedEdges: true,
     		    tooltipDelay: 300,
     		    zoomView: true
            },
       		manipulation: {
       			enabled: true,
       			
       		    initiallyActive: false,
       		    addNode: true,
       		    addEdge: true,
       		    editNode: undefined,
       		    editEdge: true,
       		    deleteNode: true,
       		    deleteEdge: true,
       		    controlNodeStyle:{
       		      // all node options are valid.
       		    }
       		},
       		layout: {
       			randomSeed:32,
       			improvedLayout:true,
       			
       			hierarchical: {
       		      enabled:false,
       		      levelSeparation: 150,
       		      nodeSpacing: 100,
       		      treeSpacing: 200,
       		      blockShifting: true,
       		      edgeMinimization: true,
       		      parentCentralization: true,
       		      direction: 'UD',        // UD, DU, LR, RL
       		      sortMethod: 'hubsize'   // hubsize, directed
       		    },
       			physics: {
       				enabled: true,
       				barnesHut: {
       			      gravitationalConstant: -12000,
       			      centralGravity: 0.2,
       			      springLength: 95,
       			      springConstant: 0.04,
       			      damping: 0.09,
       			      avoidOverlap: 1
       			    },
       			    forceAtlas2Based: {
       			      gravitationalConstant: -20000,
       			      centralGravity: 0.3,
       			      springConstant: 0.18,
       			      springLength: 230,
       			      damping: 0.4,
       			      avoidOverlap: 0
       			    },
       			    repulsion: {
       			      centralGravity: 0.2,
       			      springLength: 200,
       			      springConstant: 0.05,
       			      nodeDistance: 100,
       			      damping: 0.09
       			    },
       			    hierarchicalRepulsion: {
       			      centralGravity: 0.0,
       			      springLength: 100,
       			      springConstant: 0.01,
       			      nodeDistance: 120,
       			      damping: 0.09
       			    },
       			    maxVelocity: 146,
       			    minVelocity: 0.1,
       			    solver: 'barnesHut',
       			    
       			    stabilization: {
       			      enabled: true,
       			      iterations: 150,
       			      updateInterval: 100,
       			      onlyDynamicEdges: false,
       			      fit: true
       			    },
       			    timestep: 0.35,
       			    adaptiveTimestep: true
       		    }
       		},
    		nodes: {
    			borderWidth:2,
    			borderWidthSelected:8,
    			shadow:true,
    			shape:'circularImage',
    			image:DIR+'router.png'
    	    },
    	    edges: {
              	shadow:true,
    	      	smooth: {
    	      		enabled: false,
    	            type: "continuous", //'dynamic', 'continuous', 'discrete', 'diagonalCross', 'straightCross', 'horizontal', 'vertical', 'curvedCW', 'curvedCCW', 'cubicBezier'
    	            roundness: 0.5
    	      	}
    	    }
        };
    
    
    
 function draw(options) {
    
    var nodes = new vis.DataSet();
    var edges = new vis.DataSet();
    
    var gephiImported;
    var fixedCheckbox = document.getElementById('fixed');
    fixedCheckbox.onchange = redrawAll;

    var parseColorCheckbox = document.getElementById('parseColor');
    parseColorCheckbox.onchange = redrawAll;

    var nodeContent = document.getElementById('nodeContent');
    var edgeContent = document.getElementById('nodeContent');

    loadJSON('http://localhost:8080/resources/topology/ICNAD_Topology.json', redrawAll, function(err) {console.log('error')});

    var clusterIndex = 0;
    var clusters = [];
    var lastClusterZoomLevel = 0;
    var clusterFactor = 0.9;

    // create a network
    var container = document.getElementById('mynetwork');

    var data = {
  	      nodes: nodes,
  	      edges: edges
    };

    if(changedOptions == false) {
    	options = startOptions;
    } else {
    	options = options;
    }
    network = new vis.Network(container, data, options);
    
    network.on('click', function (params) {
   	    if (params.nodes.length > 0) {
   	      var data = nodes.get(params.nodes[0]); // get the data from selected node
   	      nodeContent.innerHTML = JSON.stringify(data, undefined, 3); // show the data in the div
   	    }
   	    else if (params.edges.length > 0) {
  	      var data = edges.get(params.edges[0]); // get the data from selected edge
  	      nodeContent.innerHTML = JSON.stringify(data, undefined, 3); // show the data in the div
  	    }
   	    
		//for(var i=0; i < network.getSelection().edges.length; i++) {
			//alert(network.getSelection().edges[i]);
	 		
			//if(network.getSelection().edges[i] < 10) {
				//draw(options3);
			//}
			//} else {
//				draw(options2);
			//}
		//}
   	    
	     
   	});
    
    network.on("doubleClick", function (params) {
		//alert(network.getSelection().edges.length);        
		        

    });
    network.on("hoverNode", function (params) {
    	//network.interactionHandler._checkShowPopup(params.pointer.DOM);
    	console.log('hoverNode Event:', params);
    });
    network.on("hoverEdge", function (params) {
    	params.event = "[original event]";    
    });
    

    /**
    * This function fills the DataSets. These DataSets will update the network.
    */
    function redrawAll(gephiJSON) {
        if (gephiJSON.nodes === undefined) {
          	gephiJSON = gephiImported;
        }
        else {
         	gephiImported = gephiJSON;
        }

        nodes.clear();
        edges.clear();
        
        var fixed = fixedCheckbox.checked;
        var parseColor = parseColorCheckbox.checked;
        
        var parsed = vis.network.gephiParser.parseGephi(gephiJSON, {
          fixed: fixed,
          parseColor: parseColor,
        });
        
        // add the parsed data to the DataSets.
        nodes.add(parsed.nodes);
        edges.add(parsed.edges);
        
        var data = nodes.get(2); // get the data from node 2 as example
        nodeContent.innerHTML = JSON.stringify(data,undefined,3); // show the data in the div
        network.fit(); // zoom to fit
        
    }
    
 } //draw
    
    function changeOptions() {
        var newColor = '#' + Math.floor((Math.random() * 255 * 255 * 255)).toString(16);
        var selectedOption;
        
        if(shadowState == false) {
        	shadowState = true;
        } else {
        	shadowState = false;
        }
        
        if(changedOptions == false) {
        	changedOptions = true;
        } else {
        	changedOptions = false;
        }
        
        var options1 = {
       		nodes: {
     			borderWidth:2,
     			borderWidthSelected:8,
     			shadow:shadowState,
     			shape:'circularImage',
     			image:DIR+'router.png'
     	    },
     	    edges: {
               	shadow:shadowState,
               	color:'orange',
               	width:2
     	    }
        };
        
        var options2 = {
       		nodes: {
     			borderWidth:2,
     			borderWidthSelected:8,
     			shadow:shadowState,
     			shape:'circularImage',
     			image:DIR+'router.png'
     	    },
     	    edges: {
     	    	font: {
     	    		color:'black'
     	    	},
               	shadow:shadowState,
               	color: {
                    color:newColor
               	},
               	width:3
     	    }
        };
        
        var options3 = {
           		nodes: {
         			borderWidth:2,
         			borderWidthSelected:8,
         			shadow:shadowState,
         			shape:'circularImage',
         			image:DIR+'router.png'
         	    },
         	    edges: {
         	    	font: {
         	    		color:'black'
         	    	},
                   	shadow:shadowState,
                   	color: {
                        color:newColor
                   	},
                   	width:5
         	    }
         };
		
		draw(options3);
    }
  

</script>
  

</body>
</html>