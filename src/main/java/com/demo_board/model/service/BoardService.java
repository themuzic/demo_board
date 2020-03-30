package com.demo_board.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.demo_board.model.domain.Board;
import com.demo_board.model.domain.BoardRepository;

@Service("boardService")
public class BoardService {
	@Autowired
	private BoardRepository boardRepository;
	
	public ModelAndView boardPaging(int pageNum, ModelAndView mv) {
		Pageable pageable = PageRequest.of(pageNum, 10, Direction.DESC, "bDate");
		Page<Board> boardList = boardRepository.findAll(pageable);
		int startPage = pageNum/5+1;
		int lastPage = pageNum/5+5;
		int totalPages = boardList.getTotalPages();
		mv.addObject("boardList", boardList.getContent());
		mv.addObject("getNumber", boardList.getNumber());
		mv.addObject("prevPage", boardList.previousPageable());
		mv.addObject("nextPage", boardList.nextPageable());
		mv.addObject("getTotalPages", totalPages);
		mv.addObject("getNumber", boardList.getNumber());
		mv.addObject("getNumberOfElements", boardList.getNumberOfElements());
		mv.addObject("getSize", boardList.getSize());
		mv.addObject("isFirst", boardList.isFirst());
		mv.addObject("startPage", startPage);
		mv.addObject("lastPage", lastPage < totalPages ? lastPage : totalPages);
		mv.addObject("isLast", boardList.isLast());
		return mv;
	}

}
