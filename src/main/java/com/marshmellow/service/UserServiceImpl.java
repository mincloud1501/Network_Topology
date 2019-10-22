package com.marshmellow.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.marshmellow.example.DAO.UserDAO;
import com.marshmellow.dto.LoginDTO;
import com.marshmellow.example.VO.UserVO;

@Service
public class UserServiceImpl implements UserService{
	@Inject
	private UserDAO userDAO;

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return userDAO.login(dto);
	}

	@Override
	public void keepLogin(String uId, String sessionId, Date next) throws Exception {
		userDAO.keepLogin(uId, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) {
		return userDAO.checkUserWithSessionKey(value);
	}
	
	
}
