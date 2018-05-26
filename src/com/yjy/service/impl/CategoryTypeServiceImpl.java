package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import com.yjy.entity.CategoryType;
import com.yjy.repository.CategoryTypeDao;
import com.yjy.service.CategoryTypeService;
import com.yjy.utils.Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * 类CategoryTypeService.java的实现描述： categorytype 进下增删改查操作
 * 
 * @author zhangmengmeng 2015-3-28 下午3:27:19
 */
@Component
// 类中所有public函数都纳入事务管理的标识.
@Transactional
public class CategoryTypeServiceImpl implements CategoryTypeService{
	@Autowired
	private CategoryTypeDao categoryTypeDao;

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
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<CategoryType> spec = Util.buildSpecification(
				searchParams, CategoryType.class);
		return categoryTypeDao.findAll(spec, pageRequest);
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
	 * 获取CategoryType集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:37
	 * @return
	 */
	public List<CategoryType> getList() {
		List<CategoryType> list = categoryTypeDao.getList();
		return list;
	}

	/**
	 * 更新CategoryType对象
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:15:55
	 * @param categoryType
	 */
	public void SaveOrUpdate(CategoryType categoryType) {
		categoryTypeDao.save(categoryType);
	}

	/**
	 * 删除CategoryType对象。逻辑删除，状态设为1
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:10
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			categoryTypeDao.deleteCategoryType(Long.parseLong(i));
		}
		return true;
	}

	/**
	 * 根据字典值获取字典项集合
	 * 
	 * @author zhangmengmeng
	 * @date 2015-4-9 下午3:16:34
	 * @param value
	 * @return
	 */
	public List<CategoryType> getCategoryTypeByValue(String value) {
		return categoryTypeDao.findByValue(value);
	}
}
