package com.study.springboot.spring.dao.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.spring.qna.ListReply;
import com.study.springboot.spring.qna.WriteReply;

@Mapper
public interface ReplyDao {

	public List<ListReply> listDao(int qNum);
	public int writeDao(WriteReply writeReply);
	public int deleteDao(int reNum);
}
