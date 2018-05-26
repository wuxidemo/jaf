package com.yjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.WeChatAccount;
import com.yjy.repository.WeChatAccountDao;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class WeChatAccountService {
	@Autowired
	private WeChatAccountDao weChatAccountDao;

	public WeChatAccount getmain() {
		List<WeChatAccount> lwca = weChatAccountDao.getMainWeChat();
		if (lwca.size() == 1) {
			return lwca.get(0);
		} else {
			System.out.println("==============微信平台主账号未配置或配置过多============");
			return null;
		}
	}

	public void RefreshAccessToken() {
		WXManage.WCA.setAccesstoken(WXManage.getAccessToken(WXManage.WCA));
		weChatAccountDao.save(WXManage.WCA);
	}

	public void RefreshJsapi_ticket() {
		WXManage.WCA.setJsapiticket(WXManage.Getjsapi_ticket(getAccesstoken()));
		weChatAccountDao.save(WXManage.WCA);
	}

	public void RefreshJsapiticketforcard() {
		WXManage.WCA.setJsapiticketforcard(WXManage.Getjsapi_ticketForCard(getAccesstoken()));
		weChatAccountDao.save(WXManage.WCA);
	}

	public String getAccesstoken() {
		return weChatAccountDao.findOne(WXManage.WCA.getId()).getAccesstoken();
	}

	public String getJsapi_ticket() {
		return weChatAccountDao.findOne(WXManage.WCA.getId()).getJsapiticket();
	}

	public String getJsapiticketforcard() {
		return weChatAccountDao.findOne(WXManage.WCA.getId()).getJsapiticketforcard();
	}

	public WeChatAccount get(Long id) {
		return weChatAccountDao.findOne(id);
	}

	public WeChatAccount getByAppid(String appid) {
		return weChatAccountDao.getByAppid(appid);
	}
}
