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
public class File {
	
	private int f_no;
	private int b_no;
	private String path;
	private String origin_name;
	private String change_name;
	private Date f_date;
	private Date f_modify_date;
	private String f_status;
	
	public File(int f_no, int b_no, String path, String origin_name, String change_name) {
		super();
		this.f_no = f_no;
		this.b_no = b_no;
		this.path = path;
		this.origin_name = origin_name;
		this.change_name = change_name;
	}
}
