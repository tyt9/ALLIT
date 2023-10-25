package com.study.springboot.spring.dao.notice;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.study.springboot.spring.notice.Notice;


@Repository
public class NoticeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<Notice>noRowMapper = 
			(ResultSet rs, int rowNum) -> {
		Notice notice = new Notice(
				rs.getInt("NoNum"),
				rs.getTimestamp("NoDate").toLocalDateTime(),
				rs.getString("NoTitle"),
				rs.getString("NOCONTENT"),
				rs.getInt("NOHITS"),
				rs.getInt("NOIMPOR")
				);
		notice.setNoNum(rs.getInt("NONUM"));
		return notice;	
		};
		

	
	public Notice noticeSelectByNum(int nonum) {
		
		List<Notice> results = jdbcTemplate.query( "select*from Notice where nonum= ? ", 		
		noRowMapper,nonum);
		return results.isEmpty() ? null : results.get(0);
		}
		
	
//	public Notice noticeSelectDateByNoimpor(LocalDateTime nodate,int noimpor) {//게시판 내 상단 고정
//		List<Notice> results = jdbcTemplate.query("select*from Notice where , null)
//		return null;
//	}
//	
	
	
		
	public List<Notice> noticeSelectAll(){
		List<Notice> results = jdbcTemplate.query("select * from Notice",
				noRowMapper);
				return results;
	}
	
	public Notice noticeinsert(Notice notice) {
		
		String sql = "insert into notice(nonum, nodate, notitle,nocontent,nohits,noimpor)"
				+ " values(0,now(),?,?,0,?)";
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update((con)->{
			PreparedStatement pstm = con.prepareStatement(sql,new String[]{"noNum"});
			pstm.setString(1, notice.getNoTitle());
			pstm.setString(2, notice.getNoContent());			
			pstm.setInt(3, notice.getNoImpor());
			return pstm;
			},keyHolder);
		Number keyValue = keyHolder.getKey();
		notice.setNoNum(keyValue.intValue());
		return notice;

		
	
		}
	public int noticeDelete(int noNum) {
		String sql = "delete from notice where nonum = ?";
		return jdbcTemplate.update(sql, noNum);
	}
	
	public void noticeUpdate(Notice notice) {
		String sql = "update notice set notitle = ?, nocontent = ? where nonum = ?";
		this.jdbcTemplate.update(sql, notice.getNoTitle(), 
				notice.getNoContent(), notice.getNoNum());
		
	}
	
	public int noticeSelectCount() {
		String sql = "select count(*) from notice";
		
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}




	public List<Notice> select(int startRow, int size) {
		String sql = "select * from notice " +
				"order by noimpor desc, nonum desc, nodate desc limit ?, ?";
		
		return jdbcTemplate.query(sql, 
				(rs, n) -> convertNotice(rs), startRow, size);
		
	}
	private Notice convertNotice(ResultSet rs) throws SQLException {
		return new Notice(rs.getInt("NoNum"),
				rs.getTimestamp("noDate").toLocalDateTime(),
				rs.getString("NoTitle"),
				rs.getString("notitle"),
				rs.getInt("nohits"),
				rs.getInt("noimpor")
				);
	}
	
	
	public void increaseReadCount(int noNum) {
		String sql="update notice set nohits = nohits + 1 where nonum = ?";
		jdbcTemplate.update(sql,noNum);
	}


	


	public int update(int noNum, String title, String content, int impor) {
		String sql = "update notice set notitle = ?, nodate = now(), nocontent =? ,noimpor = ?"+
				" where nonum = ?";
		return jdbcTemplate.update(sql, title,content,impor,noNum) ;
		
	}
	
	
	public List<Notice> noticeForMain(){
		String sql = "select * from notice order by nodate desc limit 7";
		return jdbcTemplate.query(sql, noRowMapper);
	}

	
	
}