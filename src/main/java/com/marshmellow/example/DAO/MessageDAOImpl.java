package com.marshmellow.example.DAO;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.marshmellow.example.VO.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Inject
	private SqlSession sqlSession;

/*************************************************************/
	private static String namespace = "mappers.messageMapper";
/*************************************************************/

	@Override
	public void create(MessageVO message) throws Exception {
		sqlSession.insert(namespace + ".create", message);
	}

	@Override
	public MessageVO readMessage(Integer mId) throws Exception {
		return sqlSession.selectOne(namespace + ".readMessage", mId);
	}

	@Override
	public void updateState(Integer mId) throws Exception {
		sqlSession.update(namespace + ".updateState", mId);
	}

}
