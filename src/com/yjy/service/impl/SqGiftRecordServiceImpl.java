package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MySqGiftRecordDao;
import com.yjy.entity.Community;
import com.yjy.entity.SqGiftRecord;
import com.yjy.repository.SqGiftRecordDao;
import com.yjy.service.SqGiftRecordService;

@Component
@Transactional
public class SqGiftRecordServiceImpl implements SqGiftRecordService {

	@Autowired
	private MySqGiftRecordDao mySqGiftRecordDao;
	@Autowired
	private SqGiftRecordDao sqGiftRecordDao;

	@Override
	public Page<Object[]> getSqGiftRecordList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id DESC";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(
				mySqGiftRecordDao.getSqGiftRecordData(searchParams, pageNumber, pageSize, order, c), pageRequest,
				mySqGiftRecordDao.getSqGiftRecordCountByParam(searchParams, c));
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	/* 物品赠予记录一共捐赠了几件物品 */
	@Override
	public Integer getGiftCountByParam(Map<String, Object> params, Community c) {
		return mySqGiftRecordDao.getGiftCountByParam(params, c);
	}

	@Override
	public SqGiftRecord getSqGiftRecordById(Long id) {
		// TODO Auto-generated method stub
		return sqGiftRecordDao.getSqGiftRecordById(id);
	}

	@Override
	public SqGiftRecord save(SqGiftRecord s) {
		// TODO Auto-generated method stub
		return sqGiftRecordDao.save(s);
	}

	@Override
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			sqGiftRecordDao.delete(Long.parseLong(i));
		}
		return true;
	}

	@Override
	public List<SqGiftRecord> getSqGiftRecordByComid(Long comid) {
		// TODO Auto-generated method stub
		return sqGiftRecordDao.getSqGiftRecordByComid(comid);
	}

	@Override
	public List<SqGiftRecord> getSqDonationByPhoneNo(String phoneno) {
		// TODO Auto-generated method stub
		return sqGiftRecordDao.getSqDonationByPhoneNo(phoneno);
	}

	@Override
	public SqGiftRecord getSqGiftRecordByNum(String num) {
		return sqGiftRecordDao.getSqGiftRecordByNum(num);
	}

}
