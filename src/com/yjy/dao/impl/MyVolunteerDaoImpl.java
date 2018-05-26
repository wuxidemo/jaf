package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MyVolunteerDao;
import com.yjy.entity.CategoryValue;
import com.yjy.entity.Community;

@Service
@NoRepositoryBean
public class MyVolunteerDaoImpl implements MyVolunteerDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getVolunteerListData(Map<String, Object> params, int start, int size) {
		String sql = "SELECT aaa.* FROM (SELECT v.id, v.`name`, v.sex, v.headimgurl,v.ability, GROUP_CONCAT(cv.`value`) AS abilities, v.abilitydescrib, v.paytype, v.pay, v.state, v.isshow, v.createtime, v.communityid FROM volunteer v,categoryvalue cv WHERE v.ability like CONCAT('%,',cv.id) OR v.ability=cv.id OR v.ability like CONCAT('%,',cv.id,',%') or v.ability like CONCAT(cv.id,',%') GROUP BY v.id) AS aaa where 1=1 and aaa.state=1 and aaa.isshow=1 ";
	
		String where = "";
		
		if(params.containsKey("commid")) {
			String commid = (String) params.get("commid");
			where += " and aaa.communityid="+commid;
		}
		
		if(params.containsKey("kind")) {
			String kind = (String) params.get("kind");
			where += " and (aaa.ability like CONCAT('%,',"+kind+") OR aaa.ability="+kind+" OR aaa.ability like CONCAT('%,',"+kind+",',%') or aaa.ability like CONCAT("+kind+",',%'))";
		}
		
		if(params.containsKey("pay")) {
			String pay = (String) params.get("pay");
			where += " and aaa.paytype="+pay;
		}
		
		if(params.containsKey("keyword")) {
			String keyword = (String) params.get("keyword");
			where += " and  (aaa.name like '%"+keyword+"%' or aaa.abilities like '%"+keyword+"%') ";
		}

		sql += where +  " order by aaa.createtime desc  LIMIT " + start + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getVolunteerListByParam(Map<String, Object> params, int start, int size, String order,List<CategoryValue>  keywordlist,Community c) {
/*		String sql = "SELECT aaa.* FROM ( SELECT v.id,v.`name`,v.sex,v.phone,v.headimgurl,GROUP_CONCAT(cv.`value`) AS abilities,v.servertime,v.abilitydescrib,v.paytype,v.pay,v.state,v.isshow,v.createtime,v.communityid,v.openid FROM volunteer v,categoryvalue cv WHERE v.ability LIKE CONCAT('%,', cv.id) OR v.ability = cv.id OR v.ability LIKE CONCAT('%,', cv.id, ',%') OR v.ability LIKE CONCAT(cv.id, ',%') GROUP BY v.id) AS aaa WHERE 1 = 1 ";*/
        String sql="SELECT aaa.*,community.`name` communityname FROM(SELECT v.id,v.`name`,v.sex,v.phone,v.headimgurl,GROUP_CONCAT(cv.`value`) AS abilities,v.servertime,v.abilitydescrib,v.paytype,v.pay,v.state,v.isshow,v.createtime,v.communityid,v.openid FROM volunteer v,categoryvalue cv WHERE v.ability LIKE CONCAT('%,', cv.id) OR v.ability = cv.id OR v.ability LIKE CONCAT('%,', cv.id, ',%') OR v.ability LIKE CONCAT(cv.id, ',%') GROUP BY v.id) AS aaa LEFT JOIN community ON aaa.communityid=community.id GROUP BY aaa.id HAVING 1=1";
		String where = "";
        if(c!=null){
        	if(c.getId()!=null){
     			where += " and aaa.communityid="+c.getId();
     		}
		}else{
			if(params.containsKey("EQ_community")) {
				where +=" and aaa.communityid  like '%" + params.get("EQ_community")+ "%'";
			}
		}
       
		if(params.containsKey("LIKE_name")) {
			where +=" and aaa.name  like '%" + params.get("LIKE_name")+ "%'";
		}
		if(params.containsKey("EQ_paytype")) {
			String EQ_paytype = (String) params.get("EQ_paytype");
			where += " and aaa.paytype="+EQ_paytype;
		}
		if(params.containsKey("EQ_isshow")) {
			String EQ_isshow = (String) params.get("EQ_isshow");
			if("1".equals(EQ_isshow.trim())||"0".equals(EQ_isshow.trim())){
				where += " and aaa.isshow="+EQ_isshow;
			}else if("2".equals(EQ_isshow.trim())){
				where += " and aaa.state=2";//拒绝
			}else if("3".equals(EQ_isshow.trim())){
				where += " and aaa.state=0";//待审核
			}
		}
		/*循环遍历条件*/
			for(int i=0;i<keywordlist.size();i++){
				String id="LIKE_"+keywordlist.get(i).getId();
				if (params.containsKey(id)) {
		   			String LIKE_ability = (String) params.get(id);
		   			if (LIKE_ability == "" || "".equals(LIKE_ability)) {
		   			}else{
		   				/*where += " and aaa.abilities like '%" +LIKE_ability.trim()+ "%'";*/
		   				where += " and (aaa.abilities like CONCAT('%,','" +LIKE_ability.trim()+ "')OR aaa.abilities = '" +LIKE_ability.trim()+ "'OR aaa.abilities LIKE CONCAT('%,','" +LIKE_ability.trim()+ "', ',%')OR aaa.abilities LIKE CONCAT('" +LIKE_ability.trim()+ "', ',%'))";
		   			}
		   		   }
			}
		sql += where +  " order by aaa.createtime desc  LIMIT " + (start - 1) * size + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getVolCountByParam(Map<String, Object> params,List<CategoryValue>  keywordlist,Community c) {
		String sql = "SELECT COUNT(aaa.id) FROM ( SELECT v.id,v.`name`,v.sex,v.headimgurl,GROUP_CONCAT(cv.`value`) AS abilities,v.abilitydescrib,v.paytype,v.pay,v.state,v.isshow,v.createtime,v.communityid,v.openid FROM volunteer v,categoryvalue cv WHERE v.ability LIKE CONCAT('%,', cv.id) OR v.ability = cv.id OR v.ability LIKE CONCAT('%,', cv.id, ',%') OR v.ability LIKE CONCAT(cv.id, ',%') GROUP BY v.id) AS aaa WHERE 1 = 1 ";
		String where = "";
		
		if(c!=null){
        	if(c.getId()!=null){
     			where += " and aaa.communityid="+c.getId();
     		}
		}else{
			if(params.containsKey("EQ_community")) {
				where +=" and aaa.communityid  like '%" + params.get("EQ_community")+ "%'";
			}
		} 
		if (params.containsKey("LIKE_name")) {
			where += " and aaa.name  like '%" + params.get("LIKE_name") + "%'";
		}
		if(params.containsKey("EQ_paytype")) {
			String EQ_paytype = (String) params.get("EQ_paytype");
			where += " and aaa.paytype="+EQ_paytype;
		}
		if(params.containsKey("EQ_isshow")) {
			String EQ_isshow = (String) params.get("EQ_isshow");
			if("1".equals(EQ_isshow.trim())||"0".equals(EQ_isshow.trim())){
				where += " and aaa.isshow="+EQ_isshow;
			}else if("2".equals(EQ_isshow.trim())){
				where += " and aaa.state=2";//拒绝
			}else if("3".equals(EQ_isshow.trim())){
				where += " and aaa.state=0";//待审核
			}
		}
		/*循环遍历条件*/
			for(int i=0;i<keywordlist.size();i++){
				String id="LIKE_"+keywordlist.get(i).getId();
				if (params.containsKey(id)) {
		   			String LIKE_ability = (String) params.get(id);
		   			if (LIKE_ability == "" || "".equals(LIKE_ability)) {
		   			}else{
		   				/*where += " and aaa.abilities like '%" +LIKE_ability.trim()+ "%'";*/
		   				where += " and (aaa.abilities like CONCAT('%,','" +LIKE_ability.trim()+ "')OR aaa.abilities = '" +LIKE_ability.trim()+ "'OR aaa.abilities LIKE CONCAT('%,','" +LIKE_ability.trim()+ "', ',%')OR aaa.abilities LIKE CONCAT('" +LIKE_ability.trim()+ "', ',%'))";
		   			}
		   		   }
			}
			sql += where;
			
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult()
				.toString());
	}


	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getVolunteerDetail(Long id) {
		// TODO Auto-generated method stub
		String sql = "SELECT aaa.* FROM (SELECT v.id,v.headimgurl,v.`name`,v.nickname,v.sex,v.age,v.servertime,v.phone,GROUP_CONCAT(cv.`value`) AS ability,v.abilitydescrib,v.paytype,v.pay,v.state,v.isshow,v.createtime,v.communityid,v.openid,v.failreason FROM volunteer v LEFT JOIN categoryvalue cv ON v.ability like CONCAT('%,',cv.id) OR v.ability=cv.id OR v.ability like CONCAT('%,',cv.id,',%') or v.ability like CONCAT(cv.id,',%') OR v.ability IS NULL GROUP BY v.id) AS aaa where aaa.id="+id;
		
		return em.createNativeQuery(sql).getResultList();
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getVolunteerDetail2(Long id) {
		String sql = "SELECT aaa.*, community.`name` communityname FROM (SELECT v.id, v.headimgurl,v.`name`,v.nickname,v.sex,v.age,v.servertime,v.phone,GROUP_CONCAT(cv.`value`) AS ability,v.abilitydescrib,v.paytype,v.pay,v.state,v.isshow,v.createtime,v.communityid,v.openid,v.failreason FROM volunteer v LEFT JOIN categoryvalue cv ON v.ability LIKE CONCAT('%,', cv.id) OR v.ability = cv.id OR v.ability LIKE CONCAT('%,', cv.id, ',%') OR v.ability LIKE CONCAT(cv.id, ',%') OR v.ability IS NULL GROUP BY v.id ) AS aaa LEFT JOIN community ON aaa.communityid = community.id HAVING aaa.id="+id;
	return em.createNativeQuery(sql).getResultList();
	}

}
