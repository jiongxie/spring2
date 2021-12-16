<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
  Cookie[] cookies = request.getCookies();
  String mid = "";
  for(int i=0; i<cookies.length; i++) {
  	String cookieName = cookies[i].getName();
  	if(cookieName.equals("cmid")) {
  		mid = cookies[i].getValue();
  		break;
  	}
  }
  request.setAttribute("mid", mid);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mLogin.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container" style="padding:30px;">
  <h2 style="text-align:center;"></h2>
  <form method="post" class="form-inline">
    <div class="form-check mb-2 mr-sm-2">
      <label for="mid">ID : </label>
      <input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="회원 아이디를 입력하세요" required autofocus/>
      <div class="valid-feedback">정확한 아이디를 입력하세요.</div>
      <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
    </div>
	  <div class="form-check mb-2 mr-sm-2">
	  	<input type="checkbox" name="idCheck" checked/> 아이디 저장 |
	  </div>
    <div class="form-check mb-2 mr-sm-2">
      <label for="pwd">Password :</label>
      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" required/>
      <div class="valid-feedback">정확한 비밀번호를 입력하세요.</div>
      <div class="invalid-feedback">비밀번호는 필수 입력사항입니다.</div>
    </div>
    <div class="form-check mb-2 mr-sm-2">
			<button type="submit" class="btn btn-outline-warning">Login</button>
	    <button type="button" class="btn btn-outline-dark" onclick="location.href='${contextPath}/member/mInput';">Register</button>
	    <button type="button" class="btn btn-outline-danger" onclick="location.href='${contextPath}/member/mMidSearch';">Find ID</button>
	    <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/member/mPwdSearch';">Find PW</button>
	  </div>
  </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>