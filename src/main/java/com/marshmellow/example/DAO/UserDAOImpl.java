package com.marshmellow.example.DAO;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.marshmellow.dto.LoginDTO;
import com.marshmellow.example.VO.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;

/*************************************************************/
	private static String namespace = "mappers.userMapper";
/*************************************************************/

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return sqlSession.selectOne(namespace + ".login", dto);
	}

	@Override
	public void keepLogin(String uId, String sessionId, Date next) {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("uId", uId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		
		sqlSession.update(namespace+".keepLogin",paramMap);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		return sqlSession.selectOne(namespace+".checkUserWithSessionKey",value);
	}

}
