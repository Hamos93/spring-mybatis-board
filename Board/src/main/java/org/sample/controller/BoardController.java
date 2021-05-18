package org.sample.controller;

import org.sample.domain.BoardVO;
import org.sample.domain.Criteria;
import org.sample.domain.PageDTO;
import org.sample.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller // 스프링의 빈으로 인식
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	/* [ 의존성 주입 ] */
	// BoardController는 BoardService에 대해서 의존적
	// 필드 주입
	@Autowired
	BoardService service;

	// POST방식 후 처리 -> RedirectAttributes 객체를 이용하여 목록화면으로 이동
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("[ Controller ] register() 호출: " + board);

		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("[ Controller ] list() 호출");

		model.addAttribute("list", service.getListWithPaging(cri));
		
		// PageDTO를 Model에 담아 화면에 전달
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("[ Controller ] get() 호출");

		// ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담음
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("[ Controller ] modify() 호출");
		
		if(service.modify(board))
			rttr.addFlashAttribute("result", "success");
	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("[ Controller ] remove() 호출");
		
		if(service.remove(bno))
			rttr.addFlashAttribute("result", "success");
	
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
}
