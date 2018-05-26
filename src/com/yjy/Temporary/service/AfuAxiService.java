package com.yjy.Temporary.service;

import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.AfuAxi;


public interface AfuAxiService {
	
	public AfuAxi save(AfuAxi afuAxi);
	
	public AfuAxi get(Long id);
	
	public void delete(Long id);
	
	public Page<AfuAxi> getAfuAxi(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public AfuAxi add(String openid);
	
	public int getTotal();
	
}
