package com.yjy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Sq_Donation_Item;
import com.yjy.repository.Sq_Donation_ItemDao;
import com.yjy.service.Sq_Donation_ItemService;

@Component
@Transactional
public class Sq_Donation_ItemServiceImpl implements Sq_Donation_ItemService {

	@Autowired
	private Sq_Donation_ItemDao sq_Donation_ItemDao;

	@Override
	public Sq_Donation_Item save(Sq_Donation_Item s) {
		return sq_Donation_ItemDao.save(s);
	}

	@Override
	public boolean delete(Long id) {
		sq_Donation_ItemDao.delete(id);
		return true;
	}

	@Override
	public List<Sq_Donation_Item> getSq_Donation_ItemBydonation(Long donationid) {
		return sq_Donation_ItemDao.getSq_Donation_ItemBydonation(donationid);
	}

}
