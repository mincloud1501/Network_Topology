package com.marshmellow.service;

import java.util.Date;

import com.marshmellow.dto.LoginDTO;
import com.marshmellow.example.VO.UserVO;

public interface UserService {
	public UserVO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String uId,String sessionId,Date next) throws Exception;
	
	public UserVO checkLoginBefore(String value);
}
