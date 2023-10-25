package com.study.springboot.service.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.spring.dao.log.MemberDao;
@Service
public class DeleteMemService {
	
	@Autowired
	MemberDao memberDao;
	
	@Transactional
	public void deleteMember(int memberNum) {
		memberDao.deleteMemberByMemberNum(memberNum);
	}
}
