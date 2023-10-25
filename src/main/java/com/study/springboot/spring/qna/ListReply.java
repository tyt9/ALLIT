package com.study.springboot.spring.qna;

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
public class ListReply {

	private int qnum;
	private String qTitle;
	private int memberNum;
	private String memberName;
	private String qContent;
	private int reNum;
	private String reContent;
	private Date reDate;
	private String replyName;
	
	
}
