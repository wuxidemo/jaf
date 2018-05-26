package com.yjy.service.impl;

import java.util.Date;
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

import com.yjy.dao.MyDao;
import com.yjy.entity.Sq_PensionAct;
import com.yjy.repository.Sq_PensionActDao;
import com.yjy.service.Sq_PensionActService;
@Component
@Transactional
public class Sq_PensionActServiceImpl implements Sq_PensionActService {
	
	@Autowired
	private Sq_PensionActDao sq_PensionActDao;
	
	@Autowired
	private MyDao myDao;
	
	@Override
	public Page<Object[]> getSqPensionActDateByParams(Map<String, Object> params, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id DESC";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myDao.getSqPensionActDateByParams(params, pageNumber, pageSize, order), pageRequest,
				myDao.getSqPensionActCountByParams(params));
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
	public Sq_PensionAct save(Sq_PensionAct s) {
		return sq_PensionActDao.save(s);
	}
	@Override
	public void delete(Long id) {
		sq_PensionActDao.delete(id);
		/*String[] id = ids.split("\\|");
		for (String i : id) {
			sq_PensionActDao.delete(Long.parseLong(i));
		}	*/
	}

	@Override
	public List<Sq_PensionAct> getAllSqPensionAct() {
		return sq_PensionActDao.getAllSqPensionAct();
	}

	@Override
	public Sq_PensionAct getSq_PensionActById(Long id) {
		return sq_PensionActDao.findOne(id);
	}
	@Override
	public List<Sq_PensionAct> getSq_PensionActList(int start, int size){
		return sq_PensionActDao.getPensionActList(start, size);
	}

	@Override
	public List<Object[]> getMyPensionApplyByOpenid(String openid, int start, int size) {
		return myDao.getMyPensionApplyByOpenid(openid, start, size);
	}

	@Override
	public void updateState() {
		// TODO Auto-generated method stub
		List<Sq_PensionAct> actlist = sq_PensionActDao.getOnLineActs();
		if(actlist != null && actlist.size() > 0) {
			Date date = new Date();
			for(Sq_PensionAct sq : actlist) {
				Date endtime = sq.getEndtime();
				Date starttime=sq.getStarttime();
				if(date.getTime() >= endtime.getTime()) {
					sq.setState(2);//如果时间超出结束时间,就自动结束
					sq_PensionActDao.save(sq);
				}else if(date.getTime()>=starttime.getTime() && sq.getState()==3){
					sq.setState(1);//如果时间已到，就自动上线
					sq_PensionActDao.save(sq);
				}
				/*if(date.getTime()>=starttime.getTime() && date.getTime() < endtime.getTime() && (sq.getState() == null || sq.getState() == 0||sq.getState()==3)){
					sq.setState(1);//如果时间已到，就自动上线
					sq_PensionActDao.save(sq);
				}*/
			}
		}
	}

}
