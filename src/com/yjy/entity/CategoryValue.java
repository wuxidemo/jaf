package com.yjy.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 类CategoryValue.java的实现描述：CategoryValue实体类
 * @author zhangmengmeng 2015-3-28 下午3:26:19
 */
@Entity
@Table(name="categoryvalue")
public class CategoryValue {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String value;
	private Date createtime;
	@JoinColumn(name="createid")
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	private User user;
	
	@ManyToOne(cascade = CascadeType.REFRESH,fetch=FetchType.LAZY)
	@JoinColumn(name="pid")
	@JsonIgnore
	private CategoryValue categoryValue;
	
	
	@ManyToOne(cascade = CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="cid")
	private CategoryType categoryType;
	
	private Integer state;
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public CategoryValue getCategoryValue() {
		return categoryValue;
	}


	public void setCategoryValue(CategoryValue categoryValue) {
		this.categoryValue = categoryValue;
	}


	public CategoryType getCategoryType() {
		return categoryType;
	}


	public void setCategoryType(CategoryType categoryType) {
		this.categoryType = categoryType;
	}

}


