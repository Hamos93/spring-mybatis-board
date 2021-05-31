package org.sample.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.sample.domain.Criteria;
import org.sample.domain.ReplyVO;

public interface ReplyMapper {

	/* [ Create ] */
	public int insert(ReplyVO reply);

	/* [ Read ] */
	public ReplyVO read(Long rno);

	/* [ Update ] */
	public int update(ReplyVO reply);

	/* [ Delete ] */
	public int delete(Long rno);

	/* 댓글의 목록과 페이징 처리 */
	// MyBatis에서 두 개 이상의 데이터를 파라미터로 전달하기 위해 @Param을 이용
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);

	/* 해당 게시물의 전체 댓글 수 */
	public int getCountByBno(Long bno);
	
}
