package com.study.springboot.service.apply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.apply.ApplyDao;

@Service
public class ApplyService {

	@Autowired
	private ApplyDao applyDao;
	
	
	public void deleteMyExamByMeNum(int meNum) {
		applyDao.deleteMyExam(meNum);
	}
}
