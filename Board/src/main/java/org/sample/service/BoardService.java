package org.sample.service;

import java.util.List;

import org.sample.domain.BoardVO;

public interface BoardService {
	
	// 메서드 설계 시 메서드 이름은 현실적인 로직의 이름을 붙이는 것이 관례
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public List<BoardVO> getList();
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
}
