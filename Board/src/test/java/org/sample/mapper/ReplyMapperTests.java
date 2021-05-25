package org.sample.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sample.domain.Criteria;
import org.sample.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	// ReplyMapperTests 클래스는 스프링을 이용해서 ReplyMapper 인터페이스의 구현체를 주입받아서 동작
	// setter 의존성 주입
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	// ReplyMapper 타입의 객체가 정상적으로 사용이 가능한지 테스트
	@Test
	public void testMapper() {
		log.info(mapper);
	}

	@Test
	public void insert() {
		ReplyVO reply = new ReplyVO();
		
		reply.setBno(206L);
		reply.setReply("댓글 추가 테스트");
		reply.setReplyer("댓글 추가 테스트");

		mapper.insert(reply);
	}

	@Test
	public void read() {
		Long rno = 1L;
		ReplyVO reply = mapper.read(rno);

		log.info(reply);
	}

	@Test
	public void update() {
		ReplyVO reply = mapper.read(1L);

		reply.setReply("댓글 수정 테스트");
		reply.setReplyer("댓글 수정 테스트");

		int count = mapper.update(reply);

		log.info("수정된 댓글 수: " + count);
	}

	@Test
	public void delete() {
		int count = mapper.delete(1L);

		log.info("삭제된 댓글 수: " + count);
	}

	@Test
	public void list() {
		List<ReplyVO> replies = mapper.getListWithPaging(new Criteria(), 206L);
		
		replies.forEach(reply -> log.info(reply));
	}
	
}
