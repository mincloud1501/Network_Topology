var eventBus = require('vertx/event_bus');
var console  = require('vertx/console');

function sendPersistorEvent(command, callback) {

  eventBus.send('mindMaps.persistor', command, function(reply) {  // mongo 퍼시스터에 명령을 보내고 

    if (reply.status === "ok") {                                  // 응답을 받은후에 핸들러 호출 
      callback(reply);

    } else {
      console.log(reply.message);
    }

  });

};

eventBus.registerHandler('mindMaps.list', function(args, responder) {

  sendPersistorEvent(
    {action: "find", collection: "mindMaps", matcher: {}},    // mindMaps 에서 모든것을 가져와서 응답~

    function(reply) {
      responder({mindMaps: reply.results}); 
    }
  );
});

eventBus.registerHandler('mindMaps.find', function(args, responder) {

  sendPersistorEvent(
    {action: "findone", collection: "mindMaps", matcher: {_id: args._id}}, //  id 에 대당하는것을 리턴~

    function(reply) {
      responder({mindMap: reply.result}); 
    }
  );  

});

eventBus.registerHandler('mindMaps.save', function(mindMap, responder) {

  sendPersistorEvent(
    {action: "save", collection: "mindMaps", document: mindMap}, //  새 mindMap 을 저장 

    function(reply) {
      mindMap._id = reply._id;
      responder(mindMap);
    }

  );

});

eventBus.registerHandler('mindMaps.delete', function(args, responder) {

  sendPersistorEvent(
    {action: "delete", collection: "mindMaps", matcher: {_id: args.id}}, responder({})
  );

});