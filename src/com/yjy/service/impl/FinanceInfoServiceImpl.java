package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.FinanceInfo;
import com.yjy.repository.FinanceInfoDao;
import com.yjy.service.FinanceInfoService;
import com.yjy.utils.Util;

@Component
@Transactional
public class FinanceInfoServiceImpl implements FinanceInfoService {

	@Autowired
	private FinanceInfoDao financeInfoDao;

	@Override
	public Page<FinanceInfo> getFinanceInfo(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<FinanceInfo> spec = Util.buildSpecification(searchParams, FinanceInfo.class);
		return financeInfoDao.findAll(spec, pageRequest);
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

	@Override
	public FinanceInfo save(FinanceInfo financeInfo) {
		// TODO Auto-generated method stub
		return financeInfoDao.save(financeInfo);
	}

	@Override
	public FinanceInfo get(Long id) {
		// TODO Auto-generated method stub
		return financeInfoDao.findOne(id);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		financeInfoDao.delete(id);
	}

	@Override
	public List<FinanceInfo> getAllFinanceInfo() {
		// TODO Auto-generated method stub
		return financeInfoDao.getAllFinanceInfo();
	}

	@Override
	public List<FinanceInfo> getPublishedFinanceInfo() {
		// TODO Auto-generated method stub
		return financeInfoDao.getPublishedFinanceInfo();
	}

	public void updateCount(Long id, int count) {
		FinanceInfo fi = financeInfoDao.findOne(id);
		if (fi != null) {
			if (fi.getCount() == null) {
				fi.setCount(count);
			} else {
				fi.setCount(fi.getCount() + count);
			}
			financeInfoDao.save(fi);
		}

	}
}
