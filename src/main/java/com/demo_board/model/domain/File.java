package com.demo_board.model.domain;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.SequenceGenerator;

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
@Entity
@SequenceGenerator(
		name="FILE_SEQ_GEN",			// 시퀀스 제네레이터 이름
		sequenceName = "FILE_SEQ",		// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class File {
	@Id
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "FILE_SEQ_GEN"				// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private int f_no;
	@Column(nullable = false)
	private int b_no;
	@Column(nullable = false)
	private String path;
	@Column(nullable = false)
	private String origin_name;
	@Column(nullable = false)
	private String change_name;
	@Column(nullable = false)
	private LocalDate f_date;
	@Column(nullable = false)
	private LocalDate f_modify_date;
	@Column(nullable = false)
	private String f_status;
	
	public File(int f_no, int b_no, String path, String origin_name, String change_name) {
		super();
		this.f_no = f_no;
		this.b_no = b_no;
		this.path = path;
		this.origin_name = origin_name;
		this.change_name = change_name;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		this.f_date = LocalDate.now();
		this.f_modify_date = LocalDate.now();
		this.f_status = "Y";
	}
}
