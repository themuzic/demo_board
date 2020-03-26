package com.demo_board.model.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.demo_board.model.domain.Member;
import com.demo_board.model.domain.MemberRepository;

@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberRepository memberRepository; 
	
	private List<Member> memberList = new ArrayList<>();
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/write")
	public String writeForm(){
		return "/write-form/write-form";
	}
	
	@PostMapping("/join")
	public String join(Member member) {
		System.out.println(member);
		memberRepository.save(member);
		return "/modal/join";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session, Member member) {
		Member loginUser = memberRepository.findByEmailAndPwd(member.getEmail(), member.getPwd());
		if(loginUser != null) {
			session.setAttribute("loginUser", loginUser);
			System.out.println(loginUser);
			System.out.println("로그인성공");
		}
		return "/index";
	}
	
	@GetMapping("/logout")
	public String logout(SessionStatus status) {	// SessionStatus : 세션의 상태를 관리하는 객체
		status.setComplete();
		return "/index";
	}
	
}
