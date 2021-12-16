<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShopList.jsp(판매상품진열하기)</title>
</head>
<body>
<%@ include file="/WEB-INF/views/include/nav.jsp" %>
<%@ include file="/WEB-INF/views/include/slide.jsp" %>
<p><br/></p>
<div class="container">
  <span>[<a href="${contextPath}/study/dbshop/dbShopList">전체보기</a>]</span> /
  <c:forEach var="title" items="${subTitle}" varStatus="st">s
  	<span>[<a href="${contextPath}/study/dbshop/dbShopList?gubun=${title.product3}">${title.product3}</a>]</span>
	  <c:if test="${!st.last}"> / </c:if>
  </c:forEach>
 	<h3 style="text-align:center;"><a href="${contextPath }/study/dbshop/dbMyOrder">◀</a><a href="${contextPath }/study/dbshop/dbShop"><font color="brown">${gubun}</font></a><a href="${contextPath }/study/dbshop/dbCartList">▶</a></h3>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${vos}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${contextPath}/study/dbshop/dbShopContent?idx=${vo.idx}">
            <img src="${contextPath}/resources/study/${vo.rfname}" width="200px" height="180px"/>
            <div><font size=2>${vo.product}</font></div>
            <div><font size=2 color="orange"><fmt:formatNumber value="${vo.mainprice}" pattern="#,###"/>원</font></div>
            <div><font size=2>${vo.detail}</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt%3 == 0}">
        </div>
        <div class="row mt-md-5">
      </c:if>
    </c:forEach>
  </div>
  <br/>
  <p>
    <button type="button" class="btn btn-dark" onclick="location.href='${contextPath}/study/dbshop/dbShop';">메뉴로돌아가기</button>
  </p>
</div>
<p><br/></p>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>