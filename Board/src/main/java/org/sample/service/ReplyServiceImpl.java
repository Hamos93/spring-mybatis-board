package org.sample.service;

import java.util.List;

import org.sample.domain.Criteria;
import org.sample.domain.ReplyPageDTO;
import org.sample.domain.ReplyVO;
import org.sample.mapper.ReplyMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 비즈니스 영역을 담당하는 객체임을 표시
@AllArgsConstructor
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	/* [ 의존성 주입 ] */
	// ReplyServiceImpl 객체는 ReplyMapper가 없으면 일 수행 X
	// 스프링 4.3 이상에서 단일 생성자의 묵시적 자동주입
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO reply) {
		log.info("[ Service ] " + reply);

		return mapper.insert(reply);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("[ Service ] " + rno + "번 댓글 조회");

		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {
		log.info("[ Service ] 댓글 수정");
		
		return mapper.update(reply);
	}

	@Override
	public int remove(Long rno) {
		log.info("[ Service ] " + rno + "번 댓글 삭제");
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("[ Service ] " + bno + "번 댓글 목록");
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListWithPaging(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	
}
