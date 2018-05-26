package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MySq_Donation_GoodDao;
import com.yjy.entity.Community;
@Service
@NoRepositoryBean
public class MySq_Donation_GoodDaoImpl implements MySq_Donation_GoodDao{

	@PersistenceContext
	private EntityManager em;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getSq_Donation_Goods(Map<String, Object> params, int start, int size, String order,Community c) {
		String sql="SELECT aaa.*, community.`name` communityname FROM ( SELECT * FROM sq_donation_good) AS aaa LEFT JOIN community ON aaa.comid = community.id GROUP BY aaa.id HAVING 1 = 1";
		String where= "";
		if(c!=null){
        	if(c.getId()!=null){
     			where += " and aaa.comid="+c.getId();
     		}
		}else{
			if(params.containsKey("EQ_community.id")) {
				where +=" and aaa.comid  like '%" + params.get("EQ_community.id")+ "%'";
			}
		}
		if (params.containsKey("LIKE_name")) {
			where += " and aaa.name like '%" + params.get("LIKE_name") + "%'";
		}
		if (params.containsKey("EQ_state")) {
			where += " and aaa.state =" + params.get("EQ_state");
		}
		sql+=where+" order by aaa.createtime desc ,aaa.id desc  LIMIT " + (start - 1) * size + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getSq_Donation_GoodsCount(Map<String, Object> params, Community c) {
		String sql="SELECT COUNT(*) FROM sq_donation_good WHERE 1=1";
		String where= "";
		if(c!=null){
        	if(c.getId()!=null){
     			where += " and comid="+c.getId();
     		}
		}else{
			if(params.containsKey("EQ_community.id")) {
				where +=" and comid  like '%" + params.get("EQ_community.id")+ "%'";
			}
		}
		if (params.containsKey("LIKE_name")) {
			where += " and name like '%" + params.get("LIKE_name") + "%'";
		}
		if (params.containsKey("EQ_state")) {
			where += " and state =" + params.get("EQ_state");
		}
		sql+=where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	/*根据id查询物品信息以及社区*/
	@SuppressWarnings("unchecked")
	public List<Object[]> getSq_Donation_GoodById(Long id){
		String sql="SELECT aaa.*, community.`name` communityname FROM ( SELECT *FROM sq_donation_good where id="+id+") AS aaa LEFT JOIN community ON aaa.comid = community.id ";
		return em.createNativeQuery(sql).getResultList();
	}
}
