<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>志愿者管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/mt/media/css/datepicker.css" />
	<link rel="stylesheet" href="${ctx}/static/yjyupload/yjyupload.css" />
	<%@ include file="../quote.jsp"%>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/date.js"></script>
	<script src="${ctx}/static/mt/media/js/form-components.js"></script>
	
	<script src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctx}/static/jquery-validation/1.11.1/messages_bs_zh.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctx}/static/mt/media/js/bootstrap-fileupload.js"></script>
	<script src="${ctx}/static/mt/media/js/gallery.js"></script>
	<script src="${ctx}/static/mt/media/js/jquery.fancybox.pack.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/ajaxfileupload.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
	
	<script type="text/javascript" src="${ctx}/static/rating/lib/jquery.raty.min.js"></script>
    
</head>
<script>
   var processdate=0;
   function uploadfile(){
	   var filepath=$("#fileToUpload").val();
	   var extStart=filepath.lastIndexOf(".");
	   var ext=filepath.substring(extStart,filepath.length).toUpperCase();
	   if(ext!=".XLS"){
		   window.parent.showAlert("只支持xls格式!");
			return false;
	   }
	   $.ajaxFileUpload({
			  url:'${ctx}/imou/imfile', //链接到服务器的地址
			  fileElementId:'fileToUpload',  //文件选择框的id属性
			  dataType:'json',
			  success:function(data){  
			    /*   $("#url11").val(data.path); */
			    if(data!=null){
			    	 window.parent.showAlert("上传成功!");
			    }
			   
			  }  ,
			   error : function(data) {
				   window.parent.showAlert("上传成功!");
				}   
		  });
   }
   

</script>
<body>
    <div class="portlet-body form">
        <form id="volunteers"action="${ctx}/volunteers/${action}"method="post" class="form-horizontal">
<div class="row-fluid" id="upload">
    <label for="name" class="control-label">上传excel文件</label>
    <div class="controls">
          <input id="fileToUpload"name="fileToUpload"type="file"onchange="uploadfile();" style=""/>
           <span name="easyTip"style="color: red; font-size: 10px;">(只支持xls格式)</span>			
    </div>
    
    <input type="hidden" name="url" id="url11" value="" /> 
    </form>
</div>
</body>
</html>