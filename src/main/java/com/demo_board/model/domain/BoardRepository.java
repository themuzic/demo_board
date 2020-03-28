package com.demo_board.model.domain;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BoardRepository extends JpaRepository<Board, Long>{
	@Modifying(clearAutomatically = true, flushAutomatically = true)
//	@Transactional 
	@Query(value="UPDATE Board b SET b.b_title = :#{#paramBoard.bTitle}, b.b_content = :#{#paramBoard.bContent} WHERE b.b_no = :#{#paramBoard.bNo}", nativeQuery = true)
	int updateBTitleAndBContent(@Param("paramBoard") Board board);
}
