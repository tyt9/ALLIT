package com.study.springboot.controller.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.study.springboot.spring.dao.qna.ReplyDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReplyController {

	@Autowired
	private ReplyDao replyDao;
	
	@GetMapping("/test")
	public String list() {
//		System.out.println(replyDao.writeDao(10, "답글 4", "관리자"));
		return "test";
	}
}
