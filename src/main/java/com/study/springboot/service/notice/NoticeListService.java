package com.study.springboot.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.Notice;
import com.study.springboot.spring.notice.NoticePage;

@Service
public class NoticeListService {

	@Autowired
	private NoticeDao noticeDao;
	private int size = 10;
	
	public NoticePage getNoticePage(int pageNum) {
		
		int total = noticeDao.noticeSelectCount();
		List<Notice> content = noticeDao.select((pageNum - 1) * size, size);
		return new NoticePage(total, pageNum, size, content);
	
	
	
	
	
	}
}
