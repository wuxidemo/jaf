package com.yjy.service;

import com.yjy.entity.WXuserInfo;

public interface WXuserInfoService {

	public WXuserInfo getInfoByOpenid(String openid);

	public WXuserInfo save(WXuserInfo wui);
	
	public WXuserInfo modifyWXuserInfo(String name,String phone,String commid,Long id);

}
