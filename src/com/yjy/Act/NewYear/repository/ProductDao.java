package com.yjy.Act.NewYear.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.yjy.Act.NewYear.entity.Product;



public interface ProductDao extends PagingAndSortingRepository<Product, Long>,JpaSpecificationExecutor<Product> {

	/*查找进入前五十的*/
	@Query(nativeQuery = true, value = "SELECT  p.*,(case when a.c is null then 0 else a.c end) as c1,(case when b.c is null then 0 else b.c end) as c2 FROM  product  p LEFT JOIN (SELECT count(*) as c,productid from liketh WHERE openid=?1 and DATE_FORMAT(createtime,'%Y%m%d')=?2 GROUP BY productid ) a on a.productid= p.id LEFT JOIN (SELECT count(*) as c,productid from liketh GROUP BY productid ) b on b.productid= p.id where state=2 and collegestate=?3 order by senumber ASC")
	public List<Object> getbyall(String openid,String a,int collegestate );
	
	
	@Query(nativeQuery = true, value = "SELECT * FROM  product  p LEFT JOIN (SELECT sumcount(*),productid from liketh WHERE openid=?1  GROUP BY productid ) a on a.productid= p.id where state=2 order by senumber DESC")
	public List<Object> getbyalll(String openid);
	
	
	@Query(nativeQuery = true, value = "SELECT * FROM  product where openid=?1")
	public Product findbyone(String openid);
	
	/*查找所有状态为1的*/
	@Query(nativeQuery = true, value = "SELECT * FROM  product where state=?1")
	public List<Product> findProductByState(int state);

    /*查数据库表总共有几条记录*/
	@Query(nativeQuery = true, value = "select count(*) from product")
	public int findsum();
	
	@Query(nativeQuery = true, value = "select id,collegestate,likepro.total as ptotal from product pro left join (SELECT count(*) as total,productid from liketh GROUP BY productid) likepro on pro.id = likepro.productid where collegestate=?1 and state=2 ORDER BY ptotal DESC limit 0,6")
	public List<Object[]> getTopThreeWinner(int collegestate);
	
	@Query(nativeQuery = true, value = "SELECT * FROM  product where state=?1 and collegestate=?2")
	public List<Product> findProductByStateAndCollege(int state, int college);
}
