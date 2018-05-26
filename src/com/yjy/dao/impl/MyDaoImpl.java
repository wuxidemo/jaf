package com.yjy.dao.impl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.stereotype.Service;

import com.yjy.Temporary.Tmprecord;
import com.yjy.dao.MyDao;
import com.yjy.entity.Order;
import com.yjy.entity.Sq_Propertyfee;
import com.yjy.entity.WXCard;

@Service
@NoRepositoryBean
public class MyDaoImpl implements MyDao {
	@PersistenceContext
	private EntityManager em;

	public int getRebateRecordCountByParam(Map<String, Object> params) {
		String sql = " select count(*) from rebaterecord rr where 1=1 ";
		if (params != null) {
			if (params.containsKey("EQ_rebateid")) {
				sql += " and rebateid=" + params.get("EQ_rebateid");
			}
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("GTE_createdate")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createdate>=str_to_date('" + sdf.format(params.get("GTE_createdate")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createdate")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createdate<=str_to_date('" + sdf.format(params.get("LTE_createdate")) + "','%Y%m%d')";
			}
			if (params.containsKey("LIKE_mycode")) {
				sql += " and mycode like '%" + params.get("LIKE_mycode") + "%'";
			}
			if (params.containsKey("LIKE_receivename")) {
				sql += " and receivename like '%" + params.get("LIKE_receivename") + "%'";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getRebateRecordSumByParam(Map<String, Object> params) {
		String sql = " select case when sum(price) is null then 0 else  sum(price) end from rebaterecord rr where 1=1 ";
		if (params != null) {
			if (params.containsKey("EQ_rebateid")) {
				sql += " and rebateid=" + params.get("EQ_rebateid");
			}
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("GTE_createdate")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createdate>=str_to_date('" + sdf.format(params.get("GTE_createdate")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createdate")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and createdate<=str_to_date('" + sdf.format(params.get("LTE_createdate")) + "','%Y%m%d')";
			}
			if (params.containsKey("LIKE_mycode")) {
				sql += " and mycode like '%" + params.get("LIKE_mycode") + "%'";
			}
			if (params.containsKey("LIKE_receivename")) {
				sql += " and receivename like '%" + params.get("LIKE_receivename") + "%'";
			}
		}
		Integer sum = Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
		return sum == null ? 0 : sum;
	}

	@SuppressWarnings("unchecked")
	public List<Order> getOrderByParam(Map<String, Object> params, int start, int count, String order) {
		String sql = " select * from myorder where 1=1 and state!=0 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and merchantid=" + params.get("EQ_merchantid");
			}
		}
		if (order != null) {
			sql += " order by " + order;
		}

		sql += "  LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql, Order.class).getResultList();
	}

	public int getOrderCountByParam(Map<String, Object> params) {
		String sql = " select count(*) from myorder where 1=1 and state!=0 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getOrderSumPriceByParam(Map<String, Object> params) {
		String sql = " select case when sum(price) is null then 0 else  sum(price) end from myorder where 1=1 and state!=0 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getOrderSumPayPriceByParam(Map<String, Object> params) {
		String sql = " select case when sum(payprice) is null then 0 else  sum(payprice) end from myorder where 1=1 and state!=0 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@SuppressWarnings("unchecked")
	public List<WXCard> getCardByLocation(String id) {
		String sql = "SELECT * FROM wxcard where (locationids like '%," + id + ",%' or locationids like '%" + id
				+ ",%' or locationids like '%," + id + "%' or locationids='" + id
				+ "' )  and ((  endtime >=NOW() and datetype=1 ) or ( datetype=2) ) and mytype=1 and state=1";
		return em.createNativeQuery(sql, WXCard.class).getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<WXCard> getAllUserCard() {
		String sql = "SELECT * FROM wxcard where  nownum >0 and ((  endtime >=NOW() and datetype=1 ) or ( datetype=2) ) and mytype=1 and state=1";
		return em.createNativeQuery(sql, WXCard.class).getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<WXCard> getAllJFUserCard() {
		String sql = "SELECT * FROM wxcard where  nownum >0 and (( endtime >=NOW() and datetype=1 ) or ( datetype=2) ) and mytype=2 and state=1 and count is not null";
		return em.createNativeQuery(sql, WXCard.class).getResultList();
	}

	public int getCardCountByorder(Map<String, Object> params) {
		String sql = " SELECT count(*) from wxcardrecord wr LEFT JOIN myorder mo on mo.id=wr.orderid where 1=1 and wr.state=2 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and mo.state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and mo.code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and mo.merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getCardbankPriceByorder(Map<String, Object> params) {
		String sql = " SELECT  case when sum(wr.bankprice) is null then 0 else  sum(wr.bankprice) end  from wxcardrecord wr LEFT JOIN myorder mo on mo.id=wr.orderid where 1=1 and wr.state=2 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and mo.state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and mo.code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and mo.merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getCardshopPriceByorder(Map<String, Object> params) {
		String sql = " SELECT  case when sum(wr.shopprice) is null then 0 else  sum(wr.shopprice) end  from wxcardrecord wr LEFT JOIN myorder mo on mo.id=wr.orderid where 1=1 and wr.state=2 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and mo.state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and mo.code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and mo.paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and mo.merchantid=" + params.get("EQ_merchantid");
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getOrderData(Map<String, Object> params, int start, int count, String order) {
		String sql = "SELECT o.id,o.`code`,o.paytime,o.payname,o.price,o.payprice, a.cardprice,o.state,o.wxcode,o.merhchantname,a.cardshopprice FROM myorder o left JOIN ( select SUM(wcr.bankprice) as cardprice,SUM(wcr.shopprice) as cardshopprice,wcr.orderid from wxcardrecord wcr GROUP BY wcr.orderid) a on a.orderid=o.id where 1=1 and state!=0 ";
		if (params != null) {
			if (params.containsKey("EQ_state")) {
				sql += " and o.state=" + params.get("EQ_state");
			}
			if (params.containsKey("LIKE_code")) {
				sql += " and o.code like '%" + params.get("LIKE_code") + "%'";
			}
			if (params.containsKey("GTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.paytime>=str_to_date('" + sdf.format(params.get("GTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_paytime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.paytime<=str_to_date('" + sdf.format(params.get("LTE_paytime")) + "','%Y%m%d')";
			}
			if (params.containsKey("EQ_merchantid")) {
				sql += " and o.merchantid=" + params.get("EQ_merchantid");
			}
		}
		if (order != null) {
			sql += " order by " + order;
		}

		sql += "  LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql).getResultList();
	}

	/**
	 * 
	 * 查询领取记录数量
	 * 
	 * @author luyf
	 * @date 2015年8月7日 下午6:16:32
	 * @param params
	 * @return
	 */
	public int getTmpRecordCount(Map<String, Object> params) {
		String sql = " select count(*) from tmprecord o where o.state=2 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getTmpRecordSumPrice(Map<String, Object> params) {
		String sql = " select case when sum(o.price) is null then 0 else  sum(o.price) end  from tmprecord o where ( o.state=1 or o.state=2 ) ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getTmpRecordSumRebatePrice(Map<String, Object> params) {
		String sql = " select case when sum(o.rebateprice) is null then 0 else  sum(o.rebateprice) end  from tmprecord o where ( o.state=1 or o.state=2 ) ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@SuppressWarnings("unchecked")
	public List<Tmprecord> getTmprecordByParam(Map<String, Object> params, int start, int count, String order) {
		String sql = "select * from Tmprecord o where ( o.state=1 or o.state=2 ) ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		if (order != null) {
			sql += " order by " + order;
		}

		sql += "  LIMIT " + (start - 1) * count + "," + count;
		return em.createNativeQuery(sql, Tmprecord.class).getResultList();
	}

	public int getTmprecordCountByParam(Map<String, Object> params) {
		String sql = "select count(*) from Tmprecord o where ( o.state=1 or o.state=2 ) ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getIntrgralRecordCountByParam(Map<String, Object> params) {
		String sql = "select count(*) from integralrecord o where 1=1 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getIntrgralRecordPriceByParam(Map<String, Object> params) {
		String sql = "select case when  sum(w.price) is null then 0 else   sum(w.price) end from integralrecord o LEFT JOIN wxcardrecord wr on wr.`code`=o.cardcode LEFT JOIN wxcard w on w.cardid=wr.cardid where 1=1 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getIntrgralRecordJFByParam(Map<String, Object> params) {
		String sql = "select case when  sum(o.count) is null then 0 else   sum(o.count) end from integralrecord o  where 1=1 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getIntrgralRecordUsePriceByParam(Map<String, Object> params) {
		String sql = "select case when  sum(w.price) is null then 0 else   sum(w.price) end from integralrecord o LEFT JOIN wxcardrecord wr on wr.`code`=o.cardcode LEFT JOIN wxcard w on w.cardid=wr.cardid where wr.state=2 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	public int getIntrgralRecordUseCountByParam(Map<String, Object> params) {
		String sql = "select count(wr.id) from integralrecord o LEFT JOIN wxcardrecord wr on wr.`code`=o.cardcode LEFT JOIN wxcard w on w.cardid=wr.cardid where wr.state=2 ";
		if (params != null) {
			if (params.containsKey("GTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime>=str_to_date('" + sdf.format(params.get("GTE_createtime")) + "','%Y%m%d')";
			}
			if (params.containsKey("LTE_createtime")) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				sql += " and o.createtime<=str_to_date('" + sdf.format(params.get("LTE_createtime")) + "','%Y%m%d')";
			}
		}
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByDistance(String lat, String lon, int start, int size) {
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.classify,b.businessid,b.juli,a.wcname, (CASE WHEN c.avgscore IS NULL THEN 0 ELSE c.avgscore END)  AS score from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost,m.classify as classify,m.businessid,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a "
				+ " ON b.merid = a.msubid LEFT JOIN (SELECT merid, (CASE WHEN AVG(score) is NULL THEN 0 ELSE ROUND(AVG(score),1) END ) AS avgscore  FROM `mercomment` GROUP BY merid) c ON b.merid = c.merid where b.telephone is not null and b.state=1 limit "
				+ (start) + ", " + size + "";
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByArea(String key, String lat, String lon, int day, String time, int start,
			int size) {
		String sql = "SELECT aaa.* FROM  (SELECT merch.merid,merch.mername,merch.category,merch.thumbnailurl, merch.juli, card.conname,merch.state, merch.areaid from  "
				+ " (SELECT m.id as merid,m.name as mername,m.category,m.thumbnailurl,m.state, m.areaid, FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-"
				+ lat + ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon
				+ ")*PI()/360.0),2))))  as juli from merchant m ORDER BY juli ASC) merch  "
				+ " LEFT JOIN (SELECT merchantid,GROUP_CONCAT(`name`) as conname from(SELECT ma.id AS actid, mc.id, mc. NAME, mc.merchantid FROM mycard mc"
				+ " LEFT JOIN myactivitymycard mamc ON mamc.mycard_id = mc.id"
				+ " LEFT JOIN myactivity ma ON ma.id = mamc.myactivity_id"
				+ " LEFT JOIN merchant mer ON mer.id = ma.merchant_id" + " WHERE ma.state = 1 AND ma.isonline = 1"
				+ " AND ma.ustime <= '" + time + "'" + " AND ma.uetime >= '" + time + "'"
				+ " AND (ma.datetype = 1 OR (ma.datetype = 2 AND ma.dates LIKE '%" + day + "%'))"
				+ " AND DATE_FORMAT(NOW(), '%Y%m%d') >= DATE_FORMAT(mamc.starttime, '%Y%m%d')"
				+ " AND DATE_FORMAT(NOW(), '%Y%m%d') <= DATE_FORMAT(mamc.endtime, '%Y%m%d') )a GROUP BY a.merchantid) card"
				+ " ON merch.merid = card.merchantid) aaa" + " where aaa.state=1 and aaa.areaid=" + key + "" + " limit "
				+ (start) + ", " + size + "";
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByClassify(String lat, String lon, int start, int size, String pid, String id) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.pclassify, b.classify,b.businessid,b.juli,a.wcname from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost, m.pclassify as pclassify, m.classify as classify,m.businessid,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a ";

		if (pid == null || "0".equals(pid)) {
			sql += " ON b.merid = a.msubid where b.telephone is not null and b.state=1 limit " + (start) + ", " + size
					+ "";
		} else if (id == null || "0".equals(id)) {
			sql += " ON b.merid = a.msubid where b.telephone is not null and b.state=1 AND b.pclassify=" + pid
					+ " limit " + (start) + ", " + size + "";
		} else {
			sql += " ON b.merid = a.msubid where b.telephone is not null and b.state=1 AND b.classify=" + id + " limit "
					+ (start) + ", " + size + "";
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByBusiness(String lat, String lon, int start, int size, String id) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.classify,b.businessid,b.juli,a.wcname from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost,m.classify as classify,m.businessid,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a ";

		if (id == null || "0".equals(id)) {
			sql += " ON b.merid = a.msubid where b.telephone is not null and b.state=1 limit " + (start) + ", " + size
					+ "";
		} else {
			sql += " ON b.merid = a.msubid where b.telephone is not null and b.state=1 AND b.businessid=" + id
					+ " limit " + (start) + ", " + size + "";
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByKeywords(String lat, String lon, int start, int size, String keywords) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.classify,b.businessid, b.juli,a.wcname,b.keywords,(CASE WHEN c.avgscore IS NULL THEN 0 ELSE c.avgscore END) AS score from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost,m.classify as classify,m.businessid, m.keywords,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a ";

		if (keywords == null || "".equals(keywords.trim())) {
			sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 limit " + (start) + ", " + size
					+ "";
		} else {
			sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND (b.keywords like '%"
					+ keywords + "%' OR b.mername like '%" + keywords + "%' OR a.wcname like '%" + keywords
					+ "%') limit " + (start) + ", " + size + "";
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantByCommunity(String lat, String lon, int start, int size, String commid) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.classify,b.community,b.juli,a.wcname,(CASE WHEN c.avgscore IS NULL THEN 0 ELSE c.avgscore END) AS score from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost,m.classify as classify,m.businessid, m.community,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a ";

		if (commid == null || "0".equals(commid.trim()) || "".equals(commid.trim())) {
			sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.community is not null limit "
					+ (start) + ", " + size + "";
		} else {
			sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.community=" + commid
					+ " limit " + (start) + ", " + size + "";
		}

		System.out.println(sql);

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getWXCardByBusiness(String id, int start, int size) {
		// TODO Auto-generated method stub
		String sql = "SELECT GROUP_CONCAT(m.poi_id) as poi_ids,GROUP_CONCAT(m.`name`) as mernames, GROUP_CONCAT(m.thumbnailurl) as thimgs, wc.`name`, wc.cardid, wc.type, wc.isonly from merchant m , wxcard wc where (wc.locationids like CONCAT('%,',m.poi_id) OR wc.locationids=m.poi_id OR wc.locationids like CONCAT('%,',m.poi_id,',%') or wc.locationids like CONCAT(m.poi_id,',%')) and   "
				+ "wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1";

		if (id == null || "0".equals(id.trim())) {
			sql += " GROUP BY wc.cardid limit " + (start) + ", " + size + "";
		} else {
			sql += " AND m.businessid=" + id + " GROUP BY wc.cardid limit " + (start) + ", " + size + "";
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	public List<Object[]> getWXCardByOrder(String type, int start, int size) {
		// TODO Auto-generated method stub
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getPublishedFinanceInfo(Long commid, int start, int size) {
		String sql = "select fi.id,fi.title,fi.url,fi.count,fi.publishtime from financeinfo fi where fi.state=1 ORDER BY fi.updatetime desc limit "
				+ (start) + "," + size + "";

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMerchantsByOption(String lat, String lon, int start, int size, String pid, String id,
			String bid) {
		// TODO Auto-generated method stub
		String sql = "SELECT b.merid,b.thumbnailurl,b.mername,b.onecost,b.pclassify, b.classify,b.businessid,b.juli,a.wcname, (CASE WHEN c.avgscore IS NULL THEN 0 ELSE c.avgscore END) AS score from (SELECT   "
				+ "m.id as merid,m.thumbnailurl,m.name as mername,CAST(m.onecost AS CHAR) AS onecost, m.pclassify as pclassify, m.classify as classify,m.businessid,  "
				+ " FLOOR(2*6371393*ASIN(SQRT( POW(SIN(ABS(m.latitude-" + lat
				+ ")*PI()/360.0),2) + COS(m.latitude*PI()/180.0)* COS(" + lat
				+ "*PI()/180.0) * POW(SIN(ABS(m.longitude-" + lon + ")*PI()/360.0),2))))  as juli, "
				+ " m.telephone, m.state, m.poi_id from merchant m ORDER BY juli ASC) b LEFT JOIN"
				+ " (SELECT msub.id as msubid, msub.poi_id, GROUP_CONCAT(wc.`name`) as wcname from merchant msub LEFT JOIN wxcard wc ON wc.locationids like CONCAT('%,',msub.poi_id) OR wc.locationids=msub.poi_id OR wc.locationids like CONCAT('%,',msub.poi_id,',%') or wc.locationids like CONCAT(msub.poi_id,',%') where wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1  GROUP BY msubid,poi_id) a ";

		if (bid == null || "0".equals(bid)) {
			if (pid == null || "0".equals(pid)) {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 limit " + (start) + ", "
						+ size + "";
			} else if (id == null || "0".equals(id)) {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.pclassify=" + pid
						+ " limit " + (start) + ", " + size + "";
			} else {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.classify=" + id
						+ " limit " + (start) + ", " + size + "";
			}
		} else {
			if (pid == null || "0".equals(pid)) {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.businessid=" + bid
						+ " limit " + (start) + ", " + size + "";
			} else if (id == null || "0".equals(id)) {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.businessid=" + bid
						+ " AND b.pclassify=" + pid + " limit " + (start) + ", " + size + "";
			} else {
				sql += " ON b.merid = a.msubid LEFT JOIN (SELECT merid,(CASE WHEN AVG(score) IS NULL THEN 0 ELSE ROUND(AVG(score), 1) END ) AS avgscore FROM `mercomment` GROUP BY merid ) c ON b.merid = c.merid where b.telephone is not null and b.state=1 AND b.businessid=" + bid
						+ " AND b.classify=" + id + " limit " + (start) + ", " + size + "";
			}
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getCardByOption(int start, int size, String businessid, String sort) {
		String sql = "SELECT GROUP_CONCAT(m.poi_id) as poi_ids,GROUP_CONCAT(m.`name`) as mernames, GROUP_CONCAT(m.thumbnailurl) as thimgs, wc.`name`, wc.cardid, wc.type, wc.isonly,(wc.totalnum-wc.nownum) as outnum,(CASE WHEN (wc.type = 'CASH' AND wc.leastprice !=0 AND wc.leastprice is NOT NULL ) THEN  FORMAT((wc.price/wc.leastprice),2) WHEN (type = 'CASH'  AND (wc.leastprice =0 OR wc.leastprice is NULL )) THEN FORMAT((wc.price/100),2)  WHEN wc.type = 'DISCOUNT' THEN wc.price  WHEN wc.type = 'GIFT' THEN 0 WHEN wc.type = 'GROUPON' THEN 0 WHEN wc.type = 'GENERAL_COUPON' THEN 0 ELSE 0 END) + 0 as lidu,wc.createtime from merchant m , wxcard wc where (wc.locationids like CONCAT('%,',m.poi_id) OR wc.locationids=m.poi_id OR wc.locationids like CONCAT('%,',m.poi_id,',%') or wc.locationids like CONCAT(m.poi_id,',%')) and   "
				+ "wc.nownum >0 and ((  wc.endtime >=NOW() and wc.datetype=1 ) or ( datetype=2) ) and wc.mytype=1 and wc.state=1";

		if (sort == null || "".equals(sort)) {
			if (businessid == null || "0".equals(businessid.trim())) {
				sql += " AND m.telephone is not null and m.state=1  GROUP BY wc.cardid ORDER BY lidu DESC, outnum desc, createtime DESC limit "
						+ (start) + ", " + size + "";
			} else {
				sql += " AND m.telephone is not null and m.state=1 and m.businessid=" + businessid
						+ " GROUP BY wc.cardid  ORDER BY lidu DESC, outnum desc, createtime DESC limit " + (start)
						+ ", " + size + "";
			}
		} else if ("1".equals(sort)) {
			if (businessid == null || "0".equals(businessid.trim())) {
				sql += " AND m.telephone is not null and m.state=1  GROUP BY wc.cardid ORDER BY outnum desc limit "
						+ (start) + ", " + size + "";
			} else {
				sql += " AND m.telephone is not null and m.state=1 and  m.businessid=" + businessid
						+ " GROUP BY wc.cardid ORDER BY outnum desc limit " + (start) + ", " + size + "";
			}
		} else if ("2".equals(sort)) {
			if (businessid == null || "0".equals(businessid.trim())) {
				sql += " AND m.telephone is not null and m.state=1  GROUP BY wc.cardid ORDER BY lidu DESC limit "
						+ (start) + ", " + size + "";
			} else {
				sql += " AND m.telephone is not null and m.state=1 and m.businessid=" + businessid
						+ " GROUP BY wc.cardid ORDER BY lidu DESC limit " + (start) + ", " + size + "";
			}
		} else if ("3".equals(sort)) {
			if (businessid == null || "0".equals(businessid.trim())) {
				sql += " AND m.telephone is not null and m.state=1  GROUP BY wc.cardid ORDER BY createtime DESC limit "
						+ (start) + ", " + size + "";
			} else {
				sql += " AND m.telephone is not null and m.state=1 and m.businessid=" + businessid
						+ " GROUP BY wc.cardid ORDER BY createtime DESC limit " + (start) + ", " + size + "";
			}
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getYiCangRecordsByComid(Long comid) {
		// TODO Auto-generated method stub

		String juancomstr = "";
		String zengcomstr = "";
		if (comid != 0 && !"".equals(comid)) {
			juancomstr += " and sqd.comid=" + comid + " ";
			zengcomstr += " and comid=" + comid + " ";
		}

		String sql = "SELECT * FROM ( SELECT 1 AS leibie, sqd.name, sqd.type, sqd.context, sqd.createtime, sqd.price, sqd.company, sqd.contexttype, sqd.context AS things, sqd.price AS total, sqd.picurl, sqd.id FROM sq_donation AS sqd WHERE 1 = 1 "
				+ juancomstr
				+ " UNION SELECT 2 AS leibie, CONCAT(sqg.firstname, sqg.lastname) AS NAME, NULL AS type, context, createtime, price, NULL AS company, NULL AS contexttype, NULL AS things, NULL AS total, picurl, sqg.id FROM sq_giftrecord sqg WHERE 1 = 1 "
				+ zengcomstr + ") bbb ORDER BY createtime DESC, id DESC LIMIT 0, 20";
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getYiCangRecordsByComidWithPage(Long comid, String type, int start, int size) {
		// TODO Auto-generated method stub

		String juancomstr = "";
		String zengcomstr = "";
		if (comid != 0 && !"".equals(comid)) {
			juancomstr += " and sqd.comid=" + comid + " ";
			zengcomstr += " and comid=" + comid + " ";
		}

		String sql = "SELECT * FROM ( SELECT 1 AS leibie, sqd.name, sqd.type, sqd.context, sqd.createtime, sqd.price, sqd.company, sqd.contexttype, sqd.context AS things, sqd.price AS total, sqd.picurl, sqd.id FROM sq_donation AS sqd WHERE 1 = 1 "
				+ juancomstr
				+ " UNION SELECT 2 AS leibie, CONCAT(sqg.firstname, sqg.lastname) AS NAME, NULL AS type, context, createtime, price, NULL AS company, NULL AS contexttype, NULL AS things, NULL AS total, picurl, id FROM sq_giftrecord sqg WHERE 1 = 1 "
				+ zengcomstr + ") bbb where 1=1 ";

		if ("0".equals(type)) {
			sql += "ORDER BY createtime DESC, id DESC LIMIT " + start + " , " + size + "";
		} else if ("1".equals(type)) {
			sql += " AND leibie=1 ORDER BY createtime DESC, id DESC LIMIT " + start + " , " + size + "";
		} else if ("2".equals(type)) {
			sql += " AND leibie=2 ORDER BY createtime DESC, id DESC LIMIT " + start + " , " + size + "";
		} else {
			sql += "ORDER BY createtime DESC, id DESC LIMIT " + start + " , " + size + "";
		}

		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMyDonationsByPhone(String phone, int start, int size) {
		// TODO Auto-generated method stub
		String sql = "SELECT 1 AS leibie, sqd. NAME, sqd.type, sqd.context, sqd.createtime, sqd.price, sqd.company, sqd.contexttype, sqd.context AS things, sqd.price AS total, sqd.picurl, sqd.id FROM sq_donation AS sqd WHERE 1 = 1 AND sqd.phone="
				+ phone + " ORDER BY sqd.createtime DESC, sqd.id DESC limit " + start + ", " + size + "";
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMygiftsByPhone(String phone, int start, int size) {
		// TODO Auto-generated method stub
		String sql = "SELECT 2 AS leibie, CONCAT(sqg.firstname, sqg.lastname) AS NAME, 1 AS type, context, createtime, price, 1 AS company, 1 AS contexttype, 1 AS things, 1 AS total, picurl, sqg.id FROM sq_giftrecord sqg WHERE phone ='"
				+ phone + "' ORDER BY createtime DESC, id DESC limit " + start + ", " + size + "";
		return (List<Object[]>) em.createNativeQuery(sql).getResultList();
	}

	/************************* 2016-04-20添加 ****************************/

	@Override
	@SuppressWarnings("unchecked")
	public List<WXCard> getQiangGouActCard() {
		String sql = "SELECT * FROM wxcard where  nownum >0 and ((  endtime >=NOW() and datetype=1 ) or ( datetype=2) ) and mytype=3 and state=1";
		return em.createNativeQuery(sql, WXCard.class).getResultList();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Sq_Propertyfee> getMyFeeListByOpenid(String openid, int start, int size) {
		// TODO Auto-generated method stub
		String sql = "SELECT sqp.* FROM  (SELECT * FROM sq_wy_telephone swt WHERE openid='" + openid
				+ "') aaa LEFT JOIN sq_propertyfee sqp ON aaa.telephone = sqp.telephone  WHERE sqp.id IS NOT NULL ORDER BY sqp.state ASC, sqp.createtime DESC LIMIT "
				+ start + "," + size;
		return em.createNativeQuery(sql, Sq_Propertyfee.class).getResultList();
	}

	/************************* 2016-04-22添加（活动报名） ****************************/

	@SuppressWarnings("unchecked")
	@Override
	public List<Object[]> getSqPensionActDateByParams(Map<String, Object> params, int start, int size, String order) {
		String sql = "SELECT * FROM sq_pensionact WHERE 1=1";
		String where = "";
		if (params.containsKey("LIKE_name")) {

			where += " and name like '%" + params.get("LIKE_name") + "%'";

		}
		if (params.containsKey("EQ_starttime")) {
			where += " and endtime>str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		if (params.containsKey("EQ_endtime")) {
			where += " and starttime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		sql += where + " order by createtime desc , id desc  LIMIT " + (start - 1) * size + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}

	@Override
	public Integer getSqPensionActCountByParams(Map<String, Object> params) {
		String sql = "SELECT COUNT(*) FROM sq_pensionact WHERE 1=1";
		String where = "";
		if (params.containsKey("LIKE_name")) {

			where += " and name like '%" + params.get("LIKE_name") + "%'";

		}
		if (params.containsKey("EQ_starttime")) {
			where += " and endtime>str_to_date('" + params.get("EQ_starttime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		if (params.containsKey("EQ_endtime")) {
			where += " and starttime<str_to_date('" + params.get("EQ_endtime").toString().replaceAll("-", "")
					+ "','%Y%m%d')";
		}
		sql += where;
		return Integer.parseInt(em.createNativeQuery(sql).getSingleResult().toString());
	}
	
	/**
	 * 我申请的活动 根据openid查询
	 */
	@Override
	@SuppressWarnings("unchecked")
	public List<Object[]> getMyPensionApplyByOpenid(String openid, int start, int size) {
		String sql = "SELECT bbb.id, bbb.`name` AS actname, aaa.name AS applyname, aaa.createtime, aaa.id AS applyid,aaa.content  FROM (SELECT name, createtime, sqactid, id,content FROM sq_pensionapply WHERE openid='"+openid+"' ) aaa LEFT JOIN sq_pensionact bbb ON aaa.sqactid = bbb.id ORDER BY aaa.createtime DESC LIMIT "+ start + "," + size;
		return em.createNativeQuery(sql).getResultList();
	}
}
