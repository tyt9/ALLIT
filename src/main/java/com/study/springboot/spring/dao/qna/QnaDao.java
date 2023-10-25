package com.study.springboot.spring.dao.qna;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.dto.Qna;
import com.study.springboot.spring.qna.ListRequest;
import com.study.springboot.spring.qna.ReadRequest;

@Repository
public class QnaDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public QnaDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	// 문의 글 작성 메소드
	public Qna insert(Qna qna) {
		String sql = "insert into qna(qnum, qdate, qtitle, qcontent, qhits, memberNum)"
				+ "values (?, now(), ?, ?, 0, ?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update((con) ->{
			PreparedStatement pstm = con.prepareStatement(sql, new String[] {"qNum"});
			pstm.setInt(1, qna.getQNum());
			pstm.setString(2, qna.getQTitle());
			pstm.setString(3, qna.getQContent());
			pstm.setInt(4, qna.getMemberNum());
			return pstm;
		}, keyHolder);
		Number keyValue = keyHolder.getKey();
		qna.setQNum(keyValue.intValue());
		return qna;
	}
	
	// 회원수 조회 메소드
	public int selectMemberCount() {
		String sql = "select count(*) from member";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	// 게시글 갯수 조회 메소드
	public int selectQnaCount() {
		String sql = " select count(*) from Qna";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
//	// 리스트 조회 메소드
//	public List<Qna> select(int startRow, int size) {
//		String sql = "select * from qna order by qnum desc limit ?, ?";
//		return jdbcTemplate.query(sql, (rs,n) -> convertArticle(rs), startRow, size);
//	}
	
	// 리스트 조회 메소드(커맨드 객체)
	public List<ListRequest> selectNameByNum(int startRow, int size){
		String sql = "select q.qnum, q.qtitle, m.memberName, q.qdate, q.qhits "
				+ "from member m inner join qna q on m.membernum = q.membernum order by qnum desc limit ?, ?";
		return jdbcTemplate.query(sql, (rs,n) -> convertRequestArticle(rs), startRow, size);
	}

//	// 글 양식대로 변환해주는 메소드
//	private Qna convertArticle(ResultSet rs) throws SQLException {
//		return new Qna(rs.getInt("qNum"), toDate(rs.getTimestamp("qDate")),
//					   rs.getString("qTitle"), rs.getString("qContent"),
//					   rs.getInt("qHits"), rs.getInt("memberNum"));
//	}
	
//	 글 양식대로 변환해주는 메소드(리스트 커맨드 객체)
	private ListRequest convertRequestArticle(ResultSet rs) throws SQLException {
		return new ListRequest(rs.getInt("qNum"), rs.getString("qTitle"), rs.getString("memberName"), rs.getDate("qDate"), rs.getInt("qHits"));
	}
	
	
	private Date toDate(Timestamp timestamp) {
		return new Date(timestamp.getTime());
	}
	
	
	// 문의 번호 조회 메소드 (글 번호, 글 제목, 회원 번호, 회원 이름, 글 내용)
	public ReadRequest selectByNum(int no) {
		String sql = "select q.qnum, q.qtitle, m.membernum,q.qdate, m.memberName, q.qcontent "
				+ "from member m inner join qna q on m.membernum = q.membernum"
				+ " where qNum =?";
		
		List<ReadRequest> list = jdbcTemplate.query(sql, (rs,n) -> convertReadRequestArticle(rs), no);
		
		return list.isEmpty() ? null : list.get(0);
	}
	
	// read 커맨드 객체 생성
	public ReadRequest convertReadRequestArticle(ResultSet rs) throws SQLException {
		return new ReadRequest(rs.getInt("qNum"), rs.getString("qTitle"), rs.getInt("memberNum"), rs.getDate("qDate"), rs.getString("memberName"), rs.getString("qContent"));
	}
	
	// 조회수 올려주는 메소드
	public void increaseReadCount(int no) {
		String sql = "update qna set qhits = qhits + 1 where qnum = ?";
		jdbcTemplate.update(sql, no);
	}
	
	// 글 수정 메소드
	public int update(int no, String title, String content) {
		String sql = "update qna set qtitle = ?, qContent = ?, qdate = now() where qnum = ?";
		return jdbcTemplate.update(sql, title,content, no);
	}
	
	// 문의글 삭제 메소드
	public int delete(int no) {
		String sql = "delete from qna where qnum = ?";
		return jdbcTemplate.update(sql, no);
	}
	
	private RowMapper<Qna> qnaMapper =
			(rs, n) -> {
			Qna qna = new Qna(	
				rs.getDate("qDate"),
				rs.getString("qTitle"),
				rs.getString("qContent"),
				rs.getInt("qHits"),
				rs.getInt("memberNum"));
			return qna;
			};
			
		public List<Qna> selectQnaByMemberNum(int memberNum) {
			String sql = "select * from QNA where MEMBERNUM = ?";
			List<Qna> results = jdbcTemplate.query(sql, qnaMapper, memberNum);
			return results;
		}
		
		public int CountQnaByMemberNum(int memberNum) {
			String sql = "select count(*) from QNA where MEMBERNUM = ?";
			int count = jdbcTemplate.queryForObject(sql, Integer.class, memberNum);
			return count;
		}
		
		public List<Qna> findMyQnaByMemberNum(int memberNum) {
			String sql = "select * from QNA where MEMBERNUM = ? ORDER BY qdate DESC LIMIT 5";
			List<Qna> results = jdbcTemplate.query(sql, (rs, n) -> {
				Qna qna = new Qna(
						rs.getDate("qDate"),
						rs.getString("qTitle"),
						rs.getString("qContent"),
						rs.getInt("qHits"),
						rs.getInt("memberNum"));
				qna.setQNum(rs.getInt("qNum"));
					return qna;
					}, memberNum);
			return results;
		}
}
