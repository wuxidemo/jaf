package com.yjy.utils;

import java.sql.ResultSet;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;





import com.yjy.entity.Inuser;



//查询所有信息
public class StuService {
   public static List<Inuser> getAllByDb(){
	   List<Inuser> list=new ArrayList<Inuser>();
	   try {
		DBhepler db=new DBhepler();
		String sql="select * from inuser";
		ResultSet re=db.Search(sql, null);
		while (re.next()) {
			Long id=re.getLong("id");
			String name=re.getString("name");
			String phone=re.getString("phone");
			String cardnum=re.getString("cardnum");
			int point=re.getInt("point");
			int state=re.getInt("state");
			Date createtime=re.getDate("createtime");
			Date updatetime=re.getDate("updatetime");
			String openid=re.getString("openid");
			String type=re.getString("type");
			list.add(new Inuser(id,name,phone,cardnum,point,state,createtime,updatetime,openid,type));
		}
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	   return list;
   }
   
}
