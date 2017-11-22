<!doctype html>
<html>
<head>
	<title>Network | Sizing</title>

	<style type="text/css">
		html, body {
			font: 10pt arial;
		}
		#mynetwork {
			width: 600px;
			height: 600px;
			border: 1px solid lightgray;
		}
	</style>

	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.19.1/vis.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.19.1/vis.min.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
		var nodes = null;
		var edges = null;
		var network = null;

		function draw() {

			var url = "./getconnections.php";
			var oReq = new XMLHttpRequest();

			oReq.onload = function(){
				response = oReq.response;
	            // Parse the JSON data
	            json = JSON.parse(oReq.responseText);

	            nodesArray = json.nodes;
	            edgeArray = json.links;

		        nodes = new vis.DataSet(nodesArray);
				edges = new vis.DataSet(edgeArray);

				// Instantiate our network object.
				var container = document.getElementById('mynetwork');
				var data = {
					nodes: nodes,
					edges: edges
				};

				var options = {
						nodes: {
						shape: 'dot',
					}
				}
				
				network = new vis.Network(container, data, options);
			}

			// Perform request
            oReq.open("get", url, true);
            oReq.responseType = "text";
            oReq.send();
  		}
		console.log(nodes);
		console.log(edges);
</script>

</head>
<body onload="draw()">
	<p>
		Scale nodes and edges depending on their value. Hover over the edges to get a popup with more information.
	</p>
	<div id="mynetwork"></div>
</body>
</html>
