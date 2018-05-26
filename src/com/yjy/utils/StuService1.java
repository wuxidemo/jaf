package com.yjy.utils;

import java.sql.ResultSet;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.yjy.entity.IntegralRecord;




//查询所有信息
public class StuService1 {
   public static List<IntegralRecord> getAllByDb(){
	   List<IntegralRecord> list=new ArrayList<IntegralRecord>();
	   try {
		DBhepler db=new DBhepler();
		String sql="select * from integralrecord";
		ResultSet re=db.Search(sql, null);
		while (re.next()) {
			Long id=re.getLong("id");
			Date createtime=re.getDate("createtime");
			int count=re.getInt("count");
			int type=re.getInt("type");
			String openid=re.getString("openid");
			String name=re.getString("name");
			String phone=re.getString("phone");
			String cardcode=re.getString("cardcode");
			String cardname=re.getString("cardname");
			String cardtype=re.getString("cardtype");
			String cardnum=re.getString("cardnum");
			Long inuserid=re.getLong("inuserid");
			list.add(new IntegralRecord(id,createtime,count,type,openid,name,phone,cardcode,cardname,cardtype,cardnum,inuserid));
		}
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	   return list;
   }
   
}
