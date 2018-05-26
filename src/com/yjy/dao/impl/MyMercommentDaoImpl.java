package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MyMercommentDao;
@Service
@NoRepositoryBean
public class MyMercommentDaoImpl implements MyMercommentDao{

	@PersistenceContext
	private EntityManager em;

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getMercommentData(Map<String, Object> params, int start, int count, String order) {
		String sql="";
		String where="";
		sql+=where+" order by aaa.createtime desc , aaa.id desc  LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public Integer getMercommentCount(Map<String, Object> params) {
		String sql="";
		String where="";
		
		sql+=where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
	
/**
 * 加载分页
 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getMercommentListData(Map<String, Object> params, int start, int size) {
		String sql="SELECT aaa.*, wxuser.realname name,wxuser.headimgurl headimg FROM (SELECT * FROM mercomment) AS aaa LEFT JOIN wxuser ON aaa.openid = wxuser.openid GROUP BY aaa.id HAVING 1=1";
		String where="";
		if (params.containsKey("merid")) {//用户商家id查询
			where += " and aaa.merid =" + params.get("merid");
		}
		
		if (params.containsKey("LIKE_realname")) {//用户昵称查询
			where += " and name like '%" + params.get("LIKE_realname") + "%'";
		}
		
		if (params.containsKey("EQ_startscore")) {//开始分数

			where += " and aaa.score>=" + params.get("EQ_startscore");

		}
		if (params.containsKey("EQ_endscore")) {//结束分数

			where += " and aaa.score<=" + params.get("EQ_endscore");

		}
		
		if (params.containsKey("EQ_urls")) {//图片查询
			if(Integer.parseInt(params.get("EQ_urls")+"")==0){
				where += " and (aaa.urls is null or aaa.urls='')";
			}else if(Integer.parseInt(params.get("EQ_urls")+"")==1){
				where += " and aaa.urls is not null and aaa.urls <>''";
			}
		}
		
		if (params.containsKey("EQ_starttime")) {//开始时间

			where += " and aaa.createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		if (params.containsKey("EQ_endtime")) {//结束时间

			where += " and aaa.createtime<=str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		sql+=where+" order by aaa.createtime desc , aaa.id desc  LIMIT "  + start + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}
/**
 * 根据merid查询商户，评论信息
 */
@SuppressWarnings("unchecked")
@Override
public List<Object[]> getMercommentListData(Long merid) {
	String sql="SELECT merchant.`name`, (SUM(aaa.score) / COUNT(aaa.id)) score,COUNT(aaa.id) num1,COUNT(DISTINCT aaa.openid) num2,(SUM(aaa.total)/COUNT(aaa.id)) num3,merchant.introduceurl imgurl FROM (SELECT mercomment.*,payorder.total total FROM mercomment LEFT JOIN payorder ON mercomment.orderid=payorder.id) AS aaa LEFT JOIN merchant ON aaa.merid = merchant.id GROUP BY merchant.id HAVING merchant.id="+merid;
	return em.createNativeQuery(sql).getResultList();
}

/**
 * 取前三条
 */
@SuppressWarnings("unchecked")
@Override
public List<Object[]> getMercommentList(Map<String, Object> params) {
	String sql="SELECT aaa.*, wxuser.realname name,wxuser.headimgurl headimg FROM (SELECT * FROM mercomment) AS aaa LEFT JOIN wxuser ON aaa.openid = wxuser.openid GROUP BY aaa.id HAVING 1=1";
	String where="";
	if (params.containsKey("merid")) {//用户商家id查询
		where += " and aaa.merid =" + params.get("merid");
	}
	sql+=where+" order by aaa.createtime desc , aaa.id desc LIMIT 4";
	return em.createNativeQuery(sql).getResultList();
}
/**
 * 我的订单 加载分页
 * @param params
 * @return
 */
@SuppressWarnings("unchecked")
@Override
public List<Object[]> getMyPayOrderByOpenid(Map<String, Object> params, int start, int size) {
	String sql="SELECT aaa.*, mercomment.orderid merorderid FROM(SELECT pay.id id,pay.createtime createtime,pay.total,pay.merchantid merid,pay.ordernum ordernum,pay.nickname,pay.translatenum,pay.paytype,pay.state,pay.openid openid,pay.failreason,merchant.name mername,merchant.introduceurl merimgurl FROM (SELECT * FROM payorder) AS pay LEFT JOIN merchant ON pay.merchantid = merchant.id ) AS aaa LEFT JOIN mercomment on  aaa.id=mercomment.orderid HAVING 1 = 1";
	String where="";
	if (params.containsKey("openid")) {//用户商家id查询
		where += " and aaa.openid='" + params.get("openid")+"'";
	}
	if (params.containsKey("judge")) {//用户商家id查询
			where += " and merorderid is NULL";
	}
	sql+=where+" order by aaa.createtime desc , aaa.id desc LIMIT "  + start + "," + size;
	return em.createNativeQuery(sql).getResultList();
}
	
}
