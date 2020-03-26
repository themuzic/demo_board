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
public class Board {
	
	private int b_no;
	private String b_title;
	private String w_email;
	private String w_name;
	private String b_content;
	private Date b_date;
	private String b_file;
	private int b_like;
	private String b_status;
	
	public Board(int b_no, String b_title, String w_email, String w_name, String b_content) {
		super();
		this.b_no = b_no;
		this.b_title = b_title;
		this.w_email = w_email;
		this.w_name = w_name;
		this.b_content = b_content;
	}
}
