<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>tempDelete.jsp</title>
</head>
<body>
<p><br/></p>
<!-- Navbar -->
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container">
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h3 class="w3-wide">Temp File</h3>
        <a href="${contextPath}/admin/file/boardTempDelete" style="float:center;"><img src="${contextPath}/main/images/delete.png" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%"></a>
    </div>
  </div>
</div>
</div>
<!-- Footer -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>