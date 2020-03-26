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
		name="BOARD_SEQ_GEN",			// 시퀀스 제네레이터 이름
		sequenceName = "BOARD_SEQ",		// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class Board {
	@Id
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "BOARD_SEQ_GEN"				// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private Long b_no;
	@Column(nullable = false)
	private String b_title;
	@Column(nullable = false)
	private Long w_id;
	@Column(nullable = false)
	private String w_name;
	@Column(nullable = false)
	private String b_content;
	@Column(nullable = false)
	private LocalDate b_date;
	@Column(nullable = false)
	private String b_file;
	@Column(nullable = false)
	private Long b_like;
	@Column(nullable = false)
	private String b_status;
	
	public Board(Long b_no, String b_title, Long w_id, String w_name, String b_content) {
		super();
		this.b_no = b_no;
		this.b_title = b_title;
		this.w_id = w_id;
		this.w_name = w_name;
		this.b_content = b_content;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		this.b_date = LocalDate.now();
		this.b_file = this.b_file == null ? "N" : "Y";
		this.b_like = this.b_like == null ? 0 : this.b_like;
		this.b_status = "Y";
	}
}
