package com.demo_board.model.domain;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long>{
	
	List<Board> findBybTitleContaining(String bTitle);
	List<Board> findBywNameContaining(String wName);
	List<Board> findBybContentContaining(String bContent);
}
