<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/bs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<script>
  function memberDeleteCheck() {
	  var ans = confirm("탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은아이디로 가입불가입니다.\n탈퇴 하시겠습니까?");
		  if(ans) location.href="${contextPath}/member/memberDelete";
	  }
  }
</script>
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
    <a href="${contextPath}/admin/aCheck" class="w3-bar-item w3-button w3-padding-large">Administer</a>


    
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
