package com.marshmellow.service;

import com.marshmellow.example.VO.MessageVO;

public interface MessageService {
	public void addMessage(MessageVO message) throws Exception;

	public MessageVO readMessage(String uId, Integer mId) throws Exception;
}
