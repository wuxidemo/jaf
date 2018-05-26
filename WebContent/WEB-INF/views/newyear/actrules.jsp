<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta
	content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<title>活动规则</title>
<style type="text/css">
body {
	margin: 0;
	background-color: #ff5742;
	font-family: Microsoft YaHei;
}

.container {
	margin: 20px;
}

.div_rule img {
	width: 100px;
	margin-top: 20px;
	position: relative;
}

.div_rule div {
	color: white;
	font-size: 15px;
	margin-bottom: 20px;
	margin-top: 20px;
}

.hr {
	margin-top: -6px;
	border: 1px #fbd439 solid;
}
</style>
</head>
<body>
	<div class="container">
		<div class="div_rule">
			<img src="${ctx}/static/wxfile/newyear/image/rule_01.png">
			<hr class="hr">
			<div>① 每个商户最多3人参与；</div>
			<div>② 报名参与人员需提供本人照片一张（尽量保证脸部在照片的中间位置），并写明所在商户、个人心语等信息；</div>
			<div>
				③ 活动时间：1月5日-1月25日；<br>&nbsp;&nbsp;&nbsp;&nbsp;报名时间：1月5日-14日；<br>&nbsp;&nbsp;&nbsp;&nbsp;审核时间：1月15日（组委会审核评选出50名服务员进入投票阶段）；
				<br>&nbsp;&nbsp;&nbsp;&nbsp;投票时间：1月16日-24日；<br>&nbsp;&nbsp;&nbsp;&nbsp;获奖公布：1月25日。
			</div>
		</div>
		<div class="div_rule">
			<img src="${ctx}/static/wxfile/newyear/image/rule_02.png">
			<hr class="hr">
			<div>① 为你最喜欢的服务员投票，每个ID每天可投3票（不可投给同一个服务员）；</div>
			<div>②
				参赛的服务员可通过两种方式为自己拉票：一、分享链接邀请好友投票；二、扫码投票（服务员提供二维码邀请消费者关注本微信平台并投票，若消费者定位在无锡，则每新增一位粉丝，服务员可获得0.5元的返利红包，每天结算。一天少于两位粉丝者，无返利红包。定位不在无锡的消费者，可参与投票，但服务员无返利红包）；</div>
			<div>③ 最终名次按得票数量由高至低排名；</div>
			<div>④ 本活动拒绝一切形式的刷票，一经发现立即取消参与资格；</div>
			<div>⑤ 奖品在活动结束后3天内由湖滨商业街管委会颁发；</div>
			<div>⑥ 在法律范围内，解释权归金阿福e服务平台所有。</div>
		</div>
		<div class="div_rule">
			<img src="${ctx}/static/wxfile/newyear/image/rule_03.png">
			<hr class="hr">
			<div>一等奖 1名 奖品为现金2000元</div>
			<div>二等奖 3名 奖品为每人现金1000元</div>
			<div>三等奖 5名 奖品为每人现金500元</div>
			<div>参与奖 500份 参与投票的用户都有机会获一个微信红包!</div>
		</div>
	</div>
</body>
</html>