package com.marshmellow.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.marshmellow.example.DAO.MessageDAO;
import com.marshmellow.example.DAO.PointDAO;
import com.marshmellow.example.VO.MessageVO;

@Service
public class MessageServiceImpl implements MessageService{

	@Inject
	private MessageDAO messageDAO;
	
	@Inject
	private PointDAO pointDAO;
	
	@Transactional
	@Override
	public void addMessage(MessageVO message) throws Exception {
		messageDAO.create(message);
		pointDAO.updatePoint(message.getSender(), 10);
	}

	@Override
	public MessageVO readMessage(String uId, Integer mId) throws Exception {
		messageDAO.updateState(mId);
		pointDAO.updatePoint(uId, 5);
		return messageDAO.readMessage(mId);
	}

}
