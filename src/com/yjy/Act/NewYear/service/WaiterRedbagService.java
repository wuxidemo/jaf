package com.yjy.Act.NewYear.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.Act.NewYear.entity.WaiterRedbag;

public interface WaiterRedbagService {
	
	public Page<Object[]> getWaiterRedbagList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType);
	
	public WaiterRedbag save(WaiterRedbag waiterRedbag);
	
	public Map<String, Object> saveWaiterRedbag(Long id, String fromopenid, String fromnickname, String fromlat, String fromlon, String citystr);
	
	public List<Object[]> getNoSendWaiterRedbagByDate(String datestr);
	
	public WaiterRedbag get(Long id);
	
}
