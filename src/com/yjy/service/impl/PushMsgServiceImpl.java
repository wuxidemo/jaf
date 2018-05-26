package com.yjy.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.PushMsg;
import com.yjy.repository.PushMsgDao;
import com.yjy.service.PushMsgService;
import com.yjy.utils.Util;
@Component
@Transactional
public class PushMsgServiceImpl implements PushMsgService {

	@Autowired
	private PushMsgDao pushMsgDao;
	
	@Override
	public Page<PushMsg> getPushMsg(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,sortType);
		Specification<PushMsg> spec = Util.buildSpecification(
				searchParams, PushMsg.class);
		return pushMsgDao.findAll(spec, pageRequest);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else{
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public PushMsg save(PushMsg p) {
		return pushMsgDao.save(p);
	}

	@Override
	public void delete(Long id) {
		pushMsgDao.delete(id);
	}

	@Override
	public PushMsg getPushMsgById(Long id) {
		return pushMsgDao.findOne(id);
	}

}
