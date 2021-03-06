package com.demo_board.model.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
		name="REPLY_SEQ_GEN",			// 시퀀스 제네레이터 이름
		sequenceName = "REPLY_SEQ",		// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class Reply {
	@Id
	@Column(name = "r_no")
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "REPLY_SEQ_GEN"				// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private Long replyNo;
	@Column(nullable = false, name = "b_no")
	private Long boardNo;
	@Column(nullable = false, name = "w_id")
	private Long writerId;
	@Column(nullable = false, name = "w_name")
	private String writerName;
	@Column(nullable = false, name = "r_content")
	private String replyContent;
	@Column(nullable = false, name = "r_date")
	private LocalDateTime replyDate;
	@Column(nullable = false, name = "r_status")
	private String replyStatus;
	@Column(nullable = false, name = "r_level")
	private int replyLevel;
	@Column(name = "rr_no")
	private Long rreplyNo;
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.replyDate = LocalDateTime.parse(now.format(dateTimeFormatter),dateTimeFormatter);
		this.replyStatus = "Y";
	}
	
}
