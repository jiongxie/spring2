<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>thumbShow.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
  <h2 style="text-align:cetner;">신규전략</h2>
  <p>
    <img src="${contextPath}/resources/study/thumbnail/${tFileName}?tFileName=${vo.tFileName}"/>
  <p>
    <img src="${contextPath}/resources/study/thumbnail/${oFileName}?oFileName=${vo.oFilename}"/>
  <p>
<%--    
    <a href="${contextPath}/study/thumbnail/thumbnail">돌아가기</a>
    
 --%>  
 </p>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>