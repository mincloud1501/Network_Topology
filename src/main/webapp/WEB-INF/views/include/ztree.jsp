<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<title> ZTREE DEMO </title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/resources/ztree/demo.css" type="text/css">
<link rel="stylesheet" href="/resources/ztree/zTreeStyle.css" type="text/css">

<script type="text/javascript" src="/resources/ztree/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/resources/ztree/jquery.ztree.core.js"></script>

<script>
var zTreeObj;
// zTree configuration information, refer to API documentation (setting details)
var setting = {};
// zTree data attributes, refer to the API documentation (treeNode data details)
var zNodes = [
{name:"test1", open:true, children:[
   {name:"test1_1"}, {name:"test1_2"}]},
{name:"test2", open:true, children:[
   {name:"test2_1"}, {name:"test2_2"}]}
];
$(document).ready(function(){
   zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
});
</script>
</head>

<body>

<div>
   <ul id="treeDemo" class="ztree"></ul>
</div>

</body>

</html>