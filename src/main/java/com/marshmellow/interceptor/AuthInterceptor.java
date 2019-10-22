package com.marshmellow.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.marshmellow.service.UserService;
import com.marshmellow.example.VO.UserVO;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Inject
	private UserService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();

		if (session.getAttribute("login") == null) {

			logger.info("current user is not logined");

			saveDest(request);

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {

				UserVO userVO = service.checkLoginBefore(loginCookie.getValue());

				logger.info("USERVO: " + userVO);

				if (userVO != null) {
					session.setAttribute("login", userVO);
					return true;
				}

			}

			response.sendRedirect("/user/login");
			return false;
		}
		return true;
	}

	private void saveDest(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();

		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		if (request.getMethod().equals("GET")) {
			logger.info("dest" + (uri + query));
			request.getSession().setAttribute("dest", uri + query);
		}
	}

}
