load('vertx.js');

vertx.createHttpServer().requestHandler(function(req) {
  req.response.end("Hello World!");
}).listen(9090, 'localhost');