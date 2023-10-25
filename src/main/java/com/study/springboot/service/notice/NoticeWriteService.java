package com.study.springboot.service.notice;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.notice.NoticeDao;
import com.study.springboot.spring.notice.Notice;
import com.study.springboot.spring.notice.WriteRequest;

@Service
public class NoticeWriteService {

	@Autowired
	NoticeDao noticeDao;

	public Integer write(WriteRequest req) {
		Notice noticewrite = toNotice(req);
		Notice savedNotice = noticeDao.noticeinsert(noticewrite);
		if (savedNotice == null) {
			throw new RuntimeException("fail to insert notice");
		}

		return savedNotice.getNoNum();
	}

	private Notice toNotice(WriteRequest req) {

		return new Notice(0, LocalDateTime.now(), req.getTitle(), req.getContent(), 0, req.getImpor());
	}




//	@Transactional
//	public String NoticeWrite() {
//		Notice notice = noticeDao.noticeinsert(null);
//		
//		
//		return null;
//		
//	}
//	

}
