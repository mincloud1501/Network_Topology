var container = require("vertx/container");

container.deployModule("io.vertx~mod-web-server~2.0.0-final", {

  port: 9090,
  host: "localhost",
  bridge: true,

  inbound_permitted: [
    { address: 'mindMaps.list' },
    { address: 'mindMaps.save' },
    { address: 'mindMaps.delete' }
  ]

});

container.deployModule("io.vertx~mod-mongo-persistor~2.0.0-final", {   // mongo 모듈이 추가되었네요 !

  address: "mindMaps.persistor",    // 모듈을 위한 이벤트 버스 주소 
  db_name: "mind_maps"              //  이 퍼시스터가 사용할 데이타베이스 이름 

});

container.deployVerticle('mindmaps.js');