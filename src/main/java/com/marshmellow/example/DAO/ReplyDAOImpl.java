package com.marshmellow.example.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "mappers.replyMapper";

	@Override
	public List<ReplyVO> list(Integer bNo) throws Exception {
		return sqlSession.selectList(namespace + ".list", bNo);
	}

	@Override
	public void create(ReplyVO reply) throws Exception {
		sqlSession.insert(namespace + ".create", reply);
	}

	@Override
	public void update(ReplyVO reply) throws Exception {
		sqlSession.update(namespace + ".update", reply);
	}

	@Override
	public void delete(Integer rNo) throws Exception {
		sqlSession.delete(namespace + ".delete", rNo);
	}

	@Override
	public List<ReplyVO> listPage(Integer bNo, Criteria cri) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("bNo", bNo);
		paramMap.put("cri", cri);

		return sqlSession.selectList(namespace + ".listPage", paramMap);
	}

	@Override
	public int count(Integer bNo) throws Exception {
		return sqlSession.selectOne(namespace + ".count", bNo);
	}

	@Override
	public int getBNo(Integer rNo) throws Exception {
		return sqlSession.selectOne(namespace+".getBNo",rNo);
	}
}
