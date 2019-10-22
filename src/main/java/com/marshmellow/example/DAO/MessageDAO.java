package com.marshmellow.example.DAO;

import com.marshmellow.example.VO.MessageVO;

public interface MessageDAO {
	public void create(MessageVO message) throws Exception;

	public MessageVO readMessage(Integer mId) throws Exception;

	public void updateState(Integer mId) throws Exception;
}
