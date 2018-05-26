package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_Advert;


public interface SqAdvertService {

	public Page<Sq_Advert> getSqAdverts(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public Sq_Advert get(Long id);
	
	public Sq_Advert save(Sq_Advert sqAdvert);
	
	public void delete(Long id);
	
	public List<Sq_Advert> getSqAdvertByType(int type);
	
	public List<Sq_Advert> getSqAdvertByComid(Long comid);

}
