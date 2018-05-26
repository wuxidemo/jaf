package com.yjy.Temporary.service.impl;

import java.util.Date;
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

import com.yjy.Temporary.entity.Popularity;
import com.yjy.Temporary.entity.PopularityRecord;
import com.yjy.Temporary.entity.ShareRecord;
import com.yjy.Temporary.repository.PopularityDao;
import com.yjy.Temporary.repository.PopularityRecordDao;
import com.yjy.Temporary.service.PopularityRecordService;
import com.yjy.Temporary.service.PopularityService;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;

@Component
@Transactional
public class PopularityServiceImpl implements PopularityService {
	@Autowired
	PopularityDao popularityDao;
	@Autowired
	PopularityRecordService popularityRecordService;
	@Autowired
	WXUserService wXUserService;

	public Popularity get(Long id) {
		return popularityDao.findOne(id);
	}

	public Popularity getByOpenid(String openid) {
		return popularityDao.getByOpenid(openid);
	}

	public int getRankByOpenid(int count, Date time) {
		return popularityDao.getRankByOpenid(count, time);
	}

	public List<Object[]> getTop10By() {
		return popularityDao.getTop10By();
	}

	public boolean Judge(String openid) {
		return popularityRecordService.getFromCount(openid) == 0;
	}

	public boolean add1Score(String toopenid, String fromopenid) {
		PopularityRecord pr = new PopularityRecord();
		pr.setCreatetime(new Date());
		pr.setFromopenid(fromopenid);
		pr.setOpenid(toopenid);
		pr.setScore(10);
		popularityRecordService.save(pr);
		Popularity p = popularityDao.getByOpenid(toopenid);
		if (p == null) {
			p = new Popularity();
			p.setCreatetime(new Date());
			p.setOpenid(toopenid);
			p.setName(wXUserService.getOrNewWXUser(toopenid).getRealname());
			p.setTotalscore(10);
			popularityDao.save(p);
		} else {
			popularityDao.updateTotalScore(toopenid, 10);
		}
		return true;
	}

	public String add2Score(String toopenid, String fromopenid) {
		PopularityRecord pr = popularityRecordService.getByFromopenid(toopenid, 10);
		if (pr != null && !pr.getFromopenid().equals(pr.getOpenid())) {
			PopularityRecord prr = new PopularityRecord();
			prr.setCreatetime(new Date());
			prr.setFromopenid(fromopenid);
			prr.setOpenid(pr.getOpenid());
			prr.setScore(3);
			popularityRecordService.save(prr);
			popularityDao.updateTotalScore(prr.getOpenid(), 3);
			return prr.getOpenid();
		} else {
			return null;
		}
	}

	public Page<Popularity> getPopularity(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Popularity> spec = Util.buildSpecification(searchParams, Popularity.class);
		return popularityDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "totalscore");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public List<Popularity> getTop2() {
		return popularityDao.getTop2();
	}

	public int get500Count() {
		return popularityDao.get500Count();
	}

	public List<Popularity> get500() {
		return popularityDao.get500();
	}

	public List<Popularity> get1000() {
		return popularityDao.get1000();
	}

	public Popularity save(Popularity p) {
		return popularityDao.save(p);
	}

	public int get1000Count() {
		return popularityDao.get1000Count();
	}
}
