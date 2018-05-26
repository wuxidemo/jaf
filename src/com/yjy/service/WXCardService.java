package com.yjy.service;

import java.util.Date;
import java.util.HashMap;
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

import com.yjy.dao.MyDao;
import com.yjy.entity.IntegralRecord;
import com.yjy.entity.Inuser;
import com.yjy.entity.Merchant;
import com.yjy.entity.WXCard;
import com.yjy.entity.WXCardRecord;
import com.yjy.entity.WXMerchant;
import com.yjy.entity.WXUser;
import com.yjy.repository.WXCardDao;
import com.yjy.repository.WXCardRecordDao;
import com.yjy.utils.Util;
import com.yjy.wechat.WXCardManage;
import com.yjy.wechat.WXManage;
import com.yjy.wechat.WXUtil;

@Component
@Transactional
public class WXCardService {
	@Autowired
	public WXCardDao wxcardDao;
	@Autowired
	public WXCardRecordDao wXCardRecordDao;
	@Autowired
	public WXUserService wXUserService;
	@Autowired
	public WXCardRecordService wXCardRecordService;
	@Autowired
	public MyDao myDao;
	@Autowired
	MerchantService merchantService;
	@Autowired
	ImportuserService importuserService;
	@Autowired
	IntegralRecordService integralRecordService;
	@Autowired
	WXMerchantService wXMerchantService;
	@Autowired
	WeChatAccountService weChatAccountService;

	/* 根据领用的数量进行排序 */
	public List<Object> getlistsum(String date, int id) {
		return wxcardDao.getListsum(date, id);
	}

	/* 根据上架的时间经行排序 */
	public List<Object> getdatelist(String date, int id) {
		return wxcardDao.getdateList(date, id);
	}

	/* 根据折扣力度进行排序 */
	public List<Object> getprilist(String date) {

		return wxcardDao.getpriList(date);
	}

	public WXCard get(Long id) {
		return wxcardDao.findOne(id);
	}

	public WXCard save(WXCard wxc) {
		return wxcardDao.save(wxc);
	}

	public List<WXCard> getlist(Long wxmerchantid, String date) {

		return wxcardDao.getList(wxmerchantid, date);
	}

	public Page<WXCard> getWXCard(Map<String, Object> searchParams, int pageNumber, int pageSize, String sortType) {
		PageRequest pageRequest = buildPageRequest(pageNumber, pageSize, sortType);
		Specification<WXCard> spec = Util.buildSpecification(searchParams, WXCard.class);
		return wxcardDao.findAll(spec, pageRequest);
	}

	private PageRequest buildPageRequest(int pageNumber, int pageSize, String sortType) {
		Sort sort = null;
		if ("auto".equals(sortType)) {
			sort = new Sort(Direction.DESC, "id");
		} else if ("title".equals(sortType)) {
			sort = new Sort(Direction.ASC, "name");
		} else if ("createtime".equals(sortType)) {
			sort = new Sort(Direction.DESC, "createtime");
		}

		return new PageRequest(pageNumber - 1, pageSize, sort);
	}

	public WXCard getWXCardByCardid(String cardid) {
		List<WXCard> lc = wxcardDao.getWXCardByCardid(cardid);
		if (lc.size() > 0) {
			return lc.get(0);
		}
		return null;
	}

	/**
	 * 
	 * 卡券审核通过 保存
	 * 
	 * @author lyf
	 * @date 2015年7月2日 下午2:53:57
	 * @param cardid
	 * @param state
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean saveCard(String cardid, int state) {
		WXCard card = getWXCardByCardid(cardid);
		if (card == null) {
			Map<String, Object> data = WXCardManage.getCardInfo(weChatAccountService.getAccesstoken(), cardid);
			if (data != null && Integer.parseInt(data.get("errcode").toString()) == 0) {
				WXCard wxc = new WXCard();
				wxc.setCardid(cardid);
				wxc.setCreatetime(new Date());
				Map<String, Object> info = WXUtil.changeInfo(data);
				if (!(info.get("type").toString().equals("GROUPON") || info.get("type").toString().equals("DISCOUNT")
						|| info.get("type").toString().equals("GIFT") || info.get("type").toString().equals("CASH")
						|| info.get("type").toString().equals("GENERAL_COUPON"))) {
					return false;
				}

				wxc.setType(info.get("type").toString());
				wxc.setName(info.get("title").toString());
				wxc.setState(Integer.parseInt(info.get("state").toString()));
				wxc.setMytype(1);
				// wxc.setLogourl(info.get("logourl").toString());
				if (info.containsKey("leastprice")) {
					wxc.setLeastprice((Integer) info.get("leastprice"));
				} else {
					wxc.setLeastprice(0);
				}
				if (info.containsKey("price")) {
					wxc.setPrice((Integer) info.get("price"));
				} else {
					wxc.setPrice(0);
				}
				if (info.containsKey("locations")) {
					wxc.setLocationids(info.get("locations").toString());
					if (info.get("locations").toString().contains(",")) {
						wxc.setIsonly(0);
						wxc.setMerchantname("多商家");
					} else {
						wxc.setIsonly(1);
						Merchant m = merchantService.getMerchantByPoi_id(info.get("locations").toString());
						wxc.setMerchantname(m == null ? "" : m.getName());
						wxc.setLogourl(m.getThumbnailurl());
					}
				}
				wxc.setDatetype(Integer.parseInt(info.get("datetype").toString()));
				if (wxc.getDatetype() == 2) {
					wxc.setDelaytime(Integer.parseInt(info.get("delay").toString()));
					wxc.setUsetime(Integer.parseInt(info.get("usetime").toString()));
				} else {
					wxc.setStarttime((Date) info.get("starttime"));
					wxc.setEndtime((Date) info.get("endtime"));
				}
				wxc.setTotalnum(Integer.parseInt(info.get("total").toString()));
				wxc.setNownum(Integer.parseInt(info.get("use").toString()));
				if (info.containsKey("submerid")) {
					WXMerchant wxm = wXMerchantService.getWXMOrNew(Long.parseLong(info.get("submerid").toString()));
					if (wxm != null) {
						wxc.setWxmerchantid(wxm.getMerchantid());
						wxc.setWxmerchantname(wxm.getBrandname());
					}
				}
				if (info.get("isfriend").toString().equals("1")) {
					wxc.setWxtype(1);
				} else {
					wxc.setWxtype(0);
				}
				wxcardDao.save(wxc);
			} else {
				return false;
			}
		} else {
			card.setState(state);
			wxcardDao.save(card);
		}
		return true;
	}

	/**
	 * 
	 * 根据cardid查询记录 如果没有从微信查询并保存
	 * 
	 * @author lyf
	 * @date 2015年7月3日 上午8:43:47
	 * @param cardid
	 * @return
	 */
	public WXCard getCardOrNew(String cardid) {
		WXCard card = getWXCardByCardid(cardid);
		if (card == null) {
			Map<String, Object> data = WXCardManage.getCardInfo(weChatAccountService.getAccesstoken(), cardid);
			if (data != null && Integer.parseInt(data.get("errcode").toString()) == 0) {
				WXCard wxc = new WXCard();
				wxc.setCardid(cardid);
				wxc.setCreatetime(new Date());
				Map<String, Object> info = WXUtil.changeInfo(data);
				if (!(info.get("type").toString().equals("GROUPON") || info.get("type").toString().equals("DISCOUNT")
						|| info.get("type").toString().equals("GIFT") || info.get("type").toString().equals("CASH")
						|| info.get("type").toString().equals("GENERAL_COUPON"))) {
					return null;
				}
				wxc.setState(Integer.parseInt(info.get("state").toString()));
				wxc.setType(info.get("type").toString());
				wxc.setName(info.get("title").toString());
				wxc.setMytype(1);
				// wxc.setLogourl(info.get("logourl").toString());
				if (info.containsKey("leastprice")) {
					wxc.setLeastprice((Integer) info.get("leastprice"));
				} else {
					wxc.setLeastprice(0);
				}
				if (info.containsKey("price")) {
					wxc.setPrice((Integer) info.get("price"));
				} else {
					wxc.setPrice(0);
				}
				if (info.containsKey("locations")) {
					wxc.setLocationids(info.get("locations").toString());
					if (info.get("locations").toString().contains(",") || info.get("locations").toString().equals("")) {
						wxc.setIsonly(0);
						wxc.setMerchantname("多商家");
					} else {
						wxc.setIsonly(1);
						Merchant m = merchantService.getMerchantByPoi_id(info.get("locations").toString());
						wxc.setMerchantname(m == null ? "" : m.getName());
						wxc.setLogourl(m == null ? "" : m.getThumbnailurl());
					}
				}
				wxc.setDatetype(Integer.parseInt(info.get("datetype").toString()));
				if (wxc.getDatetype() == 2) {
					wxc.setDelaytime(Integer.parseInt(info.get("delay").toString()));
					wxc.setUsetime(Integer.parseInt(info.get("usetime").toString()));
				} else {
					wxc.setStarttime((Date) info.get("starttime"));
					wxc.setEndtime((Date) info.get("endtime"));
				}
				wxc.setTotalnum(Integer.parseInt(info.get("total").toString()));
				wxc.setNownum(Integer.parseInt(info.get("use").toString()));
				if (info.containsKey("submerid")) {
					WXMerchant wxm = wXMerchantService.getWXMOrNew(Long.parseLong(info.get("submerid").toString()));
					if (wxm != null) {
						wxc.setWxmerchantid(wxm.getMerchantid());
						wxc.setWxmerchantname(wxm.getBrandname());
					}
				}
				if (info.get("isfriend").toString().equals("1")) {
					wxc.setWxtype(1);
				} else {
					wxc.setWxtype(0);
				}
				wxc = wxcardDao.save(wxc);
				return wxc;
			} else {
				return null;
			}
		} else {
			return card;
		}
	}

	/**
	 * 
	 * 获取优惠券信息 或者更新
	 * 
	 * @author luyf
	 * @date 2015年7月17日 上午11:28:55
	 * @param cardid
	 * @return
	 */
	public WXCard getCardOrUpdate(String cardid) {
		WXCard wxc = getWXCardByCardid(cardid);
		if (wxc == null) {
			wxc = new WXCard();
			wxc.setCardid(cardid);
			wxc.setCreatetime(new Date());
			// wxc.setMytype(0); // 默认设置为一般优惠券 积分优惠券暂不使用
			wxc.setIsbank(0);
		}
		Map<String, Object> data = WXCardManage.getCardInfo(weChatAccountService.getAccesstoken(), cardid);
		if (data != null && Integer.parseInt(data.get("errcode").toString()) == 0) {
			Map<String, Object> info = WXUtil.changeInfo(data);
			wxc.setState(Integer.parseInt(info.get("state").toString()));
			if (!(info.get("type").toString().equals("GROUPON") || info.get("type").toString().equals("DISCOUNT")
					|| info.get("type").toString().equals("GIFT") || info.get("type").toString().equals("CASH")
					|| info.get("type").toString().equals("GENERAL_COUPON"))) {
				return null;
			}
			wxc.setType(info.get("type").toString());
			wxc.setName(info.get("title").toString());
			// wxc.setLogourl(info.get("logourl").toString());
			if (info.containsKey("leastprice")) {
				wxc.setLeastprice((Integer) info.get("leastprice"));
			} else {
				wxc.setLeastprice(0);
			}
			if (info.containsKey("price")) {
				wxc.setPrice((Integer) info.get("price"));
			} else {
				wxc.setPrice(0);
			}
			if (info.containsKey("locations")) {
				wxc.setLocationids(info.get("locations").toString());
				if (info.get("locations").toString().contains(",") || info.get("locations").toString().equals("")) {
					wxc.setIsonly(0);
					wxc.setMerchantname("多商家");
				} else {
					wxc.setIsonly(1);
					Merchant m = merchantService.getMerchantByPoi_id(info.get("locations").toString());
					wxc.setMerchantname(m == null ? "" : m.getName());
					wxc.setLogourl(m == null ? "" : m.getThumbnailurl());
				}
			}
			wxc.setDatetype(Integer.parseInt(info.get("datetype").toString()));
			if (wxc.getDatetype() == 2) {
				wxc.setDelaytime(Integer.parseInt(info.get("delay").toString()));
				wxc.setUsetime(Integer.parseInt(info.get("usetime").toString()));
			} else {
				wxc.setStarttime((Date) info.get("starttime"));
				wxc.setEndtime((Date) info.get("endtime"));
			}
			wxc.setTotalnum(Integer.parseInt(info.get("total").toString()));
			wxc.setNownum(Integer.parseInt(info.get("use").toString()));
			if (info.containsKey("submerid")) {
				WXMerchant wxm = wXMerchantService.getWXMOrNew(Long.parseLong(info.get("submerid").toString()));
				if (wxm != null) {
					wxc.setWxmerchantid(wxm.getMerchantid());
					wxc.setWxmerchantname(wxm.getBrandname());
				}
			}
			if (info.get("isfriend").toString().equals("1")) {
				wxc.setWxtype(1);
			} else {
				wxc.setWxtype(0);
			}
		} else {
			return null;
		}
		wxc = wxcardDao.save(wxc);
		return wxc;
	}

	/**
	 * 
	 * 根据code查询记录 如果没有从微信查询并保存
	 * 
	 * @author lyf
	 * @date 2015年7月3日 上午10:48:14
	 * @param cardid
	 * @param code
	 * @return
	 */
	public WXCardRecord getCardRecordOrNew(String cardid, String code) {
		WXCardRecord wr = wXCardRecordService.getWXCardRecordByCode(code);
		if (wr == null) {
			Map<String, Object> data = WXCardManage.getCodeInfo(weChatAccountService.getAccesstoken(), code, null);
			if (data == null || !data.get("errcode").toString().equals("0")) {
				return null;
			}
			Map<String, Object> card = (Map<String, Object>) data.get("card");
			String ncardid = (cardid != null ? cardid : card.get("card_id").toString());
			System.out.println(ncardid);
			WXCard wc = getCardOrNew(ncardid);
			String openid = "";
			String name = "";
			if (wc.getWxtype() == null || wc.getWxtype() == 0) {
				openid = data.get("openid").toString();
				name = wXUserService.getOrNewWXUser(openid).getRealname();
			} else {
				if (data.containsKey("mark_openid")) {
					openid = data.get("mark_openid").toString();
					name = wXUserService.getOrNewWXUser(openid).getRealname();
				} else {
					// openid = data.get("openid").toString();
				}
			}
			wr = new WXCardRecord();
			wr.setCardid(ncardid);
			wr.setCardname(wc.getName());
			wr.setCardtype(wc.getType());
			wr.setCode(code);
			wr.setCreatetime(new Date());
			wr.setOpenid(openid);
			wr.setOwnname(name);
			wr.setStarttime(new Date(Long.parseLong(card.get("begin_time") + "000")));
			wr.setEndtime(new Date(Long.parseLong(card.get("end_time") + "000")));
			wr.setState(1);
			wr.setIsbank(wc.getIsbank());
			wr.setWxmerchantid(wc.getWxmerchantid());
			wr.setWxmerchantname(wc.getWxmerchantname());
			return wXCardRecordDao.save(wr);
		} else {
			if (wr.getOpenid().equals("")) {
				Map<String, Object> data = WXCardManage.getCodeInfo(weChatAccountService.getAccesstoken(), code, null);
				Map<String, Object> card = (Map<String, Object>) data.get("card");
				String ncardid = cardid != null ? cardid : card.get("card_id").toString();
				WXCard wc = getCardOrNew(ncardid);
				String openid = "";
				String name = "";
				if (wc.getWxtype() == null || wc.getWxtype() == 0) {
					openid = data.get("openid").toString();
					name = wXUserService.getOrNewWXUser(openid).getRealname();
				} else {
					if (data.containsKey("mark_openid")) {
						openid = data.get("mark_openid").toString();
						name = wXUserService.getOrNewWXUser(openid).getRealname();
					} else {
						// openid = data.get("openid").toString();
					}
				}
				wr.setOpenid(openid);
				wr.setOwnname(name);
				wr = wXCardRecordDao.save(wr);
			}
		}
		return wr;
	}

	/**
	 * 
	 * 保存卡券领取记录
	 * 
	 * @author lyf
	 * @date 2015年7月3日 上午8:54:27
	 * @param openid
	 * @param giveopenid
	 * @param isgive
	 * @param code
	 * @param cardid
	 * @param outerid
	 * @return
	 */
	public boolean saveCardRecord(String openid, String giveopenid, String isgive, String code, String cardid,
			String outerid, String oldcode) {
		// 是否是转增
		if (isgive.equals("1")) {
			WXCardRecord wcr = getCardRecordOrNew(cardid, oldcode);
			WXUser wu = wXUserService.getOrNewWXUser(openid);
			wcr.setOpenid(openid);
			wcr.setCode(code);
			if (wu != null) {
				wcr.setOwnname(wu.getRealname());
			} else {
				wcr.setOwnname("");
			}
			wXCardRecordDao.save(wcr);
		} else {
			WXCardRecord wcr = getCardRecordOrNew(cardid, code);
			wxcardDao.updatecount(cardid);
			if (outerid != null && !outerid.equals("0")) {
				WXCard wc = getWXCardByCardid(wcr.getCardid());
				if (wc.getMytype().equals(2)) {
					Inuser iu = importuserService.get(Long.parseLong(outerid));
					if (iu != null) {
						IntegralRecord ir = new IntegralRecord();
						ir.setCardcode(code);
						ir.setCardname(wc.getName());
						ir.setCardtype(wc.getType());
						ir.setCount(wc.getCount());
						ir.setCreatetime(new Date());
						ir.setName(iu.getName());
						ir.setOpenid(openid);
						ir.setPhone(iu.getPhone());
						ir.setType(1);
						ir.setCardnum(iu.getCardnum());
						ir.setInuserid(iu.getId());
						integralRecordService.SaveOrUpdate(ir);
						importuserService.updatePoint(iu.getId(), wc.getCount());
					}

				}
			}

		}
		return true;
	}

	/**
	 * 
	 * 查询卡券是否被使用
	 * 
	 * @author luyf
	 * @date 2015年7月9日 下午4:50:44
	 * @param code
	 * @return
	 */
	public Boolean isCardUse(String code) {
		Map<String, Object> result = WXCardManage.getCodeInfo(weChatAccountService.getAccesstoken(), code, null);
		if (result == null) {
			return null;

		} else {
			if (result.get("errcode").toString().equals("40099")) {
				return true;
			} else if (result.get("errcode").toString().equals("0")) {
				return false;
			} else {
				return null;
			}

		}
	}

	public Map<String, Object> checkCard(String code, String locationid) {
		Map<String, Object> result = new HashMap<String, Object>();
		WXCardRecord wcr = getCardRecordOrNew(null, code);
		if (wcr == null) {
			result.put("result", "0");
			result.put("msg", "未找到此卡券");
		} else {
			if (wcr.getOpenid().equals("")) {
				result.put("result", "0");
				result.put("msg", "核销失败,顾客的二维码未展开或已展开超过五分钟");
			} else {
				WXUser wu = wXUserService.getOrNewWXUser(wcr.getOpenid());
				if (wu.getState() == 0) {
					result.put("result", "0");
					result.put("msg", "卡券拥有者未关注公众号,请关注后核销。");
				} else {
					if (wcr.getState() == 2) {
						result.put("result", "0");
						result.put("msg", "此卡券已被使用");
					} else {
						if (isCardUse(code)) {
							result.put("result", "0");
							result.put("msg", "此卡券已被使用");
							wcr.setState(2);
							wXCardRecordDao.save(wcr);
						} else {
							WXCard wxc = getCardOrNew(wcr.getCardid());
							if (wxc == null) {
								result.put("result", "0");
								result.put("msg", "未找到此卡券");
							} else {
								if (wxc.getBankper() == null || wxc.getShopper() == null) {
									result.put("result", "0");
									result.put("msg", "卡券信息不完整,请联系我们。");
								} else {
									String[] ls = wxc.getLocationids().split(",");
									boolean isshop = false;
									for (String s : ls) {
										if (s.equals(locationid)) {
											isshop = true;
											break;
										}
									}
									if (isshop) {
										result.put("result", "1");
										result.put("data", wxc);
										result.put("rdata", wcr);
									} else {
										result.put("result", "0");
										result.put("msg", "此卡券不能在本店使用");
									}
								}

							}
						}
					}
				}
			}
		}
		return result;
	}

	/**
	 * 
	 * 卡券价格计算
	 * 
	 * @author lyf
	 * @date 2015年7月6日 上午10:43:05
	 * @param price
	 * @param lwxc
	 * @return
	 */
	public int calculatePrice(int price, List<WXCard> lwxc, List<WXCardRecord> lwr) {
		int totalprice = price;
		for (int i = 0; i < lwxc.size(); i++) {
			if (lwxc.get(i).getType().equals("DISCOUNT")) {
				lwr.get(i).setShopprice((totalprice * lwxc.get(i).getPrice() * lwxc.get(i).getShopper()) / 10000);
				lwr.get(i).setBankprice((totalprice * lwxc.get(i).getPrice() * lwxc.get(i).getBankper()) / 10000);
				totalprice = totalprice * (100 - lwxc.get(i).getPrice()) / 100;
			}
			// 代金券
			else if (lwxc.get(i).getType().equals("CASH")) {
				if (totalprice >= lwxc.get(i).getLeastprice()) {
					lwr.get(i).setShopprice(lwxc.get(i).getShopper());
					lwr.get(i).setBankprice(lwxc.get(i).getBankper());
					totalprice -= lwxc.get(i).getPrice();

				}
			} else {
				lwr.get(i).setShopprice(lwxc.get(i).getShopper());
				lwr.get(i).setBankprice(lwxc.get(i).getBankper());
				totalprice -= lwxc.get(i).getPrice();
			}
		}
		return totalprice < 0 ? 0 : totalprice;
	}

	/**
	 * 
	 * 根据门店ID查询卡券
	 * 
	 * @author luyf
	 * @date 2015年7月10日 上午10:09:43
	 * @param string
	 * @return
	 */
	public List<WXCard> getCardByLocation(String string) {
		return myDao.getCardByLocation(string);
	}

	public List<WXCard> getAllUserCard() {
		return myDao.getAllUserCard();
	}

	public void refreshCard() {
		List<String> ls = WXCardManage.getALLCardid(weChatAccountService.getAccesstoken());
		for (String s : ls) {
			try {
				getCardOrUpdate(s);
			} catch (Exception e) {
				System.out.println(s);
			}
		}

	}

	/************************* 2016-04-20添加 ****************************/

	public List<WXCard> getQiangGouActCard() {
		return myDao.getQiangGouActCard();
	}

}
