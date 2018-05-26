package com.yjy.Act.NewYear.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.Act.NewYear.entity.Like;
import com.yjy.Act.NewYear.repository.LikeDao;
import com.yjy.Act.NewYear.service.LikeService;

@Component
@Transactional
public class LikeServiceImpl implements LikeService {

	@Autowired
	private LikeDao likeDao;

	public Like save1(Like like) {
		return likeDao.save(like);
	}

	/* 记录删除 */
	public boolean delete(String openid, int productid) {
		likeDao.delete1(openid, productid);
		return true;
	}

	/* 判断同一个人当天有没有对同一个点过赞 */
	public List<Like> panduan(String openid, int productid, String date1) {
		return likeDao.findbyone(openid, productid, date1);
	}

	/* 判断同一个人当天总共点击了多少次 */

	public int findsum(String openid,String date1,int collegestate) {
		return likeDao.findbyone2(openid, date1, collegestate);
	}

	/* 判断同一个人总共点击了多少条 */

	public int findbyzon(String openid) {
		return likeDao.findbyone3(openid);
	}

	@Override
	public List<Object[]> getWinList(int collegestate) {
		// TODO Auto-generated method stub
		return likeDao.getWinList(collegestate);
	}
	
	/*判断参与人数*/
	public int getlikesum(){
		
		return likeDao.findlikesum();
	}
	
	/*根据一个productid判断被点击了多少次*/
	public int findliketh(int productid){
		return likeDao.findproliketh(productid);
	}

}
