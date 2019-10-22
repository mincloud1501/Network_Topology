package com.marshmellow.example.VO;

import java.util.Date;

public class MessageVO {
	private Integer mId;
	private String targetId;
	private String sender;
	private String message;
	private Date openDate;
	private Date sendDate;

	public Integer getmId() {
		return mId;
	}

	public void setmId(Integer mId) {
		this.mId = mId;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	
	@Override
	public String toString() {
		return "MessageVO [mId=" + mId + ", targetId=" + targetId + ", sender=" + sender + ", message=" + message
				+ ", openDate=" + openDate + ", sendDate=" + sendDate + "]";
	}

}
