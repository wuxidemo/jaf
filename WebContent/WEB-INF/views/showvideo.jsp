<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>视频预览</title>

  <!-- Include the VideoJS Library -->
  <script src="${ctx}/static/video-js/video.js" type="text/javascript" charset="utf-8"></script>

  <script type="text/javascript">
    VideoJS.setupAllWhenReady();
  </script>

  <!-- Include the VideoJS Stylesheet -->
  <link rel="stylesheet" href="${ctx}/static/video-js/video-js.css" type="text/css" media="screen" title="Video JS">
</head>
<body>

  <!-- Begin VideoJS -->
  <div class="video-js-box">
    <!-- Using the Video for Everybody Embed Code http://camendesign.com/code/video_for_everybody -->
    <video id="example_video_1" class="video-js" width="600" height="600" controls="controls" preload="auto" >
      <source src="${vpath}" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />
    </video>
  </div>
  <!-- End VideoJS -->

</body>
</html>