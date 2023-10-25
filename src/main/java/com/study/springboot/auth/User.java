package com.study.springboot.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class User {
	private int memberNum;
	private String userId;
	private String userName;
	private int memberGrade;
}
