var eventBus = require('vertx/event_bus');
var mindMapUtils = require('web/mindmap_utils');

function newNodeKey() {
  return java.util.UUID.randomUUID().toString();// js 파일에서 자바를 쓸수있는건 vert.x 가 JVM 위에서 돌아감.
}

// 중요 함수다.  위에서 말했다시피 이 시스템의 구조는  브라우저 => 서버 로 Command 실행
//  서버에서 => 모든 브라우저로 이벤트 전파이다. 아래함수는 모든 브라우저(선택된 마인드맵 id 의 핸들러가 등록된)
// 로 이벤트를 전파한다. 
function publishMindMapEvent(mindMap, event) {
  eventBus.publish('mindMaps.events.'+mindMap._id, event);
}

// 브라우저 => 서버로의 Command 를 처리해주는 서버 핸들러
eventBus.registerHandler('mindMaps.editor.addNode', function(args) { 
  eventBus.send('mindMaps.find', {_id: args.mindMapId}, function(res) {
  	if (res.mindMap) {
	  var mindMap = res.mindMap;
	  var parent  = mindMapUtils.findNodeByKey(mindMap, args.parentKey);
	  var newNode = {key: newNodeKey()};
	  if (args.name) {
		newNode.name = args.name;
	  } else {
		newNode.name = 'Click to edit';
  	  }

	  if (!parent.children) {
		parent.children = [];
	  }
	  parent.children.push(newNode);

	  eventBus.send('mindMaps.save', mindMap, function() {
	    publishMindMapEvent(mindMap, {event: 'nodeAdded', parentKey: args.parentKey, node: newNode});
	  });
    }
  });
});

eventBus.registerHandler('mindMaps.editor.renameNode', function(args) {
  eventBus.send('mindMaps.find', {_id: args.mindMapId}, function(res) {
    if (res.mindMap) {
      var mindMap = res.mindMap;
      var node    = mindMapUtils.findNodeByKey(mindMap, args.key);

      if (node) {
      	node.name = args.newName;
      	eventBus.send('mindMaps.save', mindMap, function(reply) {
          publishMindMapEvent(mindMap, {event: 'nodeRenamed', key: args.key, newName: args.newName});
      	});
      }
    }
  });
});

eventBus.registerHandler('mindMaps.editor.deleteNode', function(args) {
  eventBus.send('mindMaps.find', {_id: args.mindMapId}, function(res) {
    if (res.mindMap) {
      var mindMap = res.mindMap;
      var parent  = mindMapUtils.findNodeByKey(mindMap, args.parentKey);

      parent.children.forEach(function(child, index) {
        if (child.key === args.key) {
          parent.children.splice(index, 1);
          eventBus.send('mindMaps.save', mindMap, function(reply) {
            publishMindMapEvent(mindMap, {event: 'nodeDeleted', parentKey: args.parentKey, key: args.key});
          });
        }
      });
    }
  });
});