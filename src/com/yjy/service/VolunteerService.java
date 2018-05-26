package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.CategoryValue;
import com.yjy.entity.Community;
import com.yjy.entity.Volunteer;

/**
 * 类VolunteerService.java的实现描述：Volunteer下的增删改查操作
 *
 */

public interface VolunteerService {

	/**
	 * 获取Volunteer集合，分页
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	/* public Page<Volunteer> getVolunteerList(Map<String,Object> searchParams,int pageNumber,int pageSize,String sortType);*/
	public Page<Object[]> getVolunteerList(Map<String, Object> params,int pageNumber, int pageSize, String sortType,List<CategoryValue>  keywordlist,Community c);
	 /**
	  * 根据id查询对象
	  * @param id
	  * @return
	  */
	 public Volunteer getVolunteerById(Long id);
	 /**
	  * 根据openid获取志愿者
	  * @param openid
	  * @return
	  */
	 public Volunteer getVolunteerByOpenid(String openid);
	 /**
	  * 添加
	  * @param volunteer
	  * @return
	  */
	 public Volunteer save(Volunteer volunteer);
	 
	 
	 
	 public List<Object[]> getVolunteerListDataByParam(Map<String, Object> searchParams, int start, int size);
	 /**
	  * 删除
	  * @param ids
	  * @return
	  */
	 public boolean delete(String ids) ;
	 
	 public List<Object[]> getVolunteerDetail(Long id);
	 
	 public List<Object[]> getVolunteerDetail2(Long id);
	 
	 public List<Volunteer> getVolunteersByOpenid(String openid);
	
}
