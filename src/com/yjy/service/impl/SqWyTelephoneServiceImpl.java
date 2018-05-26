package com.yjy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Sq_Wy_Telephone;
import com.yjy.repository.SqWyTelephoneDao;
import com.yjy.service.SqWyTelephoneService;
@Component
@Transactional
public class SqWyTelephoneServiceImpl implements SqWyTelephoneService{
	
	@Autowired
	private SqWyTelephoneDao sqWyTelephoneDao;

	@Override
	public Sq_Wy_Telephone save(Sq_Wy_Telephone sq_Wy_Telephone) {
		// TODO Auto-generated method stub
		return sqWyTelephoneDao.save(sq_Wy_Telephone);
	}

	@Override
	public Sq_Wy_Telephone get(Long id) {
		// TODO Auto-generated method stub
		return sqWyTelephoneDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sqWyTelephoneDao.delete(id);
	}

	@Override
	public List<Sq_Wy_Telephone> getListByOpenid(String openid) {
		// TODO Auto-generated method stub
		return sqWyTelephoneDao.getListByOpenid(openid);
	}

	@Override
	public List<Sq_Wy_Telephone> getListByTelephone(String telephone) {
		// TODO Auto-generated method stub
		return sqWyTelephoneDao.getListByTelephone(telephone);
	}

	@Override
	public int getCountByOpenid(String openid) {
		// TODO Auto-generated method stub
		return sqWyTelephoneDao.getCountByOpenid(openid);
	}
}
