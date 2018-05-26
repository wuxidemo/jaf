package com.yjy.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Sort.Direction;

import com.yjy.entity.Classify;
import com.yjy.repository.ClassifyDao;
import com.yjy.service.ClassifyService;
import com.yjy.utils.Util;
/**
 * 类Classify的实现描述：classify进行增删改查操作
 * @author liping
 *
 */
@Component
//类中所有public函数都纳入事务管理的标识
@Transactional
public class ClassifyServiceImpl implements ClassifyService{
	@Autowired
	private ClassifyDao classifyDao;
	
	@Override
	/**
	 * 获取classify集合
	 */
	public Page<Classify> getClassifyList(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest=builPageRequest(pageNumber,pageSize,sortType);
		Specification<Classify> spec=Util.buildSpecification(searchParams, Classify.class);
		return classifyDao.findAll(spec,pageRequest);
	}
    /**
     * 分页查询方法
     * @param pageNumber
     * @param pageSize
     * @param sortType
     * @return
     */
	private PageRequest builPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort=null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC,"id");
		}else if("createtime".equals(sortType)){
			sort=new Sort(Direction.DESC,"createtime");
		}
		return new PageRequest(pageNumber-1,pageSize,sort);
	}

	@Override
	/**
	 * 获取Classify集合
	 */
	public List<Classify> getList(String name) {
		List<Classify> list=new ArrayList<Classify>();
		if(name==null||"".equals(name.trim())){
			list=classifyDao.getList();
		}else{
			list=classifyDao.getList1(name);
		}
		return list;
	}
	
	/**
	 * 获取Classify集合
	 */
	public List<Classify> getListPid(String name) {
		
		List<Classify> list=new ArrayList<Classify>();
		if(name==null||"".equals(name.trim())){
			list=classifyDao.getListPid();
		}else{
			list=classifyDao.getListPid1(name);
		}
		return list;
	}
	
	@Override
	/**
	 * 更新Classify对象
	 */
	public void SaveOrUpdate(Classify classify) {
		classifyDao.save(classify);
	}

	@Override
	public boolean delete(String ids) {
		String[] id=ids.split("\\|");
		for(String i:id){
			classifyDao.deleteClassify(Long.parseLong(i));
		}
		return true;
	}

	public boolean deleteByPid(String ids) {
		String[] id=ids.split("\\|");
		for(String i:id){
			classifyDao.deleteClassifyByPid(Long.parseLong(i));
		}
		return true;
	}
	
	@Override
	/**
	 * 根据值获取集合
	 */
	public List<Classify> getClassifyByValue(String value) {
		return classifyDao.findByValue(value);
	}
	
	/**
	 * 根据pid值获取集合
	 */
	public List<Classify> getClassifyListByPid(Long pid) {
		return classifyDao.ClassifyListByPid(pid);
	}
	
	/**
	 * 根据id值获取集合
	 */
	public List<Classify> findClassifyByid(Long id) {
		return classifyDao.findById(id);
	}
	@Override
	public Classify get(Long id) {
		// TODO Auto-generated method stub
		return classifyDao.findOne(id);
	}
	@Override
	public List<Classify> getAllSubClassify() {
		// TODO Auto-generated method stub
		return classifyDao.getAllSubClassify();
	}
}
