package com.study.springboot.spring.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class Qna {

	private int qNum;
	private Date qDate;
	private String qTitle;
	private String qContent;
	private int qHits;
	private int memberNum;
	
	public Qna(Date qDate, String qTitle, String qContent, int qHits, int memberNum) {
		super();
		this.qDate = qDate;
		this.qTitle = qTitle;
		this.qContent = qContent;
		this.qHits = qHits;
		this.memberNum = memberNum;
	}
	
}
