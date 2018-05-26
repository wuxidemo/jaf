package com.yjy.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.FatherActivity;

public interface FatherActivityService {
	
	
	public Page<Object[]> getFatherActivitys(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public FatherActivity save(FatherActivity fatherActivity);
	
	public FatherActivity get(Long id);
	
	public void delete(Long id);
	
}
