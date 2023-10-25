package com.study.springboot.service.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.Notice;
import com.study.springboot.spring.notice.NoticeModifyRequest;
import com.study.springboot.spring.notice.NoticeNotFoundException;


@Service
public class NoticeModifyService {
	@Autowired
	private NoticeDao noticeDao;
	
	public void modify(NoticeModifyRequest modReq) throws NoticeNotFoundException {
		
		Notice notice = noticeDao.noticeSelectByNum(modReq.getNoNum());
		if(notice == null) {
			throw new NoticeNotFoundException();
		}
		noticeDao.update(modReq.getNoNum(), modReq.getTitle(),modReq.getContent(),modReq.getImpor());

		}
		
		
		
		
}

