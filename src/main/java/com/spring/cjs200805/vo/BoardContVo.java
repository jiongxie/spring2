package com.spring.cjs200805.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode
//@ToString
@SuppressWarnings("unused")
public class BoardContVo {
	private int idx;
	private int boardIdx;
	private String nickname;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date wdate;
	private String hostip;
	private String content;
	private int level;
	private int levelOrder;
	
	@Override
	public String toString() {
		return "BoardContVo [idx=" + idx + ", boardIdx=" + boardIdx + ", nickname=" + nickname + ", wdate=" + wdate
				+ ", hostip=" + hostip + ", content=" + content + ", level=" + level + ", levelOrder=" + levelOrder + "]";
	}
	
}
