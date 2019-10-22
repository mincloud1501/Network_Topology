package com.marshmellow.vertx.verticles;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;

public class EventBusSenderVerticle extends AbstractVerticle {

	public void start(Future<Void> startFuture) {
        vertx.eventBus().publish("anAddress", "message 2");
        vertx.eventBus().send   ("anAddress", "message 1");
    }
}