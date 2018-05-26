package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Advert;

/**
 * 类AdvertService.java的实现描述：Advert 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-6-16 下午2:10:48
 */
public interface AdvertService {


	/**
	 * 更新保存信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午2:31:52
	 * @param advert
	 */
	public void SaveOrUpdate(Advert advert);

	/**
	 * 删除信息
	 * 
	 * @author zhangmengmeng
	 * @date 2015-6-16 下午2:32:03
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	public List<Advert> getListTitle(String type);
	public List<Advert> getList(String type) ;
	public Advert findOne(String id);

	public Page<Advert> getAdvertList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) ;
	
	
	/*********************************************/

	public List<Advert> getAdListByType(String type);
}
