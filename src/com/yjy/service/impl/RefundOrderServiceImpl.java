package com.yjy.service.impl;

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

import com.yjy.entity.Merchant;
import com.yjy.entity.Payorder;
import com.yjy.entity.RefundOrder;
import com.yjy.repository.PayorderDao;
import com.yjy.repository.RefundOrderDao;
import com.yjy.service.PayorderService;
import com.yjy.service.RefundOrderService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class RefundOrderServiceImpl implements RefundOrderService {
	@Autowired
	private RefundOrderDao refundOrderDao;
	@Autowired
	PayorderService payorderService;

	public RefundOrder save(RefundOrder ro) {
		return refundOrderDao.save(ro);
	}

	public void refreshrefundorder() {
		List<RefundOrder> lro = refundOrderDao.getListByState();
		for (RefundOrder ro : lro) {
			Map<String, String> result = WXManage.refundquery(WXManage.WCA, ro.getSubmchid(), ro.getTranslatenum());
			Payorder po = payorderService.get(ro.getPayorderid());
			if (result.get("result").equals("1")) {
				if (result.get("state").equals("SUCCESS")) {
					ro.setState(2);
					refundOrderDao.save(ro);
					po.setState(3);
				} else if (result.get("state").equals("FAIL")) {
					ro.setState(3);
					po.setState(4);
					refundOrderDao.save(ro);
				} else if (result.get("state").equals("PROCESSING")) {
					continue;
				} else if (result.get("state").equals("NOTSURE")) {
					ro.setState(3);
					ro.setFailreason("NOTSURE");
					po.setState(4);
					po.setFailreason("NOTSURE");
					refundOrderDao.save(ro);
				} else if (result.get("state").equals("CHANGE")) {
					ro.setState(3);
					ro.setFailreason("CHANGE");
					po.setState(4);
					po.setFailreason("CHANGE");
					refundOrderDao.save(ro);
				}
				payorderService.save(po);
			} else {
				continue;
			}
		}
	}
}
