package com.marshmellow.vertx.application;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.marshmellow.vertx.verticles.ServerVerticle;
import com.marshmellow.vertx.verticles.EventBusReceiverVerticle;
import com.marshmellow.vertx.verticles.EventBusSenderVerticle;

import io.vertx.core.Vertx;

//@SpringBootApplication
@Configuration
@EnableJpaRepositories("com.marshmellow.vertx.repository")
//@EntityScan("com.marshmellow.vertx.entity")
//@ComponentScan(basePackages = { "com.marshmellow" })

public class VertxSpringApplication {

    @Autowired
    private ServerVerticle serverVerticle;

    @Autowired
    private EventBusReceiverVerticle serviceVerticle;

    public static void main(String[] args) throws InterruptedException {
        //SpringApplication.run(VertxSpringApplication.class, args);
    	Vertx vertx = Vertx.vertx();
    	vertx.deployVerticle(new EventBusReceiverVerticle("R1"));
    	vertx.deployVerticle(new EventBusReceiverVerticle("R2"));

    	Thread.sleep(3000);
    	vertx.deployVerticle(new EventBusSenderVerticle());
    }   
    
    @PostConstruct
    public void deployVerticle() {
        final Vertx vertx = Vertx.vertx();
        vertx.deployVerticle(serverVerticle);
        vertx.deployVerticle(serviceVerticle);
    }

}