package com.marshmellow.example.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.marshmellow.example.VO.BoardVO;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;

/*************************************************************/
	private static String namespace = "mappers.boardMapper";
/*************************************************************/
	
	@Override
	public void create(BoardVO boardVO) throws Exception {
		sqlSession.insert(namespace + ".create", boardVO);
	}

	@Override
	public BoardVO read(Integer bNo) throws Exception {
		return sqlSession.selectOne(namespace + ".read", bNo);
	}

	@Override
	public void update(BoardVO boardVO) throws Exception {
		sqlSession.update(namespace + ".update", boardVO);
	}

	@Override
	public void delete(Integer bNo) throws Exception {
		sqlSession.delete(namespace + ".delete", bNo);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return sqlSession.selectList(namespace + ".listAll");
	}

	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		if (page <= 0)
			page = 1;
		page = (page - 1) * 10;
		return sqlSession.selectList(namespace + ".listPage", page);
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return sqlSession.selectList(namespace + ".listCriteria", cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return sqlSession.selectOne(namespace+".countPaging", cri);
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+".listSearch",cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace+".listSearchCount",cri);
	}
	
	@Override
	public void updateReplyCnt(Integer bNo, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bNo", bNo);
		paramMap.put("amount", amount);
		sqlSession.update(namespace+".updateReplyCnt",paramMap);
	}

	@Override
	public void updateViewCnt(Integer bNo) throws Exception {
		sqlSession.update(namespace+".updateViewCnt",bNo);
	}
	
	@Override
	public void addAttach(String fullName) throws Exception {
		sqlSession.insert(namespace + ".addAttach", fullName);
	}
	
	@Override
	public List<String> getAttach(Integer bNo) throws Exception {
		return sqlSession.selectList(namespace + ".getAttach", bNo);
	}

	@Override
	public void deleteAttach(Integer bNo) throws Exception {
		sqlSession.delete(namespace + ".deleteAttach", bNo);
	}

	@Override
	public void replaceAttach(String fullName, Integer bNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("bNo", bNo);
		paramMap.put("fullName", fullName);
		
		sqlSession.insert(namespace+".replaceAttach",paramMap);
	}
}
