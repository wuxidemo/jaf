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

import com.yjy.entity.Sq_Repair;
import com.yjy.repository.Sq_RepairDao;
import com.yjy.service.Sq_RepairService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_RepairServiceImpl implements Sq_RepairService {

	@Autowired
	private Sq_RepairDao repairDao;

	/**
	 * 获取Repair集合
	 */
	@Override
	public Page<Sq_Repair> getRepairList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_Repair> spec = Util.buildSpecification(searchParams, Sq_Repair.class);
		return repairDao.findAll(spec, pageRequest);
	}

	/**
	 * 分页方法
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		sort = new Sort(Direction.DESC, "createtime").and(new Sort(Direction.DESC, "community.id"));

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Sq_Repair get(Long id) {
		// TODO Auto-generated method stub
		return repairDao.findOne(id);
	}

	@Override
	public Sq_Repair save(Sq_Repair sr) {
		// TODO Auto-generated method stub
		return repairDao.save(sr);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		repairDao.delete(id);
	}

	@Override
	public boolean delete(String ids) {
		// TODO Auto-generated method stub
		String[] id = ids.split("\\|");
		for (String i : id) {
			repairDao.delete(Long.parseLong(i));
		}
		return true;
	}

	@Override
	public List<Sq_Repair> getRepairsByOpenid(String openid, int start, int size) {
		// TODO Auto-generated method stub
		return repairDao.getRepairsByOpenid(openid, start, size);
	}

	@Override
	public List<Sq_Repair> getRepairByState(String openid, int state, int start, int size) {
		// TODO Auto-generated method stub
		if (state == 0) {
			return repairDao.getRepairByState0(openid, start, size);
		} else if (state == 1) {
			return repairDao.getRepairByState1(openid, start, size);
		} else {
			return repairDao.getRepairByState2(openid, start, size);
		}
	}

}
