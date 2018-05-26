package com.yjy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.Sq_Gift_Item;
import com.yjy.repository.Sq_Gift_ItemDao;
import com.yjy.service.Sq_Gift_ItemService;

@Component
@Transactional
public class Sq_Gift_ItemServiceImpl implements Sq_Gift_ItemService {

	@Autowired
	private Sq_Gift_ItemDao sq_Gift_ItemDao;

	@Override
	public Sq_Gift_Item save(Sq_Gift_Item s) {
		return sq_Gift_ItemDao.save(s);
	}

	@Override
	public boolean delete(Long id) {
		sq_Gift_ItemDao.delete(id);
		return true;
	}

	@Override
	public List<Sq_Gift_Item> getSq_Gift_ItemByGift(Long giftid) {
		return sq_Gift_ItemDao.getSq_Gift_ItemByGift(giftid);
	}

}
