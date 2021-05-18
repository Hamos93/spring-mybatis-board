package org.sample.service;

import java.util.List;

import org.sample.domain.BoardVO;
import org.sample.domain.Criteria;
import org.sample.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service // 비즈니스 영역을 담당하는 객체임을 표시
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {
	
	/* [ 의존성 주입 ] */
	// BoardServiceImpl 객체는 BoardMapper가 없으면 일 수행 X
	// 스프링 4.3 이상에서 단일 생성자의 묵시적 자동주입
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("[ Service ] " + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("[ Service ] " + bno + "번 글 조회");
		return mapper.read(bno);
	}

	/*
	@Override
	public List<BoardVO> getList() {
		log.info("[ Service ] 게시글 목록 조회");
		
		return mapper.getList();
	}
	*/
	
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public boolean modify(BoardVO board) {
		log.info("[ Service ] 게시글 수정");

		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("[ Service ] " + bno + "번 글 삭제");
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
}
