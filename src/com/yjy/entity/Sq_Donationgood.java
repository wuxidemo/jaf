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
 * 捐献的物品和捐赠之间的关系
 *
 */
@Entity
@Table(name="sq_donationgood")
public class Sq_Donationgood {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@JoinColumn(name="donationid")
	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	private Sq_Donation sq_Donation;
	@JoinColumn(name="goodid")
	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	private Sq_Donation_Good sq_Donation_Good;
	private Integer count;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Sq_Donation getSq_Donation() {
		return sq_Donation;
	}
	public void setSq_Donation(Sq_Donation sq_Donation) {
		this.sq_Donation = sq_Donation;
	}
	public Sq_Donation_Good getSq_Donation_Good() {
		return sq_Donation_Good;
	}
	public void setSq_Donation_Good(Sq_Donation_Good sq_Donation_Good) {
		this.sq_Donation_Good = sq_Donation_Good;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
}
