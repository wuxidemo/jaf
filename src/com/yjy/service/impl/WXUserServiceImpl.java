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

import com.yjy.entity.WXUser;
import com.yjy.repository.WXUserDao;
import com.yjy.service.WXUserService;
import com.yjy.service.WeChatAccountService;
import com.yjy.utils.Util;
import com.yjy.wechat.WXManage;

@Component
@Transactional
public class WXUserServiceImpl implements WXUserService {
	@Autowired
	private WXUserDao wxuserDao;
	@Autowired
	WeChatAccountService weChatAccountService;

	public Page<WXUser> getWXUser(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<WXUser> spec = Util.buildSpecification(searchParams, WXUser.class);
		return wxuserDao.findAll(spec, pageRequest);
	}

	public WXUser save(WXUser user) {
		if (user.getCreattime() == null) {
			user.setCreattime(new Date());
		}
		return wxuserDao.save(user);
	}

	public WXUser update(WXUser user) {
		if (user.getCreattime() == null) {
			user.setCreattime(new Date());
		}
		return wxuserDao.save(user);
	}

	public void delete(Long id) {
		wxuserDao.delete(id);
	}

	public WXUser get(Long id) {
		return wxuserDao.findOne(id);
	}

	/**
	 * 分页排序
	 * 
	 * @param pageNumber
	 * @param pagzSize
	 * @param sortType
	 * @return
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "title");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}
		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}

	public WXUser getUserByOpenid(String openid) {
		List<WXUser> lu = wxuserDao.getUserByOpenid(openid);
		if (lu != null && lu.size() > 0) {
			return lu.get(0);
		} else
			return null;
	}

	public boolean isUser(String name) {
		if (wxuserDao.isUser(name) > 0) {
			return true;
		} else
			return false;
	}

	/**
	 * 
	 * 根据OPENID查询用户信息,如果不存在向微信查询
	 * 
	 * @author lyf
	 * @date 2015年6月17日 上午9:36:45
	 * @param openid
	 * @return
	 */
	public WXUser getOrNewWXUser(String openid) {
		WXUser user = getUserByOpenid(openid);
		if (user != null) {
			return user;
		}
		Map<String, String> userinfo = WXManage.getUserInfo(weChatAccountService.getAccesstoken(), openid);
		user = new WXUser();
		if (userinfo == null) {
			return null;
		}
		user.setOpenid(openid);
		if (userinfo.get("subscribe").equals("0")) {
			user.setState(0);
		} else {
			user.setHeadimgurl(userinfo.get("headimgurl"));
			user.setRealname(userinfo.get("realname"));
			user.setSex(Integer.parseInt(userinfo.get("sex")));
			user.setState(1);
			user.setFirstpay(0);
		}
		user = wxuserDao.save(user);
		return user;
	}

	@Override
	public int getAdCount() {
		// TODO Auto-generated method stub
		return wxuserDao.getAdCount();
	}

	@Override
	public int getJDCount() {
		// TODO Auto-generated method stub
		return wxuserDao.getJDCount();
	}

	@Override
	public int getTHCount() {
		// TODO Auto-generated method stub
		return wxuserDao.getTHCount();
	}
}
