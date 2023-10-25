package com.study.springboot.spring.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class InsertExamInfo {

	private int exNum;
	private String infoDate;
	private String info;
	private String infoStart;
	private String infoEnd;
	private String infoLoc;
	private int infoSeq;
	private int infoPrice;
	
}
