package com.demo_board.model.domain;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long>{
	
	Page<Board> findBybTitleContaining(String bTitle, Pageable pageable);
	Page<Board> findBywNameContaining(String wName, Pageable pageable);
	Page<Board> findBybContentContaining(String bContent, Pageable pageable);
}
