package com.yjy.service.impl;

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

import com.yjy.entity.Merchant;
import com.yjy.entity.Payorder;
import com.yjy.repository.PayorderDao;
import com.yjy.service.PayorderService;
import com.yjy.service.WXUserService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class PayorderServiceImpl implements PayorderService {
	@Autowired
	private PayorderDao payorderDao;
	@Autowired
	WXUserService wXUserService;

	public Page<Payorder> getPayorder(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Payorder> spec = Util.buildSpecification(searchParams, Payorder.class);
		return payorderDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public Payorder save(Payorder payorder) {
		return payorderDao.save(payorder);
	}

	public List<Payorder> getPayorders(String createtime, Long merchantid, String paytype) {
		return payorderDao.getPayorders(createtime, merchantid, paytype);
	}

	public List<Payorder> getAllPayorders(String createtime, Long merchantid) {
		return payorderDao.getAllPayorders(createtime, merchantid);
	}

	public Payorder getOrNew(String ordernum, String type, String submchid, Long merchantid) {
		List<Payorder> po = payorderDao.getByOrdernum(ordernum);
		if (po.size() > 0) {
			return po.get(0);
		} else {
			if (type.equals("1")) {
				return null;
			} else if (type.equals("2")) {
				return getWXPayOrderInfo(ordernum, submchid, merchantid);
			} else {
				return null;
			}
		}
	}

	public Payorder getWXPayOrderInfo(String ordernum, String submchid, Long merchantid) {
		Map<String, Object> result = WXManage.getOrderInfo(WXManage.WCA, ordernum, submchid);
		if (result.get("result").toString().equals("1")) {
			Map<String, String> data = (Map<String, String>) result.get("data");
			Payorder po = new Payorder();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			try {
				po.setCreatetime(sdf.parse(data.get("data")));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			po.setMerchantid(merchantid);
			po.setOpenid(data.get("openid"));
			po.setNickname(wXUserService.getOrNewWXUser(data.get("openid")).getRealname());
			po.setOrdernum(ordernum);
			po.setPaytype("2");
			po.setState(1);
			po.setTotal(Integer.parseInt(data.get("total_fee")));
			po.setTranslatenum(data.get("transaction_id"));
			return payorderDao.save(po);
		} else {
			return null;
		}
	}

	public Payorder findByOrdernum(String ordernum) {
		return payorderDao.findByOrdernum(ordernum);
	}

	public Payorder get(Long id) {
		return payorderDao.findOne(id);
	}
}
