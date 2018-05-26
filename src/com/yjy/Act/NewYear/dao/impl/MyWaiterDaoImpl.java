package com.yjy.Act.NewYear.dao.impl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.Act.NewYear.dao.MyWaiterDao;
@Service
@NoRepositoryBean
public class MyWaiterDaoImpl implements MyWaiterDao {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Object[]> getWaiterData(Map<String, Object> params, int start,
			int count, String order) {
		
		String sql = "select id, wxname, name, likewaiter.total as wtotal, createtime,url,telephone,mername,senumber,state,context from waiter w left join (SELECT count(*) as total,waiterid from waiterth GROUP BY waiterid) likewaiter on w.id = likewaiter.waiterid where 1=1 ";
		if (params != null) {
			if (params.containsKey("LIKE_wxname")) {
				sql += " and wxname  like '%" + params.get("LIKE_wxname") + "%'";
			}
			if (params.containsKey("LIKE_name")) {
				sql += " and name like '%" + params.get("LIKE_name") + "%'";
			}
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
			
			if (params.containsKey("LIKE_mername")) {
				sql += " and mername  like '%" + params.get("LIKE_mername") + "%'";
			}
			
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			
		}
		
		sql += " ORDER BY wtotal DESC,createtime ASC LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getWaiterCountByParam(Map<String, Object> params) {
		// TODO Auto-generated method stub
		String sql = "select count(*) from waiter w left join (SELECT count(*) as total,waiterid from waiterth GROUP BY waiterid) likewaiter on w.id = likewaiter.waiterid where 1=1 ";
		if (params != null) {
			if (params.containsKey("LIKE_wxname")) {
				sql += " and wxname  like '%" + params.get("LIKE_wxname") + "%'";
			}
			if (params.containsKey("LIKE_name")) {
				sql += " and name like '%" + params.get("LIKE_name") + "%'";
			}
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
			
			if (params.containsKey("LIKE_mername")) {
				sql += " and mername  like '%" + params.get("LIKE_mername") + "%'";
			}
			
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			
		}
		
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
}
