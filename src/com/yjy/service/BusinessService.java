package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Business;

/**
 * 类BusinessService.java的实现描述： Business 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:19
 */
public interface BusinessService {

	/**
	 * 获取Business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:09
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return Page<Business>
	 */
	public Page<Business> getBusinessList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);


	/**
	 * 获取Business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:37
	 * @return
	 */
	public List<Business> getList() ;
	/**
	 * 根据商圈名称，字典项id获取business集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:12
	 * @param value
	 * @param cid
	 * @return
	 */
	public List<Business> getBusinessByName(String value, Long cid) ;
	/**
	 * 更新Business对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:55
	 * @param Business
	 */
	public void SaveOrUpdate(Business Business) ;

	/**
	 * 删除Business对象。逻辑删除，状态设为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:10
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) ;
	
	public List<Business> getBusinessListByDistrictid(Long districtid) ;
	
	public Business get(Long id);

}
