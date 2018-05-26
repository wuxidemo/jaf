package com.yjy.service.impl;

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

import com.yjy.entity.Activity;
import com.yjy.entity.WXMerchant;
import com.yjy.repository.WXMerchantDao;
import com.yjy.service.WXMerchantService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class WXMerchantServiceImpl implements WXMerchantService {
	@Autowired
	WXMerchantDao wXMerchantDao;
	@Autowired
	WeChatAccountService weChatAccountService;

	public Page<WXMerchant> getList(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<WXMerchant> spec = Util.buildSpecification(searchParams, WXMerchant.class);
		return wXMerchantDao.findAll(spec, pageRequest);
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

	public void RefreshWXMER() {
		Long lastid = 0l;
		while (true) {
			Map<String, Object> data = WXCardManage.getSubMerchantList(WXManage.WCA, lastid, 10, "");
			List<Map<String, Object>> lo = (List<Map<String, Object>>) data.get("list");
			lastid = Long.parseLong(data.get("nextid").toString());
			for (Map<String, Object> map : lo) {
				Long merid = Long.parseLong(map.get("merchant_id").toString());
				WXMerchant wxm = wXMerchantDao.getByMerid(merid);
				wXMerchantDao.save(changeDataToWXM(map, wxm));
			}
			if (lo.size() < 10) {
				break;
			} else {
				continue;
			}
		}
	}

	public WXMerchant getWXMOrNew(Long merid) {
		WXMerchant wxm = wXMerchantDao.getByMerid(merid);
		if (wxm != null) {
			return wxm;
		} else {
			Map<String, Object> map = WXCardManage.getSubMerchantInfo(weChatAccountService.getAccesstoken(), merid);
			if (map == null) {
				return null;
			}
			return changeDataToWXM(map, null);
		}
	}

	public WXMerchant changeDataToWXM(Map<String, Object> map, WXMerchant wxm) {
		if (wxm == null) {
			wxm = new WXMerchant();
			wxm.setType(1);
		}
		wxm.setBegintime(new Date(Long.parseLong(map.get("begin_time") + "000")));
		wxm.setBrandname(map.get("brand_name").toString());
		wxm.setCreatetime(new Date(Long.parseLong(map.get("create_time") + "000")));
		wxm.setEndtime(new Date(Long.parseLong(map.get("end_time") + "000")));
		wxm.setLogourl(map.get("logo_url").toString());
		wxm.setMerchantid(Long.parseLong(map.get("merchant_id").toString()));
		wxm.setPrimarycategoryid(Long.parseLong(map.get("primary_category_id").toString()));
		wxm.setSecondarycategoryid(Long.parseLong(map.get("secondary_category_id").toString()));
		wxm.setStatus(map.get("status").toString());
		wxm.setUpdatetime(new Date(Long.parseLong(map.get("update_time") + "000")));
		return wxm;
	}

	public List<WXMerchant> getAll() {
		return (List<WXMerchant>) wXMerchantDao.findAll();
	}
}
