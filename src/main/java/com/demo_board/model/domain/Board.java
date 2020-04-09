package com.demo_board.model.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
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
	@Column(name="b_no")
	private Long bNo;
	@Column(nullable = false, name="b_title")
	private String bTitle;
	@Column(nullable = false, name="w_id")
	private Long wId;
	@Column(nullable = false, name="w_name")
	private String wName;
	@Column(nullable = false, name="b_content")
	@Lob
	private String bContent;
	@Column(nullable = false, name="b_date")
	private LocalDateTime bDate;
	@Column(nullable = false, name="b_file")
	private String bFile;
	@Column(nullable = false, name="b_like")
	private Long bLike;
	@Column(nullable = false, name="b_view_cnt")
	private Long bViewCnt;
	@Column(nullable = false, name="b_reply")
	private Long bReply;
	@Column(nullable = false, name="b_status")
	private String bStatus;
	
	public Board(String bTitle, Long wId, String wName, String bContent) {
		super();
		this.bTitle = bTitle;
		this.wId = wId;
		this.wName = wName;
		this.bContent = bContent;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.bDate = LocalDateTime.parse(now.format(dateTimeFormatter),dateTimeFormatter);
		this.bFile = this.bFile == null ? "N" : "Y";
		this.bLike = this.bLike == null ? 0 : this.bLike;
		this.bReply = this.bReply == null ? 0 : this.bReply;
		this.bViewCnt = 0l;
		this.bStatus = "Y";
	}
}
