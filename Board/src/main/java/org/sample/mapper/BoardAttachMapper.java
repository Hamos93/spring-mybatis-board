package org.sample.mapper;

import java.util.List;

import org.sample.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);

	public void deleteAll(Long bno);
}
