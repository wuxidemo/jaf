package com.yjy.Temporary;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.yjy.entity.Advert;

public interface TmprecordDao extends PagingAndSortingRepository<Tmprecord, Long>, JpaSpecificationExecutor<Tmprecord> {

	@Query(nativeQuery = true, value = "select * from Tmprecord where openid=?1 and createtime>=?2 and createtime<?3 and actid=?4")
	public List<Tmprecord> getTodayListByOpenid(String openid, Date s, Date e, Long actid);

	@Query(value = "from Tmprecord where code=?1")
	public List<Tmprecord> getListByCode(String code);

	@Query(nativeQuery = true, value = "select * from Tmprecord where createtime>=?1 and createtime<?2 and actid=?3")
	public List<Tmprecord> getTodayList(Date s, Date e, Long actid);

	@Query(nativeQuery = true, value = " select count(*) from Tmprecord where createtime>=?1 and createtime<?2 and actid=?3 and state=?4")
	public int getTodayCountByState(Date s, Date e, Long actid, int state);

	@Query(nativeQuery = true, value = " select count(*) from Tmprecord where createtime>=?1 and createtime<?2 and actid=?3 ")
	public int getTodayCount(Date s, Date e, Long actid);
	
	@Query(nativeQuery = true, value = " select count(*) from Tmprecord where createtime>=?1 and createtime<?2 and actid=?3 and (state=1 or state=2)")
	public int getTodayPayCount(Date s, Date e, Long actid);
}
