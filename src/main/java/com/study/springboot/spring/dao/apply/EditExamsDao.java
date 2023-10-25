package com.study.springboot.spring.dao.apply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.dto.InsertExamInfo;

@Repository
public class EditExamsDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int insertInfo(InsertExamInfo iei) {
		String sql = "insert into examinfo values(null,?,?,?,?,?,?,?,?)";
//		jdbcTemplate.update(sql,iei.getInfoDate(),iei.getInfo(),iei.getExNum(),iei.getInfoStart(),
//				iei.getInfoEnd(),iei.getInfoLoc(),iei.getInfoSeq(),iei.getInfoPrice());
		KeyHolder keyHolder = new GeneratedKeyHolder();
			jdbcTemplate.update(new PreparedStatementCreator() {
				
				@Override
				public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					PreparedStatement pstmt = con.prepareStatement(sql, new String[] { "infonum" });
					pstmt.setString(1,iei.getInfoDate());
					pstmt.setString(2, iei.getInfo());
					pstmt.setInt(3, iei.getExNum());
					pstmt.setString(4, iei.getInfoStart());
					pstmt.setString(5, iei.getInfoEnd());
					pstmt.setString(6, iei.getInfoLoc());
					pstmt.setInt(7, iei.getInfoSeq());
					pstmt.setInt(8, iei.getInfoPrice());
					
					return pstmt;
				}
			}, keyHolder);
			Number keyValue = keyHolder.getKey();
			String key = String.valueOf(keyValue);
			int keyId = Integer.parseInt(key);
			return keyId;
	}
	public int selectSeqByExNum(int exNum){
		String sql = "select max(infoSeq) from examinfo where exnum = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, exNum);
	}

	public int deleteExam(int infoNum){
		String sql = "delete from examinfo where infonum = ?";
		return jdbcTemplate.update(sql,infoNum);
	}
	
}
