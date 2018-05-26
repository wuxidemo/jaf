<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String pid = request.getParameter("pid");
    String taskid = request.getParameter("taskid");
%>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />

<!DOCTYPE>
<html>
<head>
	<meta content="width=device-width, height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
	<link rel="stylesheet" href="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.css">
	<title>朗高居家养老评估表</title>
</head>
<body>
	<div data-role="page" id="table1">
		<div data-role="header" data-position="fixed">
			<input type="checkbox" name="checkbraden" id="checkbraden" value="no" style="position: static; margin-top: 0; margin-left: 10px; float:left;vertical-align: middle;" >
			<!-- <label for="checkbraden">不做该评估</label>  -->
			<span style="padding-top: 30px;" id="spancheckbraden">&nbsp;不做该评估</span>
			<h1 style="margin-top:-10px;">Braden评估表</h1>
			<a href="javascript:;" data-role="button" class="ui-btn-right" onclick="bradenFormSubmit()" id="subcheckbraden">提交当前评估</a>
		</div>
		<div data-role="content" id="bradenContent">
			
			<form id="bradenform" method="post" action="${ctx}/mapi/braden/create" method="post">
		
				<label for="obradenname">姓名：</label>
				<input type="text" id="obradenname" data-clear-btn="true" maxlength="20" placeholder="姓名" name="obradenname" value="${braden.obradenname }">
				
				<fieldset data-role="controlgroup">
					<legend>性别：</legend>
					<input type="radio" name="obradensex" id="obradensex1" value="M">
					<label for="obradensex1">男</label> 
					<input type="radio" name="obradensex" id="obradensex2" value="F">
					<label for="obradensex2">女</label> 
				</fieldset>
				
				<label for="obradenage">年龄：</label>
				<input type="text" id="obradenage" data-clear-btn="true" maxlength="20" placeholder="年龄" name="obradenage" value="${braden.obradenage }">
				
				<label for="bedno">床号：</label>
				<input type="text" id="bedno" data-clear-btn="true" maxlength="20" placeholder="床号" name="bedno" value="${braden.bedno }">
				
				<label for="oinhospital">入院诊断：</label>
				<input type="text" id="oinhospital" data-clear-btn="true" maxlength="20" placeholder="入院诊断" name="oinhospital" value="${braden.oinhospital }">
				
				<fieldset data-role="controlgroup">
					<legend>感知压力的能力：</legend>
					<input type="radio" name="sensevalue" id="sensevalue1" value="1">
					<label for="sensevalue1"><b>完全受限：</b>对疼痛刺激无反应</label> 
					<input type="radio" name="sensevalue" id="sensevalue2" value="2">
					<label for="sensevalue2"><b>非常受限：</b>对疼痛只能用呻吟、烦躁不安表示</label> 
					<input type="radio" name="sensevalue" id="sensevalue3" value="3">
					<label for="sensevalue3"><b>轻微受限：</b>能用语言表达疼痛或不舒适</label> 
					<input type="radio" name="sensevalue" id="sensevalue4" value="4">
					<label for="sensevalue4"><b>无损害：</b>痛觉反应正常</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>潮湿度(皮肤暴露于潮湿中的程度)：</legend>
					<input type="radio" name="wetvalue" id="wetvalue1" value="1">
					<label for="wetvalue1"><b>持续潮湿：</b>每次移动或翻动病人时看到皮肤总处于浸湿状态</label> 
					<input type="radio" name="wetvalue" id="wetvalue2" value="2">
					<label for="wetvalue2"><b>非常潮湿：</b>皮肤频繁受潮，床单至少每班更换1次</label> 
					<input type="radio" name="wetvalue" id="wetvalue3" value="3">
					<label for="wetvalue3"><b>偶尔潮湿：</b>要求额外更换床单大约每日一次</label> 
					<input type="radio" name="wetvalue" id="wetvalue4" value="4">
					<label for="wetvalue4"><b>罕见潮湿：</b>皮肤干燥，床单按常规时间更换</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>活动能力：</legend>
					<input type="radio" name="activityvalue" id="activityvalue1" value="1">
					<label for="activityvalue1"><b>卧床：</b>被限制在床上，不能下床活动</label> 
					<input type="radio" name="activityvalue" id="activityvalue2" value="2">
					<label for="activityvalue2"><b>坐椅子：</b>不能步行，或必须借助椅子或轮椅活动</label> 
					<input type="radio" name="activityvalue" id="activityvalue3" value="3">
					<label for="activityvalue3"><b>偶尔步行：</b>白天需借助辅助设施偶尔短距离步行。大部分时间在床上或椅子里</label> 
					<input type="radio" name="activityvalue" id="activityvalue4" value="4">
					<label for="activityvalue4"><b>经常步行：</b>室外步行每日&ge;2次，室内步行&ge;每2h一次</label> 
				</fieldset>
				
				
				<fieldset data-role="controlgroup">
					<legend>移动能力(改变和控制体位的能力)：</legend>
					<input type="radio" name="movevalue" id="movevalue1" value="1">
					<label for="movevalue1"><b>完全不能移动：</b>病人不能自主改变身体或四肢的位置</label> 
					<input type="radio" name="movevalue" id="movevalue2" value="2">
					<label for="movevalue2"><b>非常受限：</b>偶尔能轻微改变身体或四肢的位置，但不能经常改变或需要帮助才改变</label> 
					<input type="radio" name="movevalue" id="movevalue3" value="3">
					<label for="movevalue3"><b>轻微受限：</b>尽管只是轻微改变身体或四肢的位置，但可经常移动且独立进行</label> 
					<input type="radio" name="movevalue" id="movevalue4" value="4">
					<label for="movevalue4"><b>不受限：</b>可独立进行体位改变，且经常随意改变</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>营养(摄取食物的方式)：</legend>
					<input type="radio" name="eatbradenvalue" id="eatbradenvalue1" value="1">
					<label for="eatbradenvalue1"><b>非常差：</b>①从未吃过完整一餐；②每天吃两餐或蛋白质较少的食物；③摄取水分较少；④禁食和/或和清流质或静脉输液&gt;5天。</label> 
					<input type="radio" name="eatbradenvalue" id="eatbradenvalue2" value="2">
					<label for="eatbradenvalue2"><b>可能不足：</b>①罕见吃完一餐；②一般仅吃所供食物的1/2；③蛋白质摄入日常量；④接受较少量的流汁饮食或管饲饮食。</label> 
					<input type="radio" name="eatbradenvalue" id="eatbradenvalue3" value="3">
					<label for="eatbradenvalue3"><b>充足：</b>①大多数时间所吃食物&gt;1/2所供食物；②每日所吃蛋白质满足人体需要；③在鼻饲或TPN期间能满足大部分营养需求。</label> 
					<input type="radio" name="eatbradenvalue" id="eatbradenvalue4" value="4">
					<label for="eatbradenvalue4"><b>良好：</b>①每餐均能吃完或基本吃完；②从不少吃一餐。蛋白质摄入满足需要。</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>摩擦和剪切力：</legend>
					<input type="radio" name="frictionvalue" id="frictionvalue1" value="1">
					<label for="frictionvalue1"><b>非常差：</b>①从未吃过完整一餐；②每天吃两餐或蛋白质较少的食物；③摄取水分较少；④禁食和/或和清流质或静脉输液&gt;5天。</label> 
					<input type="radio" name="frictionvalue" id="frictionvalue2" value="2">
					<label for="frictionvalue2"><b>可能不足：</b>①罕见吃完一餐；②一般仅吃所供食物的1/2；③蛋白质摄入日常量；④接受较少量的流汁饮食或管饲饮食。</label> 
					<input type="radio" name="frictionvalue" id="frictionvalue3" value="3">
					<label for="frictionvalue3"><b>充足：</b>①大多数时间所吃食物&gt;1/2所供食物；②每日所吃蛋白质满足人体需要；③在鼻饲或TPN期间能满足大部分营养需求。</label> 
				</fieldset>
				
				<label for="frictionscore">摩擦和剪切力评分：</label>
				<input type="text" id="frictionscore" data-clear-btn="false"  readonly="readonly" maxlength="20" placeholder="摩擦和剪切力评分" name="frictionscore" value="${braden.frictionscore }">
				
				<label for="totalbradenvalue">总分：</label>
				<input type="text" id="totalbradenvalue" data-clear-btn="false" readonly="readonly" maxlength="20" placeholder="总分" name="totalbradenvalue" value="${braden.totalbradenvalue }">
				
				<label for="dangerass">压疮危险判断：</label>
				<textarea id="dangerass" maxlength="100" placeholder="压疮危险判断" name="dangerass">${braden.dangerass }</textarea>
				
				<input type="hidden" name="bradenpid" id="bradenpid">
				<input type="hidden" name="id" id="bradenid">
				
				<label for="note">&nbsp;</label>
					<p><span><b>备注：</b>1.Braden压疮评估表评估频次：新入院患者存在移动能力缺乏，由责任护士实施危险评估在入院2小时内完成评估；新入院患者连续评估三天，之后根据病情决定；手术后、长时间的操作结束后要及时进行评估；
					慢性病患者应每隔72h复评估一次，ICU患者和评分&le;12分或已发生压疮的患者每日评估；病情变化随时评估。2.各科转科的病人，手术病人转入转出手术室当班护士之间需要交接班记录（包括Braden评分结果及皮肤完好状况）。3.高危
					患者及时告之患者、家属并签名，护士按要求落实各项防治护理措施。4.Braden评分总分23分，15-16分有轻度危险（年龄>=70岁者分值提升至15-17分为轻度危险；13-14分中度危险；10-12分高度危险；&lt;9分极高度危险</span></p>
				
				<label for="bradenselforfamilysign"><a href="#signbraden">患者家属签字</a></label>
				<input type="hidden" id="bradenselforfamilysign" name="bradenselforfamilysign" >
				<img id="signbradenimg" style="border: 1px solid red; width: 100%">
			</form>
			
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<!-- <li><a href="#table3" id="" data-icon="check">上一个评估</a></li> -->
					<li><a href="javascript:;" id="saveall1" data-icon="check" onclick="submitAllForm()">保存所有评估表</a></li>
					<li><a href="#table2" id="" data-icon="check">下一个评估</a></li>
				</ul>
			</div>


		</div>
	</div>

	<div data-role="page" id="table2">
		<div data-role="header" data-position="fixed">
			<input type="checkbox" name="checkadl" id="checkadl" value="no" style="position: static; margin-top: 0; margin-left: 10px; float:left;vertical-align: middle;" >
			<span style="padding-top: 30px;" id="spancheckadl">&nbsp;不做该评估</span>
			<h1 style="margin-top:-10px;">ADL常规评估</h1>
			<a href="javascript:;" data-role="button" class="ui-btn-right" onclick="adlFormSubmit()" id="subcheckadl">提交当前评估</a>
		</div>
		<div data-role="content" id="adlContent">
		
			<form id="adlform" method="post" action="${ctx}/mapi/adl/create" method="post">
			
				<label for="oadlname">姓名：</label>
				<input type="text" id="oadlname" data-clear-btn="true" maxlength="20" placeholder="姓名" name="oadlname" value="${adl.oadlname }">
				
				<fieldset data-role="controlgroup">
					<legend>性别：</legend>
					<input type="radio" name="oadlsex" id="oadlsex1" value="M">
					<label for="oadlsex1">男</label> 
					<input type="radio" name="oadlsex" id="oadlsex2" value="F">
					<label for="oadlsex2">女</label> 
				</fieldset>
				
				<label for="oadlage">年龄：</label>
				<input type="text" id="oadlage" data-clear-btn="true" maxlength="20" placeholder="年龄" name="oadlage" value="${adl.oadlage }">
				
				<label for="oage">出生年月：</label>
				<input type="text" id="obirthday" data-clear-btn="true" maxlength="20" placeholder="出生年月" name="obirthday" value="${adl.obirthday }">
			
				<fieldset data-role="controlgroup">
					<legend>文化程度：</legend>
					<input type="radio" name="oeducation" id="oeducation1" value="wenmang">
					<label for="oeducation1">文盲</label> 
					<input type="radio" name="oeducation" id="oeducation2" value="xiaoxue">
					<label for="oeducation2">小学</label> 
					<input type="radio" name="oeducation" id="oeducation3" value="chuzhong">
					<label for="oeducation3">初中</label> 
					<input type="radio" name="oeducation" id="oeducation4" value="gaozhong">
					<label for="oeducation4">高中</label> 
					<input type="radio" name="oeducation" id="oeducation5" value="dazhuan">
					<label for="oeducation5">大专</label> 
					<input type="radio" name="oeducation" id="oeducation6" value="daxue">
					<label for="oeducation6">大学</label> 
				</fieldset>
				
				<label for="oage">原职业：</label>
				<input type="text" id="ojob" data-clear-btn="true" maxlength="20" placeholder="原职业" name="ojob" value="${adl.ojob }">
				
				<label for="oage">居住地：</label>
				<input type="text" id="oaddress" data-clear-btn="true" maxlength="20" placeholder="居住地" name="oaddress" value="${adl.oaddress }">
				
				<fieldset data-role="controlgroup">
					<legend>婚姻状况：</legend>
					<input type="radio" name="omarry" id="omarry1" value="weihun">
					<label for="omarry1">未婚</label> 
					<input type="radio" name="omarry" id="omarry2" value="yihun">
					<label for="omarry2">已婚</label> 
					<input type="radio" name="omarry" id="omarry3" value="lihun">
					<label for="omarry3">离婚</label> 
					<input type="radio" name="omarry" id="omarry4" value="sangou">
					<label for="omarry4">丧偶</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>居住状况：</legend>
					<input type="radio" name="oliving" id="oliving1" value="zinvliving">
					<label for="oliving1">与子女同居</label> 
					<input type="radio" name="oliving" id="oliving2" value="peiouliving">
					<label for="oliving2">与配偶同居</label> 
					<input type="radio" name="oliving" id="oliving3" value="dujuliving">
					<label for="oliving3">独居</label> 
					<input type="radio" name="oliving" id="oliving4" value="jigouliving">
					<label for="oliving4">入住养老机构</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>经济状况：</legend>
					<input type="checkbox" name="oincome" id="oincome1" value="lixiu">
					<label for="oincome1">离休</label> 
					<input type="checkbox" name="oincome" id="oincome2" value="tuixiu">
					<label for="oincome2">退休</label> 
					<input type="checkbox" name="oincome" id="oincome3" value="dibao">
					<label for="oincome3">低保</label> 
					<input type="checkbox" name="oincome" id="oincome4" value="zinv">
					<label for="oincome4">子女</label> 
					<input type="checkbox" name="oincome" id="oincome5" value="qita">
					<label for="oincome5">其他</label> 
					<input type="checkbox" name="oincome" id="oincome6" value="yibao">
					<label for="oincome6">医保</label> 
					<input type="checkbox" name="oincome" id="oincome7" value="shebao">
					<label for="oincome7">社保</label> 
					<input type="checkbox" name="oincome" id="oincome8" value="gongfei">
					<label for="oincome8">公费</label> 
					<input type="checkbox" name="oincome" id="oincome9" value="zifei">
					<label for="oincome9">自费</label> 
					<input type="checkbox" name="oincome" id="oincome10" value="dishouru">
					<label for="oincome10">低收入</label> 
				</fieldset>
				
				
				<fieldset data-role="controlgroup">
					<legend>是否有以下疾病：</legend>
					<input type="checkbox" name="odisease" id="odisease1" value="laonianchidaizheng">
					<label for="odisease1">老年痴呆症</label> 
					<input type="checkbox" name="odisease" id="odisease2" value="naogeng">
					<label for="odisease2">脑梗</label> 
					<input type="checkbox" name="odisease" id="odisease3" value="gaoxueya">
					<label for="odisease3">高血压</label> 
					<input type="checkbox" name="odisease" id="odisease4" value="tangniaobing">
					<label for="odisease4">糖尿病</label> 
					<input type="checkbox" name="odisease" id="odisease5" value="laonianyiyuzheng">
					<label for="odisease5">老年抑郁症</label> 
					<input type="checkbox" name="odisease" id="odisease6" value="pajinsen">
					<label for="odisease6">帕金森</label> 
					<input type="checkbox" name="odisease" id="odisease7" value="manzhi">
					<label for="odisease7">慢支</label> 
					<input type="checkbox" name="odisease" id="odisease8" value="guanxinbing">
					<label for="odisease8">冠心病</label> 
					<input type="checkbox" name="odisease" id="odisease9" value="shangzhiguzhe">
					<label for="odisease9">上肢骨折</label> 
					<input type="checkbox" name="odisease" id="odisease10" value="xiazhiguzhe">
					<label for="odisease10">下肢骨折</label> 
					<input type="checkbox" name="odisease" id="odisease11" value="guanjiexingjibing">
					<label for="odisease11">关节性疾病</label> 
					<input type="checkbox" name="odisease" id="odisease12" value="aizheng">
					<label for="odisease12">癌症</label>
					<input type="checkbox" name="odisease" id="odisease13" value="piantan">
					<label for="odisease13">偏瘫</label> 
					<input type="checkbox" name="odisease" id="odisease14" value="jingzhuibing">
					<label for="odisease14">颈椎病</label>
					<input type="checkbox" name="odisease" id="odisease15" value="gaolingshineng">
					<label for="odisease15">高龄失能</label> 
				</fieldset>
				
				<label for="oselfphone">本人联系电话：</label>
				<input type="text" id="oselfphone" data-clear-btn="true" maxlength="20" placeholder="本人联系电话" name="oselfphone" value="${adl.oselfphone }">
				
				<label for="oselfphone">子女联系电话：</label>
				<input type="text" id="ochildrenphone" data-clear-btn="true" maxlength="20" placeholder="子女联系电话" name="ochildrenphone" value="${adl.ochildrenphone }">
				
				<label for="olifestate">生命体征：</label>
				<input type="text" id="olifestate" data-clear-btn="true" maxlength="200" placeholder="生命体征" name="olifestate" value="${adl.olifestate }">
				
				<label for="onofunctionlevel">失能级别及现状：</label>
				<input type="text" id="onofunctionlevel" data-clear-btn="true" maxlength="200" placeholder="失能级别及现状" name="onofunctionlevel" value="${adl.onofunctionlevel }">
				
				
				<fieldset data-role="controlgroup">
					<legend>评估后的建议措施：</legend>
					<label>康复治疗</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass1" value="kfzl_zhenjiuzhiliao">
					<label for="adviceafterass1">针灸治疗</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass2" value="kfzl_tuinaanmo">
					<label for="adviceafterass2">推拿按摩</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass3" value="kfzl_zhitikangfuxunlian">
					<label for="adviceafterass3">肢体康复训练</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass4" value="kfzl_naoxunhuanyi">
					<label for="adviceafterass4">脑循环仪</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass5" value="kfzl_qiyadaixunhuan">
					<label for="adviceafterass5">气压带循环</label> 
					
					<input type="checkbox" name="adviceafterass" id="adviceafterass6" value="shzl_laorenshineishenghuo">
					<label for="adviceafterass6">老人室内生活</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass7" value="shzl_chenwanjianhuli">
					<label for="adviceafterass7">晨晚间护理</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass8" value="shzl_rijiangerenweisheng">
					<label for="adviceafterass8">日间个人卫生</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass9" value="shzl_peitongshiwaihuodong">
					<label for="adviceafterass9">陪同室外活动</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass10" value="shzl_peichuang">
					<label for="adviceafterass10">陪床</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass11" value="shzl_peitonggongnengxunlian">
					<label for="adviceafterass11">陪同功能训练</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass12" value="shzl_gezhongjibinghuli">
					<label for="adviceafterass12">各种疾病护理</label>
					<input type="checkbox" name="adviceafterass" id="adviceafterass13" value="shzl_linzhonghuli">
					<label for="adviceafterass13">临终护理</label> 
					
					<input type="checkbox" name="adviceafterass" id="adviceafterass14" value="ylhl_xinlihuli">
					<label for="adviceafterass14">心理护理</label>
					<input type="checkbox" name="adviceafterass" id="adviceafterass15" value="ylhl_yinshizhidao">
					<label for="adviceafterass15">饮食指导</label> 
					<input type="checkbox" name="adviceafterass" id="odisease16" value="ylhl_gezhongjibinghulizhidao">
					<label for="adviceafterass16">各种疾病护理指导</label>
					<input type="checkbox" name="adviceafterass" id="adviceafterass17" value="ylhl_xinlishudao">
					<label for="adviceafterass17">心理疏导</label> 
					<input type="checkbox" name="adviceafterass" id="adviceafterass18" value="ylhl_jingshenweijie">
					<label for="adviceafterass18">精神慰藉</label>
					<input type="checkbox" name="adviceafterass" id="adviceafterass19" value="ylhl_shengmingtizhengjiance">
					<label for="adviceafterass19">生命体征检测</label> 
					
					<label>其他</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>服务项目：</legend>
					<input type="checkbox" name="serveitem" id="serveitem1" value="kangfuzhiliao">
					<label for="serveitem1">康复治疗</label> 
					<input type="checkbox" name="serveitem" id="serveitem2" value="yiliaohuli">
					<label for="serveitem2">医疗护理</label> 
					<input type="checkbox" name="serveitem" id="serveitem3" value="shenghuohuli">
					<label for="serveitem3">生活护理</label> 
					<input type="checkbox" name="serveitem" id="serveitem4" value="xinlishudao">
					<label for="serveitem4">心理疏导</label> 
					<input type="checkbox" name="serveitem" id="serveitem5" value="gongnengduanlian">
					<label for="serveitem5">功能锻炼</label> 
				</fieldset>
				
				<input type="hidden" name="adlpid" id="adlpid">
				<input type="hidden" name="id" id="adlid">
				
				<label for="adlselforfamilysign"><a href="#signadl">患者家属签字</a></label> 
				<input type="hidden" id="adlselforfamilysign" name="adlselforfamilysign" >
				<img id="signadlimg" style="border: 1px solid red; width: 100%">
			</form>
			
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#table1" id="" data-icon="check">上一个评估</a></li>
					<li><a href="javascript:;" id="saveall2" data-icon="check" onclick="submitAllForm()">保存所有评估表</a></li>
					<li><a href="#table3" id="" data-icon="check">下一个评估</a></li>
				</ul>
			</div>


		</div>
	</div>


	<div data-role="page" id="table3">
		<div data-role="header" data-position="fixed">
			<input type="checkbox" name="checkadlplus" id="checkadlplus" value="no" style="position: static; margin-top: 0; margin-left: 10px; float:left;vertical-align: middle;" >
			<span style="padding-top: 30px;" id="spancheckadlplus">&nbsp;不做该评估</span>
			<h1 style="margin-top:5px;">ADL行为能力评估</h1>
			<a href="javascript:;" data-role="button" class="ui-btn-right" onclick="adlplusFormSubmit()" id="subcheckadlplus">提交当前评估</a>
		</div>
		<div data-role="content">
		
			<form id="adlplusform" method="post" action="${ctx}/mapi/adlplus/create" method="post">
			
				<label for="oadlplusname">姓名：</label>
				<input type="text" id="oadlplusname" data-clear-btn="true" maxlength="20" placeholder="姓名" name="oadlplusname" value="${adlplus.oadlplusname }">
				
				<label for="oidcard">身份证号：</label>
				<input type="text" id="oidcard" data-clear-btn="true" maxlength="20" placeholder="身份证号" name="oidcard" value="${adlplus.oidcard }">
			
				<fieldset data-role="controlgroup">
					<legend>行动：</legend>
					<input type="radio" name="actionvalue" id="actionvalue1" value="0">
					<label for="actionvalue1">独立</label> 
					<input type="radio" name="actionvalue" id="actionvalue2" value="3">
					<label for="actionvalue2">需要帮助(人/器械)</label> 
					<input type="radio" name="actionvalue" id="actionvalue3" value="10">
					<label for="actionvalue3">需要较多的帮助/卧床</label> 
					<input type="radio" name="actionvalue" id="actionvalue4" value="16">
					<label for="actionvalue4">完全需要人力帮助</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>吃饭：</legend>
					<input type="radio" name="eatadlplusvalue" id="eatadlplusvalue1" value="0">
					<label for="eatadlplusvalue1">独立</label> 
					<input type="radio" name="eatadlplusvalue" id="eatadlplusvalue2" value="3">
					<label for="eatadlplusvalue2">需要帮助</label> 
					<input type="radio" name="eatadlplusvalue" id="eatadlplusvalue3" value="10">
					<label for="eatadlplusvalue3">完全需要帮助</label> 
					<input type="radio" name="eatadlplusvalue" id="eatadlplusvalue4" value="16">
					<label for="eatadlplusvalue4">需要喂食</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>如厕：</legend>
					<input type="radio" name="toiletvalue" id="toiletvalue1" value="0">
					<label for="toiletvalue1">独立</label> 
					<input type="radio" name="toiletvalue" id="toiletvalue2" value="3">
					<label for="toiletvalue2">需要人帮助</label> 
					<input type="radio" name="toiletvalue" id="toiletvalue3" value="8">
					<label for="toiletvalue3">需要便桶/便盆/尿壶</label> 
					<input type="radio" name="toiletvalue" id="toiletvalue4" value="16">
					<label for="toiletvalue4">不能自理，需要帮助</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>个人卫生处理：</legend>
					<input type="radio" name="selfcleanvalue" id="selfcleanvalue1" value="0">
					<label for="selfcleanvalue1">独立(无需帮助)</label> 
					<input type="radio" name="selfcleanvalue" id="selfcleanvalue2" value="2">
					<label for="selfcleanvalue2">某些行为需要帮助/监护</label> 
					<input type="radio" name="selfcleanvalue" id="selfcleanvalue3" value="4">
					<label for="selfcleanvalue3">所有行为需要帮助</label> 
					<input type="radio" name="selfcleanvalue" id="selfcleanvalue4" value="6">
					<label for="selfcleanvalue4">卧床/手推车洗漱</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>康复治疗：</legend>
					<input type="radio" name="healvalue" id="healvalue1" value="1">
					<label for="healvalue1">日常治疗&nbsp;口述/局部治疗&nbsp;1分</label> 
					<input type="radio" name="healvalue" id="healvalue2" value="3">
					<label for="healvalue2">日常治疗&nbsp;口述/局部治疗&nbsp;1分&nbsp;康复治疗&nbsp;2分</label> 
					<input type="radio" name="healvalue" id="healvalue3" value="7">
					<label for="healvalue3">日常治疗&nbsp;口述/局部治疗&nbsp;1分&nbsp;康复治疗&nbsp;2分&nbsp;理疗&nbsp;4分</label> 
					<input type="radio" name="healvalue" id="healvalue4" value="12">
					<label for="healvalue4">日常治疗&nbsp;口述/局部治疗&nbsp;1分&nbsp;康复治疗&nbsp;2分&nbsp;理疗&nbsp;4分&nbsp;特殊治疗程序以分钟计&nbsp;每分钟5分</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>社会和情感需要：</legend>
					<input type="radio" name="motionvalue" id="motionvalue1" value="0">
					<label for="motionvalue1">无</label> 
					<input type="radio" name="motionvalue" id="motionvalue2" value="1">
					<label for="motionvalue2">偶尔需要</label> 
					<input type="radio" name="motionvalue" id="motionvalue3" value="2">
					<label for="motionvalue3">经常需要</label> 
					<input type="radio" name="motionvalue" id="motionvalue4" value="3">
					<label for="motionvalue4">一直需要</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>意识模糊、走失、丢失物品、迷路：</legend>
					<input type="radio" name="consciousvalue" id="consciousvalue1" value="0">
					<label for="consciousvalue1">无</label> 
					<input type="radio" name="consciousvalue" id="consciousvalue2" value="3">
					<label for="consciousvalue2">偶尔发生(每周1~3次)</label> 
					<input type="radio" name="consciousvalue" id="consciousvalue3" value="8">
					<label for="consciousvalue3">经常发生(每周4~6次)</label> 
					<input type="radio" name="consciousvalue" id="consciousvalue4" value="10">
					<label for="consciousvalue4">一直发生(每天)</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>精神问题、幻觉、幻想、焦虑、抑郁：</legend>
					<input type="radio" name="mindvalue" id="mindvalue1" value="0">
					<label for="mindvalue1">无</label> 
					<input type="radio" name="mindvalue" id="mindvalue2" value="2">
					<label for="mindvalue2">轻微干扰生活</label> 
					<input type="radio" name="mindvalue" id="mindvalue3" value="4">
					<label for="mindvalue3">中等干扰生活</label> 
					<input type="radio" name="mindvalue" id="mindvalue4" value="6">
					<label for="mindvalue4">严重干扰生活</label> 
				</fieldset>
				
				<fieldset data-role="controlgroup">
					<legend>行为问题、多动、暴力行为、逃匿、不合作：</legend>
					<input type="radio" name="behaviorvalue" id="behaviorvalue1" value="0">
					<label for="behaviorvalue1">无</label> 
					<input type="radio" name="behaviorvalue" id="behaviorvalue2" value="3">
					<label for="behaviorvalue2">偶尔发生(每周1~3次)</label> 
					<input type="radio" name="behaviorvalue" id="behaviorvalue3" value="10">
					<label for="behaviorvalue3">经常发生(每周4~6次)</label> 
					<input type="radio" name="behaviorvalue" id="behaviorvalue4" value="16">
					<label for="behaviorvalue4">一直发生(每天)</label> 
				</fieldset>
				
				<label for="totaladlplusvalue">总分：</label>
				<input type="text" id="totaladlplusvalue" data-clear-btn="true" readonly="readonly"  maxlength="20" placeholder="总分" name="totaladlplusvalue" value="${adlplus.totaladlplusvalue }">
				
				<input type="hidden" name="adlpluspid" id="adlpluspid">
				<input type="hidden" name="id" id="adlplusid">
				
				<label for="adlplusselforfamilysign"><a href="#signadlplus">患者家属签字</a></label> 
				<input type="hidden" id="adlplusselforfamilysign" name="adlplusselforfamilysign" >
				<img id="signadlplusimg" style="border: 1px solid red; width: 100%">
			
			</form>
		
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#table2" id="" data-icon="check">上一个评估</a></li>
					<li><a href="javascript:;" id="saveall3" data-icon="check" onclick="submitAllForm()">保存所有评估表</a></li>
					<!-- <li><a href="#table1" id="" data-icon="check">下一个评估</a></li> -->
				</ul>
			</div>
		</div>
	</div>


	<div id="signbraden" data-role="page" data-title="客户签名">
		<div data-role="content" style="padding: 0;">
			<canvas id="simplebraden" style="width: 100%; height: 100%;">浏览器不支持canvas</canvas>
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="javascript:void(0)" id="clearbraden"
						data-icon="refresh">清空</a></li>
					<li><a href="#" id="savebradensign" data-icon="check">保存</a></li>
				</ul>
			</div>
		</div>

	</div>
	
	<div id="signadl" data-role="page" data-title="客户签名">
		<div data-role="content" style="padding: 0;">
			<canvas id="simpleadl" style="width: 100%; height: 100%;">浏览器不支持canvas</canvas>
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="javascript:void(0)" id="clearadl"
						data-icon="refresh">清空</a></li>
					<li><a href="#" id="saveadlsign" data-icon="check">保存</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="signadlplus" data-role="page" data-title="客户签名">
		<div data-role="content" style="padding: 0;">
			<canvas id="simpleadlplus" style="width: 100%; height: 100%;">浏览器不支持canvas</canvas>
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="javascript:void(0)" id="clearadlplus"
						data-icon="refresh">清空</a></li>
					<li><a href="#" id="saveadlplussign" data-icon="check">保存</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
<script src="${ctx}/static/mt/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script src="${ctx}/static/jquery mobile/jquery.mobile-1.4.5.min.js"></script>
<script>

	$(document).ready(function(){
		var pid = "<%=pid%>";
		var taskid = "<%=taskid%>";
		
		var oldmanname = '';
		var oldmanage = '';
		var oldmanaddress = '';
		var oldmanidnumber = ''
		var oldmanphone = '';
		
		var caseurl = "${ctx}/mapi/getcasebypid";
		$.post(caseurl,{"pid":pid},function(data){
			if(data != null && data != 'undefined') {
				oldmanname = data.name;
				oldmanage = data.age;
				oldmanphone = data.phone;
				oldmanaddress = data.address;
				oldmanidnumber = data.idnumber;
			}
		});
		
		var url = "${ctx}/mapi/getAssess";
		$.post(url,{"pid":pid},function(data){
			if(data != null && data != 'undefined') {
				if(data.bradenresult == '1') {
					var braden = data.bradendata;
					
					$("#obradenname").val(braden.obradenname);
					$("#obradenage").val(braden.obradenage);
					$("#bedno").val(braden.bedno);
					$("#oinhospital").val(braden.oinhospital);
					
					$("input:radio[name='obradensex'][value="+braden.obradensex+"]").attr("checked", "checked");
					$("input:radio[name='obradensex'][value="+braden.obradensex+"]").attr("data-cacheval",false);
					$("input:radio[name='obradensex'][value="+braden.obradensex+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='sensevalue'][value="+braden.sensevalue+"]").attr("checked", "checked");
					$("input:radio[name='sensevalue'][value="+braden.sensevalue+"]").attr("data-cacheval",false);
					$("input:radio[name='sensevalue'][value="+braden.sensevalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='wetvalue'][value="+braden.wetvalue+"]").attr("checked", "checked");
					$("input:radio[name='wetvalue'][value="+braden.wetvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='wetvalue'][value="+braden.wetvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='activityvalue'][value="+braden.activityvalue+"]").attr("checked", "checked");
					$("input:radio[name='activityvalue'][value="+braden.activityvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='activityvalue'][value="+braden.activityvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='movevalue'][value="+braden.movevalue+"]").attr("checked", "checked");
					$("input:radio[name='movevalue'][value="+braden.movevalue+"]").attr("data-cacheval",false);
					$("input:radio[name='movevalue'][value="+braden.movevalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='eatbradenvalue'][value="+braden.eatbradenvalue+"]").attr("checked", "checked");
					$("input:radio[name='eatbradenvalue'][value="+braden.eatbradenvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='eatbradenvalue'][value="+braden.eatbradenvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='frictionvalue'][value="+braden.frictionvalue+"]").attr("checked", "checked");
					$("input:radio[name='frictionvalue'][value="+braden.frictionvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='frictionvalue'][value="+braden.frictionvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("#frictionscore").val(braden.frictionvalue);
					
					$("#totalbradenvalue").val(braden.totalbradenvalue);
					
					$("#dangerass").val(braden.dangerass);
					
					$("#bradenpid").val(pid);
					
					$("#bradenid").val(braden.id);
					
					$("#bradenselforfamilysign").val(braden.bradenselforfamilysign);
					
					$("#signbradenimg").attr("src","${ctx}"+braden.bradenselforfamilysign);
					
					$("#checkbraden").remove();
					$("#spancheckbraden").remove();
					
				}else{
					$("#bradenpid").val(pid);
					$("#adlpid").val(pid);
					$("#adlpluspid").val(pid);
					
					if(oldmanname != null && oldmanname != 'undefined' && oldmanname != '') {
						$("#obradenname").val(oldmanname);
					}
					
					if(oldmanage != null && oldmanage != 'undefined' && oldmanage != '') {
						$("#obradenage").val(oldmanage);
					}
				}
				
				if(data.adlresult == '1') {
					var adl = data.adldata;
					
					$("#oadlname").val(adl.oadlname);
					
					
					$("input:radio[name='oadlsex'][value="+adl.oadlsex+"]").attr("checked", "checked");
					$("input:radio[name='oadlsex'][value="+adl.oadlsex+"]").attr("data-cacheval",false);
					$("input:radio[name='oadlsex'][value="+adl.oadlsex+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("#oadlage").val(adl.oadlage);
					
					$("#obirthday").val(adl.obirthday);
					
					$("input:radio[name='oeducation'][value="+adl.oeducation+"]").attr("checked", "checked");
					$("input:radio[name='oeducation'][value="+adl.oeducation+"]").attr("data-cacheval",false);
					$("input:radio[name='oeducation'][value="+adl.oeducation+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("#ojob").val(adl.ojob);
					
					$("#oaddress").val(adl.oaddress);
					
					$("input:radio[name='omarry'][value="+adl.omarry+"]").attr("checked", "checked");
					$("input:radio[name='omarry'][value="+adl.omarry+"]").attr("data-cacheval",false);
					$("input:radio[name='omarry'][value="+adl.omarry+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='oliving'][value="+adl.oliving+"]").attr("checked", "checked");
					$("input:radio[name='oliving'][value="+adl.oliving+"]").attr("data-cacheval",false);
					$("input:radio[name='oliving'][value="+adl.oliving+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					var eco = adl.oincome;
					var ecoarr = eco.split(",");
					for(var i = 0;i<ecoarr.length;i++) {
						if(eco.indexOf(ecoarr[i]) >=0){
							$("input:checkbox[name='oincome'][value="+ecoarr[i]+"]").attr("checked", "checked");
							$("input:checkbox[name='oincome'][value="+ecoarr[i]+"]").attr("data-cacheval",false);
							$("input:checkbox[name='oincome'][value="+ecoarr[i]+"]").prev().removeClass("ui-checkbox-off").addClass("ui-checkbox-on");
						}
					}
					
					var dis = adl.odisease;
					var disarr = dis.split(",");
					for(var i = 0;i<disarr.length;i++) {
						if(dis.indexOf(disarr[i]) >=0){
							$("input:checkbox[name='odisease'][value="+disarr[i]+"]").attr("checked", "checked");
							$("input:checkbox[name='odisease'][value="+disarr[i]+"]").attr("data-cacheval",false);
							$("input:checkbox[name='odisease'][value="+disarr[i]+"]").prev().removeClass("ui-checkbox-off").addClass("ui-checkbox-on");
						}
					}
					
					
					
					
					$("#oselfphone").val(adl.oselfphone);
					
					$("#ochildrenphone").val(adl.ochildrenphone);
					
					$("#olifestate").val(adl.olifestate);
					
					$("#onofunctionlevel").val(adl.onofunctionlevel);
					
					
					var advice = adl.adviceafterass;
					var advicearr = advice.split(",");
					for(var i = 0;i<advicearr.length;i++) {
						if(advice.indexOf(advicearr[i]) >=0){
							$("input:checkbox[name='adviceafterass'][value="+advicearr[i]+"]").attr("checked", "checked");
							$("input:checkbox[name='adviceafterass'][value="+advicearr[i]+"]").attr("data-cacheval",false);
							$("input:checkbox[name='adviceafterass'][value="+advicearr[i]+"]").prev().removeClass("ui-checkbox-off").addClass("ui-checkbox-on");
						}
					}
					
					var serve = adl.serveitem;
					var servearr = serve.split(",");
					for(var i = 0;i<servearr.length;i++) {
						if(serve.indexOf(servearr[i]) >=0){
							$("input:checkbox[name='serveitem'][value="+servearr[i]+"]").attr("checked", "checked");
							$("input:checkbox[name='serveitem'][value="+servearr[i]+"]").attr("data-cacheval",false);
							$("input:checkbox[name='serveitem'][value="+servearr[i]+"]").prev().removeClass("ui-checkbox-off").addClass("ui-checkbox-on");
						}
					}
					
					
					$("#adlpid").val(pid);
					
					$("#adlid").val(adl.id);
					
					$("#adlselforfamilysign").val(adl.adlselforfamilysign);
					
					$("#signadlimg").attr("src","${ctx}"+adl.adlselforfamilysign);
					
					$("#checkadl").remove();
					$("#spancheckadl").remove();
					
				}else{
					$("#bradenpid").val(pid);
					$("#adlpid").val(pid);
					$("#adlpluspid").val(pid);
					
					if(oldmanname != null && oldmanname != 'undefined' && oldmanname != '') {
						$("#oadlname").val(oldmanname);
					}
					
					if(oldmanage != null && oldmanage != 'undefined' && oldmanage != '') {
						$("#oadlage").val(oldmanage);
					}
					
					if(oldmanphone != null && oldmanphone != 'undefined' && oldmanphone != '') {
						$("#oselfphone").val(oldmanphone);
					}
					
					if(oldmanaddress != null && oldmanaddress != 'undefined' && oldmanaddress != '') {
						$("#oaddress").val(oldmanaddress);
					}
				}
				
				if(data.adlplusresult == '1') {
					var adlplus = data.adlplusdata;
					
					$("#oadlplusname").val(adlplus.oadlplusname);
					
					$("#oidcard").val(adlplus.oidcard);
					
					$("input:radio[name='actionvalue'][value="+adlplus.actionvalue+"]").attr("checked", "checked");
					$("input:radio[name='actionvalue'][value="+adlplus.actionvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='actionvalue'][value="+adlplus.actionvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='eatadlplusvalue'][value="+adlplus.eatadlplusvalue+"]").attr("checked", "checked");
					$("input:radio[name='eatadlplusvalue'][value="+adlplus.eatadlplusvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='eatadlplusvalue'][value="+adlplus.eatadlplusvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='toiletvalue'][value="+adlplus.toiletvalue+"]").attr("checked", "checked");
					$("input:radio[name='toiletvalue'][value="+adlplus.toiletvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='toiletvalue'][value="+adlplus.toiletvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='selfcleanvalue'][value="+adlplus.selfcleanvalue+"]").attr("checked", "checked");
					$("input:radio[name='selfcleanvalue'][value="+adlplus.selfcleanvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='selfcleanvalue'][value="+adlplus.selfcleanvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='healvalue'][value="+adlplus.healvalue+"]").attr("checked", "checked");
					$("input:radio[name='healvalue'][value="+adlplus.healvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='healvalue'][value="+adlplus.healvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='motionvalue'][value="+adlplus.motionvalue+"]").attr("checked", "checked");
					$("input:radio[name='motionvalue'][value="+adlplus.motionvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='motionvalue'][value="+adlplus.motionvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='consciousvalue'][value="+adlplus.consciousvalue+"]").attr("checked", "checked");
					$("input:radio[name='consciousvalue'][value="+adlplus.consciousvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='consciousvalue'][value="+adlplus.consciousvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='mindvalue'][value="+adlplus.mindvalue+"]").attr("checked", "checked");
					$("input:radio[name='mindvalue'][value="+adlplus.mindvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='mindvalue'][value="+adlplus.mindvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					
					$("input:radio[name='behaviorvalue'][value="+adlplus.behaviorvalue+"]").attr("checked", "checked");
					$("input:radio[name='behaviorvalue'][value="+adlplus.behaviorvalue+"]").attr("data-cacheval",false);
					$("input:radio[name='behaviorvalue'][value="+adlplus.behaviorvalue+"]").prev().removeClass("ui-radio-off").addClass("ui-radio-on");
					

					$("#totaladlplusvalue").val(adlplus.totaladlplusvalue);
					
					$("#adlpluspid").val(pid);
					
					$("#adlplusid").val(adlplus.id);
					
					$("#adlplusselforfamilysign").val(adlplus.adlplusselforfamilysign);
					
					$("#signadlplusimg").attr("src","${ctx}"+adlplus.adlplusselforfamilysign);
					
					$("#checkadlplus").remove();
					$("#spancheckadlplus").remove();
					
				}else{
					$("#bradenpid").val(pid);
					$("#adlpid").val(pid);
					$("#adlpluspid").val(pid);
					
					if(oldmanname != null && oldmanname != 'undefined' && oldmanname != '') {
						$("#oadlplusname").val(oldmanname);
					}
					
					if(oldmanidnumber != null && oldmanidnumber != 'undefined' && oldmanidnumber != '') {
						$("#oidcard").val(oldmanidnumber);
					}
				}
			}
		});
		
		$("#bradenpid").val(pid);
		$("#adlpid").val(pid);
		$("#adlpluspid").val(pid);
		$("input:radio").bind("click",function(){$(this).focus();});
	});
	
	
	$("input:radio[name='frictionvalue']").change(function(){
		var frivalue = $("input:radio[name='frictionvalue']:checked").val();
		if(frivalue == 'undefined') {
			$("#frictionscore").val("");
		}else{
			$("#frictionscore").val(frivalue);
		}
	});
	
	
	$("input:radio").on("change",function(){
		var sensevalue = $("input:radio[name='sensevalue']:checked").val();
		var wetvalue = $("input:radio[name='wetvalue']:checked").val();
		var activityvalue = $("input:radio[name='activityvalue']:checked").val();
		var movevalue = $("input:radio[name='movevalue']:checked").val();
		var eatbradenvalue = $("input:radio[name='eatbradenvalue']:checked").val();
		var frictionvalue = $("input:radio[name='frictionvalue']:checked").val();
		
		if(sensevalue != null && sensevalue != 'undefined' && wetvalue != null && wetvalue != 'undefined' && activityvalue != null && activityvalue != 'undefined' && movevalue != null &&  movevalue != 'undefined' && eatbradenvalue != null && eatbradenvalue != 'undefined' && frictionvalue != null && frictionvalue != 'undefined') {
			var total = parseInt(sensevalue) + parseInt(wetvalue) + parseInt(activityvalue) + parseInt(movevalue) + parseInt(eatbradenvalue) + parseInt(frictionvalue);
			$("#totalbradenvalue").val(total);
		}else{
			$("#totalbradenvalue").val("");
		}
		
		var actionvalue = $("input:radio[name='actionvalue']:checked").val();
		var eatadlplusvalue = $("input:radio[name='eatadlplusvalue']:checked").val();
		var toiletvalue = $("input:radio[name='toiletvalue']:checked").val();
		var selfcleanvalue = $("input:radio[name='selfcleanvalue']:checked").val();
		var healvalue = $("input:radio[name='healvalue']:checked").val();
		var motionvalue = $("input:radio[name='motionvalue']:checked").val();
		var consciousvalue = $("input:radio[name='consciousvalue']:checked").val();
		var mindvalue = $("input:radio[name='mindvalue']:checked").val();
		var behaviorvalue = $("input:radio[name='behaviorvalue']:checked").val();
		if(actionvalue != null && actionvalue != 'undefined' &&
		   eatadlplusvalue != null && eatadlplusvalue != 'undefined' &&
		   toiletvalue != null && toiletvalue != 'undefined' &&
		   selfcleanvalue != null && selfcleanvalue != 'undefined' &&
		   healvalue != null && healvalue != 'undefined' &&
		   motionvalue != null && motionvalue != 'undefined' &&
		   consciousvalue != null && consciousvalue != 'undefined' &&
		   mindvalue != null && mindvalue != 'undefined' &&
		   behaviorvalue != null && behaviorvalue != 'undefined') {
			var total = parseInt(actionvalue) + parseInt(eatadlplusvalue) + parseInt(toiletvalue) + 
			parseInt(selfcleanvalue) + parseInt(healvalue) + parseInt(motionvalue) + 
			parseInt(consciousvalue) + parseInt(mindvalue) + parseInt(behaviorvalue);
			$("#totaladlplusvalue").val(total);
		}else{
			$("#totaladlplusvalue").val("");
		}
		
	});
	
	$("[id^=check]").each(function(){
		$(this).change(function(){
			$("#sub"+ $(this).attr("id")).toggle();
		});
	});
	
	function bradenFormCheck() {
		var obradenname = $("#obradenname").val();
		var obradensex = $("input:radio[name='obradensex']:checked").val();
		var obradenage = $("#obradenage").val();
		var bedno = $("#bedno").val();
		var oinhospital = $("#oinhospital").val();
		var sensevalue = $("input:radio[name='sensevalue']:checked").val();
		var wetvalue = $("input:radio[name='wetvalue']:checked").val();
		var activityvalue = $("input:radio[name='activityvalue']:checked").val();
		var movevalue = $("input:radio[name='movevalue']:checked").val();
		var eatbradenvalue = $("input:radio[name='eatbradenvalue']:checked").val();
		var frictionvalue = $("input:radio[name='frictionvalue']:checked").val();
		var dangerass = $("#dangerass").val();
		var bradenselforfamilysign = $("#bradenselforfamilysign").val();
		
		
		if($.trim(obradenname).length == 0) {
			alert("Braden评估表中老人姓名不能为空！");
			return false;
		}
		if(obradensex == null || obradensex == 'undefined') {
			alert("Braden评估表中你没有选择老人的性别！");
			return false;
		}
		if($.trim(obradensex).length == 0) {
			alert("Braden评估表中老人的年龄不能为空！");
			return false;
		}
		
		if(!(/^([1-9]|([1-9][0-9])|(1[0-1][0-9])|120)$/.test(obradenage))) {
			alert("Braden评估表中老人的年龄应该为数字且范围是1-120！");
			return false;
		}
		
		if($.trim(bedno).length == 0) {
			alert("Braden评估表中老人的床号不能为空！");
			return false;
		}
		
		if(sensevalue == null || sensevalue == 'undefined') {
			alert("Braden评估表中你没有选择老人感知压力的能力！");
			return false;
		}
		if(wetvalue == null || wetvalue == 'undefined') {
			alert("Braden评估表中你没有选择老人潮湿度！");
			return false;
		}
		if(activityvalue == null || activityvalue == 'undefined') {
			alert("Braden评估表中你没有选择老人活动能力！");
			return false;
		}
		if(movevalue == null || movevalue == 'undefined') {
			alert("Braden评估表中你没有选择老人移动能力！");
			return false;
		}
		if(eatbradenvalue == null || eatbradenvalue == 'undefined') {
			alert("Braden评估表中你没有选择老人摄取食物的能力！");
			return false;
		}
		if(frictionvalue == null || frictionvalue == 'undefined') {
			alert("Braden评估表中你没有选择老人摩擦力和剪切力！");
			return false;
		}
		
		if($.trim(dangerass).length == 0) {
			alert("Braden评估表中Braden危险性综合评估不能为空！");
			return false;
		}
		
		if($.trim(bradenselforfamilysign).length == 0) {
			alert("Braden评估表中患者或者家属没有签名！");
			return false;
		}
		
		return true;
	}
	
	function bradenFormSubmit() {
		
		var bradenflag = bradenFormCheck();
		if(!bradenflag) {
			return false;
		}
		
		var data = jQuery("#bradenform").serialize();
		$.post("${ctx}/mapi/braden/create", data, function(d) {
			if (d.result == "1") {
				$("#bradenid").val(d.bradenid);
				alert("Braden评估表保存成功！");
				return true;
			}
		});
		
		//$("#bradenform").submit();
	}
	
	function adlFormCheck() {
		
		var oadlname = $("#oadlname").val();
		var oadlsex = $("input:radio[name='oadlsex']:checked").val();
		var oadlage = $("#oadlage").val();
		var obirthday = $("#obirthday").val();
		var oeducation = $("input:radio[name='oeducation']:checked").val();
		var ojob = $("#ojob").val();
		var oaddress = $("#oaddress").val();
		var omarry = $("input:radio[name='omarry']:checked").val();
		var oliving = $("input:radio[name='oliving']:checked").val();
		var oincome = $("#oincome").val();
		var odisease = $("#odisease").val();
		var oselfphone = $("#oselfphone").val();
		var ochildrenphone = $("#ochildrenphone").val();
		var olifestate = $("#olifestate").val();
		var onofunctionlevel = $("#onofunctionlevel").val();
		var adviceafterass = $("#adviceafterass").val();
		var serveitem = $("#serveitem").val();
		//var score = $("#score").val();
		//var adloperatorsign = $("#adloperatorsign").val();
		var adlselforfamilysign = $("#adlselforfamilysign").val();
		
		if($.trim(oadlname).length == 0) {
			alert("ADL常规评估表中你没有填写老人姓名");
			return false;
		}
		
		if(oadlsex == null || oadlsex == 'undefined') {
			alert("ADL常规评估表中你没有选择老人性别！");
			return false;
		}
		
		if($.trim(oadlage).length == 0) {
			alert("ADL常规评估表中你没有填写老人年龄！");
			return false;
		}
		
		if(!(/^([1-9]|([1-9][0-9])|(1[0-1][0-9])|120)$/.test(oadlage))) {
			alert("ADL常规评估表中老人的年龄应该为数字且范围是1-120！");
			return false;
		}
		
		if($.trim(obirthday).length == 0) {
			alert("ADL常规评估表中你没有填写老人出生日期！");
			return false;
		} 
		
		var reg=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/; 
		
		if(!obirthday.match(reg)) {
			alert("ADL常规评估表中日期的格式应该如   1945-08-09   格式！");
			return false;
		}
		
		if(oeducation == null || oeducation == 'undefined') {
			alert("ADL常规评估表中你没有选择老人的文化程度！");
			return false;
		}
		
		if($.trim(ojob).length == 0) {
			alert("ADL常规评估表中你没有填写老人原职业！");
			return false;
		}
		
		if($.trim(oaddress).length == 0) {
			alert("ADL常规评估表中你没有填写老人家庭住址！");
			return false;
		}
		
		if(omarry == null || omarry == 'undefined') {
			alert("ADL常规评估表中你没有选择老人的婚姻状况！");
			return false;
		}
		
		if(oliving == null || oliving == 'undefined') {
			alert("ADL常规评估表中你没有选择老人的居住状况！");
			return false;
		}
		
		if($.trim(oselfphone).length == 0) {
			alert("ADL常规评估表中你没有填写老人的个人电话！");
			return false;
		}
		
		if((oselfphone).search(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/) == -1
				&& (oselfphone).search(/^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})(\-[0-9]{1,4})?$/) == -1) {
			alert("ADL常规评估表中老人的个人电话号码格式不对！");
			return false;
		}
		
		if($.trim(ochildrenphone).length == 0) {
			alert("ADL常规评估表中你没有填写老人的子女电话！");
			return false;
		}
		
		if((ochildrenphone).search(/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/) == -1
				&& (ochildrenphone).search(/^(0[0-9]{2,3}\-)([2-9][0-9]{6,7})(\-[0-9]{1,4})?$/) == -1) {
			alert("ADL常规评估表中老人的子女电话号码格式不对！");
			return false;
		}
		
		if($.trim(olifestate).length == 0) {
			alert("ADL常规评估表中你没有填写老人的生命体征！");
			return false;
		}
		
		if($.trim(onofunctionlevel).length == 0) {
			alert("ADL常规评估表中你没有填写老人的失能级别！");
			return false;
		}
		
		/* if($.trim(adloperatorsign).length == 0) {
			alert("你没有填写评估者签名！");
			return ;
		} */
		
		if($.trim(adlselforfamilysign).length == 0) {
			alert("ADL常规评估表中患者或者其家属没有签名！");
			return false;
		}
		
		return true;
	}
	
	function adlFormSubmit() {
		
		var adlflag = adlFormCheck();
		if(!adlflag){
			return false;
		}
		
		var data = jQuery("#adlform").serialize();
		$.post("${ctx}/mapi/adl/create", data, function(d) {
			if (d.result == "1") {
				$("#adlid").val(d.adlid);
				alert("ADL评估表保存成功 ！");
				return true;
			}
		});
		
		//$("#adlform").submit();
	}
	
	function adlplusFormCheck() {
		
		var oadlplusname = $("#oadlplusname").val();
		var oidcard = $("#oidcard").val();
		var actionvalue = $("input:radio[name='actionvalue']:checked").val();
		var eatadlplusvalue = $("input:radio[name='eatadlplusvalue']:checked").val();
		var toiletvalue = $("input:radio[name='toiletvalue']:checked").val();
		var selfcleanvalue = $("input:radio[name='selfcleanvalue']:checked").val();
		var healvalue = $("input:radio[name='healvalue']:checked").val();
		var motionvalue = $("input:radio[name='motionvalue']:checked").val();
		var consciousvalue = $("input:radio[name='consciousvalue']:checked").val();
		var mindvalue = $("input:radio[name='mindvalue']:checked").val();
		var behaviorvalue = $("input:radio[name='behaviorvalue']:checked").val();
		var totaladlplusvalue = $("#totaladlplusvalue").val();
		//var adlplusoperatorsign = $("#adlplusoperatorsign").val();
		var adlplusselforfamilysign = $("#adlplusselforfamilysign").val();
		
		if($.trim(oadlplusname).length == 0) {
			alert("ADL日常行为能力评估表中老人姓名不能为空!");
			return false;
		}
		
		if($.trim(oidcard).length == 0) {
			alert("ADL日常行为能力评估表中老人身份证号码不能为空!");
			return false;
		}
		
		if(actionvalue == null || actionvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为行动项评分!");
			return false;
		}
		
		if(eatadlplusvalue == null || eatadlplusvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的吃饭能力评分!");
			return false;
		}
		
		if(toiletvalue == null || toiletvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的如厕能力评分!");
			return false;
		}
		
		if(selfcleanvalue == null || selfcleanvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的个人卫生能力评分!");
			return false;
		}
		
		if(healvalue == null || healvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人需要的康复治疗评分!");
			return false;
		}
		
		if(motionvalue == null || motionvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的社会和情感需求能力评分!");
			return false;
		}
		
		if(consciousvalue == null || consciousvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的意识行为表现评分!");
			return false;
		}
		
		if(mindvalue == null || mindvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的精神问题表现评分!");
			return ;
		}
		
		if(behaviorvalue == null || behaviorvalue == 'undefined') {
			alert("ADL日常行为能力评估表中你没有为老人的行为问题表现评分!");
			return false;
		}
		
		if($.trim(adlplusselforfamilysign).length == 0) {
			alert("ADL日常行为能力评估表中患者或者家属没有签名!");
			return false;
		}
		
		return true;
		
	}
	
	function adlplusFormSubmit() {
		
		var adlplusflag = adlplusFormCheck();
		if(!adlplusflag){
			return false;
		}
		
		var data = jQuery("#adlplusform").serialize();
		$.post("${ctx}/mapi/adlplus/create", data, function(d) {
			if (d.result == "1") {
				$("#adlplusid").val(d.adlplusid);
				alert("ADL日常行为评估表保存成功！");
				return true;
			}
		});
		
		//$("#adlplusform").submit();
	}
	
	function submitAllForm() {
		
		
		var checkbradenval = $("input:checkbox[name='checkbraden']").attr("data-cacheval");
		
		var checkadlval = $("input:checkbox[name='checkadl']").attr("data-cacheval");
		
		var checkadlplusval = $("input:checkbox[name='checkadlplus']").attr("data-cacheval");
		
		if(checkbradenval != 'false') {
			var bravalue = bradenFormCheck();
			if(bravalue != null && bravalue.toString() == 'false') {
				return ;
			}
		}
		
		if(checkadlval != 'false') {
			var adlvalue = adlFormCheck();
			if(adlvalue != null && adlvalue.toString() == 'false') {
				return ;
			}
		}
		
		if(checkadlplusval != 'false') {
			var adlplusvalue = adlplusFormCheck();
			if(adlplusvalue != null && adlplusvalue.toString() == 'false') {
				return ;
			}
		}
		
		var data = jQuery("#bradenform").serialize();
		$.post("${ctx}/mapi/braden/create", data, function(d) {
			if (d.result == "1") {
				$("#bradenid").val(d.bradenid);
			}
		});
		
		var data = jQuery("#adlform").serialize();
		$.post("${ctx}/mapi/adl/create", data, function(d) {
			if (d.result == "1") {
				$("#adlid").val(d.adlid);
			}
		});
		
		var data = jQuery("#adlplusform").serialize();
		$.post("${ctx}/mapi/adlplus/create", data, function(d) {
			if (d.result == "1") {
				$("#adlplusid").val(d.adlplusid);
			}
		});
		
		var url="${ctx}/mapi/completeserviceprocess";
		$.post(url,{"taskid":<%=taskid%>},function(data){
			if(data == "1"){
				alert("所有评估表数据保存成功！");
				window.location.href = "${ctx}/static/evaluate/list.jsp";
			}else{
				alert("保存失败！");
				return ;
			}
		});
	}


	var canvasbraden = null, contextbraden = null;
	var canvasadl = null, contextadl = null;
	var canvasadlplus = null, contextadlplus = null;
	function resetBradenCanvas() {
		canvasbraden = document.getElementById('simplebraden');
		contextbraden = canvasbraden.getContext('2d');
	}
	function resetAdlCanvas() {
		canvasadl = document.getElementById('simpleadl');
		contextadl = canvasadl.getContext('2d');
	}
	function resetAdlPlusCanvas() {
		canvasadlplus = document.getElementById('simpleadlplus');
		contextadlplus = canvasadlplus.getContext('2d');
	}
	$("#saveall").on("click", function() {
		$.post("${ctx}/mapi/saveimg", {
			"data" : databraden
		}, function(bradenimgurl) {
			if (bradenimgurl && bradenimgurl.result == "1") {
				$("#bradenselforfamilysign").val(bradenimgurl.url);
				alert("保存签名成功！");
			}
		});
		$.post("${ctx}/mapi/saveimg", {
			"data" : dataadl
		}, function(adlimgurl) {
			if (adlimgurl && adlimgurl.result == "1") {
				$("#adlselforfamilysign").val(adlimgurl.url);
				alert("保存签名成功！");
			}
		});
		$.post("${ctx}/mapi/saveimg", {
			"data" : dataadlplus
		}, function(adlplusimgurl) {
			if (adlplusimgurl && adlplusimgurl.result == "1") {
				$("#adlplusselforfamilysign").val(adlplusimgurl.url);
				alert("保存签名成功！");
			}
		});
	});
	
	
	$(window).bind("orientationchange", function(event) {
		setTimeout(function() {
			$("#simplebraden").attr("width", $("#simplebraden").width());
			$("#simplebraden").attr("height", $("#simplebraden").height()); // 延迟300ms，才能得到正确屏宽  
		}, 300);
		
		setTimeout(function() {
			$("#simpleadl").attr("width", $("#simpleadl").width());
			$("#simpleadl").attr("height", $("#simpleadl").height()); // 延迟300ms，才能得到正确屏宽  
		}, 300);
		
		setTimeout(function() {
			$("#simpleadlplus").attr("width", $("#simpleadlplus").width());
			$("#simpleadlplus").attr("height", $("#simpleadlplus").height()); // 延迟300ms，才能得到正确屏宽  
		}, 300);
		//if(event.orientation){ 
		//     if(event.orientation == 'portrait'){ //竖屏 
		//    } 
		//    else if(event.orientation == 'landscape') { //横评 
		//   } 
		//  } 
	});

	var databraden = "";
	$(document).on("pageinit", "#signbraden", function() {
		$("#signbraden").on("pageshow", function() {
			$("#simplebraden").attr("width", $("#simplebraden").width());
			$("#simplebraden").attr("height", $("#simplebraden").height());
		});

		$("#clearbraden").on("click", function() {
			canvasbraden.width = canvasbraden.width;
		});

		$("#savebradensign").on("click", function() {
			databraden = canvasbraden.toDataURL("image/png");
			$("#signbradenimg").attr("src", databraden);
			$.mobile.changePage("#table1", "slideup");
			$.post("${ctx}/mapi/saveimg", {
				"data" : databraden
			}, function(bradenimgurl) {
				if (bradenimgurl && bradenimgurl.result == "1") {
					$("#bradenselforfamilysign").val(bradenimgurl.url);
					alert("保存签名成功！");
				}
			});
		});

		resetBradenCanvas();
		canvasbraden.addEventListener('touchstart', function(evt) {
			evt.preventDefault();
			contextbraden.beginPath();
			contextbraden.moveTo(evt.touches[0].pageX, evt.touches[0].pageY);
		}, false);
		canvasbraden.addEventListener('touchmove', function(evt) {
			contextbraden.lineTo(evt.touches[0].pageX, evt.touches[0].pageY);
			contextbraden.stroke();
		}, false);
		canvasbraden.addEventListener('touchend', function(evt) {
		}, false);
	});
	
	var dataadl = "";
	$(document).on("pageinit", "#signadl", function() {
		$("#signadl").on("pageshow", function() {
			$("#simpleadl").attr("width", $("#simpleadl").width());
			$("#simpleadl").attr("height", $("#simpleadl").height());
		});

		$("#clearadl").on("click", function() {
			canvasadl.width = canvasadl.width;
		});

		$("#saveadlsign").on("click", function() {
			dataadl = canvasadl.toDataURL("image/png");
			$("#signadlimg").attr("src", dataadl);
			$.mobile.changePage("#table2", "slideup");
			$.post("${ctx}/mapi/saveimg", {
				"data" : dataadl
			}, function(adlimgurl) {
				if (adlimgurl && adlimgurl.result == "1") {
					$("#adlselforfamilysign").val(adlimgurl.url);
					alert("保存签名成功！");
				}
			});
		});

		resetAdlCanvas();
		canvasadl.addEventListener('touchstart', function(evt) {
			evt.preventDefault();
			contextadl.beginPath();
			contextadl.moveTo(evt.touches[0].pageX, evt.touches[0].pageY);
		}, false);
		canvasadl.addEventListener('touchmove', function(evt) {
			contextadl.lineTo(evt.touches[0].pageX, evt.touches[0].pageY);
			contextadl.stroke();
		}, false);
		canvasadl.addEventListener('touchend', function(evt) {
		}, false);
	});
	
	var dataadlplus = "";
	$(document).on("pageinit", "#signadlplus", function() {
		$("#signadlplus").on("pageshow", function() {
			$("#simpleadlplus").attr("width", $("#simpleadlplus").width());
			$("#simpleadlplus").attr("height", $("#simpleadlplus").height());
		});

		$("#clearadlplus").on("click", function() {
			canvasadlplus.width = canvasadlplus.width;
		});

		$("#saveadlplussign").on("click", function() {
			dataadlplus = canvasadlplus.toDataURL("image/png");
			$("#signadlplusimg").attr("src", dataadlplus);
			$.mobile.changePage("#table3", "slideup");
			$.post("${ctx}/mapi/saveimg", {
				"data" : dataadlplus
			}, function(adlplusimgurl) {
				if (adlplusimgurl && adlplusimgurl.result == "1") {
					$("#adlplusselforfamilysign").val(adlplusimgurl.url);
					alert("保存签名成功！");
				}
			});
		});

		resetAdlPlusCanvas();
		canvasadlplus.addEventListener('touchstart', function(evt) {
			evt.preventDefault();
			contextadlplus.beginPath();
			contextadlplus.moveTo(evt.touches[0].pageX, evt.touches[0].pageY);
		}, false);
		canvasadlplus.addEventListener('touchmove', function(evt) {
			contextadlplus.lineTo(evt.touches[0].pageX, evt.touches[0].pageY);
			contextadlplus.stroke();
		}, false);
		canvasadlplus.addEventListener('touchend', function(evt) {
		}, false);
	});
</script>
</html>