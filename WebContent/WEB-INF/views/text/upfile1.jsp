<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>文件导入</title>
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
	
<link href="${ctx}/static/mt/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/style.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/static/mt/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	
</head>

<script>
   var processdataintro=0;
   function uploadfile(){
	   var filepath=$("#fileToUpload").val();
	   var extStart=filepath.lastIndexOf(".");
	   var ext=filepath.substring(extStart,filepath.length).toUpperCase();
	   if(ext!=".XLS"){
		   window.parent.showAlert("只支持xls格式!");
			return false;
	   }
	   $.ajaxFileUpload({
			  url:'${ctx}/imoup/imfile', //链接到服务器的地址
			  fileElementId:'fileToUpload',  //文件选择框的id属性
			  dataType:'json',
			  success:function(data){  
			    /*   $("#url11").val(data.path); */
			    if(data.msg==0){
			    	 window.parent.showAlert("文件已存在。请重新上传");
			    }else if(data.msg==1){
			    	$("#barintro").css({'width':'0%'});
			    	$("#showprocessintro").css("display","block");
			    	setTimeout('window.parent.iFrameHeight();',100);
			    	 window.parent.showAlert("上传成功! 请点击刷新!");
			    }
			   
			  }  ,
			   error : function(data) {
				   processdataintro=100;
				   window.parent.showAlert("出错啦!");
				}   
		  });
	     processdataintro=0;
		 doProgressLoopintro();
   }
   
     function getProgressintro(){
    	 $.ajax({
		        type: "post",
		    	dataType : 'json',
		        url: "${ctx}/api/process/getprocess",
		        data: "",
		        success: function (data) { 
		        	if(data!=null){
			        	processdataintro=data.process;
			        	$("#barintro").css({'width':data.process+'%'});
		        	}
		        },
		        error: function (err) {
		        	window.parent.showAlert("读取进度失败");
		        	processdataintro=100;
		        }
		    });
     }
     function doProgressLoopintro() { 
 	    if (processdataintro < 100) {
 		    setTimeout("getProgressintro()", 1000);
 		    setTimeout("doProgressLoopintro()", 1000);
 	    }
 	}
 	
     
   
   function outfile(){
	   window.parent.showConfirm("确认导出默认文件位置为    D://inuser.xls",suDisable);
   }
   function suDisable(){
	   var url="${ctx}/imoup/oufile";
	   window.location.href = url;
   }

</script>
<body>
     <div class="row-fluid">
   <div class="span12">
     <h3 class="page-title">
       <img src="${ctx}/static/images/xtgl.png"style="vertical-align:text-bottom;">文件导入
     </h3>
   </div>
</div>
    <!--  <div class="portlet box grey">
       <div class="portlet-title">
			<div class="caption">
				<i class="icon-globe"></i>文件导入
			</div>
		</div>
		<div class="portlet-body">
			<div class="portlet-body form">
			<form id="inputForm" action="" method="post" class="form-horizontal">
			   <div class="control-group">
			       <label for="name" class="control-label">导入excel文件</label>
			        <div class="controls">
                    <input id="fileToUpload"name="fileToUpload"type="file"onchange="uploadfile();" style=""/>
                    <span name="easyTip"style="color: red; font-size: 10px;">(只支持xls格式)</span>			
                   </div>
			   </div>
			   
			   <div class=" control-group" id="showprocessintro" style="display: none;">
			        <div class="controls" style="float: left;">
			            <div class="progress progress-striped active"style="width: 290px;float: left;">
			             <div class="bar" id="barintro"  style="width: 40%; float: left"></div>
			            </div>
			        </div>
			   </div>
			   
			  </form>
			</div>
		</div>
     </div> -->
     <div class="portlet box grey">
         <div class="portlet-title">
          <div class="caption">
            <i class="icon-globe"></i>列表
          </div>
         <div class="actions">
          <!--  <a href="javascript:;" class="btn blue"onclick="outfile()"><i class=""></i>导出本地</a> -->
           <a href="${ctx}/imoup/outipot" class="btn blue"><i class=""></i>导入</a>  
           <a href="${ctx}/imoup" class="btn red"><i class=""></i>刷新</a>      
         </div>
        </div>
        
         <div class="portlet-body">
          <table id="sample_1"
				class="table table-striped table-bordered table-hover">
             <thead>
                <tr>
                   <th style="width: 11%">序号</th>
                   <th style="width: 11%">用户名</th>
                   <th style="width: 11%">用户电话</th>
                   <th style="width: 11%">卡号</th>
                   <th style="width: 11%">积分</th>
                  <!--  <th style="width: 11%">状态</th> -->
                   <th style="width: 16%">导入时间</th>
                   <th style="width: 16%">修改时间</th>
                   
                </tr>
             </thead>
          <tbody>
              <c:forEach items="${impos.content}" var="impo" varStatus="status">
                  <tr>
                    <td>${status.count}</td>
                    <td>${impo.name}</td>
                    
                    <td>${impo.phone}</td>
                    
                    <td>${impo.cardnum}</td>
                    
                    <td>${impo.point}</td>
                    
                   <%--  <td>${impo.state}</td> --%>
                    
                    <td>${impo.createtime}</td>
                      
                    <td>${impo.updatetime}</td>
                        
                   <%--  <td>${impo.openid}</td> --%>
                    
                  </tr>
               </c:forEach>
               
             </tbody>
           </table>
       <tags:pagination page="${impos}" paginationSize="3"/>
        </div>
     </div>

   
</body>
</html>