package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MyVolunteerDao;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Community;
import com.yjy.entity.Volunteer;
import com.yjy.repository.VolunteerDao;
import com.yjy.service.VolunteerService;

@Component
@Transactional
public class VolunteerServiceImpl implements VolunteerService{

	@Autowired
	private VolunteerDao volunteerDao;
	
	@Autowired
	private MyVolunteerDao myVolunteerDao;
	
	@Override
	public PageImpl<Object[]> getVolunteerList(Map<String, Object> params, int pageNumber, int pageSize, String sortType,List<CategoryValue>  keywordlist,Community c) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myVolunteerDao.getVolunteerListByParam(params, pageNumber, pageSize, order, keywordlist,c),pageRequest,myVolunteerDao.getVolCountByParam(params,keywordlist,c));
	}
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	/*public Page<Volunteer> getVolunteerList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest=buildPageRequest(pageNumber,pageSize,sortType);
		Specification<Volunteer> spec=Util.buildSpecification(searchParams, Volunteer.class);
		return volunteerDao.findAll(spec, pageRequest);
	}*/

	/*private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort=null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC, "id");
		}else if("createtime".equals(sortType)){
			sort=new Sort(Direction.DESC,"createtime");
		}
		return new PageRequest(pageNumber-1, pageSize, sort);
	}*/

	@Override
	public Volunteer getVolunteerById(Long id) {
		return volunteerDao.getVolunteerById(id);
	}

	@Override
	public Volunteer getVolunteerByOpenid(String openid) {
		// TODO Auto-generated method stub
		return volunteerDao.getVolunteerByOpenid(openid);
	}

	@Override
	public Volunteer save(Volunteer volunteer) {
		return volunteerDao.save(volunteer);
	}

	@Override
	public List<Object[]> getVolunteerListDataByParam(Map<String, Object> searchParams, int start, int size) {
		// TODO Auto-generated method stub
		return myVolunteerDao.getVolunteerListData(searchParams, start, size);
	}

	@Override
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			volunteerDao.delete(Long.parseLong(i));
		}
		return true;
	}
	@Override
	public List<Object[]> getVolunteerDetail(Long id) {
		// TODO Auto-generated method stub
		return myVolunteerDao.getVolunteerDetail(id);
	}
	
	@Override
	public List<Object[]> getVolunteerDetail2(Long id) {
		// TODO Auto-generated method stub
		return myVolunteerDao.getVolunteerDetail2(id);
	}
	@Override
	public List<Volunteer> getVolunteersByOpenid(String openid) {
		// TODO Auto-generated method stub
		return volunteerDao.getVolunteersByOpenid(openid);
	}



}
