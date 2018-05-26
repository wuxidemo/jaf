package com.yjy.Act.NewYear.service.impl;

import java.util.Date;
import java.util.HashMap;
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

import com.yjy.Act.NewYear.dao.MyWaiterRedbagDao;
import com.yjy.Act.NewYear.entity.Waiter;
import com.yjy.Act.NewYear.entity.WaiterRedbag;
import com.yjy.Act.NewYear.repository.WaiterDao;
import com.yjy.Act.NewYear.repository.WaiterRedbagDao;
import com.yjy.Act.NewYear.service.WaiterRedbagService;


@Component
@Transactional
public class WaiterRedbagServiceImpl implements WaiterRedbagService {

	@Autowired
	private WaiterRedbagDao waiterRedbagDao;
	
	@Autowired
	private MyWaiterRedbagDao myWaiterRedbagDao;
	
	@Autowired
	private WaiterDao waiterDao;

	@Override
	public WaiterRedbag save(WaiterRedbag waiterRedbag) {
		// TODO Auto-generated method stub
		return waiterRedbagDao.save(waiterRedbag);
	}

	@Override
	public Page<Object[]> getWaiterRedbagList(Map<String, Object> searchParams,
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
		return new PageImpl<Object[]>(myWaiterRedbagDao.getWaiterRedbagData(searchParams, pageNumber, pageSize, order), pageRequest,
				myWaiterRedbagDao.getWaiterRedbagCountByParam(searchParams));
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "nickname");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public Map<String, Object> saveWaiterRedbag(Long id, String fromopenid, String fromnickname, String fromlat, String fromlon, String citystr) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Waiter waiter = waiterDao.findOne(id);
		if(fromopenid.equals(waiter.getOpenid())) {
			map.put("result", "0");
			return map;
		}
		WaiterRedbag wr = null;
		List<WaiterRedbag> wrlist = waiterRedbagDao.findByOpenidAndFromOpenid(waiter.getOpenid(), fromopenid);
		if(wrlist != null && wrlist.size() > 0) {
			map.put("result", "0");
			return map;
		}else{
			wr = new WaiterRedbag();
			wr.setNickname(waiter.getWxname());
			wr.setName(waiter.getName());
			wr.setTelephone(waiter.getTelephone());
			wr.setOpenid(waiter.getOpenid());
			wr.setMername(waiter.getMername());
			wr.setFromnickname(fromnickname);
			wr.setFromopenid(fromopenid);
			wr.setFromlat(fromlat);
			wr.setFromlon(fromlon);
			wr.setCreatetime(new Date());
			wr.setSendstate(0);
			wr.setSendresult(null);
			wr.setSendtime(null);
			wr = waiterRedbagDao.save(wr);
			map.put("result", "1");
			map.put("reopenid", waiter.getOpenid());
			return map;
		}
	}
	
	public List<Object[]> getNoSendWaiterRedbagByDate(String datestr) {
		return myWaiterRedbagDao.getNoSendWaiterRedbagByDate(datestr);
	}

	@Override
	public WaiterRedbag get(Long id) {
		// TODO Auto-generated method stub
		return waiterRedbagDao.findOne(id);
	}
	
}
