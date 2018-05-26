package com.yjy.service;

import java.util.List;

import com.yjy.entity.Sq_Gift_Item;

public interface Sq_Gift_ItemService {

	/**
	 * 添加赠予物品
	 * 
	 * @param s
	 * @return
	 */
	public Sq_Gift_Item save(Sq_Gift_Item s);

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
	public List<Sq_Gift_Item> getSq_Gift_ItemByGift(Long giftid);
}
