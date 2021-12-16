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
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="${contextPath}/" class="w3-bar-item w3-button w3-padding-large">Robostock.com</a>
    <a href="${contextPath}/guest/gList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Guest</a>
<%-- 	  <a href="${contextPath}/study/thumbnail/thumbShow?oFileName=408f0a21-ab79-44d4-b872-c2cf25b491d5_변동성돌파전략.PNG&tFileName=s_408f0a21-ab79-44d4-b872-c2cf25b491d5_변동성돌파전략.PNG" class="w3-bar-item w3-button w3-padding-large w3-hide-small">New</a> --%>
    <a href="${contextPath}/board/bList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Board</a>
    <a href="${contextPath}/notify/mnList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Notice</a>
    <%-- 
    <a href="${contextPath}/pds/pList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Dat</a>
     --%>
    <a href="${contextPath}/pdsm/pmList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Data</a>
    <c:if test="${slevel < 4}">
	    <%-- 
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">Study <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${contextPath}/study/calendar" class="w3-bar-item w3-button">Calendar</a>
	        <a href="${contextPath}/study/woo" class="w3-bar-item w3-button">우편번호 API</a>
	        <a href="${contextPath}/study/fileUpload" class="w3-bar-item w3-button">파일업로드</a>
	      </div>
	    </div>
	     --%> 
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">${snickname} <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	      <%-- 
	        <a href="${contextPath}/" class="w3-bar-item w3-button">회원조회</a>
	       --%>  
	        <a href="${contextPath}/member/mUpdateCheck" class="w3-bar-item w3-button">Mypage</a>
	        <a href="javascript:memberDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
	        <a href="${contextPath}/study/dbshop/dbShop" class="w3-bar-item w3-button">주문</a>
	        <c:if test="${slevel == 0 }">
<%-- 	        	<a href="${contextPath}/study/thumbnail/thumbnail" class="w3-bar-item w3-button">신규전략 홍보</a> --%>
	        	<a href="${contextPath}/study/dbshop/dbShopAd" class="w3-bar-item w3-button" onclick="myFunction()">주문관리</a>
	        	<a href="${contextPath}/mail/mailForm" class="w3-bar-item w3-button">메일발송</a>
	        	<a href="${contextPath}/admin/member/aMList" class="w3-bar-item w3-button"  >회원관리</a>
					  <a href="${contextPath}/notify/nList" class="w3-bar-item w3-button" >공지사항관리</a>
					  <a href="${contextPath}/admin/file/tempDelete" class="w3-bar-item w3-button">임시파일삭제</a>
	        	<%-- 
	        	<a href="${contextPath}/admin/aCheck" class="w3-bar-item w3-button">Administer</a>
	        	 --%>
	        </c:if>
	      </div>
	    </div>
	  </c:if>
	  <c:if test="${slevel == 4}">
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">${snickname} <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${contextPath}/member/mUpdateCheck" class="w3-bar-item w3-button">MyPage</a>
	        <a href="javascript:memberDeleteCheck()" class="w3-bar-item w3-button">회원탈퇴</a>
	      </div>
	    </div>
	  </c:if>
    <c:if test="${empty slevel}">
    	<a href="${contextPath}/member/mLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
    </c:if>
    <c:if test="${!empty slevel}">
    	<a href="${contextPath}/member/mLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Logout</a>
    </c:if>
    <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>


<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <%-- <a href="${contextPath}/study/thumbnail/thumbShow?oFileName=408f0a21-ab79-44d4-b872-c2cf25b491d5_변동성돌파전략.PNG&tFileName=s_408f0a21-ab79-44d4-b872-c2cf25b491d5_변동성돌파전략.PNG" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">New</a> --%>
  <a href="${contextPath}/guest/gList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Guest</a>
  <a href="${contextPath}/board/bList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Board</a>
  <a href="${contextPath}/notify/mnList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Notice</a>
  <a href="${contextPath}/pdsm/pmList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Data</a>
  <c:if test="${slevel < 4}">
		  <a href="${contextPath}/member/mUpdateCheck" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">정보수정</a>
		  <a href="javascript:memberDeleteCheck()" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">회원탈퇴</a>
		  <a href="${contextPath}/study/dbshop/dbShop" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">주문</a>
	  <c:if test="${slevel == 0 }">
		  <%-- <a href="${contextPath}/study/thumbnail/thumbnail" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">신규전략 홍보</a> --%>
 		  <a href="${contextPath}/study/dbshop/dbShopAd" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">주문관리</a>
		  <a href="${contextPath}/mail/mailForm" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">메일발송</a>
		  <a href="${contextPath}/admin/member/aMList" class="w3-bar-item w3-button w3-padding-large"  >회원관리</a>
		  <a href="${contextPath}/notify/nList" class="w3-bar-item w3-button w3-padding-large" >공지사항관리</a>
		  <a href="${contextPath}/admin/file/tempDelete" class="w3-bar-item w3-button w3-padding-large">임시파일삭제</a>
	  </c:if>
		  <a href="${contextPath}/pds/pList" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Data</a>
	</c:if>
  <!-- <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Study</a> -->
  <c:if test="${empty slevel}">
  	<a href="${contextPath}/member/mLogin" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Login</a>
  </c:if>
  <c:if test="${!empty slevel}">
  	<a href="${contextPath}/member/mLogout" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">Logout</a>
  </c:if>
</div>