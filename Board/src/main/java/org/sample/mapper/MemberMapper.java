package org.sample.mapper;

import org.sample.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
}
