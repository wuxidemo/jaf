package com.yjy.dao.impl;

import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.dao.MySq_DonationDao;
import com.yjy.entity.Community;

@Service
@NoRepositoryBean
public class MySq_DonationDaoImpl implements MySq_DonationDao {

	@PersistenceContext
	private EntityManager em;

	/* 以下企业捐赠记录 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getCompanyDonations(Map<String, Object> params, int start, int size, String order,
			Community c) {
		/* String sql = "SELECT *FROM sq_donation WHERE type=3"; */
		String sql = "SELECT aaa.*, community.`name` communityname FROM (SELECT * FROM sq_donation WHERE type = 3 ) as aaa LEFT JOIN community ON aaa.comid= community.id GROUP BY aaa.id HAVING 1 = 1";
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

		if (params.containsKey("LIKE_company")) {
			where += " and aaa.company  like '%" + params.get("LIKE_company") + "%'";
		}
		if (params.containsKey("EQ_contexttype")) {
			where += " and aaa.contexttype  =" + params.get("EQ_contexttype");
		}
		if (params.containsKey("EQ_starttime")) {
			where += " and aaa.createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		if (params.containsKey("EQ_endtime")) {
			where += " and aaa.createtime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		sql += where + " order by aaa.createtime desc ,aaa.id desc  LIMIT " + (start - 1) * size + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}

	/* 以下企业捐赠数量 */
	@Override
	public Integer getCompanyCountbyParams(Map<String, Object> params, Community c) {
		String sql = "SELECT COUNT(*) FROM sq_donation WHERE type=3";
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

		if (params.containsKey("LIKE_company")) {
			where += " and company  like '%" + params.get("LIKE_company") + "%'";
		}
		if (params.containsKey("EQ_contexttype")) {
			where += " and contexttype  =" + params.get("EQ_contexttype");
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

	@Override
	public Integer getPriceByParams(Map<String, Object> params, Community c) {
		// 企业钱财数量
		String sql = "SELECT case when SUM(price) is null then 0 else  SUM(price) end FROM sq_donation WHERE contexttype=1 and type= 3 ";
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

		if (params.containsKey("LIKE_company")) {
			where += " and company  like '%" + params.get("LIKE_company") + "%'";
		}
		if (params.containsKey("EQ_contexttype")) {
			where += " and contexttype  =" + params.get("EQ_contexttype");
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

	@Override
	public Integer getDonationCountByParams(Map<String, Object> params, Community c) {
		// 企业物品数量
		String sql = "SELECT case when SUM(sq_donation_item.count) is null then 0 else  SUM(sq_donation_item.count) end FROM sq_donation LEFT JOIN sq_donation_item on sq_donation.id=sq_donation_item.donationid WHERE sq_donation.contexttype=2 and type= 3";
		String where = "";
		if (c != null) {
			if (c.getId() != null) {
				where += " and sq_donation.comid=" + c.getId();
			}
		} else {
			if (params.containsKey("EQ_community")) {
				where += " and sq_donation.comid  like '%" + params.get("EQ_community") + "%'";
			}
		}

		if (params.containsKey("LIKE_company")) {
			where += " and sq_donation.company  like '%" + params.get("LIKE_company") + "%'";
		}
		if (params.containsKey("EQ_contexttype")) {
			where += " and sq_donation.contexttype  =" + params.get("EQ_contexttype");
		}
		if (params.containsKey("EQ_starttime")) {
			where += " and sq_donation.createtime>=str_to_date('"
					+ params.get("EQ_starttime").toString().replaceAll("-", "") + "','%Y%m%d')";
		}
		if (params.containsKey("EQ_endtime")) {
			where += " and sq_donation.createtime<str_to_date('"
					+ params.get("EQ_endtime").toString().replaceAll("-", "") + "','%Y%m%d')";
		}
		sql += where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	/* 以下物品捐赠记录 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getGoodsDonations(Map<String, Object> params, int start, int size, String order,
			Community c) {
		/*
		 * String sql =
		 * "SELECT * FROM sq_donation WHERE type <> 3 and contexttype=2 ";
		 */
		String sql = "SELECT aaa.*,community.`name` communityname FROM (SELECT * FROM sq_donation WHERE type <> 3 AND contexttype = 2)as aaa LEFT JOIN community ON aaa.comid= community.id GROUP BY aaa.id HAVING 1 = 1";
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
			where += " and aaa.name  like '%" + params.get("LIKE_name") + "%'";
		}
		if (params.containsKey("LIKE_context")) {
			where += " and aaa.context  like '%" + params.get("LIKE_context") + "%'";
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

	/* 除企业外的物品捐赠数量 */
	@Override
	public Integer getDonationGoodsCountByParams(Map<String, Object> params, Community c) {
		// 企业物品数量
		String sql = "SELECT case when SUM(sq_donation_item.count) is null then 0 else  SUM(sq_donation_item.count) end FROM sq_donation LEFT JOIN sq_donation_item on sq_donation.id=sq_donation_item.donationid WHERE sq_donation.contexttype=2 and type<>3";
		String where = "";
		if (c != null) {
			if (c.getId() != null) {
				where += " and sq_donation.comid=" + c.getId();
			}
		} else {
			if (params.containsKey("EQ_community")) {
				where += " and sq_donation.comid  like '%" + params.get("EQ_community") + "%'";
			}
		}

		if (params.containsKey("LIKE_company")) {
			where += " and sq_donation.company  like '%" + params.get("LIKE_company") + "%'";
		}
		if (params.containsKey("EQ_contexttype")) {
			where += " and sq_donation.contexttype  =" + params.get("EQ_contexttype");
		}
		if (params.containsKey("EQ_starttime")) {
			where += " and sq_donation.createtime>=str_to_date('"
					+ params.get("EQ_starttime").toString().replaceAll("-", "") + "','%Y%m%d')";
		}
		if (params.containsKey("EQ_endtime")) {
			where += " and sq_donation.createtime<str_to_date('"
					+ params.get("EQ_endtime").toString().replaceAll("-", "") + "','%Y%m%d')";
		}
		sql += where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	/* 以下物品捐赠记录数量 */
	@Override
	public Integer getGoodsCountbyParams(Map<String, Object> params, Community c) {
		String sql = "SELECT COUNT(*)FROM sq_donation WHERE type <> 3 and contexttype=2 ";
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
			where += " and name  like '%" + params.get("LIKE_name") + "%'";
		}
		if (params.containsKey("LIKE_context")) {
			where += " and context  like '%" + params.get("LIKE_context") + "%'";
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

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getGeRenDonations(Map<String, Object> params, int start, int size, String order) {
		// TODO Auto-generated method stub

		String iscomm = "";
		if (params.containsKey("EQ_comid")) {
			iscomm += " WHERE 1 = 1 AND sqd.comid = " + params.get("EQ_comid") + "";
		}

		String where = "";
		if (params.containsKey("LIKE_name")) {
			where += " and aaa.name like '%" + params.get("LIKE_name") + "%' ";
		}

		if (params.containsKey("EQ_starttime")) {
			where += " and createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d') ";
		}

		if (params.containsKey("EQ_endtime")) {
			where += " and createtime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d') ";
		}

		String sql = "SELECT aaa.id, aaa.num, aaa. name, aaa.sex, aaa.total, aaa.things, aaa.createtime, aaa.phone, aaa.type FROM ( SELECT sqd.*, SUM(sqd_g.price * sqdg.count) AS total, GROUP_CONCAT(CONCAT(sqd_g.`name`,'x',CAST(sqdg.count AS CHAR),sqd_g.format)) AS things FROM sq_donation AS sqd LEFT JOIN sq_donationgood AS sqdg ON sqd.id = sqdg.donationid LEFT JOIN sq_donation_good AS sqd_g ON sqdg.goodid = sqd_g.id "
				+ iscomm + " GROUP BY sqd.id ) AS aaa WHERE 1 = 1 AND type=1 " + where
				+ " ORDER BY createtime DESC LIMIT " + (start - 1) * size + "," + size;

		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public Integer getGeRenCountbyParams(Map<String, Object> params) {
		// TODO Auto-generated method stub
		String iscomm = "";
		if (params.containsKey("EQ_comid")) {
			iscomm += " WHERE 1 = 1 AND sqd.comid = " + params.get("EQ_comid") + "";
		}

		String where = "";
		if (params.containsKey("LIKE_name")) {
			where += " and aaa.name like '%" + params.get("LIKE_name") + "%' ";
		}

		if (params.containsKey("EQ_starttime")) {
			where += " and createtime>=str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d') ";
		}

		if (params.containsKey("EQ_endtime")) {
			where += " and createtime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d') ";
		}

		String sql = "SELECT aaa.id, aaa.num, aaa. name, aaa.sex, aaa.total, aaa.things, aaa.createtime, aaa.phone, aaa.type FROM ( SELECT sqd.*, SUM(sqd_g.price * sqdg.count) AS total, GROUP_CONCAT(CONCAT(sqd_g.`name`,'x',CAST(sqdg.count AS CHAR),sqd_g.format)) AS things FROM sq_donation AS sqd LEFT JOIN sq_donationgood AS sqdg ON sqd.id = sqdg.donationid LEFT JOIN sq_donation_good AS sqd_g ON sqdg.goodid = sqd_g.id "
				+ iscomm + " GROUP BY sqd.id ) AS aaa WHERE 1 = 1 AND type=1 " + where;

		sql = "select count(*) from (" + sql + ") ttt";

		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

}
