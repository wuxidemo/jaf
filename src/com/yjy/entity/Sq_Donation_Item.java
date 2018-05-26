package com.yjy.entity;

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
 * 捐赠所有物品
 * @author liping
 *
 */
@Entity
@Table(name="sq_donation_item")
public class Sq_Donation_Item {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private String name;//名称
	private Integer count;//数量
	private Long donationid;//捐赠编号
	/*@JoinColumn(name="donationid")
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private Sq_Donation sq_Donation;*/
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
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Long getDonationid() {
		return donationid;
	}
	public void setDonationid(Long donationid) {
		this.donationid = donationid;
	}

	
}
