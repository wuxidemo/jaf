package com.yjy.service;

import java.util.List;

import com.yjy.entity.Sq_Donation_Item;

public interface Sq_Donation_ItemService {

	/**
	 * 添加赠予物品
	 * 
	 * @param s
	 * @return
	 */
	public Sq_Donation_Item save(Sq_Donation_Item s);

	/**
	 * 删除赠予物品
	 * 
	 * @param id
	 * @return
	 */
	public boolean delete(Long id);

	/**
	 * 根据giftid查询
	 * 
	 * @param giftid
	 * @return
	 */
	public List<Sq_Donation_Item> getSq_Donation_ItemBydonation(Long donationid);
}
