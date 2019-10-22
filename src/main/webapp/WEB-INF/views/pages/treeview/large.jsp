
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Fancytree - Example: font-awesome</title>

	<link href="../../resources/treeview/jquery-ui.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	
	<script src="../../resources/treeview/jquery-3.2.1.min.js"></script>
	<script src="../../resources/treeview/jquery-ui.min.js"></script>
	
	<link href="../../resources/treeview/ui.fancytree.css" rel="stylesheet" class="skinswitcher">
	<script src="../../resources/treeview/jquery.fancytree.js"></script>
	<script src="../../resources/treeview/jquery.fancytree.glyph.js"></script>
	

<style type="text/css">
	ul.fancytree-container {
		font-size: 1em;
	}
</style>

	<!-- Add code to initialize the tree when the document is loaded: -->
<script type="text/javascript">
	$(function(){
		// Initialize Fancytree
		$("#tree").fancytree({
			extensions: ["glyph"],
			checkbox: true,
			selectMode: 3,
			glyph: {
				preset: "awesome4",
				map: {}
			},
			source: {url: "../../resources/json/ajax-tree-products.json", debugDelay: 1000},
			// source: {url: "ajax-tree-taxonomy.json", debugDelay: 1000},
			lazyLoad: function(event, ctx) {
				ctx.result = {url: "../../resources/json/ajax-sub2.json", debugDelay: 1000};
			}
		});
	});
</script>

<script>
$(function(){
	// Adjust skinswitcher for current folder layout
	function setSize(event, ui){
		$("#tree .fancytree-container").css("font-size", ui.value + "pt");
		$("#curSize").text(ui.value + " pt");
	}
	$( "#fontSlider" ).slider({
		min: 4,
		max: 64,
		value: 10,
		change: setSize,
		slide: setSize
	 }).slider("value", 10);
/*
	$("#skinswitcher")
		// .skinswitcher("option", "base", "../../src/")
		.skinswitcher("addChoices", [
			{name: "Awesome", value: "awesome", href: "skin-awesome/ui.fancytree.css"}
			])
		.skinswitcher("change", "awesome");
*/
/*
	addSampleButton({
		label: "Generate <input> elements",
		code: function(){
			$("#tree").fancytree("getTree").generateInput();
			$("#tree2").fancytree("getTree").generateInput();
		}
	});
*/
});
</script>

</head>

<body class="example">
	<h1>Fancytree with JSON</h1>
	<div class="description">
		<p>
		</p>
	</div>

	<div id="tree">
	</div>
	
	<a href="http://wwwendt.de/tech/fancytree/demo/taxonomy-browser/" target="_blank">taxonomy-browser</a>
</body>
</html>
