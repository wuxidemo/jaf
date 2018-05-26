package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MyActivityDao;
@Service
@NoRepositoryBean
public class MyActivityDaoImpl implements MyActivityDao{
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Object[]> getFatherActivityByParam(Map<String, Object> params, int start, int count, String order) {
		// TODO Auto-generated method stub
		String sql = "SELECT fa.id,fa.`name`, GROUP_CONCAT(CAST(ac.id AS CHAR)) as acids, GROUP_CONCAT(ac.title) from fatheractivity fa LEFT JOIN fatherchildactivity fc ON fa.id=fc.fatherid LEFT JOIN activity ac ON fc.childid=ac.id GROUP BY fa.id limit " + (start - 1) * count + "," + count;
		
		
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getFatherActivityCountByParam(Map<String, Object> params, int start, int count, String order) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(*) from (SELECT fa.id,fa.`name`, GROUP_CONCAT(CAST(ac.id AS CHAR)) as acids, GROUP_CONCAT(ac.title) from fatheractivity fa LEFT JOIN fatherchildactivity fc ON fa.id=fc.fatherid LEFT JOIN activity ac ON fc.childid=ac.id GROUP BY fa.id) as newtb";
		
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
	
}
