package org.sample.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.sample.domain.BoardAttachVO;
import org.sample.domain.BoardVO;
import org.sample.domain.Criteria;
import org.sample.domain.PageDTO;
import org.sample.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) return;
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
			
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
			
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	// POST방식 후 처리 -> RedirectAttributes 객체를 이용하여 목록화면으로 이동
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		if(board.getAttachList() != null)
			board.getAttachList().forEach(attach -> log.info("첨부파일: " + attach));
		
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list", service.getListWithPaging(cri));
		
		// PageDTO를 Model에 담아 화면에 전달
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담음
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if(service.modify(board))
			rttr.addFlashAttribute("result", "success");
	
		// rttr.addAttribute("pageNum", cri.getPageNum());
		// rttr.addAttribute("amount", cri.getAmount());
		// rttr.addAttribute("type", cri.getType());
		// rttr.addAttribute("keyword", cri.getKeyword());

		// UriComponentsBuilder를 이용하는 링크 생성
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		// rttr.addAttribute("pageNum", cri.getPageNum());
		// rttr.addAttribute("amount", cri.getAmount());
		// rttr.addAttribute("type", cri.getType());
		// rttr.addAttribute("keyword", cri.getKeyword());
		
		// 1. 해당 게시물의 첨부파일 목록 준비
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		// 2. 데이터베이스 상에서 해당 게시물과 첨부파일 데이터 삭제
		if(service.remove(bno)) {
			// 3. 첨부파일 목록을 이용해서 해당 폴더에서 파일 삭제
			deleteFiles(attachList);
			
			rttr.addAttribute("result", "success");
		}
		
 		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

}
