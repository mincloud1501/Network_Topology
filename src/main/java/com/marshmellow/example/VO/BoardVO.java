package com.marshmellow.example.VO;

import java.util.Arrays;
import java.util.Date;

public class BoardVO {
	private Integer bNo;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int viewCnt;	
	private int replyCnt;
	
	private String[] files;
	
	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public Integer getbNo() {
		return bNo;
	}

	public void setbNo(Integer bNo) {
		this.bNo = bNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	@Override
	public String toString() {
		return "BoardVO [bNo=" + bNo + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + ", viewCnt=" + viewCnt + ", replyCnt=" + replyCnt + ", files=" + Arrays.toString(files)
				+ "]";
	}

}
