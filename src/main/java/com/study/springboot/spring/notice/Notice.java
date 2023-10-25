package com.study.springboot.spring.notice;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
public class Notice {

	private int noNum;
	private LocalDateTime noDate;
	private String noTitle;
	private String noContent;
	private int noHits;
	private int noImpor;

		
	

}
