package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.CategoryType;

/**
 * 类CategoryTypeService.java的实现描述： categorytype 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:19
 */
public interface CategoryTypeService {

	/**
	 * 获取categorytype集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:09
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return Page<CategoryType>
	 */
	public Page<CategoryType> getCategoryTypeList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) ;


	/**
	 * 获取CategoryType集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:37
	 * @return
	 */
	public List<CategoryType> getList() ;

	/**
	 * 更新CategoryType对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:55
	 * @param categoryType
	 */
	public void SaveOrUpdate(CategoryType categoryType);

	/**
	 * 删除CategoryType对象。逻辑删除，状态设为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:10
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	/**
	 * 根据字典值获取字典项集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:34
	 * @param value
	 * @return
	 */
	public List<CategoryType> getCategoryTypeByValue(String value);
}
