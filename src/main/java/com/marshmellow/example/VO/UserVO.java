package com.marshmellow.example.VO;

public class UserVO {
	private String uId;
	private String uPw;
	private String uName;
	private String uGroup;
	private int uPoint;

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

	public String getuName() {
		return uName;
	}

	public String getuGroup() {
		return uGroup;
	}

	public void setuGroup(String uGroup) {
		this.uGroup = uGroup;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	public int getuPoint() {
		return uPoint;
	}

	public void setuPoint(int uPoint) {
		this.uPoint = uPoint;
	}

	@Override
	public String toString() {
		return "UserVO [uId=" + uId + ", uPw=" + uPw + ", uName=" + uName + ", uPoint=" + uPoint + "]";
	}

}
