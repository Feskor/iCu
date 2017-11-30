<html>
<head>
	<link rel="stylesheet" href="visualize_connections.css">
	<link href="https://fonts.googleapis.com/css?family=Maven+Pro" rel="stylesheet">
</head>
<body style="margin : 0, height : 100%">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/springy/2.7.1/springy.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/springy/2.7.1/springyui.min.js"></script>
	<script>

		var url = "./get_connections.php";
		var oReq = new XMLHttpRequest();
		var graph = new Springy.Graph();

		var totalNodes = [];
		var totalEdges = [];
		
		oReq.onload = function(){			

			var response = oReq.response;
            var deviceData = JSON.parse(oReq.responseText);

            var newNodes = [];
            var newEdges = [];
            var nodes = deviceData.nodes;
            var edges = deviceData.links;
            
        	if (totalNodes.length < nodes.length){
        		newNodes = nodes.slice(totalNodes.length);
        	}
			        
        	if (totalEdges.length < edges.length){
        		newEdges = edges.slice(totalEdges.length);
        	}

        	if (totalEdges.length > edges.length){
        		graph.edges.forEach(function(graphEdge){
        			if ((edges.find(edge => 
        				(edge.from == graphEdge.source.data.label) && 
        				(edge.to == graphEdge.target.data.label)) == undefined)){
        				var index = graph.edges.indexOf(graphEdge);
        				console.log(index);
        				graph.edges.splice(index,1);
        			}
        		});
        	}
        	
        	totalNodes = nodes;
         	totalEdges = edges;

         	totalNodes.forEach(function(thisNode){
				var graphNode = graph.nodes.find(node => node.data.label.indexOf(thisNode.id) >= 0);				
				if (graphNode != undefined)
					graphNode.data.label = thisNode.label;
         	});			

            newNodes.forEach(function(node){
            	graph.newNode(node);
            });

            newEdges.forEach(function(connection){
            	var fromNode = graph.nodes.find(node => node.data.label.indexOf(connection.from) >= 0);
            	var toNode = graph.nodes.find(node => node.data.label.indexOf(connection.to) >= 0);                	
            	graph.newEdge(fromNode, toNode, {color : connection.color});
            });			
		}

		window.setInterval(function(){
			// Perform request
	        oReq.open("get", url, true);
	        oReq.responseType = "text";
	        oReq.send();	
    	},1000);
		

		function init()
		{
		    canvas = document.getElementById("c");
		    canvas.width = document.body.clientWidth; //document.width is obsolete
		    canvas.height = document.body.clientHeight; //document.height is obsolete
		    // canvasW = canvas.width;
		    // canvasH = canvas.height;

		    // if( canvas.getContext )
		    // {
		    //     setup();
		    //     setInterval( run , 33 );
		    // }
		}


		jQuery(function(){
			var springy = window.springy = jQuery('#c').springy({
				graph: graph,
				nodeSelected: function(node){
					console.log('Node selected: ' + JSON.stringify(node.data));
				}
			});
			init();
		});
	</script>

	<canvas id="c" width="1000px" height="600px" />
</body>
</html>
