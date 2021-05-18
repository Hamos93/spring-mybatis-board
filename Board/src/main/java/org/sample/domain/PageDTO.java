package org.sample.domain;

import lombok.Getter;
import lombok.ToString;

/* 페이징 처리를 위한 클래스 */
@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private int total;
	private int realEnd;
	
	private boolean prev;
	private boolean next;
	
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		// 끝 페이지, 시작 페이지 번호 계산
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		// 전체 페이지 끝 번호 계산
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) 
			this.endPage = realEnd;

		// 이전 버튼
		this.prev = this.startPage > 1;
		
		// 다음 버튼
		this.next = this.endPage < realEnd;
	}
	
}
