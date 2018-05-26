package com.yjy.Act.NewYear.service;

import java.util.List;

import com.yjy.Act.NewYear.entity.Like;

public interface LikeService {
	
	
	public Like save1(Like like);
	/*删除记录*/
	public boolean delete(String openid,int productid);
    
    /*判断同一个人当天对同一个点击过*/
	 public List<Like> panduan(String openid,int productid ,String date1 );
	 
	 
	 public int  findsum(String openid,String date1,int collegestate);
	 
	 
	 public int findbyzon(String openid);
	 
	 public List<Object[]> getWinList(int collegestate);
	 
	 public int getlikesum();
	 
	 public int findliketh(int productid);
	 
}
