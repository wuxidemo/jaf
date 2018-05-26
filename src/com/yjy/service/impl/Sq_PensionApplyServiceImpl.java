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

import com.yjy.entity.Sq_PensionApply;
import com.yjy.repository.Sq_PensionApplyDao;
import com.yjy.service.Sq_PensionApplyService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_PensionApplyServiceImpl implements Sq_PensionApplyService {

	@Autowired
	Sq_PensionApplyDao pensionApplyDao;

	@Override
	public Sq_PensionApply save(Sq_PensionApply pensionApply) {
		// TODO Auto-generated method stub
		return pensionApplyDao.save(pensionApply);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		pensionApplyDao.delete(id);
	}

	@Override
	public boolean delete(String ids) {
		// TODO Auto-generated method stub
		String[] id = ids.split("\\|");
		for (String i : id) {
			pensionApplyDao.delete(Long.parseLong(i));
		}
		return true;
	}

	@Override
	public Sq_PensionApply update(Sq_PensionApply pensionApply) {
		// TODO Auto-generated method stub
		return pensionApplyDao.save(pensionApply);
	}

	@Override
	public Sq_PensionApply get(Long id) {
		// TODO Auto-generated method stub
		return pensionApplyDao.findOne(id);
	}

	@Override
	public Page<Sq_PensionApply> getPensionApplyList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = bulidPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_PensionApply> spec = Util.buildSpecification(searchParams, Sq_PensionApply.class);
		return pensionApplyDao.findAll(spec, pageRequest);
	}

	/**
	 * 排序分页
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public PageRequest bulidPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		sort = new Sort(Direction.DESC, "createtime");
		
		return new PageRequest(pageNumber - 1, pageSize, sort);

	}

	@Override
	public Sq_PensionApply getPensionApplyByOpenid(String openid) {
		// TODO Auto-generated method stub
		return pensionApplyDao.getPensionApplyByOpenid(openid);
	}

	@Override
	public List<Sq_PensionApply> getPenActListByOpenAndAct(Long sqactid, String openid) {
		return pensionApplyDao.getPenActListByOpenAndAct(sqactid,openid);
	}
/**
 * 根据活动id，获得相应的申请
 */
	@Override
	public List<Sq_PensionApply> getPenActListBySqactid(Long sqactid) {
		return pensionApplyDao.getPenApplyListBySqactid(sqactid);
	}
}
