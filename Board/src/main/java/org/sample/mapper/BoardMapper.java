package org.sample.mapper;

import java.util.List;

import org.sample.domain.BoardVO;
import org.sample.domain.Criteria;

public interface BoardMapper {
	
	/* [ Create ] */
	// 1. insert만 처리되고 생성된 PK 값을 알 필요가 없는 경우
	public void insert(BoardVO board);

	// 2. insert문이 실행되고 생성된 PK 값을 알아야 하는 경우
	public void insertSelectKey(BoardVO board);

	/* [ Read ] */
	// @Select("select * from TBL_BOARD")
	public List<BoardVO> getList();	
	
	public List<BoardVO> getListWithPaging(Criteria cri);

	public BoardVO read(Long bno);

	/* [ Update ] */
	public int update(BoardVO board);
	
	/* [ delete ] */
	public int delete(Long bno);

}
