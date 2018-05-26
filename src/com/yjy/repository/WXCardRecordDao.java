package com.yjy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.WXCardRecord;

public interface WXCardRecordDao
		extends PagingAndSortingRepository<WXCardRecord, Long>, JpaSpecificationExecutor<WXCardRecord> {
	@Query(value = " from WXCardRecord where code=?1")
	public List<WXCardRecord> getWXCardRecordByCode(String code);
	// @Query(value = " from WXCardRecord where code=?1")
	// public List<WXCardRecord> getWXCardRecordByCode(String code);

	@Query(nativeQuery = true, value = " update WXCardRecord set state=?1 ,usetime=?2 where orderid=?3")
	@Modifying
	public void updateState(int state, Date paydate, Long orderid);

	@Query(nativeQuery = true, value = " update WXCardRecord set merchantid=?1,merchantname=?2,orderid=?3,ordercode=?4 where code=?5")
	@Modifying
	public void updateUseState(Long merchantid, String merchantname, Long orderid, String ordercode, String code);

	@Query(value = " from WXCardRecord where orderid=?1")
	public List<WXCardRecord> getWXCardRecordByOrderid(Long codeid);

	@Query(nativeQuery = true, value = "UPDATE wxcardrecord set state=4  where endtime <?1 and state=1")
	@Modifying
	public void updateOverCard(Date now);

	@Query(value = " from WXCardRecord where state =?1")
	public List<WXCardRecord> getListByState(int state);

	@Query(nativeQuery = true, value = "SELECT w.`name`,w.isonly,w.logourl,w.merchantname,wr.starttime,wr.endtime,wr.`code`,wr.cardid FROM `wxcardrecord` wr  LEFT JOIN wxcard w on w.cardid=wr.cardid where wr.openid=?1 and wr.state=1")
	public List<Object[]> getDataByOpenid(String openid);

	@Query(nativeQuery = true, value = "SELECT w.`name`,w.isonly,w.logourl,w.merchantname,wr.starttime,wr.endtime,wr.`code`,wr.cardid,wr.state,wr.usetime,date_add(wr.endtime, interval 1 day) as ovtime FROM `wxcardrecord` wr  LEFT JOIN wxcard w on w.cardid=wr.cardid where wr.state!=1 and wr.openid=?1 ")
	public List<Object[]> getUsedDataByOpenid(String openid);

	@Query(nativeQuery = true, value = " SELECT * from(select cardname,`code`,ownname,usetime,bankprice,shopprice from wxcardrecord where date_format(usetime,'%Y%m%d')=?1 and merchantid=?2 union select name,`code`,nickname,usedate,0,price from act_cardrecord   where merid=?2 and date_format(usedate,'%Y%m%d')=?1 ) a  ORDER BY a.usetime asc ")
	public List<Object[]> getMerUsedRecord(String time, Long merid);

	@Query(nativeQuery = true, value = "SELECT * from(select cardname,`code`,ownname,usetime,bankprice,shopprice from wxcardrecord where date_format(usetime,'%Y%m%d')=?1 and merchantid=?2 and cardid=?3 union select name,`code`,nickname,usedate,0,price from act_cardrecord   where merid=?2 and date_format(usedate,'%Y%m%d')=?1 and cast(winname as char(12))=?3 ) a  ORDER BY a.usetime asc")
	public List<Object[]> getMerUsedRecordByCardid(String time, Long merid, String cardid);

	@Query(nativeQuery = true, value = " SELECT  cardid,cardname from wxcardrecord where merchantid=?1 and date_format(usetime,'%Y%m%d')=?2  GROUP BY cardid UNION SELECT  cast(winname as char(12)),name from act_cardrecord where merid=?1 and date_format(usedate,'%Y%m%d')=?2  GROUP BY winname")
	public List<Object[]> getCardNames(Long merid, String time);
	
	/*查询当天的卡卷发行使用记录*/
	@Query(nativeQuery = true, value="SELECT* FROM(SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE DATE_FORMAT(wxcard.createtime,'%Y-%m-%d')=CURDATE()GROUP BY wxcard.cardid) a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2  AND  (DATE_FORMAT(wxcardrecord.createtime,'%Y-%m-%d')=CURDATE()) GROUP BY wxcardrecord.cardid) a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List();
	
	/*查询最近7天的记录卡卷发行使用记录*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE ((DATE_FORMAT(wxcard.createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 7 DAY),'%Y-%m-%d') AND  CURDATE())GROUP BY wxcard.cardid) a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2  AND  ((DATE_FORMAT(wxcardrecord.createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 7 DAY),'%Y-%m-%d') AND  CURDATE()) GROUP BY wxcardrecord.cardid) a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List1();
	
	/*查询最近30天的记录卡卷发行使用记录*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE ((DATE_FORMAT(wxcard.createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 30 DAY),'%Y-%m-%d') AND  CURDATE())GROUP BY wxcard.cardid) a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2  AND  ((DATE_FORMAT(wxcardrecord.createtime,'%Y-%m-%d')) BETWEEN DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 30 DAY),'%Y-%m-%d') AND  CURDATE()) GROUP BY wxcardrecord.cardid) a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List2();
	
	/*查询卡券的所有发行使用记录*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid  GROUP BY wxcard.cardid)a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2 GROUP BY wxcardrecord.cardid)a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List3();
	
	
	/*根据商家id查询商家卡券的发行使用记录*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE wxcardrecord.merchantid=?1  GROUP BY wxcard.cardid)a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2 AND wxcardrecord.merchantid=?1 GROUP BY wxcardrecord.cardid)a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List4(int id);
	
	/*根据开始和结束时间查询数据*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE ((DATE_FORMAT(wxcard.createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 )GROUP BY wxcard.cardid) a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2  AND  ((DATE_FORMAT(wxcardrecord.createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) GROUP BY wxcardrecord.cardid) a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List5(Date a,Date b);
	
	/*根据开始和结束时间跟商家id进行组合查询*/
	@Query(nativeQuery=true,value="SELECT* FROM (SELECT (wxcard.cardid)as a, (wxcard.`name`)as b,(wxcard.totalnum-wxcard.nownum)AS c ,COUNT(wxcard.cardid) AS d FROM wxcard LEFT JOIN wxcardrecord ON wxcard.cardid=wxcardrecord.cardid WHERE ((DATE_FORMAT(wxcard.createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND wxcardrecord.merchantid=?3 GROUP BY wxcard.cardid) a1 LEFT JOIN (SELECT (wxcardrecord.cardid) as e,(wxcardrecord.cardname)as f ,COUNT(wxcardrecord.cardid) AS g FROM wxcardrecord WHERE wxcardrecord.state=2  AND  ((DATE_FORMAT(wxcardrecord.createtime,'%Y-%m-%d')) BETWEEN ?1 AND ?2 ) AND wxcardrecord.merchantid=?3 GROUP BY wxcardrecord.cardid) a2 ON a1.a=a2.e")
	public List<Object> getcoupon1List6(Date a,Date b,int id);

	
	@Query(nativeQuery=true,value="select * from wxcardrecord where openid=?1 and cardid=?2")
	public List<WXCardRecord> getWXCardByOpenidAndCardid(String openid, String cardid);
	
	
}
