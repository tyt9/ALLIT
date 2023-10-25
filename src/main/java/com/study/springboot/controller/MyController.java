package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.study.springboot.spring.dao.TestDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyController {
	
	@Autowired
	TestDao testDao;
	
//	@GetMapping("/main")
//	public String main() {
//		
//		log.info("-----테스트: {}", testDao.count());
//		return "main";
//	}
	
}
