package com.study.springboot.service.qna;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.spring.dao.qna.QnaDao;
import com.study.springboot.spring.dto.Qna;
import com.study.springboot.spring.qna.DeleteRequest;
import com.study.springboot.spring.qna.ListRequest;
import com.study.springboot.spring.qna.ModifyRequest;
import com.study.springboot.spring.qna.PermissionDeniedException;
import com.study.springboot.spring.qna.QnaNotFoundException;
import com.study.springboot.spring.qna.QnaPage;
import com.study.springboot.spring.qna.ReadRequest;
import com.study.springboot.spring.qna.WriteRequest;

@Service
public class QnaService {

	@Autowired
	private QnaDao qnaDao;
	
	
	private int size = 10;
	
	// 페이지 끊어서 가져오는 메소드(list)
	public QnaPage getQnaPage(int pageNum) {
		int total = qnaDao.selectQnaCount();
		List<ListRequest> content = qnaDao.selectNameByNum((pageNum - 1) * size, size);
		return new QnaPage(total, pageNum, size, content);
	}
	
	// 해당 번호 글 가져오는 메소드(read)
	public ReadRequest getQna(int articleNum, boolean increaseReadCount) {
		
		ReadRequest qna = qnaDao.selectByNum(articleNum);
		if (qna == null ) {
			throw new QnaNotFoundException();
		}
		if (increaseReadCount) {
			qnaDao.increaseReadCount(articleNum);
		}
		return new ReadRequest(qna.getQNum(), qna.getQTitle(), qna.getMemberNum(), qna.getQDate(), qna.getMemberName(), qna.getQContent());
	}
	
	// 글 작성 메소드
	public Integer write(WriteRequest req) {
		Qna writeQna = toQna(req);
		Qna savedQna = qnaDao.insert(writeQna);
		if (savedQna == null) {
			throw new RuntimeException("fail to insert qna");
		}
		return savedQna.getQNum();
	}
	
	// 새 글 작성 객체 생성
	public Qna toQna(WriteRequest req) {
		Date now = new Date();
		return new Qna(0, now, req.getQTitle(), req.getQContent(), 0, req.getMemberNum());
	}
	
	// 글 수정 메소드
	public void modify(ModifyRequest modifyRequest) {
		ReadRequest readRequest = qnaDao.selectByNum(modifyRequest.getQNum());
		if (readRequest == null) {
			throw new QnaNotFoundException();
		}
		if (!canModify(modifyRequest.getMemberNum(), readRequest)) {
			throw new PermissionDeniedException();
		}
		qnaDao.update(modifyRequest.getQNum(), modifyRequest.getQTitle(),modifyRequest.getQContent());
	}
	
	// 번호 비교 메소드
	private boolean canModify(int modifyingUserId, ReadRequest readRequest) {
		return readRequest.getMemberNum() == (modifyingUserId);
	}
	
	public void delete (DeleteRequest deleteRequest) {
		ReadRequest readRequest = qnaDao.selectByNum(deleteRequest.getQNum());
		if (readRequest == null) {
			throw new QnaNotFoundException();
		}
		if (!canDelete(deleteRequest.getMemberNum(), readRequest)) {
			throw new PermissionDeniedException();
		}
		qnaDao.delete(deleteRequest.getQNum());
	}
	
	public boolean canDelete(int deleteUserId, ReadRequest readRequest) {
		return readRequest.getMemberNum() == deleteUserId;
	}
}
