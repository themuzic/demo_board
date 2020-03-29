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
		name="MEMBER_SEQ_GEN",			// 시퀀스 제네레이터 이름
		sequenceName = "MEMBER_SEQ",	// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class Member {
	@Id
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "MEMBER_SEQ_GEN"			// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private Long id;
	@Column(nullable = false)
	private String email;
	@Column(nullable = false)
	private String pwd;
	@Column(nullable = false)
	private String name;
	@Column(nullable = false)
	private String birth;
	@Column(nullable = false)
	private String phone;
	@Column(nullable = false)
	private String gender;
	@Column(nullable = false)
	private String base;
	@Column(nullable = false)
	private String status;
	@Column(nullable = false)
	private LocalDateTime enroll_date;
	private LocalDateTime out_date;
	
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
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		this.status = "Y";
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.enroll_date = LocalDateTime.parse(now.format(dateTimeFormatter),dateTimeFormatter);
		System.out.println(this);
	}
}
