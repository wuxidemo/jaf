package com.yjy.Temporary;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class ACTConfig {
	public static Date rqzhdEndtime; // 人气值活动结束时间
	public static String rqzhdState;// 人气值活动状态 1正常0结束
	public static Date gzfxhdEndtime;
	public static String gzfxhdstate; // 关注分享活动
	public static String qccjhdstate;
	public static Date qccjhdEndtime;
	public static List<String[]> fxdates = Arrays
		/*	.asList(new String[][] { { "0000", "50" }, { "0700", "100" }, { "0800", "100" }, { "0900", "200" },
					{ "1000", "200" }, { "1100", "200" }, { "1200", "200" }, { "1300", "100" }, { "1400", "100" },
					{ "1500", "100" }, { "1600", "2" }, { "1700", "100" }, { "1800", "200" }, { "1900", "300" },
					{ "2000", "300" }, { "2100", "300" }, { "2200", "200" }, { "2300", "150" } });*/
			
			.asList(new String[][] { { "1800", "2" }, { "1900", "100" }
				});

	static {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			rqzhdEndtime = sdf.parse("2015-11-12");
			gzfxhdEndtime = sdf.parse("2015-11-12");
			qccjhdEndtime = sdf.parse("2015-11-12");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// System.out.println("1000".compareTo("1100"));
		System.out.println(getTimeS()[0] + " " + getTimeS()[1]);
	}

	public static String[] getTimeS() {
		SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
		String now = sdf.format(new Date());
		String[] result = new String[2];
		result[0] = "0000";
		result[1] = "3000";
		if (fxdates.size() != 0) {
			for (int i = fxdates.size() - 1; i > 0; i--) {
				if (fxdates.get(i)[0].compareTo(now) < 0) {
					return fxdates.get(i);
				}
			}
		}
		result[0] = "0000";
		result[1] = "3000";
		return result;
	}
}
