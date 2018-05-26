package com.yjy.service;

import com.yjy.entity.Inrecord;

public interface InrecordService {


	/**
	 * 根據文件查找
	 * 
	 * @param record
	 * @return
	 */
	public Inrecord getre(String record) ;

	public Inrecord mysave(Inrecord inred);
}
