package com.demo_board.model.domain;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;

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
@Embeddable
public class LikePK implements Serializable{
	private static final long serialVersionUID = 1L;
	@Column(name="b_no", nullable=false)
	private Long bNo;
	@Column(name="id", nullable=false)
	private Long id;
}
