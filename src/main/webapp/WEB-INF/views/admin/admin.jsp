<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin</title>
  <frameset cols="120px,*" frameborder="no">
    <frame src="${contextPath}/admin/aLeft" frameborder=0>
    <frame src="${contextPath}/admin/aContent" name="content" frameborder=0>
  </frameset>
</head>
<body>

</body>
</html>