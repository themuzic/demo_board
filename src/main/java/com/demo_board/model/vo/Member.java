package com.demo_board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private String email;
	private String pwd;
	private String name;
	private String birth;
	private String phone;
	private String gender;
	private String base;
	private String status;
	private Date enroll_date;
	private Date out_date;
	
	public Member(String email, String pwd, String name, String birth, String phone, String gender, String base) {
		super();
		this.email = email;
		this.pwd = pwd;
		this.name = name;
		this.birth = birth;
		this.phone = phone;
		this.gender = gender;
		this.base = base;
	}
}
