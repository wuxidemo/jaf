package com.yjy.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.WXUserRecord;

@Component
@Transactional
public class ThreadSave implements Runnable {

	public ThreadSave(WXUserRecordService wrs, String type, String openid, String key1, String key2, String key3) {
		mytype = type;
		myopenid = openid;
		mykey1 = key1;
		mykey2 = key2;
		mykey3 = key3;
		wXUserRecordService = wrs;
	}

	WXUserRecordService wXUserRecordService;

	String myopenid, mykey1, mykey2, mykey3, mytype;

	@Override
	public void run() {
		// TODO Auto-generated method stub
		WXUserRecord wr = new WXUserRecord();
		wr.setCreatetime(new Date());
		wr.setOpenid(myopenid);
		wr.setKey1(mykey1);
		wr.setKey2(mykey2);
		wr.setKey3(mykey3);
		wr.setType(mytype);
		wXUserRecordService.save(wr);
	}

}
