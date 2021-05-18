package org.sample.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/* 페이징 처리 클래스 */

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;
	private int amount;
	
	public Criteria() {
		this.pageNum = 1;
		this.amount = 10;
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
