package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.CategoryType;
import com.yjy.entity.CategoryValue;
import com.yjy.repository.CategoryTypeDao;
import com.yjy.repository.CategoryValueDao;
import com.yjy.service.CategoryValueService;
import com.yjy.utils.Util;

/**
 * 类CategoryValueService.java的实现描述：类管理categoryvalue的增删该查
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:24
 */
@Component
@Transactional
public class CategoryValueServiceImpl implements CategoryValueService{

	@Autowired
	private CategoryValueDao categoryValueDao;

	@Autowired
	private CategoryTypeDao categoryTypeDao;

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
			String sortType) {
		// Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<CategoryValue> spec = Util.buildSpecification(
				searchParams, CategoryValue.class);
		return categoryValueDao.findAll(spec, pageRequest);
	}

	/**
	 * 分页查询方法
	 * 
	 * @author zhangmengmeng
	 * @date 2015-3-28 下午3:43:27
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	/**
	 * 根据字典值，字典项id获取CategoryValue集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:12
	 * @param value
	 * @param cid
	 * @return
	 */
	public List<CategoryValue> getCategoryValueByValue(String value, Long cid) {
		return categoryValueDao.getCategoryValueByValue(value, cid);
	}

	/**
	 * 保存CategoryValue对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:45
	 * @param categoryValue
	 */
	public void SaveOrUpdate(CategoryValue categoryValue) {
		categoryValueDao.save(categoryValue);
	}

	/**
	 * 逻辑删除CategoryValue对象。状态设置为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:17:58
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			categoryValueDao.deleteCategoryValue(Long.parseLong(i));
		}
		return true;
	}

	/**
	 * 根据字典项的id删除字典值
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:18:14
	 * @param ids
	 * @return
	 */
	public boolean deleteCid(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			categoryValueDao.deleteCategoryCid(Long.parseLong(i));
		}
		return true;
	}

	/**
	 * 根据CategoryValue对象的id获取CategoryValue对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:00
	 * @param id
	 * @return
	 */
	public CategoryValue getCategoryValue(Long id) {
		return categoryValueDao.findOne(id);
	}

	/**
	 * 根据CategoryValue父节点获取子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:39
	 * @param pid
	 * @param state
	 * @return
	 */
	public List<CategoryValue> getCategoryValueListByPid(Long pid, int state) {
		return categoryValueDao.getCategoryValueListByPid(pid, state);
	}

	/**
	 * 根据父字典对象id删除子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:19:19
	 * @param ids
	 * @return
	 */
	public boolean deleteByPid(String ids) {
		String[] id = ids.split("\\|");
		boolean result = false;
		for (String i : id) {
			result = deleteCategoryByPid(Long.parseLong(i));
		}
		return result;
	}

	/**
	 * 根据父节点删除子节点对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:20:11
	 * @param pid
	 * @return
	 */
	public boolean deleteCategoryByPid(Long pid) {
		List<CategoryValue> values = categoryValueDao
				.getCategoryValueListByPid(pid, 0);
		for (CategoryValue c : values) {
			c.setState(1);
			categoryValueDao.save(c);
			deleteCategoryByPid(c.getId());
		}
		return true;
	}

	/**
	 * 根据字典项的id获取字典值的对象集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:20:28
	 * @param cid
	 * @param state
	 * @return
	 */
	public List<CategoryValue> getCategoryValueListByCid(Long cid, int state) {
		return categoryValueDao.getCategoryValueListByCid(cid, state);
	}

	/**
	 * 根据key获得value，后台有些部分需要用到一些设置的数据，可以存放在字典表，然后根据此方法来根据key获取value
	 * 
	 * @author yjg
	 * @date 2015-4-14 上午9:31:11
	 * @param key
	 * @return
	 */
	public String getValueByKey(String key) {
		List<CategoryType> categoryTypeList = categoryTypeDao.findByValue(key);
		if (categoryTypeList == null) {
			return null;
		}
		Long cid = categoryTypeList.get(0).getId();
		List<CategoryValue> categoryValueList = categoryValueDao
				.getCategoryValueListByCid(cid, 0);
		if (categoryValueList == null) {
			return null;
		}
		return categoryValueList.get(0).getValue();
	}
}
