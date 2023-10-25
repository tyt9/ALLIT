package com.study.springboot.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.Notice;
import com.study.springboot.spring.notice.NoticeData;
import com.study.springboot.spring.notice.NoticeNotFoundException;

@Service
public class NoticeReadService {

	@Autowired
	private NoticeDao noticeDao;

	public NoticeData getNotice(int noNum, boolean increaseReadCount) throws NoticeNotFoundException {
		Notice notice = noticeDao.noticeSelectByNum(noNum);
		// Notice notice = noticeDao.noticeSelectDateByNoimpor(noNum);
		if (notice == null) {
			throw new NoticeNotFoundException();
		}
		if (increaseReadCount) {
			noticeDao.increaseReadCount(noNum);
		}
		return new NoticeData(notice);
	}
	
	public List<Notice> mainNotice(){
		return noticeDao.noticeForMain();
	}
	
}