package com.marshmellow.service;

import java.util.List;

import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.ReplyVO;

public interface ReplyService {
	public void addReply(ReplyVO reply) throws Exception;

	public List<ReplyVO> listReply(Integer bNo) throws Exception;

	public void modifyReply(ReplyVO reply) throws Exception;

	public void removeReply(Integer rNo) throws Exception;
	
	public List<ReplyVO> listReplyPage(Integer bNo, Criteria cri) throws Exception;
	
	public int count(Integer bNo) throws Exception;
}
