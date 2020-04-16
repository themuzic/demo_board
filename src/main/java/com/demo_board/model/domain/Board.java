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
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
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
	private Long boardNo;
	@Column(nullable = false, name="b_title")
	private String boardTitle;
	@Column(nullable = false, name="w_id")
	private Long writerId;
	@Column(nullable = false, name="w_name")
	private String writerName;
	@Column(nullable = false, name="b_content")
	@Lob
	private String boardContent;
	@Column(nullable = false, name="b_date")
	private LocalDateTime boardDate;
	@Column(nullable = false, name="b_file")
	private String boardFile;
	@Column(nullable = false, name="b_like")
	private Long boardLike;
	@Column(nullable = false, name="b_view_cnt")
	private Long boardViewCnt;
	@Column(nullable = false, name="b_reply")
	private Long boardReply;
	@Column(nullable = false, name="b_status")
	private String boardStatus;
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.boardDate = LocalDateTime.parse(now.format(dateTimeFormatter),dateTimeFormatter);
		this.boardFile = this.boardFile == null ? "N" : "Y";
		this.boardLike = this.boardLike == null ? 0 : this.boardLike;
		this.boardReply = this.boardReply == null ? 0 : this.boardReply;
		this.boardViewCnt = 0l;
		this.boardStatus = "Y";
	}
}
