package org.sample.service;

import java.util.List;

import org.sample.domain.Criteria;
import org.sample.domain.ReplyPageDTO;
import org.sample.domain.ReplyVO;
import org.sample.mapper.BoardMapper;
import org.sample.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service // 비즈니스 영역을 담당하는 객체임을 표시
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	/* [ 의존성 주입 ] */
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO reply) {
		log.info("[ Service ] " + reply);
		
		boardMapper.updateReplyCnt(reply.getBno(), 1);
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

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("[ Service ] " + rno + "번 댓글 삭제");

		ReplyVO reply = mapper.read(rno);
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		
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
