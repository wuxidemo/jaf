package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Jsy;

public interface JsyService {
	
	
	public Page<Jsy> getJsys(
			Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) ;
	
	public Jsy save(Jsy jsy);
	
	public void delete(Long id);
	
	public Jsy get(Long id);
	
	public List<Jsy> getJsyByTelephone(String telephone) ;
}
