<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>leftMenu.jsp</title>
  <script>
    function logoutCheck() {
    	parent.location.href = "${contextPath}/admin/adminOut";
    }
  </script>
  <style>
  	.nav_menu {
  		text-decoration:auto;
  	}
  </style>
</head>
<body style='background-color:black;'>
<p><br/></p>
<div style="text-align:center;">
<%-- 
  <h3><a href="${contextPath}/admin/aContent" target="content" style='color:white;'>관리자메뉴</a></h3>
  --%> 
  <%-- 
  <p><a href="${contextPath}/admin/guest/aGList" target="content" style='color:white;'>방명록관리</a></p>
   --%>
  <p><a href="${contextPath}/admin/member/aMList" class="nav_menu" target="content" style='color:white;' >회원관리</a></p>
  <p><a href="${contextPath}/notify/nList" class="nav_menu" target="content" style='color:white;'>공지사항</a></p>
  <p><a href="${contextPath}/admin/file/tempDelete" class="nav_menu" target="content" style='color:white;'>임시파일</a></p>
  <p><a href="javascript:logoutCheck()" class="nav_menu" style='color:white;'>Home</a></p>
</div>
</body>
</html>