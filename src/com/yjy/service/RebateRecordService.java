package com.yjy.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.yjy.entity.Rebate;
import com.yjy.entity.RebateForFirst;
import com.yjy.entity.RebateRecord;
import com.yjy.entity.WXUser;
import com.yjy.repository.RebateDao;
import com.yjy.repository.RebateForFirstDao;
import com.yjy.repository.RebateRecordDao;
import com.yjy.utils.Util;
import com.yjy.wechat.SysConfig;
import com.yjy.wechat.WXManage;

/**
 * 类RebateRecordService.java的实现描述：RebateRecord的Service层
 * 
 * @author wutao 2015年6月23日 下午1:47:25
 */
@Component
@Transactional
public class RebateRecordService {

	@Autowired
	RebateRecordDao rebateRecordDao;

	@Autowired
	WXUserService wXUserService;
	@Autowired
	RebateForFirstDao rebateForFirstDao;
	@Autowired
	RebateDao rebateDao;

	@Autowired
	NoticeService noticeService;

	/**
	 * 获取所有的RebateRecord列表
	 * 
	 * @author wutao
	 * @date 2015年6月23日 下午2:17:41
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<RebateRecord> getRebateRecord(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<RebateRecord> spec = Util.buildSpecification(searchParams, RebateRecord.class);
		return rebateRecordDao.findAll(spec, pageRequest);
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

	public List<RebateRecord> getListByState(int state) {
		return rebateRecordDao.getListByState(state);
	}

	/**
	 * 
	 * 判断返利条件，计算返利金额
	 * 
	 * @author lyf
	 * @date 2015年6月16日 下午4:38:06
	 */
	public void sendRebate(String openid, String mycode, String wxcode, String cardtype, int price, Long merchantid,
			String merhchantname) {
		WXUser wu = wXUserService.getOrNewWXUser(openid);
		boolean isfistpay = false; // 是否发过首次红包 2个红包之间需要间隔 不然微信会报错
		if (wu == null) {
			return;
		}
		// 首次红包判断
		if (wu.getFirstpay() == null || wu.getFirstpay() == 0) {
			List<RebateForFirst> irf = (List<RebateForFirst>) rebateForFirstDao.findAll();
			if (irf.size() > 0) {
				RebateForFirst rff = irf.get(0);
				int count = rebateRecordDao.getCountByStateTime(rff.getUpdatetime(), 1);
				if (rff.getState() == 1
						&& ((rff.getMustbank() == 1 && cardtype.equals(SysConfig.NSHCode)) || rff.getMustbank() == 0)
						&& count <= rff.getTotalnum()) {
					Date now = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
					RebateRecord rr = new RebateRecord();
					System.out.println("首次红包金额：" + rff.getPrice());
					if (WXManage.sendPrize(WXManage.WCA, openid, rff.getPrice(), rff.getWishstring(), rff.getRemark(),
							rff.getNickname(), rff.getSendname(), rff.getActname(), billno)) {
						rr.setState(1);
						isfistpay = true;
					} else {
						rr.setState(0);
					}
					rr.setCreatedate(now);
					rr.setMerchantid(merchantid);
					rr.setMerhchantname(merhchantname);
					rr.setType(1);
					rr.setMycode(mycode);
					rr.setPrice(rff.getPrice());
					rr.setRebateid(rff.getId());
					rr.setRebatename(rff.getActname());
					rr.setReceiveopenid(openid);
					WXUser wxu = wXUserService.getOrNewWXUser(openid);
					rr.setReceivename(wxu.getRealname());
					rr.setWxcode(wxcode);
					rr.setRebatecode(billno);
					rebateRecordDao.save(rr);
					wu.setFirstpay(1);
					wXUserService.update(wu);
				}
			}
		}
		// 判断返利红包
		List<Rebate> lr = rebateDao.getUseRebate(new Date());
		if (lr.size() == 1) {
			Rebate r = lr.get(0);
			if ((r.getMustbank() == 1 && cardtype.equals(SysConfig.NSHCode)) || r.getMustbank() == 0) {

				Date now = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Date time = null;
				try {
					time = sdf.parse(sdf.format(now));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				if (r.getMaxordernum() == null || r.getMaxordernum() == 0
						|| rebateDao.getCountByOpenidTime(time, openid) < r.getMaxordernum()) {

					String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
					RebateRecord rr = new RebateRecord();
					int payprice = price * r.getProportion() / 100;
					if (payprice < 100) {
						System.out.println("金额小于1元");
						return;
						// payprice = 1;
					} else if (r.getMaxprice() != null && r.getMaxprice() != 0 && payprice > r.getMaxprice()) {
						payprice = r.getMaxprice();
					}
					if (isfistpay) {
						try {
							Thread.sleep(30 * 1000);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					System.out.println("红包金额：" + payprice);
					if (WXManage.sendPrize(WXManage.WCA, openid, payprice, r.getWishstring(), r.getRemark(),
							r.getNickname(), r.getSendname(), r.getActname(), billno)) {
						rr.setState(1);
					} else {
						rr.setState(0);
					}
					rr.setCreatedate(now);
					rr.setMerchantid(merchantid);
					rr.setMerhchantname(merhchantname);
					rr.setMycode(mycode);
					rr.setPrice(payprice);
					rr.setType(2);
					rr.setRebateid(r.getId());
					rr.setRebatename(r.getName());
					rr.setReceiveopenid(openid);
					WXUser wxu = wXUserService.getOrNewWXUser(openid);
					rr.setReceivename(wxu.getRealname());
					rr.setWxcode(wxcode);
					rr.setRebatecode(billno);
					rebateRecordDao.save(rr);
				}

			}

		} else if (lr.size() > 1) {
			System.out.println("====返利红包配置错误======");
			noticeService.notice("返利红包配置错误");
		}

	}

	/**
	 * 
	 * 更新红包状态
	 * 
	 * @author lyf
	 * @date 2015年6月17日 上午9:42:33
	 */
	public void updateRebateRecordState() {
		List<RebateRecord> lrr = rebateRecordDao.getListByState(1);
		for (RebateRecord rr : lrr) {
			Map<String, String> result = WXManage.getRebaeState(WXManage.WCA, rr.getRebatecode());
			if (result != null && result.get("result").equals("1")) {
				String state = result.get("status");
				if (state.equals("RECEIVED")) {
					rr.setState(2);
					rebateRecordDao.save(rr);
				} else if (state.equals("REFUND")) {
					rr.setState(3);
					rebateRecordDao.save(rr);
				}
			}
		}
	}

	public List<RebateRecord> getListByOpenid(String openid) {
		return rebateRecordDao.getListByOpenid(openid);
	}

	/**
	 * 
	 * 零时活动方法
	 * 
	 * @author luyf
	 * @date 2015年7月8日 下午4:57:42
	 */
	public void doACT(WXUser wu) {
		int price = 100;
		Date now = new Date();
		RebateRecord rr = new RebateRecord();
		rr.setCreatedate(now);
		rr.setMerhchantname("零时活动");
		rr.setPrice(price);
		rr.setRebatename("首次关注领红包");
		rr.setReceivename(wu.getRealname());
		rr.setReceiveopenid(wu.getOpenid());

		rr.setType(0);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String billno = WXManage.WCA.getMcid() + sdf.format(now) + (now.getTime() + "").substring(2, 12);
		if (WXManage.sendPrize(WXManage.WCA, wu.getOpenid(), price, "首次关注领红包", "点击关注,获取更多优惠。", "金阿福e服务", "金阿福e服务",
				"首次关注领红包", billno)) {
			rr.setState(1);
		} else {
			rr.setState(0);
		}
		rr.setRebatecode(billno);
		rebateRecordDao.save(rr);
	}

	public class sendRebateThread extends Thread {

		public sendRebateThread() {

			// WXManage.sendPrize(wca, openid, money, wishString, remark,
			// nickname, sendname, actname, billno)
		}

		@Override
		public void run() {
			super.run();
		}

	}
}
