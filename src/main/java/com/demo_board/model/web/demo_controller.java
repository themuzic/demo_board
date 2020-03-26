package com.demo_board.model.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class demo_controller {
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/write")
	public String writeForm(){
		return "/write-form/write-form";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/modal/join";
	}
	
}
