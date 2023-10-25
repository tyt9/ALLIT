package com.study.springboot.spring.log;

import javax.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LoginCommand {
	
	@NotBlank
	private String id;
	@NotBlank
	private String password;
	private boolean rememberId;
}
