package com.yjy.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.FatherChildActivity;
import com.yjy.repository.FatherChildActivityDao;
import com.yjy.service.FatherChildActivityService;

@Component
@Transactional
public class FatherChildActivityServiceImpl implements FatherChildActivityService {
	
	@Autowired
	private FatherChildActivityDao fatherChildActivityDao;

	@Override
	public FatherChildActivity save(FatherChildActivity fatherChildActivity) {
		// TODO Auto-generated method stub
		return fatherChildActivityDao.save(fatherChildActivity);
	}

	@Override
	public FatherChildActivity get(Long id) {
		// TODO Auto-generated method stub
		return fatherChildActivityDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		fatherChildActivityDao.delete(id);
	}

	@Override
	public List<FatherChildActivity> findByFatherid(Long id) {
		// TODO Auto-generated method stub
		return fatherChildActivityDao.findByFatherid(id);
	}

	@Override
	public List<FatherChildActivity> findByChildid(Long id) {
		// TODO Auto-generated method stub
		return fatherChildActivityDao.findByChildid(id);
	}

	
}

