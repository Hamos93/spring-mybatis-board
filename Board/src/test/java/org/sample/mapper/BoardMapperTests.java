package org.sample.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sample.domain.BoardVO;
import org.sample.domain.Criteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	// BoardMapperTests 클래스는 스프링을 이용해서 BoardMapper 인터페이스의 구현체를 주입받아서 동작
	// setter 의존성 주입
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void insert() {
		BoardVO board = new BoardVO();
		board.setTitle("insert 테스트");
		board.setContent("insert 테스트");
		board.setWriter("insert 테스트");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void insertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("insertSelectKey 테스트");
		board.setContent("insertSelectKey 테스트");
		board.setWriter("insertSelectKey 테스트");
		
		mapper.insert(board);
		
		log.info(board);
	}

	@Test
	public void getList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void paging() {
		Criteria cri = new Criteria(3, 10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
	
	@Test
	public void read() {
		BoardVO board = mapper.read(5L);
		log.info(board);
	}
	
	@Test
	public void update() {
		BoardVO board = mapper.read(5L);
		
		board.setTitle("update 테스트");
		board.setContent("update 테스트");
		board.setWriter("update 테스트");
		
		int count = mapper.update(board);
		log.info("[ UPDATE COUNT ] : " + count);
	}
	
	@Test
	public void delete() {
		int count = mapper.delete(83L);
		log.info("[ DELETE COUNT ] : " + count);
	}
	
}
