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

/**
 * 分类
 * @author liping
 *
 */
@Entity
@Table(name="classify")
public class Classify {
	   @Id
	   @GeneratedValue(strategy=GenerationType.IDENTITY)
       private Long id;
       private String name;
       private Date createtime;
       @JoinColumn(name="createid")
       @ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
       private User user;
       private Long pid;
       
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
    public void SaveOrUpdate(Classify classify){
    	
    }  
}
