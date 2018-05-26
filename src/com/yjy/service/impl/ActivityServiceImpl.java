package com.yjy.service.impl;


import java.util.Calendar;


import java.util.Date;
import java.util.HashMap;
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

import com.yjy.entity.Activity;
import com.yjy.repository.ActivityDao;
import com.yjy.service.ActivityService;
import com.yjy.utils.Util;

@Component
@Transactional
public class ActivityServiceImpl implements ActivityService {
	
	@Autowired
	private ActivityDao activityDao;
	
	public Page<Activity> getActivity(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);
		Specification<Activity> spec = Util.buildSpecification(
				searchParams, Activity.class);
		return activityDao.findAll(spec, pageRequest);
	}
	
	public Activity save(Activity activity) {
		return activityDao.save(activity);
	}
	
	public Activity get(Long id) {
		return activityDao.findOne(id);
	}
	
	public void delete(Long id) {
		activityDao.delete(id);
	}
	
	public void updateActivityState() {
		Map<String, Object> map = new HashMap<String, Object>();
		Specification<Activity> spec = Util.buildSpecification(map, Activity.class);
		List<Activity> actlist = activityDao.findAll(spec);
		
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		System.out.println(calendar.getTime());
		if(actlist != null && actlist.size() > 0) {
			for(Activity act : actlist) {
				
				Date enddate = act.getEndtime();
				Calendar endCal = Calendar.getInstance();
				endCal.setTime(enddate);
				endCal.add(Calendar.HOUR, +24);
				System.out.println(endCal.getTime());
				
				if(endCal.compareTo(calendar) > 0) {
					continue;
				}else{
					act.setState(2);
					activityDao.save(act);
				}
				
			}
		}
		
	}
	
	public void updateActivity() {
		Map<String, Object> map = new HashMap<String, Object>();
		Specification<Activity> spec = Util.buildSpecification(map, Activity.class);
		List<Activity> actlist = activityDao.findAll(spec);
		
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		System.out.println(calendar.getTime());
		if(actlist != null && actlist.size() > 0) {
			for(Activity act : actlist) {
				int state = act.getState();
				if(state == 3) {
					Date startdate = act.getStarttime();
					Calendar startCal = Calendar.getInstance();
					startCal.setTime(startdate);
					
					if(calendar.compareTo(startCal) >= 0) {
						act.setState(1);
						activityDao.save(act);
					}
				}else{
					continue;
				}
			}
		}
	}
	
	public List<Activity> getActivityByState(int state) {
		return activityDao.getActivityByState(state);
	}
	
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	@Override
	public List<Activity> getAllActivity() {
		// TODO Auto-generated method stub
		return activityDao.getAllActivity();
	}
}

