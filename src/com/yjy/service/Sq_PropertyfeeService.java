package com.yjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.yjy.entity.Sq_Propertyfee;

public interface Sq_PropertyfeeService {

	public Page<Sq_Propertyfee> getSqPropertyfee(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType);

	public Sq_Propertyfee save(Sq_Propertyfee s);

	public Sq_Propertyfee getById(Long id);

	public boolean delete(String ids);

	public List<Sq_Propertyfee> getByTelephone(String telephone);

	public void updateStateById(Long id, int state);
}
