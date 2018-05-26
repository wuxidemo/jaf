package com.yjy.Act.NewYear.dao.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.Act.NewYear.dao.MyWaiterRedbagDao;

@Service
@NoRepositoryBean
public class MyWaiterRedbagDaoImpl implements MyWaiterRedbagDao {

	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Object[]> getWaiterRedbagData(Map<String, Object> params, int start, int count, String order) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String sql = "";

		String datestr = "";

		if (params != null) {
			if (params.containsKey("EQ_createtime")) {
				String str = params.get("EQ_createtime").toString();
				datestr = str.replace("-", "");
			} else {
				datestr = sdf.format(new Date());
			}
		} else {
			datestr = sdf.format(new Date());
		}

		sql = "SELECT id, nickname, name, (case when w1.total is null then 0 else w1.total end) as todaytotal, (case when w2.total is null then 0 else w2.total end) as total,(case when w3.total is null then 0 else w3.total end) as yestotal, (case when w4.total is null then 0 else w4.total end) as nototal,  mername, w.openid from waiterredbag w LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestr
				+ " GROUP BY openid) w1 ON w.openid = w1.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag GROUP BY openid) w2 ON w.openid = w2.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestr
				+ " and sendstate=1 GROUP BY openid) w3 ON w.openid = w3.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestr
				+ " and (sendstate IS NULL OR sendstate=0) GROUP BY openid) w4 ON w.openid = w4.openid where 1=1 ";

		if (params != null) {
			if (params.containsKey("LIKE_nickname")) {
				sql += " and nickname  like '%" + params.get("LIKE_nickname") + "%'";
			}
			if (params.containsKey("LIKE_name")) {
				sql += " and name like '%" + params.get("LIKE_name") + "%'";
			}
			if (params.containsKey("LIKE_mername")) {
				sql += " and mername  like '%" + params.get("LIKE_mername") + "%'";
			}

		}

		/*
		 * sql +=
		 * " GROUP BY w.openid ORDER BY total DESC,todaytotal DESC LIMIT " +
		 * (start - 1) * count + "," + count;
		 */
		sql += " GROUP BY w.openid ORDER BY total DESC,todaytotal DESC";
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public int getWaiterRedbagCountByParam(Map<String, Object> params) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String sql = "";

		String datestr = "";

		if (params != null) {
			if (params.containsKey("EQ_createtime")) {
				String str = params.get("EQ_createtime").toString();
				datestr = str.replace("-", "");
			} else {
				datestr = sdf.format(new Date());
			}

		} else {
			datestr = sdf.format(new Date());
		}

		sql = "SELECT count(*) FROM (SELECT id, nickname, name, (case when w1.total is null then 0 else w1.total end) as todaytotal, (case when w2.total is null then 0 else w2.total end) as total,(case when w3.total is null then 0 else w3.total end) as yestotal, (case when w4.total is null then 0 else w4.total end) as nototal,  mername, w.openid from waiterredbag w LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')='20160117' GROUP BY openid) w1 ON w.openid = w1.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag GROUP BY openid) w2 ON w.openid = w2.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestr
				+ " and sendstate=1 GROUP BY openid) w3 ON w.openid = w3.openid LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestr
				+ " and (sendstate IS NULL OR sendstate=0) GROUP BY openid) w4 ON w.openid = w4.openid where 1=1 ";

		if (params != null) {
			if (params.containsKey("LIKE_nickname")) {
				sql += " and nickname  like '%" + params.get("LIKE_nickname") + "%'";
			}
			if (params.containsKey("LIKE_name")) {
				sql += " and name like '%" + params.get("LIKE_name") + "%'";
			}
			if (params.containsKey("LIKE_mername")) {
				sql += " and mername  like '%" + params.get("LIKE_mername") + "%'";
			}

		}

		sql += "  GROUP BY w.openid) as aaa";

		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@Override
	public List<Object[]> getNoSendWaiterRedbagByDate(String datestr) {
		// TODO Auto-generated method stub
		String sql = "";

		String datestrnew = datestr.replace("-", "");
		sql = "SELECT GROUP_CONCAT(CONV(OCT(id),8,10)) as ids, nickname, name, (case when w1.total is null then 0 else w1.total end) as todaytotal, mername, w.openid from waiterredbag w LEFT JOIN (SELECT count(*) as total,openid from waiterredbag WHERE DATE_FORMAT(createtime,'%Y%m%d')="
				+ datestrnew
				+ " and (sendstate=0 or sendstate IS NULL) GROUP BY openid) w1 ON w.openid = w1.openid where 1=1 and DATE_FORMAT(w.createtime,'%Y%m%d')="
				+ datestrnew + "";

		sql += " GROUP BY w.openid HAVING todaytotal > 0";
		return em.createNativeQuery(sql).getResultList();
	}

}
