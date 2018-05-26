package com.yjy.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.dao.MySq_DonationDao;
import com.yjy.entity.Community;
import com.yjy.entity.Sq_Donation;
import com.yjy.repository.Sq_DonationDao;
import com.yjy.service.Sq_DonationService;
import com.yjy.utils.Util;

@Component
@Transactional
public class Sq_DonationServiceImpl implements Sq_DonationService {

	@Autowired
	private Sq_DonationDao sq_DonationDao;

	@Autowired
	private MySq_DonationDao mySq_DonationDao;

	@Override
	public Page<Sq_Donation> getSqDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<Sq_Donation> spec = Util.buildSpecification(searchParams, Sq_Donation.class);
		return sq_DonationDao.findAll(spec, pageRequest);
	}

	@Override
	public Sq_Donation get(Long id) {
		// TODO Auto-generated method stub
		return sq_DonationDao.findOne(id);
	}

	@Override
	public Sq_Donation save(Sq_Donation sq_Donation) {
		// TODO Auto-generated method stub
		return sq_DonationDao.save(sq_Donation);
	}

	@Override
	public void delete(Long id) {
		// TODO Auto-generated method stub
		sq_DonationDao.delete(id);
	}

	@Override
	public boolean delete1(String ids) {
		String[] id = ids.split("\\|");
		for (String i : id) {
			sq_DonationDao.delete(Long.parseLong(i));
		}
		return true;
	}

	/**
	 * 以下企业捐赠记录
	 */
	@Override
	public Page<Object[]> getCompanyDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(
				mySq_DonationDao.getCompanyDonations(searchParams, pageNumber, pageSize, order, c), pageRequest,
				mySq_DonationDao.getCompanyCountbyParams(searchParams, c));
	}

	@Override
	public Integer getPriceByParams(Map<String, Object> params, Community c) {
		return mySq_DonationDao.getPriceByParams(params, c);
	}

	@Override
	public Integer getDonationCountByParams(Map<String, Object> params, Community c) {
		return mySq_DonationDao.getDonationCountByParams(params, c);
	}

	/**
	 * 以下物品捐赠记录
	 */
	@Override
	public Page<Object[]> getGoodsDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType, Community c) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(mySq_DonationDao.getGoodsDonations(searchParams, pageNumber, pageSize, order, c),
				pageRequest, mySq_DonationDao.getGoodsCountbyParams(searchParams, c));
	}

	/**
	 * 以下物品捐赠记录
	 */
	@Override
	public Page<Object[]> getGenRenDonations(Map<String, Object> searchParams, int pageNumber, int pageSize,
			String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		String order = "";
		if ("auto".equals(sortType)) {
			order = "id desc";
		} else if ("createtime".equals(sortType)) {
			order = "createtime desc";
		} else {
			order = "createtime desc";
		}
		return new PageImpl<Object[]>(mySq_DonationDao.getGeRenDonations(searchParams, pageNumber, pageSize, order),
				pageRequest, mySq_DonationDao.getGeRenCountbyParams(searchParams));
	}

	@Override
	public List<Sq_Donation> getSqDonationByComid(Long comid) {
		// TODO Auto-generated method stub
		return sq_DonationDao.getSqDonationByComid(comid);
	}

	@Override
	public Integer getDonationGoodsCountByParams(Map<String, Object> params, Community c) {
		// TODO Auto-generated method stub
		return mySq_DonationDao.getDonationGoodsCountByParams(params, c);
	}

	@Override
	public List<Sq_Donation> getSqDonationByPhoneNo(String phoneno) {
		// TODO Auto-generated method stub
		return sq_DonationDao.getSqDonationByPhoneNo(phoneno);
	}

	@Override
	public List<Sq_Donation> getSqDonationByOpenid(String openid) {
		// TODO Auto-generated method stub
		return sq_DonationDao.getSqDonationByOpenid(openid);
	}

	public Sq_Donation getOnlineListBynum(String num) {
		List<Sq_Donation> lsd = sq_DonationDao.getOnlineListBynum(num);
		if (lsd.size() > 0) {
			return lsd.get(0);
		} else {
			return null;
		}
	}

	@Override
	public Sq_Donation getDonationByNum(String num) {
		// TODO Auto-generated method stub
		return sq_DonationDao.getDonationByNum(num);
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

	@Override
	public void deleteDonationGoodsByDonationId(Long id) {
		// TODO Auto-generated method stub
		sq_DonationDao.deleteDonationGoodsByDonationId(id);
	}
}
