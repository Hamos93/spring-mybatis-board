package org.sample.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.drvier.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// DB 연동 테스트
	// 데이터베이스 정상 연결 시 Connection 객체 출력
	@Test
	public void connection() {
		try(Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:XE",
				"book_ex",
				"book_ex")){
			
			log.info(con);
		}catch(Exception e) {
			fail(e.getMessage());
		}
	}
}