package com.yjy.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.entity.Sq_Donation;

public interface Sq_DonationDao
		extends PagingAndSortingRepository<Sq_Donation, Long>, JpaSpecificationExecutor<Sq_Donation> {

	@Query(nativeQuery = true, value = "select * from sq_donation where comid=?1")
	List<Sq_Donation> getSqDonationByComid(Long comid);

	@Query(nativeQuery = true, value = "select * from sq_donation where phone=?1")
	List<Sq_Donation> getSqDonationByPhoneNo(String phoneno);

	@Query(nativeQuery = true, value = "select * from sq_donation where openid=?1")
	List<Sq_Donation> getSqDonationByOpenid(String openid);
	
	@Query(nativeQuery=true,value="select * from sq_donation where num=?1")
	Sq_Donation  getDonationByNum(String num);

	@Query(value = " from Sq_Donation where num=?1")
	List<Sq_Donation> getOnlineListBynum(String num);

	@Modifying
	@Query(nativeQuery=true,value="delete from sq_donationgood where donationid=?1")
	void deleteDonationGoodsByDonationId(Long id);

}
