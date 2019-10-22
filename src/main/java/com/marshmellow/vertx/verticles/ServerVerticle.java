package com.marshmellow.vertx.verticles;

import org.springframework.stereotype.Component;

import io.vertx.core.AbstractVerticle;

@Component
public class ServerVerticle extends AbstractVerticle {

    @Override
    public void start() throws Exception {
        
    	System.out.println("BasicVerticle started");
    	
    	/*
    	super.start();

        Router router = Router.router(vertx);
        Route route = router.route("/:METHOD");

        route.handler(routingContext -> {

        	HttpServerRequest request = routingContext.request();
        	MultiMap params = request.params();

        	String method = params.get("METHOD");
        	System.out.println(method);

        	request.endHandler(empty -> {

        		JsonObject param = new JsonObject();
        		params.forEach(entry -> param.put(entry.getKey(), entry.getValue()));
        		
        		request.response().putHeader("content-type", "application/json");
        		request.response().end("{\"METHOD\": \"" + method + "\"}");

        	});

        });

        HttpServerOptions httpServerOptions = new HttpServerOptions();
        httpServerOptions.setCompressionSupported(true);

        vertx.createHttpServer(httpServerOptions)
        		.requestHandler(router::accept)
        		.listen(8080);
        		
        */
    }
    
    @Override
	public void stop() throws Exception {
    	System.out.println("BasicVerticle stopped");
	}

}