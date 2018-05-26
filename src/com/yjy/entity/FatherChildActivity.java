package com.yjy.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "fatherchildactivity")
public class FatherChildActivity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private Long fatherid;
	private Long childid;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getFatherid() {
		return fatherid;
	}
	public void setFatherid(Long fatherid) {
		this.fatherid = fatherid;
	}
	public Long getChildid() {
		return childid;
	}
	public void setChildid(Long childid) {
		this.childid = childid;
	}

	
}
