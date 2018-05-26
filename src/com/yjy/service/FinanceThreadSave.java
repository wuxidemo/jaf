package com.yjy.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.yjy.entity.WXUserRecord;

@Component
@Transactional
public class FinanceThreadSave implements Runnable {

	public FinanceThreadSave(FinanceInfoService fis, Long id) {
		myfis = fis;
		myid = id;
	}

	FinanceInfoService myfis;

	Long myid;

	@Override
	public void run() {
		myfis.updateCount(myid, 1);
	}

}
