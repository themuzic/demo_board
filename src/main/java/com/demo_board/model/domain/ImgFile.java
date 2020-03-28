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
		name="IMG_SEQ_GEN",				// 시퀀스 제네레이터 이름
		sequenceName = "IMG_SEQ",		// 시퀀스 이름
		initialValue = 1,				// 시작값
		allocationSize = 1				// 메모리를 통해 할당할 범위 사이즈
		)
public class ImgFile {
	@Id
	@Column(name = "img_no")
	@GeneratedValue(
			strategy = GenerationType.SEQUENCE,		// 사용할 전략을 시퀀으로 선택
			generator = "IMG_SEQ_GEN"				// 식별자 생성기를 만들어 놓은 시퀀스 제네레이터로 설정
			)
	private Long imgNo;
	@Column(nullable = false, name = "img_path")
	private String imgPath;
	@Column(nullable = false, name = "origin_img_name")
	private String originImgName;
	@Column(nullable = false, name = "change_img_name")
	private String changeImgName;
	@Column(nullable = false, name = "img_date")
	private LocalDateTime imgDate;
	@Column(nullable = false, name = "img_status")
	private String imgStatus;
	
	public ImgFile(String imgPath, String originImgName, String changeImgName) {
		super();
		this.imgPath = imgPath;
		this.originImgName = originImgName;
		this.changeImgName = changeImgName;
	}
	
	@PrePersist		// insert 되기 직전 호출 되는 어노테이션
	public void prePersist() {
		LocalDateTime now = LocalDateTime.now();  
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.imgDate = LocalDateTime.parse(now.format(dateTimeFormatter),DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		this.imgStatus = "Y";
	}
	
}
