package org.sample.service;

import java.util.List;

import org.sample.domain.Criteria;
import org.sample.domain.ReplyPageDTO;
import org.sample.domain.ReplyVO;

/* 메서드 설계 시 메서드 이름은 현실적인 로직의 이름을 붙이는 것이 관례 */

public interface ReplyService {

	public int register(ReplyVO reply);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO reply);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri, Long bno);

	public ReplyPageDTO getListWithPaging(Criteria cri, Long bno);
	
}
