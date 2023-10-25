package com.study.springboot.service.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.qna.ReplyDao;
import com.study.springboot.spring.qna.ListReply;

@Service
public class ReplyService {

	@Autowired
	private ReplyDao replyDao;
	
	public List<ListReply> getReply(int qNum) {
		List<ListReply> content = replyDao.listDao(qNum);
		return content;
	}
}
