package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.CategoryValue;

/**
 * 类CategoryValueService.java的实现描述：类管理categoryvalue的增删该查
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:24
 */
public interface CategoryValueService {


	/**
	 * 获取categoryvalue集合 分页查询
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:09
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return Page<CategoryType>
	 */
	public Page<CategoryValue> getCategoryValueList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);


	/**
	 * 根据字典值，字典项id获取CategoryValue集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:12
	 * @param value
	 * @param cid
	 * @return
	 */
	public List<CategoryValue> getCategoryValueByValue(String value, Long cid) ;

	/**
	 * 保存CategoryValue对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:45
	 * @param categoryValue
	 */
	public void SaveOrUpdate(CategoryValue categoryValue);

	/**
	 * 逻辑删除CategoryValue对象。状态设置为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:58
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) ;

	/**
	 * 根据字典项的id删除字典值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:18:14
	 * @param ids
	 * @return
	 */
	public boolean deleteCid(String ids);

	/**
	 * 根据CategoryValue对象的id获取CategoryValue对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:00
	 * @param id
	 * @return
	 */
	public CategoryValue getCategoryValue(Long id) ;

	/**
	 * 根据CategoryValue父节点获取子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:39
	 * @param pid
	 * @param state
	 * @return
	 */
	public List<CategoryValue> getCategoryValueListByPid(Long pid, int state);

	/**
	 * 根据父字典对象id删除子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:19
	 * @param ids
	 * @return
	 */
	public boolean deleteByPid(String ids);

	/**
	 * 根据父节点删除子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:20:11
	 * @param pid
	 * @return
	 */
	public boolean deleteCategoryByPid(Long pid) ;

	/**
	 * 根据字典项的id获取字典值的对象集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:20:28
	 * @param cid
	 * @param state
	 * @return
	 */
	public List<CategoryValue> getCategoryValueListByCid(Long cid, int state) ;

	/**
	 * 根据key获得value，后台有些部分需要用到一些设置的数据，可以存放在字典表，然后根据此方法来根据key获取value
	 * 
	 * @author yjg
	 * @date 2015-4-14 上午9:31:11
	 * @param key
	 * @return
	 */
	public String getValueByKey(String key);
}
