package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Community;
import com.yjy.entity.SqGiftRecord;

/**
 * 类SqGiftRecordService.java的实现描述：SqGiftRecord下的增删改查操作
 *
 */
public interface SqGiftRecordService {
	public Page<Object[]> getSqGiftRecordList(Map<String, Object> params, int pageNumber, int pageSize, String sortType,
			Community c);

	/**
	 * 根据id查询对象
	 * 
	 * @param id
	 * @return
	 */
	public SqGiftRecord getSqGiftRecordById(Long id);

	/**
	 * 添加
	 * 
	 * @param volunteer
	 * @return
	 */
	public SqGiftRecord save(SqGiftRecord s);

	/**
	 * 删除
	 * 
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	public SqGiftRecord getSqGiftRecordByNum(String num);

	public List<SqGiftRecord> getSqGiftRecordByComid(Long comid);

	public List<SqGiftRecord> getSqDonationByPhoneNo(String phoneno);

	/**
	 * 物品赠予记录一共捐赠了几件物品
	 * 
	 * @param params
	 * @param c
	 * @return
	 */
	public Integer getGiftCountByParam(Map<String, Object> params, Community c);
}
