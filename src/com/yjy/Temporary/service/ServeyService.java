package com.yjy.Temporary.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Temporary.entity.Servey;

public interface ServeyService {
	
	public Servey findByOpenid(String openid);
	
	public int findCountByOpenid(String openid);
	
	public Servey save(Servey servey);
	
	public Servey get(Long id);
	
	public Page<Servey> getServey(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public Servey getLastServey();
	
	public int getTotalCount();
	
	public Servey findByPhone(String phone);
	
	public int idLessCount(Long id);
	
	public List<Object[]> gatAllServey();
	
	public int countTotalWuxi();
	
}
