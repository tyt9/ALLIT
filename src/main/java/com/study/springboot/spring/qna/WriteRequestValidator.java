package com.study.springboot.spring.qna;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class WriteRequestValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return WriteRequest.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		WriteRequest writeReq = (WriteRequest) target;
		if (writeReq.getQTitle() == null || writeReq.getQTitle().trim().isEmpty()) {
			errors.rejectValue("title", "required");
		}
	}

	
}
