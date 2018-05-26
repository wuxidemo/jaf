package com.yjy.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import com.yjy.entity.IntegralRecord;
import com.yjy.repository.IntegralRecordDao;
import com.yjy.service.IntegralRecordService;
import com.yjy.utils.Util;

@Component
@Transactional
public class IntegralRecordServiceImpl implements IntegralRecordService{

	@Autowired
	private IntegralRecordDao integralRecordDao;
	
	
	/**
	 * 
	 *  分页查询
	 * @author gaolongfei
	 * @date 2015年4月24日 下午2:25:03
	 * @param searchParams
	 * @param pageNumber
	 * @param pageSize
	 * @param sortType
	 * @return
	 */
	public Page<IntegralRecord> getList(Map<String, Object> searchParams, int pageNumber,
			int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize,
				sortType);

		Specification<IntegralRecord> spec = Util.buildSpecification(searchParams,
			  IntegralRecord.class);
	     return  integralRecordDao.findAll(spec, pageRequest);
	}
    /**
     * 
     * 分页查询排序条件
     * @author gaolongfei
     * @date 2015年4月24日 下午2:27:55
     * @param pageNumber
     * @param pageSize
     * @param sortType
     * @return
     */
	private PageRequest buildPageRequest(int pageNumber, int pageSize,
			String sortType) {
		// TODO Auto-generated method stub
		Sort sort = null;
		if("auto".equals(sortType)){
			sort=new Sort(Direction.DESC,"id");
		}
		return new PageRequest(pageNumber-1, pageSize, sort);
	}

	
	public void SaveOrUpdate(IntegralRecord ir) {
		integralRecordDao.save(ir);
	}

	public List<IntegralRecord> getListByOpenid(String openid) {
		return integralRecordDao.getListByOpenid(openid);
	}

	public List<IntegralRecord> getListByCardnum(String cardnum) {
		return integralRecordDao.getListByCardnum(cardnum);
	}

	/**
	 * 
	 * 获取时间段数据 (积分 卡号 时间 名字 电话)
	 * 
	 * @author luyf
	 * @date 2015年7月30日 上午11:30:44
	 * @param s
	 * @param e
	 * @return
	 */
	public List<Object[]> getSumList(Date s, Date e) {
		return integralRecordDao.getSumList(s, e);
	}

	/**
	 * 
	 * 获取昨天数据 (积分 卡号 时间 名字 电话)
	 * 
	 * @author luyf
	 * @date 2015年7月30日 上午11:30:27
	 * @return
	 */
	public List<Object[]> getYesterdayList() {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, -1);
		List<Object[]> data = null;
		try {
			data = integralRecordDao.getSumList(sdf.parse(sdf.format(c.getTime())), sdf.parse(sdf.format(now)));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return data;
	}
}
