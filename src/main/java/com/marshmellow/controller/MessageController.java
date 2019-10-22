package com.marshmellow.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.marshmellow.service.MessageService;
import com.marshmellow.example.VO.MessageVO;

@RestController
@RequestMapping("/message")
public class MessageController {
	@Inject
	private MessageService service;

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<String> addMessage(@RequestBody MessageVO message) {
		ResponseEntity<String> entity = null;
		try {
			service.addMessage(message);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;

	}

}
