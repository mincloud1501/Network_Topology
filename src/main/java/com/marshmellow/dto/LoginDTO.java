package com.marshmellow.dto;

public class LoginDTO {
	private String uId;
	private String uPw;
	private boolean useCookie;

	public String getuId() {
		return uId;
	}

	public void setuId(String uId) {
		this.uId = uId;
	}

	public String getuPw() {
		return uPw;
	}

	public void setuPw(String uPw) {
		this.uPw = uPw;
	}

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}

	@Override
	public String toString() {
		return "LoginDTO [uId=" + uId + ", uPw=" + uPw + ", useCookie=" + useCookie + "]";
	}

}
