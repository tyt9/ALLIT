package com.study.springboot.spring.notice;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class NoticeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		
		return Notice.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Notice notice = (Notice)target;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "title is empty.");
		String nTitle = notice.getNoTitle();
		
	}

	
	
	
	
}
