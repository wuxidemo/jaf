package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MySqGiftRecordDao;
import com.yjy.entity.Community;

@Service
@NoRepositoryBean
public class MySqGiftRecordDaoImpl implements MySqGiftRecordDao {

	@PersistenceContext
	private EntityManager em;

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getSqGiftRecordData(Map<String, Object> params, int start, int size, String order,
			Community c) {
		/* String sql="SELECT *FROM sq_giftrecord WHERE 1=1"; */
		String sql = "SELECT aaa.*,community.`name` communityname FROM (SELECT * FROM sq_giftrecord WHERE 1 = 1)as aaa LEFT JOIN community ON aaa.comid= community.id GROUP BY aaa.id HAVING 1 = 1";
		String where = "";
		if (c != null) {
			if (c.getId() != null) {
				where += " and aaa.comid=" + c.getId();
			}
		} else {
			if (params.containsKey("EQ_community")) {
				where += " and aaa.comid  like '%" + params.get("EQ_community") + "%'";
			}
		}

		if (params.containsKey("LIKE_name")) {

			where += " and CONCAT(aaa.firstname,aaa.lastname) like '%" + params.get("LIKE_name") + "%'";

		}
		if (params.containsKey("LIKE_doname")) {

			where += " and aaa.doname like '%" + params.get("LIKE_doname") + "%'";

		}
		if (params.containsKey("EQ_starttime")) {

			where += " and aaa.createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		if (params.containsKey("EQ_endtime")) {

			where += " and aaa.createtime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		sql += where + " order by aaa.createtime desc , aaa.id desc  LIMIT " + (start - 1) * size + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}

	/* 一共捐赠多少件物品 */
	@Override
	public Integer getGiftCountByParam(Map<String, Object> params, Community c) {
		String sql = "SELECT CASE WHEN SUM(sq_gift_item.count) IS NULL THEN 0 ELSE SUM(sq_gift_item.count) END FROM sq_giftrecord LEFT JOIN sq_gift_item ON sq_giftrecord.id = sq_gift_item.giftid WHERE 1=1";
		String where = "";
		if (c != null) {
			if (c.getId() != null) {
				where += " and sq_giftrecord.comid=" + c.getId();
			}
		} else {
			if (params.containsKey("EQ_community")) {
				where += " and sq_giftrecord.comid  like '%" + params.get("EQ_community") + "%'";
			}
		}

		if (params.containsKey("LIKE_name")) {

			where += " and CONCAT(sq_giftrecord.firstname,sq_giftrecord.lastname) like '%" + params.get("LIKE_name")
					+ "%'";

		}
		if (params.containsKey("LIKE_doname")) {

			where += " and sq_giftrecord.doname like '%" + params.get("LIKE_doname") + "%'";

		}
		if (params.containsKey("EQ_starttime")) {

			where += " and sq_giftrecord.createtime>=str_to_date('"
					+ params.get("EQ_starttime").toString().replaceAll("-", "") + "','%Y%m%d')";

		}
		if (params.containsKey("EQ_endtime")) {

			where += " and sq_giftrecord.createtime<str_to_date('"
					+ params.get("EQ_endtime").toString().replaceAll("-", "") + "','%Y%m%d')";

		}
		sql += where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@Override
	public Integer getSqGiftRecordCountByParam(Map<String, Object> params, Community c) {
		String sql = "SELECT COUNT(*) FROM sq_giftrecord WHERE 1=1";
		String where = "";
		if (c != null) {
			if (c.getId() != null) {
				where += " and comid=" + c.getId();
			}
		} else {
			if (params.containsKey("EQ_community")) {
				where += " and comid  like '%" + params.get("EQ_community") + "%'";
			}
		}

		if (params.containsKey("LIKE_name")) {

			where += " and CONCAT(firstname,lastname) like '%" + params.get("LIKE_name") + "%'";

		}
		if (params.containsKey("LIKE_doname")) {

			where += " and doname like '%" + params.get("LIKE_doname") + "%'";

		}
		if (params.containsKey("EQ_starttime")) {

			where += " and createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		if (params.containsKey("EQ_endtime")) {

			where += " and createtime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";

		}
		sql += where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

}
