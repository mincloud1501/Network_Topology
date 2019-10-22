package com.marshmellow.service;

import java.util.List;

import com.marshmellow.example.VO.BoardVO;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.SearchCriteria;

public interface BoardService {

	public void regist(BoardVO board) throws Exception;

	public BoardVO read(Integer bNo) throws Exception;

	public void modify(BoardVO board) throws Exception;

	public void remove(Integer bNo) throws Exception;

	public List<BoardVO> listAll() throws Exception;

	public List<BoardVO> listCriteria(Criteria cri) throws Exception;

	public int listCountCriteria(Criteria cri) throws Exception;

	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<String> getAttach(Integer bNo) throws Exception;
}
