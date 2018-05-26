package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_Repair;

public interface Sq_RepairService {

	/**
	 * 获取Repair集合，分页
	 * 
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<Sq_Repair> getRepairList(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public Sq_Repair get(Long id);

	public Sq_Repair save(Sq_Repair sr);

	public void delete(Long id);

	public boolean delete(String ids);

	public List<Sq_Repair> getRepairsByOpenid(String openid, int start, int size);

	public List<Sq_Repair> getRepairByState(String openid, int state, int start, int size);
}
