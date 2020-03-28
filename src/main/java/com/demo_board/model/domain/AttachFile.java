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
		name="FILE_SEQ_GEN",			// 시퀀스 제네레이터 이름
		sequenceName = "FILE_SEQ",		// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class AttachFile {
	@Id
	@Column(name = "f_no")
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "FILE_SEQ_GEN"				// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private int fNo;
	@Column(nullable = false, name = "b_no")
	private int bNo;
	@Column(nullable = false, name = "f_path")
	private String fPath;
	@Column(nullable = false, name = "origin_name")
	private String originName;
	@Column(nullable = false, name = "change_name")
	private String changeName;
	@Column(nullable = false, name = "f_date")
	private LocalDateTime fDate;
	@Column(nullable = false, name = "f_modify_date")
	private LocalDateTime fModifyDate;
	@Column(nullable = false, name = "f_status")
	private String fStatus;
	
	public AttachFile(String fPath, String originName, String changeName) {
		super();
		this.fPath = fPath;
		this.originName = originName;
		this.changeName = changeName;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.fDate = LocalDateTime.parse(now.format(dateTimeFormatter),DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		this.fModifyDate = LocalDateTime.parse(now.format(dateTimeFormatter),DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		this.fStatus = "Y";
	}
}
