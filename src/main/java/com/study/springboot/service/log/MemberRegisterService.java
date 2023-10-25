package com.study.springboot.service.log;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.study.springboot.spring.dao.log.MemberDao;
import com.study.springboot.spring.dto.Member;
import com.study.springboot.spring.log.DuplicateMemberException;
import com.study.springboot.spring.log.RegisterRequest;

@Service
public class MemberRegisterService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Transactional
	public Member regist(RegisterRequest req) {
		if (memberDao.countMemberByMemberId(req.getId())) {
			throw new DuplicateMemberException("dup memberId " + req.getId());
		}
		Member newMember = new Member(
				req.getId(), req.getName(), req.getPhone(),req.getPassword(), LocalDateTime.now());
		memberDao.insert(newMember);
		return newMember;
	}
}
