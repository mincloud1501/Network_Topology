package com.marshmellow.service;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.marshmellow.example.DAO.BoardDAO;
import com.marshmellow.example.VO.BoardVO;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDao;

	@Transactional
	@Override
	public void regist(BoardVO board) throws Exception {
		boardDao.create(board);
		String[] files = board.getFiles();
		System.out.println("BoardServiceImpl Log : "+Arrays.toString(files));
		
	    if(files == null) { return; }
	    
		for(String fileName : files) {
			System.out.println("BoardServiceImpl Log : "+fileName);
			boardDao.addAttach(fileName);
		}
	}
	
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bNo) throws Exception {
		boardDao.updateViewCnt(bNo);
		return boardDao.read(bNo);
	}

	@Transactional
	@Override
	public void modify(BoardVO board) throws Exception {
		boardDao.update(board);
		Integer bNo = board.getbNo();
		boardDao.deleteAttach(bNo);
		String[] files = board.getFiles();
		if(files==null) {return;}
		for(String fileName : files) {
			boardDao.replaceAttach(fileName, bNo);
		}
	}

	@Transactional
	@Override
	public void remove(Integer bNo) throws Exception {
		boardDao.delete(bNo);
		boardDao.delete(bNo);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return boardDao.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return boardDao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return boardDao.countPaging(cri);
	}

	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return boardDao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return boardDao.listSearchCount(cri);
	}
	
	@Override
	public List<String> getAttach(Integer bNo) throws Exception {
		return boardDao.getAttach(bNo);
	}
}
