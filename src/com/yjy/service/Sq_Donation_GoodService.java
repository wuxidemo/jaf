package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Community;
import com.yjy.entity.Sq_Donation_Good;

/**
 * 类Sq_Donation_GoodService.java的实现描述：Sq_Donation_Good下的增删改查操作
 *
 */
public interface Sq_Donation_GoodService {

	/**
	 * 获取Sq_Donation_Good集合，分页
	 * 
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Sq_Donation_Good> getSq_Donation_GoodServiceList(Map<String, Object> params, int pageNumber,
			int pageSize, String sortType);

	/**
	 * 根据id获取相应的Sq_Donation_Good
	 * 
	 * @param id
	 * @return
	 */
	public Sq_Donation_Good getSq_Donation_GoodById(Long id);

	/**
	 * 保存
	 * 
	 * @param sq_Donation_Good
	 * @return
	 */
	public Sq_Donation_Good save(Sq_Donation_Good sq_Donation_Good);

	/**
	 * 删除
	 * 
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	/**
	 * 
	 * 根据社区ID查询商品
	 * 
	 * @author lyf
	 * @date 2016年3月28日 上午9:03:51
	 * @param comid
	 * @return
	 */
	public List<Sq_Donation_Good> getListByComid(Long comid);
	/**
	 * 根据编号查询
	 * @param num
	 * @return
	 */
	public Sq_Donation_Good getSqDonatioGoodnByNum(String num);
	
	/*以下物品记录*/
	public Page<Object[]> getSq_Donation_Goods(Map<String,Object> searchParams,int pageNumber,int pageSize,String sortType,Community c);
	
	public List<Object[]> getSq_Donation_GoodById1(Long id);
}
