package com.marshmellow.example.VO;

import java.util.Date;

public class MemberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String email;
	private Date regDate;
	private Date updatedDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", email=" + email
				+ ", regDate=" + regDate + ", updatedDate=" + updatedDate + "]";
	}

}