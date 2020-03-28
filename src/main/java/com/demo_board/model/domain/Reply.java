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
	private Long rNo;
	@Column(nullable = false, name = "b_no")
	private Long bNo;
	@Column(nullable = false, name = "w_id")
	private Long wId;
	@Column(nullable = false, name = "w_name")
	private String wName;
	@Column(nullable = false, name = "r_content")
	private String rContent;
	@Column(nullable = false, name = "r_date")
	private LocalDateTime rDate;
	@Column(nullable = false, name = "r_status")
	private String rStatus;
	@Column(nullable = false, name = "r_level")
	private int rLevel;
	@Column(name = "rr_no")
	private Long rrNo;
	
	public Reply(Long bNo, Long wId, String wName, String rContent, LocalDateTime rDate, String rStatus,
			int rLevel) {
		super();
		this.bNo = bNo;
		this.wId = wId;
		this.wName = wName;
		this.rContent = rContent;
		this.rDate = rDate;
		this.rStatus = rStatus;
		this.rLevel = rLevel;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.rDate = LocalDateTime.parse(now.format(dateTimeFormatter),DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		this.rStatus = "Y";
	}
	
}
