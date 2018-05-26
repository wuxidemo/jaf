package com.yjy.Act.NewYear.dao.impl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.Act.NewYear.dao.MyProductDao;
@Service
@NoRepositoryBean
public class MyProductDaoImpl implements MyProductDao {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Object[]> getProData(Map<String, Object> params, int start,
			int count, String order) {
		// TODO Auto-generated method stub
		String sql = "select id, wxname, name, likepro.total as ptotal, createtime,url,telephone,collegestate,senumber,state,college,title,context from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
			if (params.containsKey("EQ_state")) {
				
				String state = params.get("EQ_state").toString();
				if("1".equals(state)) {
					sql += " and state=1";
				}else if("2".equals(state)) {
					sql += " and state=2";
				}else if("3".equals(state)) {
					sql += " and state>=3";
				}
			}
		}
		
		sql += " ORDER BY ptotal DESC,createtime DESC LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getProCountByParam(Map<String, Object> params) {
		// TODO Auto-generated method stub
		String sql = "select count(*) from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
			if (params.containsKey("EQ_state")) {
				
				String state = params.get("EQ_state").toString();
				if("1".equals(state)) {
					sql += " and state=1";
				}else if("2".equals(state)) {
					sql += " and state=2";
				}else if("3".equals(state)) {
					sql += " and state>=3";
				}
			}
		}
		
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
	
	/*****************************************下面是江南大学和太湖学院的Dao层实现*****************************/
	@Override
	public List<Object[]> getJDProData(Map<String, Object> params, int start,
			int count, String order) {
		// TODO Auto-generated method stub
		String sql = "select id, wxname, name, likepro.total as ptotal, createtime,url,telephone,collegestate,senumber,state,college,title,context from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
		}
		
		sql += " ORDER BY ptotal DESC,createtime DESC LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getJDProCountByParam(Map<String, Object> params) {
		// TODO Auto-generated method stub
		String sql = "select count(*) from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
		}
		
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
	
	
	
	@Override
	public List<Object[]> getTHProData(Map<String, Object> params, int start,
			int count, String order) {
		// TODO Auto-generated method stub
		String sql = "select id, wxname, name, likepro.total as ptotal, createtime,url,telephone,collegestate,senumber,state,college,title,context from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
		}
		
		sql += " ORDER BY ptotal DESC,createtime DESC LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getTHProCountByParam(Map<String, Object> params) {
		// TODO Auto-generated method stub
		String sql = "select count(*) from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where 1=1 ";
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
			if (params.containsKey("EQ_collegestate")) {
				String cstate = params.get("EQ_collegestate").toString();
				if("0".equals(cstate)) {
					sql += " and collegestate=0";
				}else if("1".equals(cstate)) {
					sql += " and collegestate=1";
				}
			}
			
		}
		
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
}
