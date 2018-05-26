package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Activity;

public interface ActivityService {
	
	
	public Page<Activity> getActivity(Map<String, Object> searchParams,
			int pageNumber, int pageSize, String sortType);
	
	public Activity save(Activity activity);
	
	public Activity get(Long id);
	
	public void delete(Long id);
	
	public void updateActivityState() ;
	
	public void updateActivity() ;
	
	public List<Activity> getActivityByState(int state);
	
	public List<Activity> getAllActivity();
	
}
