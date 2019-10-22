package com.marshmellow.example.VO;

import com.google.gson.Gson;

public class ChatVO {
	private String type;
	private String to;
	private ChatVO message;

	public static ChatVO convertMessage(String source) {
	    ChatVO message = new ChatVO();
	    Gson gson = new Gson();
	    message = gson.fromJson(source, ChatVO.class);
	    return message;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}
	
	@Override
	public String toString() {
		return "ChatVO [message=" + message + ", type=" + type + ", to=" + to + "]";
	}
}
