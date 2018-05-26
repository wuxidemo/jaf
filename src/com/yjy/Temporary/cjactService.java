package com.yjy.Temporary;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@Transactional
public class cjactService {

	@Autowired
	cjactDao cjactDao;

	public int getcount(String openid) {
		return cjactDao.getcount(openid);
	}

	public int getAllcount() {
		return cjactDao.getAllcount();
	}

	public cjact save(cjact c) {
		return cjactDao.save(c);
	}
}
