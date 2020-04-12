package com.demo_board.model.domain;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long>{
	Page<Board> findByBoardStatus(String boardStatus, Pageable pageable);
	Page<Board> findByBoardTitleContainingAndBoardStatusLike(String boardTitle, String boardStatus, Pageable pageable);
	Page<Board> findByWriterNameContainingAndBoardStatusLike(String writerName, String boardStatus, Pageable pageable);
	Page<Board> findByBoardContentContainingAndBoardStatusLike(String boardContent, String boardStatus, Pageable pageable);
	
	
}
