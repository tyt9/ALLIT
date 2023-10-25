package com.study.springboot.spring.dto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

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
public class Apply {

	private String name;
	@NotNull
	@NotEmpty
//	@Size(min = 10,max = 11)
	private String phone;
	@NotNull
	@NotEmpty
	private String address;
}
