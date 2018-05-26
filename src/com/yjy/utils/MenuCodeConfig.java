package com.yjy.utils;

import java.util.Date;
import java.util.Random;

/**
 * menu_code配置
 * 
 * @author lyf
 *
 */
public class MenuCodeConfig {
	/**
	 * 一级菜单
	 */
	public static String MENU_1 = "001";
	/**
	 * 二级菜单
	 */
	public static String MENU_2 = "002";
	/**
	 * 视频
	 */
	public static String VIDEO = "011";
	/**
	 * 网页资讯
	 */
	public static String PAGE = "012";
	/**
	 * 社区实体
	 */
	public static String COMMUNITY = "041";
	/**
	 * 通知公告
	 */
	public static String NOTICE = "042";     
	/**
	 * 社区简介
	 */
	public static String INTRO = "043";      
	/**
	 * 社区建设
	 */
	public static String BUILD = "044";   
	/**
	 * 组织成员
	 */
	public static String ORG = "045";     
	/**
	 * 便民网点
	 */
	public static String DOT = "046";     
	
	/**
	 * 护理项目
	 */
	public static String HLXM = "051";    
	
	/**
	 * 器材租赁
	 */
	public static String QCZL = "052";    
	
	/**
	 * 服务流程
	 */
	public static String FWLC = "053";    
	
	/**
	 * 朗高学堂
	 */
	public static String LGXT = "054";     
	
	/**
	 * 特惠活动
	 */
	public static String THHD = "055";     
	
	/**
	 * 终端我的社区大类
	 */
	public static String MYCOMMUNITY = "101";    //lg101486200273408
	
	/**
	 * 终端居家养老大类
	 */
	public static String JUJIAYANGLAO = "102";   //  lg102444900273408
	
	/**
	 * 终端居家服务大类
	 */
	public static String JUJIAFUWU = "103";   //   lg103975700273408
	
	/**
	 * 终端养老资讯大类
	 */
	public static String YANGLAOZIXUN = "104";  //  lg104439600273408
	
	
	
	/**
	 * 终端我的社区大类下的二级菜单---通知公告
	 */
	public static String MYCOMMUNITY_NOTICE = "211";    //lg211996165919266
	
	/**
	 * 终端我的社区大类下的二级菜单---社区简介
	 */
	public static String MYCOMMUNITY_INTRO = "212";   //  lg212804365919266
	
	/**
	 * 终端我的社区大类下的二级菜单---社区建设
	 */
	public static String MYCOMMUNITY_BUILD = "213";   //   lg213142665919267
	
	/**
	 * 终端我的社区大类下的二级菜单---组织成员
	 */
	public static String MYCOMMUNITY_ORG = "214";  //  lg214547565919267
	
	/**
	 * 终端我的社区大类下的二级菜单---便民网点
	 */
	public static String MYCOMMUNITY_DOT = "215";  //  lg215794865919267
	
	/**
	 * 终端居家养老大类下的二级菜单---护理项目
	 */
	public static String JUJIAYANGLAO_HLXM = "221";  //  lg221721965919267
	
	/**
	 * 终端居家养老大类下的二级菜单---器材租赁
	 */
	public static String JUJIAYANGLAO_QCZL = "222";  //  lg222071265919267
	
	/**
	 * 终端居家养老大类下的二级菜单---服务流程
	 */
	public static String JUJIAYANGLAO_FWLC = "223";  //  lg223486165919267
	
	/**
	 * 终端居家养老大类下的二级菜单---朗高学堂
	 */
	public static String JUJIAYANGLAO_LGXT = "224";  //  lg224050665919267
	
	/**
	 * 终端居家养老大类下的二级菜单---特惠活动
	 */
	public static String JUJIAYANGLAO_THHD = "225";  //  lg225090965919267
	

	/**
	 * 项目编号
	 */
	public static String MYPROJECT = "lg";

	/**
	 * 
	 * 获取MenuCode
	 * 
	 * @author lyf
	 * @date 2015年3月6日 下午2:14:03
	 * @param mck
	 *            类型
	 * @return
	 */
	public static String getMenuCode(MenuCodeKind mck) {
		StringBuilder sb = new StringBuilder();
		sb.append(MYPROJECT);
		if (mck.equals(MenuCodeKind.MENU_1)) {
			sb.append(MENU_1);
		} else if (mck.equals(MenuCodeKind.MENU_2)) {
			sb.append(MENU_2);
		} else if (mck.equals(MenuCodeKind.VIDEO)) {
			sb.append(VIDEO);
		} else if (mck.equals(MenuCodeKind.PAGE)) {
			sb.append(PAGE);
		} else if (mck.equals(MenuCodeKind.COMMUNITY)) {
			sb.append(COMMUNITY);
		} else if (mck.equals(MenuCodeKind.NOTICE)) {
			sb.append(NOTICE);
		} else if (mck.equals(MenuCodeKind.INTRO)) {
			sb.append(INTRO);
		} else if (mck.equals(MenuCodeKind.BUILD)) {
			sb.append(BUILD);
		} else if (mck.equals(MenuCodeKind.ORG)) {
			sb.append(ORG);
		} else if (mck.equals(MenuCodeKind.DOT)) {
			sb.append(DOT);
		} else if (mck.equals(MenuCodeKind.HLXM)) {
			sb.append(HLXM);
		} else if (mck.equals(MenuCodeKind.QCZL)) {
			sb.append(QCZL);
		} else if (mck.equals(MenuCodeKind.FWLC)) {
			sb.append(FWLC);
		} else if (mck.equals(MenuCodeKind.LGXT)) {
			sb.append(LGXT);
		} else if (mck.equals(MenuCodeKind.THHD)) {
			sb.append(THHD);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY)) {
			sb.append(MYCOMMUNITY);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO)) {
			sb.append(JUJIAYANGLAO);
		} else if (mck.equals(MenuCodeKind.JUJIAFUWU)) {
			sb.append(JUJIAFUWU);
		} else if (mck.equals(MenuCodeKind.YANGLAOZIXUN)) {
			sb.append(YANGLAOZIXUN);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY_NOTICE)) {
			sb.append(MYCOMMUNITY_NOTICE);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY_INTRO)) {
			sb.append(MYCOMMUNITY_INTRO);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY_BUILD)) {
			sb.append(MYCOMMUNITY_BUILD);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY_ORG)) {
			sb.append(MYCOMMUNITY_ORG);
		} else if (mck.equals(MenuCodeKind.MYCOMMUNITY_DOT)) {
			sb.append(MYCOMMUNITY_DOT);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO_HLXM)) {
			sb.append(JUJIAYANGLAO_HLXM);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO_QCZL)) {
			sb.append(JUJIAYANGLAO_QCZL);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO_FWLC)) {
			sb.append(JUJIAYANGLAO_FWLC);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO_LGXT)) {
			sb.append(JUJIAYANGLAO_LGXT);
		} else if (mck.equals(MenuCodeKind.JUJIAYANGLAO_THHD)) {
			sb.append(JUJIAYANGLAO_THHD);
		}
		Random random = new Random();
		Date now = new Date();
		sb.append(Util.fill(
				random.nextInt(10000)
						+ (now.getTime() + "").substring(5,
								(now.getTime() + "").length()), 12, '0'));
		return sb.toString();
	}

	public static void main(String[] args) {
		// Random random = new Random();
		// Random random1 = new Random();
		// System.out.println(random.nextInt(10000));
		// System.out.println(random1.nextInt(10000));
		// System.out.println((Math.random() * 10000));
		// System.out.println(new Date().getTime());
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MENU_1));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MENU_1));
		
		System.out.println("###########################################################");
		
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAFUWU));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.YANGLAOZIXUN));
		
		System.out.println("###########################################################");
		
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY_NOTICE));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY_INTRO));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY_BUILD));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY_ORG));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.MYCOMMUNITY_DOT));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO_HLXM));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO_QCZL));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO_FWLC));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO_LGXT));
		System.out.println(MenuCodeConfig.getMenuCode(MenuCodeKind.JUJIAYANGLAO_THHD));
	}

	public static enum MenuCodeKind {
		MENU_1(1), MENU_2(2), VIDEO(3), PAGE(4), COMMUNITY(5), NOTICE(6), INTRO(7), BUILD(8), ORG(9), DOT(10), HLXM(11), QCZL(12), FWLC(13), LGXT(14), THHD(15), MYCOMMUNITY(16),
		JUJIAYANGLAO(17), JUJIAFUWU(18), YANGLAOZIXUN(19), MYCOMMUNITY_NOTICE(20), MYCOMMUNITY_INTRO(21), MYCOMMUNITY_BUILD(22), MYCOMMUNITY_ORG(23), MYCOMMUNITY_DOT(24),
		JUJIAYANGLAO_HLXM(25), JUJIAYANGLAO_QCZL(26), JUJIAYANGLAO_FWLC(27), JUJIAYANGLAO_LGXT(28), JUJIAYANGLAO_THHD(29);

		private String stringValue;
		private int intVlue;

		private MenuCodeKind(String stringValue) {
			this.stringValue = stringValue;
		}

		private MenuCodeKind(int intVlue) {
			this.intVlue = intVlue;
		}

		public String getStringValue() {
			return stringValue;
		}

		public int getIntVlue() {
			return intVlue;
		}
	}
}
