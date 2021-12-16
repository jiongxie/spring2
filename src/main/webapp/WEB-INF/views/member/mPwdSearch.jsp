<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>mPwdSearch.jsp</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<div class="container" style="padding:30px;">
  <h4 style="text-align:center;">Find PWD(아이디와 가입시에 등록한 메일주소를 입력하세요.)</h4>
  <form method="post" class="was-validated">
    <div class="col-7" >
      <label for="mid">ID</label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="회원 아이디를 입력하세요" required autofocus/>
      <div class="valid-feedback">정확한 아이디를 입력하세요.</div>
      <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
    </div>
    <div class="col-7">
      <label for="toMail">email address</label>
      <input type="text" class="form-control" name="toMail" id="toMail" placeholder="메일주소를 입력하세요" required/>
      <div class="valid-feedback">정확한 메일주소를 입력하세요.</div>
      <div class="invalid-feedback">메일주소는 필수 입력사항입니다.</div>
    </div>
    <div class="form-check mb-2 mr-sm-2">
	    <button type="submit" class="btn btn-outline-dark">Find PWD</button>&nbsp;
	    <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/member/mLogin';">Login</button>
	  </div>
  </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>