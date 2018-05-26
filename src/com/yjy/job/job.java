package com.yjy.job;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.yjy.Act.NewYear.entity.Vote;
import com.yjy.Act.NewYear.service.VoteService;
import com.yjy.Temporary.service.ActService;
import com.yjy.service.ActivityService;
import com.yjy.service.RebateRecordService;
import com.yjy.service.RebateService;
import com.yjy.service.RefundOrderService;
import com.yjy.service.SqQuickBuyService;
import com.yjy.service.Sq_PensionActService;
import com.yjy.service.WXCardRecordService;
import com.yjy.service.WeChatAccountService;
import com.yjy.wechat.WXManage;

public class job {

	@Autowired
	WeChatAccountService weChatAccountService;
	@Autowired
	RebateRecordService rebateRecordService;
	@Autowired
	RebateService rebateService;
	@Autowired
	WXCardRecordService wXCardRecordService;
	@Autowired
	ActivityService activityService;
	@Autowired
	ActService actService;
	@Autowired
	RefundOrderService refundOrderService;

	@Autowired
	VoteService voteService;
	
	@Autowired
	SqQuickBuyService sqQuickBuyService;
	
	@Autowired
	Sq_PensionActService sq_PensionActService;

	/**
	 * 
	 * 更新ACCESSTOKEN 和 jsapi_ticket
	 * 
	 * @author lyf
	 * @date 2015年6月16日 下午7:53:32
	 */
	public void RefreshAccessToken() {
		System.out.println("=====更新AccessToken=====");

		// 获取主微信号
		if (WXManage.WCA == null) {
			WXManage.WCA = weChatAccountService.getmain();
		}
		actService.refreshRQZState();
		actService.refreshGZFXState();
		actService.refreshQCCJState();

		// 线下需要屏蔽，否则accesstoken会和线上冲突
//		weChatAccountService.RefreshAccessToken();
//		weChatAccountService.RefreshJsapi_ticket();
//		weChatAccountService.RefreshJsapiticketforcard();
	}

	/**
	 * 
	 * 更新红包记录状态
	 * 
	 * @author lyf
	 * @date 2015年6月16日 下午7:53:19
	 */
	public void refreshRebateRecordState() {
		System.out.println("=====更新红包记录状态=====");
		rebateRecordService.updateRebateRecordState();

		System.out.println("=====更新退款申请状态=====");
		refundOrderService.refreshrefundorder();
	}

	/**
	 * 
	 * 更新过期红包状态
	 * 
	 * @author lyf
	 * @date 2015年6月23日 下午10:07:59
	 */
	public void refreshUnuseRebate() {
		System.out.println("======更新过期红包状态======");
		rebateService.updateUnuse();

		System.out.println("====更新卡券领取记录状态=====");
		wXCardRecordService.updateOverCard();

		System.out.println("======更新活动状态======");
		activityService.updateActivity();
		activityService.updateActivityState();
		
	}

	// 更新最美服务员状态
	public void updateZmfwyVoteStage() {
		Vote vote = voteService.changeWaiterStage();
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			Date endData = sdf.parse("2016-01-24 23:59");
			Calendar endCal = Calendar.getInstance();
			endCal.setTime(endData);
			if (calendar.compareTo(endCal) >= 0) {
				System.out.println("33333333333333333333333");
				vote.setStage(4);
				voteService.save(vote);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void updateCommActState() {
		System.out.println(new Date().toString());
		System.out.println("======更新抢购活动状态======");
		sqQuickBuyService.updateState();
		
		System.out.println("======更新养老活动状态======");
		sq_PensionActService.updateState();
	}
}
