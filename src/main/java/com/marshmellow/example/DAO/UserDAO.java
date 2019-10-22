package com.marshmellow.example.DAO;

import java.util.Date;

import com.marshmellow.dto.LoginDTO;
import com.marshmellow.example.VO.UserVO;

public interface UserDAO {

	public UserVO login(LoginDTO dto)  throws Exception;
	
	public void keepLogin(String uId,String sessionId, Date next);
	
	public UserVO checkUserWithSessionKey(String value);
}
