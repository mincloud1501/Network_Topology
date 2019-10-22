package com.marshmellow.example.DAO;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.marshmellow.example.VO.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sqlSession;

	private static String namespace = "mappers.memberMapper";

	@Override
	public String getTime() {
		return sqlSession.selectOne(namespace + ".getTime");
	}

	@Override
	public void insertMeber(MemberVO memberVo) {
		sqlSession.insert(namespace + ".insertMember", memberVo);
	}

	@Override
	public MemberVO readMember(String userId) throws Exception {
		return (MemberVO)sqlSession.selectOne(namespace+".selectMember", userId);
	}

	@Override
	public MemberVO readWithPW(String userId, String userPw) throws Exception {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", userId);
		paramMap.put("userPw", userPw);
		
		return sqlSession.selectOne(namespace+".readWithPw", paramMap);
	}

}