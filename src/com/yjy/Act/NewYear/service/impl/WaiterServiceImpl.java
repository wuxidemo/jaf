package com.yjy.Act.NewYear.service.impl;

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

import com.yjy.Act.NewYear.dao.MyWaiterDao;
import com.yjy.Act.NewYear.entity.Waiter;
import com.yjy.Act.NewYear.entity.Waiterth;
import com.yjy.Act.NewYear.repository.WaiterDao;
import com.yjy.Act.NewYear.repository.WaiterthDao;
import com.yjy.Act.NewYear.service.WaiterService;

@Component
@Transactional
public class WaiterServiceImpl implements WaiterService {
	
	@Autowired
	private WaiterDao waiterDao;
	
	@Autowired
	private MyWaiterDao myWaiterDao;
	
	@Autowired
	private WaiterthDao waiterthDao;

	@Override
	public Waiter findByOpenid(String openid) {
		// TODO Auto-generated method stub
		List<Waiter> wlist = waiterDao.findByOpenid(openid);
		if(wlist != null && wlist.size() > 0) {
			return wlist.get(0);
		}
		return null;
	}

	
	@Override
	public Page<Object[]> getWaiterList(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(myWaiterDao.getWaiterData(searchParams, pageNumber, pageSize, order), pageRequest,
				myWaiterDao.getWaiterCountByParam(searchParams));
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}
	
	
	
	
	/**
	 * 根据openid查找
	 * 
	 */
	public Waiter findbyopenid(String openid){
		return waiterDao.findbyone(openid);
	}
	
	/**
	 * 保存方法
	 */
	public  Waiter save1(Waiter waiter){
		return waiterDao.save(waiter);
	}
	
	/**
	 * 根据id查找
	 */
	public Waiter find(Long id) {
		return waiterDao.findOne(id);
	}
	
	public boolean delete(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			List<Waiterth> thlist = waiterthDao.getWaiterthByWaiterid(Long.valueOf(i));
			if(thlist != null && thlist.size() > 0) {
				for(Waiterth wth : thlist) {
					waiterthDao.delete(wth.getId());
				}
			}
			waiterDao.delete(Long.parseLong(i));
		}
		return true;
	}
	
	/*查找前50名*/
	public List<Object> findbyall(String openid, String date1) {

	
		return waiterDao.getbyall(openid, date1);
	}


	@Override
	public List<Waiter> findByState(int state) {
		// TODO Auto-generated method stub
		return waiterDao.findByState(state);
	}


	@Override
	public List<Object[]> getWinnerList() {
		// TODO Auto-generated method stub
		return waiterDao.getWinnerList();
	}


	@Override
	public int getAllWaiterCount() {
		// TODO Auto-generated method stub
		return waiterDao.getAllWaiterCount();
	}
	
	@Override
	public List<Object[]> getTop50WinList() {
		// TODO Auto-generated method stub
		return waiterDao.getTop50WinList();
	}


	@Override
	public List<Object[]> getChosenList(String openid, String datestr) {
		// TODO Auto-generated method stub
		return waiterDao.getChosenList(openid, datestr);
	}
	
}
