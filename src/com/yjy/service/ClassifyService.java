package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Classify;

/**
 * 分类
 * 
 * @author liping
 * 
 */
public interface ClassifyService {
	/**
	 * 分类
	 * 
	 * @param sesrchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Classify> getClassifyList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType);

	/**
	 * 获得分类的集合
	 * 
	 * @return
	 */
	public List<Classify> getList(String name);

	/**
	 * 获得分类的集合
	 * 
	 * @return
	 */
	public List<Classify> getListPid(String name);

	/**
	 * 更新对象
	 * 
	 * @param classify
	 */
	public void SaveOrUpdate(Classify classify);

	/**
	 * 删除对象
	 * 
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	/**
	 * 删除zi对象
	 * 
	 * @param ids
	 * @return
	 */
	public boolean deleteByPid(String ids);

	/**
	 * 根据某个值获取类集合
	 * 
	 * @param value
	 * @return
	 */
	public List<Classify> getClassifyByValue(String value);

	/**
	 * 根据pid值获取类集合
	 * 
	 * @param value
	 * @return
	 */
	public List<Classify> getClassifyListByPid(Long pid);

	/**
	 * 根据id值获取类集合
	 * 
	 * @param value
	 * @return
	 */
	public List<Classify> findClassifyByid(Long pid);

	/***************************/
	public Classify get(Long id);

	public List<Classify> getAllSubClassify();
}
