package com.marshmellow.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.marshmellow.example.DAO.ReplyDAO;
import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.ReplyVO;
import com.marshmellow.example.DAO.BoardDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private BoardDAO boardDAO;

	@Transactional	
	@Override
	public void addReply(ReplyVO reply) throws Exception {
		replyDAO.create(reply);
		boardDAO.updateReplyCnt(reply.getbNo(), 1);
	}

	@Override
	public List<ReplyVO> listReply(Integer bNo) throws Exception {
		return replyDAO.list(bNo);
	}

	@Override
	public void modifyReply(ReplyVO reply) throws Exception {
		replyDAO.update(reply);
	}

	@Transactional
	@Override
	public void removeReply(Integer rNo) throws Exception {
		int bNo = replyDAO.getBNo(rNo);
		replyDAO.delete(rNo);
		boardDAO.updateReplyCnt(bNo, -1);		
	}

	@Override
	public List<ReplyVO> listReplyPage(Integer bNo, Criteria cri) throws Exception {
		return replyDAO.listPage(bNo, cri);
	}

	@Override
	public int count(Integer bNo) throws Exception {
		return replyDAO.count(bNo);
	}

}
