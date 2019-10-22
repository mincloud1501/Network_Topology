package com.marshmellow.example.DAO;

import java.util.List;

import com.marshmellow.example.VO.Criteria;
import com.marshmellow.example.VO.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> list(Integer bNo) throws Exception;

	public void create(ReplyVO reply) throws Exception;

	public void update(ReplyVO reply) throws Exception;

	public void delete(Integer rNo) throws Exception;
	
	public List<ReplyVO> listPage(Integer bNo,Criteria cri) throws Exception;
	
	public int count(Integer bNo) throws Exception;
	
	public int getBNo(Integer rNo) throws Exception;
}
