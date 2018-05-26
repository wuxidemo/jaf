package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import com.yjy.entity.Sq_PensionAct;

public interface Sq_PensionActService {
	
	public Page<Object[]> getSqPensionActDateByParams(Map<String, Object> params, int pageNumber, int pageSize, String sortType);

	public  Sq_PensionAct save(Sq_PensionAct s);
	
	public void delete(Long id);
	
	public List<Sq_PensionAct> getAllSqPensionAct();
	
	public Sq_PensionAct getSq_PensionActById(Long id);
	
	public List<Sq_PensionAct> getSq_PensionActList(int start, int size);
	
	public List<Object[]> getMyPensionApplyByOpenid(String openid, int start, int size);
	
	public void updateState();
}
