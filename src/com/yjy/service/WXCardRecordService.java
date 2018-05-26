package com.yjy.service;

import java.util.Date;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.WXCardRecord;
import com.yjy.repository.WXCardRecordDao;
import com.yjy.utils.Util;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class WXCardRecordService {
	@Autowired
	public WXCardRecordDao wxcardrecordDao;
	@Autowired
	WeChatAccountService weChatAccountService;

	public Page<WXCardRecord> getWXCardRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<WXCardRecord> spec = Util.buildSpecification(searchParams, WXCardRecord.class);
		return wxcardrecordDao.findAll(spec, pageRequest);
	}

	// 查询导出数据
	public List<WXCardRecord> getDownRecord(Map<String, Object> searchParams) {
		Specification<WXCardRecord> spec = Util.buildSpecification(searchParams, WXCardRecord.class);
		return wxcardrecordDao.findAll(spec, new Sort(Direction.DESC, "merchantid"));
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public WXCardRecord getWXCardRecordByCode(String code) {
		List<WXCardRecord> lwr = wxcardrecordDao.getWXCardRecordByCode(code);
		if (lwr.size() == 1) {
			return lwr.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 
	 * 根据订单ID更新状态
	 * 
	 * @author lyf
	 * @date 2015年7月7日 下午3:15:40
	 * @param state
	 * @param paydate
	 * @param codeid
	 */
	public void updateState(int state, Date paydate, Long codeid) {
		wxcardrecordDao.updateState(state, paydate, codeid);
	}

	public void updateUseState(Long merchantid, String merchantname, Long orderid, String ordercode, String code) {
		wxcardrecordDao.updateUseState(merchantid, merchantname, orderid, ordercode, code);
	}

	public List<WXCardRecord> getWXCardRecordByOrderid(Long codeid) {
		return wxcardrecordDao.getWXCardRecordByOrderid(codeid);
	}

	/**
	 * 
	 * 更新过期记录
	 * 
	 * @author luyf
	 * @date 2015年7月20日 下午3:17:10
	 * @param now
	 */
	public void updateOverCard() {
		wxcardrecordDao.updateOverCard(new Date());
	}

	public void refreshCardRrcord() {
		List<WXCardRecord> lwcr = (List<WXCardRecord>) wxcardrecordDao.findAll();
		for (WXCardRecord wcr : lwcr) {
			updateTime(wcr);
		}
	}

	/**
	 * 
	 * 更新记录有效期
	 * 
	 * @author luyf
	 * @date 2015年7月20日 下午3:32:39
	 * @param wcr
	 */
	public void updateTime(WXCardRecord wcr) {
		Map<String, Object> data = WXCardManage.getCodeInfo(weChatAccountService.getAccesstoken(), wcr.getCode(), null);
		if (data == null || !data.get("errcode").toString().equals("0")) {
			return;
		}
		Map<String, Object> card = (Map<String, Object>) data.get("card");
		wcr.setStarttime(new Date(Long.parseLong(card.get("begin_time") + "000")));
		wcr.setEndtime(new Date(Long.parseLong(card.get("end_time") + "000")));
		wxcardrecordDao.save(wcr);
	}

	/**
	 * 
	 * 根据OPENID查数据
	 * 
	 * @author luyf
	 * @date 2015年7月20日 下午3:50:05
	 * @param openid
	 * @return
	 */
	public List<Object[]> getDataByOpenid(String openid) {
		return wxcardrecordDao.getDataByOpenid(openid);
	}

	public List<Object[]> getUsedDataByOpenid(String openid) {
		return wxcardrecordDao.getUsedDataByOpenid(openid);
	}

	public WXCardRecord save(WXCardRecord wcr) {
		return wxcardrecordDao.save(wcr);
	}

	/**
	 * 
	 * 根据商户时间查询银行卡券核销记录
	 * 
	 * @author lyf
	 * @date 2015年11月16日 上午11:46:10
	 * @param time
	 * @param merid
	 * @return
	 */
	public List<Object[]> getMerUsedRecord(String time, Long merid) {
		return wxcardrecordDao.getMerUsedRecord(time, merid);
	}

	public List<Object[]> getMerUsedRecordByCardid(String time, Long merid, String cardid) {
		return wxcardrecordDao.getMerUsedRecordByCardid(time, merid, cardid);
	}

	public List<Object[]> getCardNames(Long merid, String time) {
		return wxcardrecordDao.getCardNames(merid, time);
	}

	/* 查询卡卷当天的发行使用记录 */
	public List<Object> getcoupon1() {
		return wxcardrecordDao.getcoupon1List();
	}

	/* 查询卡卷最近7天的发行使用记录 */
	public List<Object> getcoupon2() {
		return wxcardrecordDao.getcoupon1List1();
	}

	/* 查询卡卷最近30天的发行使用记录 */
	public List<Object> getcoupon3() {
		return wxcardrecordDao.getcoupon1List2();
	}

	/* 查询卡卷所有的发行使用记录 */
	public List<Object> getsumcoupon() {
		return wxcardrecordDao.getcoupon1List3();
	}

	/* 根据商家id 查询卡卷的发放使用记录 */
	public List<Object> getcoupon4(int id) {
		return wxcardrecordDao.getcoupon1List4(id);
	}

	/* 根据开始和结束时间查询卡券的发放和使用记录 */
	public List<Object> getcoupon5(Date a, Date b) {
		return wxcardrecordDao.getcoupon1List5(a, b);
	}

	/* 根据开始和结束时间，商家id来查询卡卷的发放和使用记录 */
	public List<Object> getcoupon6(Date a, Date b, int id) {
		return wxcardrecordDao.getcoupon1List6(a, b, id);
	}

	/*******************************
	 * 2016-04-22新增
	 ***************************************/

	public List<WXCardRecord> getWXCardByOpenidAndCardid(String openid, String cardid) {
		return wxcardrecordDao.getWXCardByOpenidAndCardid(openid, cardid);
	}

}
