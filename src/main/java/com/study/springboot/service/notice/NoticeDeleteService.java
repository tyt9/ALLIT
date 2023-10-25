package com.study.springboot.service.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.Notice;
import com.study.springboot.spring.notice.NoticeNotFoundException;

 



@Service
public class NoticeDeleteService {

	@Autowired
	private NoticeDao noticeDao;

	
	public void delete(int noNum) throws NoticeNotFoundException {
		Notice notice = noticeDao.noticeSelectByNum(noNum);
		if(notice == null) {
			throw new NoticeNotFoundException();
		}
	
		noticeDao.noticeDelete(noNum);				
	}



	
	
}
