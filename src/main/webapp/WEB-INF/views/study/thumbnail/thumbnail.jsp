<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>thumbnail.jsp(썸네일 연습)</title>
  <script>
    function imgCheck() {
    	// 자바스크립트를 이용해서 그림파일에 대한 처리(크기, 확장자체크~~~)
    	myform.submit();
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
	<h2 style="text-align:center;">신규전략(썸네일)</h2>
	<form name="myform" method="post" enctype="multipart/form-data">
		<p>파일명 :
		  <input type="file" name="file" id="file" class="form-controll-file border" accept=".jpg,.gif,.png,.jpeg"/>
		</p>
		<p>
		  <input type="button" value="Input" onclick="imgCheck()" class="btn btn-dark" />
		  <input type="reset"  value="Reset" class="btn btn-dark"/>
		</p>
	</form>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>