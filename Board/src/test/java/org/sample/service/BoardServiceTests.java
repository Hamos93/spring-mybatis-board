package org.sample.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sample.domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	/* [ 의존성 주입 ] */
	// 인터페이스 타입 <- 실제 객체가 무엇인지 몰라도 되는 목적
	@Setter(onMethod_= { @Autowired })
	private BoardService service;
	
	// 의존성 주입 테스트
	@Test
	public void exist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void register() {
		BoardVO board = new BoardVO();
		board.setTitle("[서비스] 등록테스트");
		board.setContent("[서비스] 등록테스트");
		board.setWriter("[서비스] 등록테스트");
		
		service.register(board);
		log.info("생성된 게시글 번호: " + board.getBno());
	}
	
	@Test
	public void get() {
		BoardVO board = service.get(3L);

		log.info(board);
	}
	
	@Test
	public void getList() {
		service.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void modify() {
		BoardVO board = service.get(2L);
		
		if(board == null) 
			return;
		
		board.setTitle("수정테스트");
		
		log.info("게시글 수정 -> " + service.modify(board));
	}
	
	@Test
	public void remove() {
		log.info("게시글 삭제 -> " + service.remove(3L));
	}

}
