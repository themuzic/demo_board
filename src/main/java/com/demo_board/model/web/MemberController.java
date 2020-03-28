package com.demo_board.model.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.demo_board.model.domain.Board;
import com.demo_board.model.domain.BoardRepository;
import com.demo_board.model.domain.Member;
import com.demo_board.model.domain.MemberRepository;

@SessionAttributes("loginUser")
@Controller
public class MemberController {
	
	@Autowired
	private MemberRepository memberRepository; 
	@Autowired
	private BoardRepository boardRepository;
	
	private List<Member> memberList = new ArrayList<>();
	
	@GetMapping("/")
	public ModelAndView index(ModelAndView mv) {
		List<Board> boardList = boardRepository.findAll();
		Collections.reverse(boardList);
		mv.addObject("boardList", boardList);
		mv.setViewName("index");
		return mv;
	}
	
	@PostMapping("/join")
	public void join(Member member, HttpServletResponse response) {
		try {
			memberRepository.save(member);
			System.out.println("회원가입완료");
			response.sendRedirect("/");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/login")
	public void login(HttpSession session, Member member, HttpServletResponse response) {
		try {
			System.out.println("로그인 하러옴");
			Member loginUser = memberRepository.findByEmailAndPwd(member.getEmail(), member.getPwd());
			if(loginUser != null) {
				session.setAttribute("loginUser", loginUser);
//				System.out.println(loginUser);
				System.out.println("로그인성공");
			} else {
				System.out.println("로그인실패");
			}
			response.sendRedirect("/");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/logout")
	public void logout(SessionStatus status, HttpServletResponse response) {	// SessionStatus : 세션의 상태를 관리하는 객체
		try {
			status.setComplete();
			System.out.println("로그아웃");
			response.sendRedirect("/");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
