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
public class Reply {

	private int reNum;
	private int qNum;
	private String reContent;
	private Date reDate;
	private String replyName;
}
