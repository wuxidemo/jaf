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

import com.yjy.entity.Apply;
import com.yjy.repository.ApplyDao;
import com.yjy.service.ApplyService;
import com.yjy.utils.Util;

/**
 * 类ApplyService.java的实现描述：Apply的Service层
 * 
 * @author wutao 2015年6月23日 下午1:47:25
 */
@Component
@Transactional
public class ApplyServiceImpl implements ApplyService{
	@Autowired
	private ApplyDao applyDao;

	/**
	 * 获取所有的Apply列表
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午2:17:41
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Apply> getApply(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Apply> spec = Util.buildSpecification(searchParams,
				Apply.class);
		return applyDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Apply get(Long id) {
		return applyDao.findOne(id);

	}

	public Apply update(Apply d) {
		return applyDao.save(d);
	}

	public void delete(Long id) {
		applyDao.delete(id);

	}

	public int getCountByServerType(Long sid) {
		return applyDao.getCountByServerType(sid);
	}

	public Apply getApplyByOpenid(String openid) {
		List<Apply> la = applyDao.getApplyByOpenid(openid);
		if (la.size() > 0) {
			return la.get(0);
		} else {
			return null;
		}
	}
}
