package com.marshmellow.example.DAO;

import com.marshmellow.example.VO.MemberVO;

public interface MemberDAO {
	public String getTime();

	public void insertMeber(MemberVO memberVo);
	
	public MemberVO readMember (String userId) throws Exception;
	
	public MemberVO readWithPW(String userId,String userPw) throws Exception;
}