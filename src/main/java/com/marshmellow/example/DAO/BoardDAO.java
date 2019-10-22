package com.marshmellow.example.DAO;

import java.util.List;

import com.marshmellow.example.VO.BoardVO;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.SearchCriteria;

public interface BoardDAO {
	
	public void create(BoardVO boardVO) throws Exception;
	
	public BoardVO read(Integer bNo) throws Exception;
	
	public void update(BoardVO boardVO) throws Exception;
	
	public void delete(Integer bNo) throws Exception;
	
	public List<BoardVO> listAll() throws Exception;
	
	public List<BoardVO> listPage(int page) throws Exception;
	
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public void updateReplyCnt(Integer bNo, int amount) throws Exception;
	
	public void updateViewCnt(Integer bNo)throws Exception;
	
	public void addAttach(String fullName) throws Exception;
	
	public List<String> getAttach(Integer bNo) throws Exception;

	public void deleteAttach(Integer bNo) throws Exception;

	public void replaceAttach(String fullName,Integer bNo) throws Exception;
}
