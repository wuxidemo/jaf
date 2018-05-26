package com.yjy.service;

import java.util.List;

import com.yjy.entity.Sq_Wy_Telephone;

public interface SqWyTelephoneService {
	
	public Sq_Wy_Telephone save(Sq_Wy_Telephone sq_Wy_Telephone);
	
	public Sq_Wy_Telephone get(Long id);
	
	public void delete(Long id);
	
	public List<Sq_Wy_Telephone> getListByOpenid(String openid);
	
	public List<Sq_Wy_Telephone> getListByTelephone(String telephone);
	
	public int getCountByOpenid(String openid);
}
