package com.demo_board.model.domain;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long>{
	
	Member findByEmailAndPwd(String email, String pwd);

}
