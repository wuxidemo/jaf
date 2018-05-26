package com.yjy.service;

import java.util.List;

import com.yjy.entity.FatherChildActivity;

public interface FatherChildActivityService {
	
	
	public FatherChildActivity save(FatherChildActivity fatherChildActivity);
	
	public FatherChildActivity get(Long id);
	
	public void delete(Long id);
	
	public List<FatherChildActivity> findByFatherid(Long id);
	
	public List<FatherChildActivity> findByChildid(Long id);
	
}
